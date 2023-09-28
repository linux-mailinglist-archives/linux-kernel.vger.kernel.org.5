Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC5C7B271B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjI1VGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjI1VGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:06:14 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D2A19D;
        Thu, 28 Sep 2023 14:06:06 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RxQxm0PkWzHj;
        Thu, 28 Sep 2023 23:06:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1695935164; bh=iXyH63ousHu8sDotYqQaWkewO39D2pY6N9s4ZikScZY=;
        h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
        b=LTQ+BWtAXtgJOH/HsOsrXjCtsI3rHVZ9aUiOC8noTbkFWAiTB971JiNiczGhQ8RR7
         LM3GxX6sKMdcJ8o6SPppg/ruXPnMYSZAs0C5yrXFMS7/M8QEcKVNfIG+5WXxrUkiFj
         wsOej967Ghqi2IR3eQJ4MconH4WoF5jdb75q8oUA+Z8VYz/Xr7AjIN8BlCTCVoPouN
         AXHBL8fSDcP7HBGYAXJ/ALag3j/m6jnTZs4yBes7hLIYoW+NEXbRi0WtCyf6AuCBUj
         KNEFvX14H+2LiCgQgb6Pie6o763uKTRQOO6TvstzYljdzWX7fL7i0e/EMVDhGqkD+b
         uSnmvmREy3rlA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.10 at mail
Date:   Thu, 28 Sep 2023 23:06:03 +0200
Message-Id: <a0d917d492b1f91ee0019e68b8e8bca9c585393f.1695934946.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1695934946.git.mirq-linux@rere.qmqm.pl>
References: <cover.1695934946.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 2/3] usb: chipidea: Simplify Tegra DMA alignment code
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:     Peter Geis <pgwipeout@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Thierry Reding <treding@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB host on Tegra3 works with 32-bit alignment. Previous code tried
to align the buffer, but it did align the wrapper struct instead, so
the buffer was at a constant offset of 8 bytes (two pointers) from
expected alignment.  Since kmalloc() guarantees at least 8-byte
alignment already, the alignment-extending is removed.

Fixes: fc53d5279094 ("usb: chipidea: tegra: Support host mode")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/usb/chipidea/host.c | 45 +++++++++++++++----------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index abddd39d1ff1..0cce19208370 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -30,8 +30,7 @@ struct ehci_ci_priv {
 };
 
 struct ci_hdrc_dma_aligned_buffer {
-	void *kmalloc_ptr;
-	void *old_xfer_buffer;
+	void *original_buffer;
 	u8 data[];
 };
 
@@ -380,60 +379,52 @@ static int ci_ehci_bus_suspend(struct usb_hcd *hcd)
 	return 0;
 }
 
-static void ci_hdrc_free_dma_aligned_buffer(struct urb *urb)
+static void ci_hdrc_free_dma_aligned_buffer(struct urb *urb, bool copy_back)
 {
 	struct ci_hdrc_dma_aligned_buffer *temp;
-	size_t length;
 
 	if (!(urb->transfer_flags & URB_ALIGNED_TEMP_BUFFER))
 		return;
+	urb->transfer_flags &= ~URB_ALIGNED_TEMP_BUFFER;
 
 	temp = container_of(urb->transfer_buffer,
 			    struct ci_hdrc_dma_aligned_buffer, data);
+	urb->transfer_buffer = temp->original_buffer;
+
+	if (copy_back && usb_urb_dir_in(urb)) {
+		size_t length;
 
-	if (usb_urb_dir_in(urb)) {
 		if (usb_pipeisoc(urb->pipe))
 			length = urb->transfer_buffer_length;
 		else
 			length = urb->actual_length;
 
-		memcpy(temp->old_xfer_buffer, temp->data, length);
+		memcpy(temp->original_buffer, temp->data, length);
 	}
-	urb->transfer_buffer = temp->old_xfer_buffer;
-	kfree(temp->kmalloc_ptr);
 
-	urb->transfer_flags &= ~URB_ALIGNED_TEMP_BUFFER;
+	kfree(temp);
 }
 
 static int ci_hdrc_alloc_dma_aligned_buffer(struct urb *urb, gfp_t mem_flags)
 {
-	struct ci_hdrc_dma_aligned_buffer *temp, *kmalloc_ptr;
-	const unsigned int ci_hdrc_usb_dma_align = 32;
-	size_t kmalloc_size;
+	struct ci_hdrc_dma_aligned_buffer *temp;
 
 	if (urb->num_sgs || urb->sg || urb->transfer_buffer_length == 0)
 		return 0;
-	if (!((uintptr_t)urb->transfer_buffer & (ci_hdrc_usb_dma_align - 1)) && !(urb->transfer_buffer_length & 3))
+	if (IS_ALIGNED((uintptr_t)urb->transfer_buffer, 4)
+	    && IS_ALIGNED(urb->transfer_buffer_length, 4))
 		return 0;
 
-	/* Allocate a buffer with enough padding for alignment */
-	kmalloc_size = ALIGN(urb->transfer_buffer_length, 4) +
-		       sizeof(struct ci_hdrc_dma_aligned_buffer) +
-		       ci_hdrc_usb_dma_align - 1;
-
-	kmalloc_ptr = kmalloc(kmalloc_size, mem_flags);
-	if (!kmalloc_ptr)
+	temp = kmalloc(sizeof(*temp) + ALIGN(urb->transfer_buffer_length, 4), mem_flags);
+	if (!temp)
 		return -ENOMEM;
 
-	/* Position our struct dma_aligned_buffer such that data is aligned */
-	temp = PTR_ALIGN(kmalloc_ptr + 1, ci_hdrc_usb_dma_align) - 1;
-	temp->kmalloc_ptr = kmalloc_ptr;
-	temp->old_xfer_buffer = urb->transfer_buffer;
 	if (usb_urb_dir_out(urb))
 		memcpy(temp->data, urb->transfer_buffer,
 		       urb->transfer_buffer_length);
+
+	temp->original_buffer = urb->transfer_buffer;
 	urb->transfer_buffer = temp->data;
-
 	urb->transfer_flags |= URB_ALIGNED_TEMP_BUFFER;
 
 	return 0;
@@ -450,7 +441,7 @@ static int ci_hdrc_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 
 	ret = usb_hcd_map_urb_for_dma(hcd, urb, mem_flags);
 	if (ret)
-		ci_hdrc_free_dma_aligned_buffer(urb);
+		ci_hdrc_free_dma_aligned_buffer(urb, false);
 
 	return ret;
 }
@@ -458,7 +449,7 @@ static int ci_hdrc_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 static void ci_hdrc_unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *urb)
 {
 	usb_hcd_unmap_urb_for_dma(hcd, urb);
-	ci_hdrc_free_dma_aligned_buffer(urb);
+	ci_hdrc_free_dma_aligned_buffer(urb, true);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.39.2


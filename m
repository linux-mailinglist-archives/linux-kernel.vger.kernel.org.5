Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77167B2719
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjI1VGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjI1VGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:06:14 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA301B6;
        Thu, 28 Sep 2023 14:06:06 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RxQxl49rkzFZ;
        Thu, 28 Sep 2023 23:06:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1695935163; bh=iiQS8kMeezpTy3iMeiyaI+cO7grb0g3SKJXNiRAc2Yo=;
        h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
        b=EvGqQJm2Fyuc6VcP9qxCVZVQK/cLRarleYOJ+9lLdM/DS92y4ah+/eXQHWlM4n/74
         UR5/vv0oPPhZl1v1RZNJHpQ/rUq/FGfLATQ0WR6FjnHXIJS3wXpKKYtcshC9U11u/+
         MSvWDkDyXZu0EtRjlKFZmqT74SBetfi1/j0OYB5H7EukJRUhQyH5nE0K5+wIKrHAt/
         75417JEt2t5SmuQJuQpBCJL/NA9LT61TXI3SXiYMnpdAKoZmm1o++g9Oiik6Z0ti8j
         2fLVbfD+Wv1F4QZyH/CGk7ceOizdQdJr1bXkfrYFENR/Kvq0W1ZNaiHyndM6d4xW77
         Z0YiJw0AVbdZw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.10 at mail
Date:   Thu, 28 Sep 2023 23:06:03 +0200
Message-Id: <ef8466b834c1726f5404c95c3e192e90460146f8.1695934946.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1695934946.git.mirq-linux@rere.qmqm.pl>
References: <cover.1695934946.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 1/3] usb: chipidea: Fix DMA overwrite for Tegra
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:     Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra USB controllers seem to issue DMA in full 32-bit words only and thus
may overwrite unevenly-sized buffers.  One such occurrence is detected by
SLUB when receiving a reply to a 1-byte buffer (below).  Fix this by
allocating a bounce buffer also for buffers with sizes not a multiple of 4.

=============================================================================
BUG kmalloc-64 (Tainted: G    B             ): kmalloc Redzone overwritten
-----------------------------------------------------------------------------

0x8555cd02-0x8555cd03 @offset=3330. First byte 0x0 instead of 0xcc
Allocated in usb_get_status+0x2b/0xac age=1 cpu=3 pid=41
 __kmem_cache_alloc_node+0x12f/0x1e4
 __kmalloc+0x33/0x8c
 usb_get_status+0x2b/0xac
 hub_probe+0x5e9/0xcec
 usb_probe_interface+0xbf/0x21c
 really_probe+0xa5/0x2c4
 __driver_probe_device+0x75/0x174
 driver_probe_device+0x31/0x94
 __device_attach_driver+0x65/0xc0
 bus_for_each_drv+0x4b/0x74
 __device_attach+0x69/0x120
 bus_probe_device+0x65/0x6c
 device_add+0x48b/0x5f8
 usb_set_configuration+0x37b/0x6b4
 usb_generic_driver_probe+0x37/0x68
 usb_probe_device+0x35/0xb4
Slab 0xbf622b80 objects=21 used=18 fp=0x8555cdc0 flags=0x800(slab|zone=0)
Object 0x8555cd00 @offset=3328 fp=0x00000000

Redzone  8555ccc0: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  ................
Redzone  8555ccd0: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  ................
Redzone  8555cce0: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  ................
Redzone  8555ccf0: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  ................
Object   8555cd00: 01 00 00 00 cc cc cc cc cc cc cc cc cc cc cc cc  ................
Object   8555cd10: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  ................
Object   8555cd20: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  ................
Object   8555cd30: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  ................
Redzone  8555cd40: cc cc cc cc                                      ....
Padding  8555cd74: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a              ZZZZZZZZZZZZ
CPU: 3 PID: 41 Comm: kworker/3:1 Tainted: G    B              6.6.0-rc1mq-00118-g59786f827ea1 #1115
Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
Workqueue: usb_hub_wq hub_event
[<8010ca28>] (unwind_backtrace) from [<801090a5>] (show_stack+0x11/0x14)
[<801090a5>] (show_stack) from [<805da2fb>] (dump_stack_lvl+0x4d/0x7c)
[<805da2fb>] (dump_stack_lvl) from [<8026464f>] (check_bytes_and_report+0xb3/0xe4)
[<8026464f>] (check_bytes_and_report) from [<802648e1>] (check_object+0x261/0x290)
[<802648e1>] (check_object) from [<802671b1>] (free_to_partial_list+0x105/0x3f8)
[<802671b1>] (free_to_partial_list) from [<80268613>] (__kmem_cache_free+0x103/0x128)
[<80268613>] (__kmem_cache_free) from [<80425a67>] (usb_get_status+0x73/0xac)
[<80425a67>] (usb_get_status) from [<80421b31>] (hub_probe+0x5e9/0xcec)
[<80421b31>] (hub_probe) from [<80428bbb>] (usb_probe_interface+0xbf/0x21c)
[<80428bbb>] (usb_probe_interface) from [<803ee13d>] (really_probe+0xa5/0x2c4)
[<803ee13d>] (really_probe) from [<803ee3d1>] (__driver_probe_device+0x75/0x174)
[<803ee3d1>] (__driver_probe_device) from [<803ee501>] (driver_probe_device+0x31/0x94)
usb 1-1: device descriptor read/8, error -71

Fixes: fc53d5279094 ("usb: chipidea: tegra: Support host mode")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/usb/chipidea/host.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index 08af26b762a2..abddd39d1ff1 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -411,12 +411,13 @@ static int ci_hdrc_alloc_dma_aligned_buffer(struct urb *urb, gfp_t mem_flags)
 	const unsigned int ci_hdrc_usb_dma_align = 32;
 	size_t kmalloc_size;
 
-	if (urb->num_sgs || urb->sg || urb->transfer_buffer_length == 0 ||
-	    !((uintptr_t)urb->transfer_buffer & (ci_hdrc_usb_dma_align - 1)))
+	if (urb->num_sgs || urb->sg || urb->transfer_buffer_length == 0)
+		return 0;
+	if (!((uintptr_t)urb->transfer_buffer & (ci_hdrc_usb_dma_align - 1)) && !(urb->transfer_buffer_length & 3))
 		return 0;
 
 	/* Allocate a buffer with enough padding for alignment */
-	kmalloc_size = urb->transfer_buffer_length +
+	kmalloc_size = ALIGN(urb->transfer_buffer_length, 4) +
 		       sizeof(struct ci_hdrc_dma_aligned_buffer) +
 		       ci_hdrc_usb_dma_align - 1;
 
-- 
2.39.2


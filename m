Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E415577233E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjHGL7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjHGL7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:59:31 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D78F128;
        Mon,  7 Aug 2023 04:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1691407285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a4pvTV8kiMTltEAHfywRlUh754oJc8Eu6vcVcqGcW6o=;
        b=vNMOj8WvW3JYZFCNQkHed9zt3EIiSGmnH6DG+UsV3nA1279zp/fAc3pju07WHfGZ3POze4
        ErgsnZo/QoSKaVz8xr1KDdBpBFhznDwTAnbGGMDtqAUSiF+mnuWiPjR5natrt6bKi1aj/w
        7A3i5pA+MuDDtVATaSxwKtgxpa10nVI=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v4 2/6] iio: buffer-dma: Rename iio_dma_buffer_data_available()
Date:   Mon,  7 Aug 2023 13:21:09 +0200
Message-Id: <20230807112113.47157-3-paul@crapouillou.net>
In-Reply-To: <20230807112113.47157-1-paul@crapouillou.net>
References: <20230807112113.47157-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change its name to iio_dma_buffer_usage(), as this function can be used
both for the .data_available and the .space_available callbacks.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>

---
v4: New patch
---
 drivers/iio/buffer/industrialio-buffer-dma.c       | 11 ++++++-----
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  2 +-
 include/linux/iio/buffer-dma.h                     |  2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index 1fc91467d1aa..764f1400a545 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -524,13 +524,14 @@ int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
 EXPORT_SYMBOL_GPL(iio_dma_buffer_read);
 
 /**
- * iio_dma_buffer_data_available() - DMA buffer data_available callback
+ * iio_dma_buffer_usage() - DMA buffer data_available and
+ * space_available callback
  * @buf: Buffer to check for data availability
  *
- * Should be used as the data_available callback for iio_buffer_access_ops
- * struct for DMA buffers.
+ * Should be used as the data_available and space_available callbacks for
+ * iio_buffer_access_ops struct for DMA buffers.
  */
-size_t iio_dma_buffer_data_available(struct iio_buffer *buf)
+size_t iio_dma_buffer_usage(struct iio_buffer *buf)
 {
 	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buf);
 	struct iio_dma_buffer_block *block;
@@ -563,7 +564,7 @@ size_t iio_dma_buffer_data_available(struct iio_buffer *buf)
 
 	return data_available;
 }
-EXPORT_SYMBOL_GPL(iio_dma_buffer_data_available);
+EXPORT_SYMBOL_GPL(iio_dma_buffer_usage);
 
 /**
  * iio_dma_buffer_set_bytes_per_datum() - DMA buffer set_bytes_per_datum callback
diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 5f85ba38e6f6..7b49f85af064 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -117,7 +117,7 @@ static const struct iio_buffer_access_funcs iio_dmaengine_buffer_ops = {
 	.request_update = iio_dma_buffer_request_update,
 	.enable = iio_dma_buffer_enable,
 	.disable = iio_dma_buffer_disable,
-	.data_available = iio_dma_buffer_data_available,
+	.data_available = iio_dma_buffer_usage,
 	.release = iio_dmaengine_buffer_release,
 
 	.modes = INDIO_BUFFER_HARDWARE,
diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
index 18d3702fa95d..52a838ec0e57 100644
--- a/include/linux/iio/buffer-dma.h
+++ b/include/linux/iio/buffer-dma.h
@@ -132,7 +132,7 @@ int iio_dma_buffer_disable(struct iio_buffer *buffer,
 	struct iio_dev *indio_dev);
 int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
 	char __user *user_buffer);
-size_t iio_dma_buffer_data_available(struct iio_buffer *buffer);
+size_t iio_dma_buffer_usage(struct iio_buffer *buffer);
 int iio_dma_buffer_set_bytes_per_datum(struct iio_buffer *buffer, size_t bpd);
 int iio_dma_buffer_set_length(struct iio_buffer *buffer, unsigned int length);
 int iio_dma_buffer_request_update(struct iio_buffer *buffer);
-- 
2.40.1


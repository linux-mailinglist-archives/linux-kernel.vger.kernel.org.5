Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7033F772346
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjHGMAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjHGMAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:00:32 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC30E5A;
        Mon,  7 Aug 2023 05:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1691407288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CjBcI7MOePyRNzsw/XKYD6tqM+t/1zi/Fz/Jzvd8lMc=;
        b=qpQpIBV9gcJaLi7D/3d4QrQuOSYVMlgPvk68Fj4GQKkMmkBL8omXdJCzE5F4U+YrxwwntZ
        /NJfKOn0CfOyiXhwkaeqZR+kXwBB0g9P9PFxK4IiSsLqzX6h6BL4HAW3BgB9dEulvLyEH5
        sKTlk51M3TdtW1wurLRJj9H9w7szE9U=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: [PATCH v4 6/6] iio: buffer-dmaengine: Enable write support
Date:   Mon,  7 Aug 2023 13:21:13 +0200
Message-Id: <20230807112113.47157-7-paul@crapouillou.net>
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

Use the iio_dma_buffer_write() and iio_dma_buffer_space_available()
functions provided by the buffer-dma core, to enable write support in
the buffer-dmaengine code.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

---
v4: .space_available is now set to iio_dma_buffer_usage (which is
    functionally the exact same).
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index deae5a4ac03d..ef9d890ed3c9 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -123,12 +123,14 @@ static void iio_dmaengine_buffer_release(struct iio_buffer *buf)
 
 static const struct iio_buffer_access_funcs iio_dmaengine_buffer_ops = {
 	.read = iio_dma_buffer_read,
+	.write = iio_dma_buffer_write,
 	.set_bytes_per_datum = iio_dma_buffer_set_bytes_per_datum,
 	.set_length = iio_dma_buffer_set_length,
 	.request_update = iio_dma_buffer_request_update,
 	.enable = iio_dma_buffer_enable,
 	.disable = iio_dma_buffer_disable,
 	.data_available = iio_dma_buffer_usage,
+	.space_available = iio_dma_buffer_usage,
 	.release = iio_dmaengine_buffer_release,
 
 	.modes = INDIO_BUFFER_HARDWARE,
-- 
2.40.1


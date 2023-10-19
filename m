Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240757CF9C9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345508AbjJSMzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345846AbjJSMwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:52:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551D61A6;
        Thu, 19 Oct 2023 05:52:46 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:ccea:1fb5:34eb:239b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AE8B2660736D;
        Thu, 19 Oct 2023 13:52:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697719965;
        bh=+To6mEq3JeR7oNn+VfFQcxDH9wOCwdTHlvSi0qsAVuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AHBDaI5BM8oK3di/U+Y7WiExMD7eXnrE2S3OEKUs2oFkYTdi8wURGr5eK+L4Azq0W
         aKfJCwJL4mrFCYzxtBn+ZlfSWLiNYvPXNALXLQajp2uQnFBCV+Hj61/+Sr9QNRp40u
         X2nNsEAPREP3maPP2FCjIdIeguaL376dJda2Wibxhww8mm0rYieYPySolnrav9aI/+
         lnXZl1OeDKp73ge0Cf1UHCSdEWUI6xyo8YASxF9klDDGaZ4/EFQ3CxCdOBzapCSBF5
         3kMwoHZ6/f7MOlY3vc9RnUdX+Cm+BnLbQNzzAl4IxWIDuq2M3ukF9VIFVHuUtpWd/j
         F7mfH6C5AfpUA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v13 27/56] media: coda: Stop direct calls to queue num_buffers field
Date:   Thu, 19 Oct 2023 14:51:53 +0200
Message-Id: <20231019125222.21370-28-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231019125222.21370-1-benjamin.gaignard@collabora.com>
References: <20231019125222.21370-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vb2_get_num_buffers() to avoid using queue num_buffers field directly.
This allows us to change how the number of buffers is computed in the
future.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/media/platform/chips-media/coda-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/chips-media/coda-common.c b/drivers/media/platform/chips-media/coda-common.c
index cc4892129aaf..f1d85758f6dd 100644
--- a/drivers/media/platform/chips-media/coda-common.c
+++ b/drivers/media/platform/chips-media/coda-common.c
@@ -794,7 +794,7 @@ static int coda_s_fmt(struct coda_ctx *ctx, struct v4l2_format *f,
 
 	if (vb2_is_busy(vq)) {
 		v4l2_err(&ctx->dev->v4l2_dev, "%s: %s queue busy: %d\n",
-			 __func__, v4l2_type_names[f->type], vq->num_buffers);
+			 __func__, v4l2_type_names[f->type], vb2_get_num_buffers(vq));
 		return -EBUSY;
 	}
 
-- 
2.39.2


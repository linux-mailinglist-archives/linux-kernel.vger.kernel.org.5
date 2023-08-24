Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22DE786B98
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240750AbjHXJWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240715AbjHXJVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:21:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6308419A2;
        Thu, 24 Aug 2023 02:21:46 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:672:c310:4c8a:3a97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BCF0A6607308;
        Thu, 24 Aug 2023 10:21:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692868905;
        bh=PWkYPK7UJF1YmVd+lrdWvCWfZPTYmEC52Q6H6L/2CpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R/SPv0Dy0iBRcsZbWmQFlUA6N4JHkxVqimQXCK3Lrr/717kH60Foss4GfNKFEBoSD
         1eodB6aWnxkSYjmgQj1eb6RxTj5F2+wRcc/I9JdPUKSNqbnC0U0I2sUda+Orre4sdq
         BRXGCoqrWFY9E49TGHO0geQ8pmo9Mp2I+G9cghz6PzPFO7+OvbR4r8x9OJPYwGfVDk
         Mdlx2jizNtqDtc5/LEbHtQ2bcwG/zow8v5zRXt948YmcJ/wG9wfJfPDy5bpD+sHjET
         LY34+TAEByasLjenXpSJNT+0qjHJzwhFyT9W6vWYpSuTh1Uox7OFoMGrp6GFp5PzFe
         jixgUT6/iNg+A==
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
Subject: [PATCH v5 06/10] media: verisilicon: vp9: Use destination buffer height to compute chroma offset
Date:   Thu, 24 Aug 2023 11:21:29 +0200
Message-Id: <20230824092133.39510-7-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824092133.39510-1-benjamin.gaignard@collabora.com>
References: <20230824092133.39510-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Source and destination buffer height may not be the same because
alignment constraint are different.
Use destination height to compute chroma offset because we target
this buffer as hardware output.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Fixes: e2da465455ce ("media: hantro: Support VP9 on the G2 core")
---
 drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c b/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c
index 6db1c32fce4d..1f3f5e7ce978 100644
--- a/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c
+++ b/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c
@@ -93,9 +93,7 @@ static int start_prepare_run(struct hantro_ctx *ctx, const struct v4l2_ctrl_vp9_
 static size_t chroma_offset(const struct hantro_ctx *ctx,
 			    const struct v4l2_ctrl_vp9_frame *dec_params)
 {
-	int bytes_per_pixel = dec_params->bit_depth == 8 ? 1 : 2;
-
-	return ctx->src_fmt.width * ctx->src_fmt.height * bytes_per_pixel;
+	return ctx->dst_fmt.width * ctx->dst_fmt.height * ctx->bit_depth / 8;
 }
 
 static size_t mv_offset(const struct hantro_ctx *ctx,
-- 
2.39.2


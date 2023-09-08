Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BA37987DC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 15:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243588AbjIHN3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 09:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243560AbjIHN3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 09:29:12 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE9E1BF6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 06:29:08 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c1e780aa95so15381855ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 06:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694179748; x=1694784548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8fTqSPosGVFRSuNbuDzcDh8MPrifrDs8eg/tRpTv6/E=;
        b=S/6Ktyxahte69BF8wIV8rn2HryXahP7SvQqUxAWzqpxjbP8luJKRC2N5gycAQ8WNrO
         V/ITDrX04wzc8uLXMC84jzhLs1X/aKjxD4hIfDaUqnnNhGT8+/zwOaIxJUQoXEfY0bFW
         TXEbHnR5mJQBSnUYIAKQmyI2zEcNuXUTjQWkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694179748; x=1694784548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8fTqSPosGVFRSuNbuDzcDh8MPrifrDs8eg/tRpTv6/E=;
        b=MjlOhTMsWggPAeleVJhoyqXYPgszg/p/KJfAMxx8fjNcihVjBu9UJ2JibMm3SOE1XV
         vQvm083h92yM09VIiFdcW1mJ55E+z3/wVE2wtJCrnnQkQ6PwVYZlMNGm4NKGvJSUM9zo
         Lfi9GhS5kgzU6ck5m9A1ULmHmwXEpm/DEVnPeOJNP/HriVFx2N6Cjd1btQex45etQiq6
         QdEtdQPq+9J1/Q4vuezYJi9+9mTLFrJka4v+wcua1OqbnAASczYqxR59YSSIJKCqHrbs
         lVTkRH4cuirQeKuPajl9kJaldaG7i9tOwwS7gYIYBdqc65tXTd1XX/jxz5G5MYisevRq
         Pa+A==
X-Gm-Message-State: AOJu0YzGUnoxsdKxVE6vGuQ/SEGA5AvYE7v/hJTsoCDRbQ1LVj6cua+O
        UhKY2FffPfkMup53FSVdpjaKmQ==
X-Google-Smtp-Source: AGHT+IHWCBplIrjcCzuUpgb9NC4rnhznC4Bx+ZzE6bt7VuZlgtVVJg0EhVEiMWW50/fNxqh+vxaWSQ==
X-Received: by 2002:a17:902:ce82:b0:1bd:c7e2:462 with SMTP id f2-20020a170902ce8200b001bdc7e20462mr3029639plg.11.1694179747803;
        Fri, 08 Sep 2023 06:29:07 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:2f7e:9c4:ed14:b826])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902778c00b001bc6536051bsm1562560pll.184.2023.09.08.06.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 06:29:07 -0700 (PDT)
From:   Fei Shao <fshao@chromium.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-mediatek@lists.infradead.org, Fei Shao <fshao@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bin Liu <bin.liu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH] media: mtk-jpegenc: Fix bug in JPEG encode quality selection
Date:   Fri,  8 Sep 2023 21:28:04 +0800
Message-ID: <20230908132839.2034566-1-fshao@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver uses the upper-bound approach to decide the target JPEG
encode quality, but there's a logic bug that if the desired quality is
higher than what the driver can support, the driver falls back to using
the worst quality.

Fix the bug by assuming using the best quality in the beginning, and
with trivial refactor to avoid long lines.

Fixes: 45f13a57d813 ("media: platform: Add jpeg enc feature")
Signed-off-by: Fei Shao <fshao@chromium.org>
---

 drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
index 2bbc48c7402c..f8fa3b841ccf 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
@@ -127,6 +127,7 @@ void mtk_jpeg_set_enc_params(struct mtk_jpeg_ctx *ctx,  void __iomem *base)
 	u32 img_stride;
 	u32 mem_stride;
 	u32 i, enc_quality;
+	u32 nr_enc_quality = ARRAY_SIZE(mtk_jpeg_enc_quality);
 
 	value = width << 16 | height;
 	writel(value, base + JPEG_ENC_IMG_SIZE);
@@ -157,8 +158,8 @@ void mtk_jpeg_set_enc_params(struct mtk_jpeg_ctx *ctx,  void __iomem *base)
 	writel(img_stride, base + JPEG_ENC_IMG_STRIDE);
 	writel(mem_stride, base + JPEG_ENC_STRIDE);
 
-	enc_quality = mtk_jpeg_enc_quality[0].hardware_value;
-	for (i = 0; i < ARRAY_SIZE(mtk_jpeg_enc_quality); i++) {
+	enc_quality = mtk_jpeg_enc_quality[nr_enc_quality - 1].hardware_value;
+	for (i = 0; i < nr_enc_quality; i++) {
 		if (ctx->enc_quality <= mtk_jpeg_enc_quality[i].quality_param) {
 			enc_quality = mtk_jpeg_enc_quality[i].hardware_value;
 			break;
-- 
2.42.0.283.g2d96d420d3-goog


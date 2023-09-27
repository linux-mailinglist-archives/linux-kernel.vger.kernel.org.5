Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F9B7B08C3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjI0PhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjI0Pg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:36:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9331B1;
        Wed, 27 Sep 2023 08:36:16 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:672:46bd:3ec7:6cdf])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3DA0E6607348;
        Wed, 27 Sep 2023 16:36:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695828975;
        bh=gAzQ/SGzIm4inZNC+PXcs+p3IPzDsrNiBUGyKW1mkfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fz7L7URA6VG0t2aTr5V4BNuQpp/yeWevC+ajxAbUi0gRORHfMaI5pjmRvy79DDq9G
         1fpA5E4Cfb4nlEtRGyu4qVCtjLNM5l3EzI/Cycld7woGAvrJRQmafflICrJQvdqeE5
         LDk7LTpXY0FisojdtWh8Ye4iqFPogI3yW65qhe6jHkzgM6yFwtugcS6WzdxwFfibYt
         g1g+j0yzQ2n6aQ/LRkOfauEZ3kwxsLZw9pt0kAkenUyicEA9f2vXVtQZFClQ+Cfyzf
         tOOpcvFY3CVyCiAguNU0ijkxQK0DgeUYMXHUpcfsZe7yIC4iFDDSrCj3YS0uj59yDb
         xOBfrHDI/FptQ==
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
Subject: [PATCH v8 17/53] media: verisilicon: Store chroma and motion vectors offset
Date:   Wed, 27 Sep 2023 17:35:22 +0200
Message-Id: <20230927153558.159278-18-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927153558.159278-1-benjamin.gaignard@collabora.com>
References: <20230927153558.159278-1-benjamin.gaignard@collabora.com>
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

Store computed values of chroma and motion vectors offset because
they depends on width and height values which change if the resolution
change.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/platform/verisilicon/hantro.h            | 2 ++
 drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
index 0948b04a9f8d..6f5eb975d0e3 100644
--- a/drivers/media/platform/verisilicon/hantro.h
+++ b/drivers/media/platform/verisilicon/hantro.h
@@ -328,6 +328,8 @@ struct hantro_vp9_decoded_buffer_info {
 	/* Info needed when the decoded frame serves as a reference frame. */
 	unsigned short width;
 	unsigned short height;
+	size_t chroma_offset;
+	size_t mv_offset;
 	u32 bit_depth : 4;
 };
 
diff --git a/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c b/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c
index 6fc4b555517f..6db1c32fce4d 100644
--- a/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c
+++ b/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c
@@ -158,9 +158,11 @@ static void config_output(struct hantro_ctx *ctx,
 
 	chroma_addr = luma_addr + chroma_offset(ctx, dec_params);
 	hantro_write_addr(ctx->dev, G2_OUT_CHROMA_ADDR, chroma_addr);
+	dst->vp9.chroma_offset = chroma_offset(ctx, dec_params);
 
 	mv_addr = luma_addr + mv_offset(ctx, dec_params);
 	hantro_write_addr(ctx->dev, G2_OUT_MV_ADDR, mv_addr);
+	dst->vp9.mv_offset = mv_offset(ctx, dec_params);
 }
 
 struct hantro_vp9_ref_reg {
@@ -195,7 +197,7 @@ static void config_ref(struct hantro_ctx *ctx,
 	luma_addr = hantro_get_dec_buf_addr(ctx, &buf->base.vb.vb2_buf);
 	hantro_write_addr(ctx->dev, ref_reg->y_base, luma_addr);
 
-	chroma_addr = luma_addr + chroma_offset(ctx, dec_params);
+	chroma_addr = luma_addr + buf->vp9.chroma_offset;
 	hantro_write_addr(ctx->dev, ref_reg->c_base, chroma_addr);
 }
 
@@ -238,7 +240,7 @@ static void config_ref_registers(struct hantro_ctx *ctx,
 	config_ref(ctx, dst, &ref_regs[2], dec_params, dec_params->alt_frame_ts);
 
 	mv_addr = hantro_get_dec_buf_addr(ctx, &mv_ref->base.vb.vb2_buf) +
-		  mv_offset(ctx, dec_params);
+		  mv_ref->vp9.mv_offset;
 	hantro_write_addr(ctx->dev, G2_REF_MV_ADDR(0), mv_addr);
 
 	hantro_reg_write(ctx->dev, &vp9_last_sign_bias,
-- 
2.39.2


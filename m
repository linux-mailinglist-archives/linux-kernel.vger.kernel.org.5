Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768C47D3FBB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjJWTAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjJWS76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:59:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44342101;
        Mon, 23 Oct 2023 11:59:56 -0700 (PDT)
Received: from arisu.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8825D66072BA;
        Mon, 23 Oct 2023 19:59:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698087595;
        bh=7U8/6XDOJhzMMzMPF2ztUQzBn+CYjBeQFdZWPFsfHD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lRfMMsYGTLyaRA/BJd9plMIZjQcgCwhf6GxxL8q4g9iGtiy9oR3IqCavGwhJ+UxDg
         K5GT8pNgFW2freF76CwEuyV5tumfxbrryvfzB+B1tS9yNKZD8KCIh/W3m8gX+klxAL
         JRD+DtQCsfVzqiDB6ma0z8mRpn6QX/okglHAE+C30VDHvkKlI27DSjMI9Jo9XFUt7D
         nSN7GyjcKJhUQIdaYXrZhUHUN/TXY4ZXkiyugJvI6q43bNt2qB9hpLZp1e2g3PZW88
         hnrTr6L2U+SOYWlE1IpDwMZlA3JitH5Fd6pygWZz+4cex1EjTo5IVFsFpLM6F9wUr5
         yAfYoZBppAe2w==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH 4/5] visl: Add a codec specific variability parameter
Date:   Mon, 23 Oct 2023 14:58:24 -0400
Message-ID: <20231023185850.67082-5-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023185850.67082-1-detlev.casanova@collabora.com>
References: <20231023185850.67082-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running tests with different input data, the stable output frames
could be too similar and hide possible issues.

This commit adds variation by using some codec specific parameters.

Only HEVC and H.264 support this.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/media/test-drivers/visl/visl-core.c |  5 ++++
 drivers/media/test-drivers/visl/visl-dec.c  | 27 +++++++++++++++++++++
 drivers/media/test-drivers/visl/visl.h      |  1 +
 3 files changed, 33 insertions(+)

diff --git a/drivers/media/test-drivers/visl/visl-core.c b/drivers/media/test-drivers/visl/visl-core.c
index d28d50afec02..c00a134a2171 100644
--- a/drivers/media/test-drivers/visl/visl-core.c
+++ b/drivers/media/test-drivers/visl/visl-core.c
@@ -93,6 +93,11 @@ module_param(stable_output, bool, 0644);
 MODULE_PARM_DESC(stable_output,
 		 " only write stable data for a given input on the output frames");
 
+bool codec_variability;
+module_param(codec_variability, bool, 0644);
+MODULE_PARM_DESC(codec_variability,
+		 " add codec specific variability data to generate more unique frames. (Only h.265 and hevc)");
+
 static const struct visl_ctrl_desc visl_fwht_ctrl_descs[] = {
 	{
 		.cfg.id = V4L2_CID_STATELESS_FWHT_PARAMS,
diff --git a/drivers/media/test-drivers/visl/visl-dec.c b/drivers/media/test-drivers/visl/visl-dec.c
index 61cfca49ead9..002d5e3b0ea4 100644
--- a/drivers/media/test-drivers/visl/visl-dec.c
+++ b/drivers/media/test-drivers/visl/visl-dec.c
@@ -223,6 +223,26 @@ static void visl_tpg_fill_sequence(struct visl_ctx *ctx,
 	}
 }
 
+static bool visl_tpg_fill_codec_specific(struct visl_ctx *ctx,
+					 struct visl_run *run,
+					 char buf[], size_t bufsz)
+{
+	switch (ctx->current_codec) {
+	case VISL_CODEC_H264:
+		scnprintf(buf, bufsz,
+			  "H264: %u", run->h264.dpram->pic_order_cnt_lsb);
+		break;
+	case VISL_CODEC_HEVC:
+		scnprintf(buf, bufsz,
+			  "HEVC: %d", run->hevc.dpram->pic_order_cnt_val);
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
 static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
 {
 	u8 *basep[TPG_MAX_PLANES][2];
@@ -255,6 +275,13 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
 	frame_dprintk(ctx->dev, run->dst->sequence, "");
 	line++;
 
+	if (codec_variability && visl_tpg_fill_codec_specific(ctx, run, buf, TPG_STR_BUF_SZ)) {
+		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, buf);
+		frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
+		frame_dprintk(ctx->dev, run->dst->sequence, "");
+		line++;
+	}
+
 	if (!stable_output) {
 		visl_get_ref_frames(ctx, buf, TPG_STR_BUF_SZ, run);
 
diff --git a/drivers/media/test-drivers/visl/visl.h b/drivers/media/test-drivers/visl/visl.h
index 5a81b493f121..4ac2d1783020 100644
--- a/drivers/media/test-drivers/visl/visl.h
+++ b/drivers/media/test-drivers/visl/visl.h
@@ -86,6 +86,7 @@ extern bool keep_bitstream_buffers;
 extern int bitstream_trace_frame_start;
 extern unsigned int bitstream_trace_nframes;
 extern bool stable_output;
+extern bool codec_variability;
 
 #define frame_dprintk(dev, current, fmt, arg...) \
 	do { \
-- 
2.41.0


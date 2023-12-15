Return-Path: <linux-kernel+bounces-1323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827DE814D69
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08946B22C10
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCDF3FE4F;
	Fri, 15 Dec 2023 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Fvwiy3WF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA983EA82;
	Fri, 15 Dec 2023 16:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702658696;
	bh=o3gVuGEC1t10luwAtPg5Gfc/jxJ1FIFC2gthXJnlS6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fvwiy3WFfv22/7ZWWXiJPGD0gVrH+FydOX/X0oYjY1yo99b3TSiaoo6KcQVD64VxA
	 PVdFLMaMBhcPQE2YmQSGGs/dIS2jkrOtSrCtdR+j7E9dicdbWm6NQHqK2odxx6Gn80
	 hcmiB7eoePOxyH92ofLFB16zr3Fu/YrP+3XdW/JfbE0IvqrHsTl7KR1+nuy1A8usEu
	 wFfK2HqK0Fi+CKkFsVKMlWX3zR4QtXuJvdvYopFVo5q+pHbcSSvFTeUR3I2Oqi2ng0
	 h1xmVfMEn5BsPd94Y4FQ3OwVn2vP2YpomwsU+HIB+rwYVkdzs+vMHeBM2GaTow2Nv7
	 hd1gIOphY24ZA==
Received: from arisu.mtl.collabora.ca (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F276E3781FE9;
	Fri, 15 Dec 2023 16:44:54 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: linux-media@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v4 4/4] visl: Add codec specific variability on output frames
Date: Fri, 15 Dec 2023 11:42:58 -0500
Message-ID: <20231215164447.743787-5-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231215164447.743787-1-detlev.casanova@collabora.com>
References: <20231215164447.743787-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running tests with different input data, the stable output frames
could be too similar and hide possible issues.

This commit adds variation by using some codec specific parameters.

Only HEVC and H.264 support this.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/media/test-drivers/visl/visl-dec.c | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/media/test-drivers/visl/visl-dec.c b/drivers/media/test-drivers/visl/visl-dec.c
index caed753e17d1..fb6f53d8dfd2 100644
--- a/drivers/media/test-drivers/visl/visl-dec.c
+++ b/drivers/media/test-drivers/visl/visl-dec.c
@@ -290,6 +290,35 @@ static void visl_tpg_fill_sequence(struct visl_ctx *ctx,
 		  " top" : " bottom") : "none");
 }
 
+static bool visl_tpg_fill_codec_specific(struct visl_ctx *ctx,
+					 struct visl_run *run,
+					 char buf[], size_t bufsz)
+{
+	/*
+	 * To add variability, we need a value that is stable for a given
+	 * input but is different than already shown fields.
+	 * The pic order count value defines the display order of the frames
+	 * (which can be different than the decoding order that is shown with
+	 * the sequence number).
+	 * Therefore it is stable for a given input and will add a different
+	 * value that is more specific to the way the input is encoded.
+	 */
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
@@ -322,6 +351,13 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
 	frame_dprintk(ctx->dev, run->dst->sequence, "");
 	line++;
 
+	if (visl_tpg_fill_codec_specific(ctx, run, buf, TPG_STR_BUF_SZ)) {
+		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, buf);
+		frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
+		frame_dprintk(ctx->dev, run->dst->sequence, "");
+		line++;
+	}
+
 	visl_get_ref_frames(ctx, buf, TPG_STR_BUF_SZ, run);
 
 	while ((line_str = strsep(&tmp, "\n")) && strlen(line_str)) {
-- 
2.41.0



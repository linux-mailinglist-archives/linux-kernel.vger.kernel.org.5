Return-Path: <linux-kernel+bounces-116593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C59889EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2076D28D363
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B22C14B082;
	Mon, 25 Mar 2024 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WF9d5NSk"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16F815F323;
	Mon, 25 Mar 2024 06:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711348885; cv=none; b=SsVsHyidBs4cDJQE14nLrZ0V49f7NYLctlKcocYx0xLYUIvLOg/kUuaOWB50G/W+QaC6E5dAcaQE22gg5ce0CbKZDQLmvf2YD8G9tQlSKU8VXLLXBLhmKLSq9vMOFmgpZdbIVAbrGxL7vCEW1PBzPH5tQVjHjZsHtg1B8RRuKkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711348885; c=relaxed/simple;
	bh=qkH1n2ZJ4QVAdDXQQaJsqr3HhVev4kuqL3wJZVBjiJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L29Gt2IAL3JBUY/mO6FMGqliLLnqlxmnkf0bVeiOp+AMzeExUi1xi/9CdH4JfNJoHdOqsf5198OsjceEM6/l+zmfv1V87WAv1cNhxG0sZNBYuwaUQStDvAeOJ10Z1OUvtCrIe15c5B6Nz/ZK0kikX94aqqYY//XRFNilR4drqSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WF9d5NSk; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513e89d0816so4973664e87.0;
        Sun, 24 Mar 2024 23:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711348881; x=1711953681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6AIAxCJz2R5rlggcf2OWr2A/Jt7N68nXNuioW63cJo=;
        b=WF9d5NSkpwOliSkjpgPn9m1twpCzhCbNdEVW/hSqiIKoFK+wPG41KaIDTsethpj1ob
         K/ZQC13trZ1P5CG+wlGnmMkpYcE/L20C3EkmKnxpfix/es30T4c4AEdZbfdj7GygZf6T
         PCWadpoN/S1KxbLGjT7H5WFQKOP6dULObdj6NjrW7bTiMXg9/lgb/ldB1j3dKUVNWqOs
         Xpm5etOji5SapWcOGUwwBcyiNhKW2XIhdVFCovEcoVZVD72z4+H9QX0+6hDBsJOR+dqT
         O87cdYBes8e8vLlnjph8HzK/R2MJtEvSKLD3TfYBra/b9+SLK2FFufbbgQVPA+dIO4Hm
         U1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711348881; x=1711953681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6AIAxCJz2R5rlggcf2OWr2A/Jt7N68nXNuioW63cJo=;
        b=RyqXZZXXcM3CrD4JICAl7K/+qwSH9p1xZoNEYz+q8N3f5NAxE68hhSHL39QkIKjGXz
         78stMNnwaoLU3H/kavmuT2LpyqShxlXk6bEcprc4by0qa2500ZMCMzhtvZS3bVW/dePN
         rMOv3+xjBG35Lu5dw+8k+/yhfseQbxB0ivV0nSXhJ2Lv8w1fJb3YDPH0FFMGGNl+lxfK
         Y3Kj9YbaWho0J4QB9Dw3U5msMYck+zDybpYc2M9jLB08sF0f6AzrNhkuyv+wYAkRKB9g
         TPYc2Px6sgfNqsm1hnHMneUcP0+GqHbYx53Oaj3XOMKcbFblS7nGWEhCFONN1lhVtf+5
         yohQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTuTCiJpJTp3gxISf/b2hxtWF+zfRtCJeqw1w+sC/Zc4aCMNMCmFGKYZwpNGwVpooH9OZ4nduZR/VzVj9oF8rDrIdJx+ecIkAhH/XAf1QiH8LJ9bhU5VBZA2RSZoY5YoDPy4gxMBrXwqs=
X-Gm-Message-State: AOJu0YxSFZathlCYP8qBf8k8WkvN4N1WyMf3F6wPmepDQyS57By5OzVo
	q3i70z72mHugUCBICyTAsKFoO6vZl+8nTu54+IzhrVTElINf4476HmM1S09td5U=
X-Google-Smtp-Source: AGHT+IHjY6jEU2tUXWbuyMoSaswlaUukw1uj+p5qAz9JveoI6u6Y8TnVuzQi/pZsWTT3oA4L1wKcfw==
X-Received: by 2002:a05:6512:3b12:b0:515:a670:3a6c with SMTP id f18-20020a0565123b1200b00515a6703a6cmr3648059lfv.23.1711348879078;
        Sun, 24 Mar 2024 23:41:19 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id h12-20020a0565123c8c00b00515a411fd20sm828229lfv.105.2024.03.24.23.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 23:41:18 -0700 (PDT)
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Ivan Bornyakov <brnkv.i1@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] media: chips-media: wave5: support decoding HEVC Main10 profile
Date: Mon, 25 Mar 2024 09:40:56 +0300
Message-ID: <20240325064102.9278-2-brnkv.i1@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325064102.9278-1-brnkv.i1@gmail.com>
References: <20240325064102.9278-1-brnkv.i1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for decoding HEVC Main10 profile by scaling FBC buffer
stride and size by the factor of (bitdepth / 8).

Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
---
 .../chips-media/wave5/wave5-vpu-dec.c         | 30 +++++++++++--------
 .../platform/chips-media/wave5/wave5-vpuapi.h |  1 +
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index ef227af72348..5a71a711f2e8 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -1055,6 +1055,22 @@ static int wave5_prepare_fb(struct vpu_instance *inst)
 	int ret, i;
 	struct v4l2_m2m_buffer *buf, *n;
 	struct v4l2_m2m_ctx *m2m_ctx = inst->v4l2_fh.m2m_ctx;
+	u32 bitdepth = inst->codec_info->dec_info.initial_info.luma_bitdepth;
+
+	switch (bitdepth) {
+	case 8:
+		break;
+	case 10:
+		if (inst->std == W_HEVC_DEC &&
+		    inst->dev->attr.support_hevc10bit_dec)
+			break;
+
+		fallthrough;
+	default:
+		dev_err(inst->dev->dev, "no support for %d bit depth\n", bitdepth);
+
+		return -EINVAL;
+	}
 
 	linear_num = v4l2_m2m_num_dst_bufs_ready(m2m_ctx);
 	non_linear_num = inst->fbc_buf_count;
@@ -1063,7 +1079,7 @@ static int wave5_prepare_fb(struct vpu_instance *inst)
 		struct frame_buffer *frame = &inst->frame_buf[i];
 		struct vpu_buf *vframe = &inst->frame_vbuf[i];
 
-		fb_stride = inst->dst_fmt.width;
+		fb_stride = ALIGN(inst->dst_fmt.width * bitdepth / 8, 32);
 		fb_height = ALIGN(inst->dst_fmt.height, 32);
 		luma_size = fb_stride * fb_height;
 
@@ -1408,22 +1424,10 @@ static int wave5_vpu_dec_start_streaming(struct vb2_queue *q, unsigned int count
 		if (ret)
 			goto free_bitstream_vbuf;
 	} else if (q->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
-		struct dec_initial_info *initial_info =
-			&inst->codec_info->dec_info.initial_info;
-
 		if (inst->state == VPU_INST_STATE_STOP)
 			ret = switch_state(inst, VPU_INST_STATE_INIT_SEQ);
 		if (ret)
 			goto return_buffers;
-
-		if (inst->state == VPU_INST_STATE_INIT_SEQ) {
-			if (initial_info->luma_bitdepth != 8) {
-				dev_info(inst->dev->dev, "%s: no support for %d bit depth",
-					 __func__, initial_info->luma_bitdepth);
-				ret = -EINVAL;
-				goto return_buffers;
-			}
-		}
 	}
 
 	return ret;
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
index 352f6e904e50..465ff9dfe8b1 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
@@ -327,6 +327,7 @@ struct vpu_attr {
 	u32 support_backbone: 1;
 	u32 support_avc10bit_enc: 1;
 	u32 support_hevc10bit_enc: 1;
+	u32 support_hevc10bit_dec: 1;
 	u32 support_vcore_backbone: 1;
 	u32 support_vcpu_backbone: 1;
 };
-- 
2.44.0



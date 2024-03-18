Return-Path: <linux-kernel+bounces-106240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE6C87EB44
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF521C212EB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390594F889;
	Mon, 18 Mar 2024 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHMexQrY"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE02D4F5FD;
	Mon, 18 Mar 2024 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710772992; cv=none; b=MSxRV0RAB3Uv8hPVFGw6CtxkmCYpT7LUp4S2zims1UMu6d6M4kgIHytRmq/rEcbPRQmsyWKV0+iqGajau1vsj/o6JYjU44yHkpwK1vlM4sbO4xoXH7jchXxrQueeQEegre9SF5tmQCUAhY+/wHokoKjt3NWfvYgQHCBCm30PH9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710772992; c=relaxed/simple;
	bh=THt2r/LoLsbGnKrMz7YjnuhgG3mfWSBhirks1hcTk0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzMhsDMupfqa70cx5mlvcUdbLVYhYhbY1Z7ePfensZeZhzd7cZ5nA9NLC2fbKsh3DyDNaMqGtW8lcgOKVaRJHBRlIgRFeq3dWSSzSEYIrncjWDocVlp+URsAHB9T52ZsjEdh9bgvco8R9A9E1grFIGJN2iAdrIidWafbBGun5KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHMexQrY; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d49ca33dcaso30343131fa.3;
        Mon, 18 Mar 2024 07:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710772989; x=1711377789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwdcaQFS3jl4gJsFXk7JgVnuvty4rRK9HOZavfZE0Bg=;
        b=iHMexQrYJK5kqEpfRTjYM4ml8KS7/wqOgsyB4t4Df2QNpGDgSe2My9jjo8UaNQ13W0
         Pp90haG8kjeO59I1rV2CXtAgFq7yeep/C0Vpl+yTfqDuRW2IKHIZL0DAbkOi3wnADmmp
         ehZyYCauvNC/vhePHRmLZCTvnW7qA/swHpjfN6wetOBIZiew/p4vcNEYfuoqSWZf4R9N
         ODBGoMxlYo4F1W5PMSjZHzJEWRbBpuMdEgOUS8poNqtLMUb6l8lWPdqmbjWMBGZOamjQ
         +GqfFXRRfmibu2bzE3bB9vzTmf6z5FZiVrOkYr0sIFvusfdHk7JIDtvbf+hdDANJwr7m
         oZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710772989; x=1711377789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwdcaQFS3jl4gJsFXk7JgVnuvty4rRK9HOZavfZE0Bg=;
        b=pSsSq1tEwBUavsOThxzx9JFlYDkoLoKybRC75mZZr5ZSNvS00pREq646sODVJ/fRk3
         TYCRQfrs9sNvor8VoWK0cPYQpW5HkM6s/4AxfOcRC7YuY959lDszLFACjZlRelXZo65s
         MSx7BGF2aPew0Zq6J7DVr26+IEvRRRkytK20q6iokDRW/NYfxcB8LPs2F7CDgjpcDaVW
         M4GmSJPOvd8XLRBF1V7ENAsVtI1KqeTr3YCkKo/oIsq9MrrmL+8neyFa5vHwkRTXCNAr
         TDbZfSjLR0+qAR1WkFNZ/DipvPnG1QgxnKOzqnQX4YP2EGEj2/yHKTk8K03rPFWPw67M
         BUXA==
X-Forwarded-Encrypted: i=1; AJvYcCVwHgpsgGJMjLMKieQ76xir9gg87yGbqV+KgwUNqdMvWxX9Qx98fzT79uCe+nQyMpGrga+ElIXau3n17qsR+gXDRKDJHzfdfJ8toQqpN++P6wJQEUPf33AhdwApsEpkmxxVxFWLRO4MY2LZMaDxmmq+y4R9JIrNJCjqRUW6I3+nQVQlJMvk
X-Gm-Message-State: AOJu0YxOB29E50nel1trmb0tNAT/kkXYkdGC1vGHT3l+PbwCr7ri0in0
	2zK5dV2CzD3wHM4T33bniH0FylKo4WU+62W3PYJDYcDxbJQIxUqtId+cOY3MX6k=
X-Google-Smtp-Source: AGHT+IG47JYkbNWp0HWD8E4zWggZCI92CyPWkf3nvKoOXbvLXbT9Qs7wLupj/67kjgrE5Pj2p5YdKQ==
X-Received: by 2002:a2e:6a19:0:b0:2d3:f464:2274 with SMTP id f25-20020a2e6a19000000b002d3f4642274mr7211690ljc.37.1710772988746;
        Mon, 18 Mar 2024 07:43:08 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id t9-20020a2e9c49000000b002d476327311sm1527486ljj.18.2024.03.18.07.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 07:43:08 -0700 (PDT)
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Ivan Bornyakov <brnkv.i1@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/6] media: chips-media: wave5: support decoding higher bit-depth profiles
Date: Mon, 18 Mar 2024 17:42:16 +0300
Message-ID: <20240318144225.30835-2-brnkv.i1@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318144225.30835-1-brnkv.i1@gmail.com>
References: <20240318144225.30835-1-brnkv.i1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for decoding higher than 8 bit-depth profiles by scaling FBC
buffer stride and size by the factor of (bitdepth / 8).

Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
---
 .../platform/chips-media/wave5/wave5-vpu-dec.c    | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index ef227af72348..aa0401f35d32 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -1055,6 +1055,7 @@ static int wave5_prepare_fb(struct vpu_instance *inst)
 	int ret, i;
 	struct v4l2_m2m_buffer *buf, *n;
 	struct v4l2_m2m_ctx *m2m_ctx = inst->v4l2_fh.m2m_ctx;
+	u32 bitdepth = inst->codec_info->dec_info.initial_info.luma_bitdepth;
 
 	linear_num = v4l2_m2m_num_dst_bufs_ready(m2m_ctx);
 	non_linear_num = inst->fbc_buf_count;
@@ -1063,7 +1064,7 @@ static int wave5_prepare_fb(struct vpu_instance *inst)
 		struct frame_buffer *frame = &inst->frame_buf[i];
 		struct vpu_buf *vframe = &inst->frame_vbuf[i];
 
-		fb_stride = inst->dst_fmt.width;
+		fb_stride = ALIGN(inst->dst_fmt.width * bitdepth / 8, 32);
 		fb_height = ALIGN(inst->dst_fmt.height, 32);
 		luma_size = fb_stride * fb_height;
 
@@ -1408,22 +1409,10 @@ static int wave5_vpu_dec_start_streaming(struct vb2_queue *q, unsigned int count
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
-- 
2.44.0



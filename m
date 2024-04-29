Return-Path: <linux-kernel+bounces-162533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DAE8B5CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B91E22857B9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7041E12A151;
	Mon, 29 Apr 2024 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C5LcsjRT"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569B712A159
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403116; cv=none; b=qAyGMVdduaSODeatkzw8nneg0W/i9ZixwHFAPL/Ii/vECJco4881WP506gIIi4NQC3cNj0d+KoXVQvw3avPJojZYmwB/0LfDgRSr2R96RUKIhyVuX96EkWxV9viEqvg28QUQgyystBKq99NraNXUaRkHq2EHJTav9ad1VdFfBXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403116; c=relaxed/simple;
	bh=3yiY68g3x2bHjb9WIW4k3fHYf6vWH8Dh8hY3tkaUKhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DL9X02TTqz7Gm7WF3xtkG87IAtgL37QGOpYboJeXU3XEQhCKgi5ZZ/H2cAJj1AMDjtslA7HE/C+jmrp8HYH5MpDck2LtQNG67O2lUXC4eq8Q3KPq3DRf+XajhCQh5anHx11LrTZJoKiznPWwljKYZtNLb+r4tyTAl4Uq/X1jYkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C5LcsjRT; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c74a75d9adso3131435b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714403107; x=1715007907; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sSE1LZ8RJP6sIAmkq+8umDfF5CuS0FK0HNlyLUmOHag=;
        b=C5LcsjRT/SH1sR1BXEPejZt22tZ+2NmusSijJ+KMKtnIHfGblWkjn+bQmxD+tFhv0X
         tNfjpwkQEwv24ObhZw6yBzHpaHArCFzZherMdHMhYCZ5hXclx51lO+wi19L8X+v2n7x7
         IdAKx4aecEYqUbFQFAP336MZgZ8SqvU4AR5T4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714403107; x=1715007907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSE1LZ8RJP6sIAmkq+8umDfF5CuS0FK0HNlyLUmOHag=;
        b=eIshPpgpg5dIh+bmQPeWRF3Mw5gfutZelrOeMb6HDPB6UrKeCBZG+nFjaKZ4zFVGu1
         EGS93eVRzkg4R1soQr6oJ/zPGScUoNP9boiHgR97MmBl1GgaPcVDmja/i53fBcBMQbpl
         a+dkhnUx0ziaHSTScV6bh82klKHnZClw7hQ0xrekwUPsUGrTrD0BNyiBmWHaKDqes6Ln
         t7w3Uc62vAYOwhDQOAjtB1PiYd7gkmi0erRRrVbBfMwxnmDAuRT4ZuhE8uPlmUyfaH2y
         iIawvt+AzVAbuj76b3dpfEcT9IZnCW+wc4yNGWFj0HE2Jxy0OZvys6VqGyIQX9KfM2Ko
         9Y/A==
X-Forwarded-Encrypted: i=1; AJvYcCUMu4hhxL/uC3k9IfpEj05gHTb9CZrBH8fP0OLTpXTfoVdkc3Hx4nEUJAslvHEmuJurf2w1DTaToQwciFAjwV982+SWBQrCYuMPDqcP
X-Gm-Message-State: AOJu0YwCHU5f7yLw7ktGxFrmAvF21d08Psek/4xfm99qW8bRwgKdgawx
	j+l12f0d8VOETt5lh4W7c26MD7hSG34hTmKMxWorK4YAv62OOcP2mxldBNT3aw==
X-Google-Smtp-Source: AGHT+IH4U39JmXtitBebyQXf3RiEBhrVCarSNwVpuxhIdD3y/YgatSZWK47F6u8fGZIDpkmTeNgcdg==
X-Received: by 2002:a05:6870:a70e:b0:22a:9c40:3782 with SMTP id g14-20020a056870a70e00b0022a9c403782mr12043126oam.11.1714403107649;
        Mon, 29 Apr 2024 08:05:07 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id p7-20020a05620a056700b0078d3b9139edsm10568591qkp.97.2024.04.29.08.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:05:06 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 29 Apr 2024 15:05:02 +0000
Subject: [PATCH v3 23/26] media: venus: vdec: Make the range of
 us_per_frame explicit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240429-fix-cocci-v3-23-3c4865f5a4b0@chromium.org>
References: <20240429-fix-cocci-v3-0-3c4865f5a4b0@chromium.org>
In-Reply-To: <20240429-fix-cocci-v3-0-3c4865f5a4b0@chromium.org>
To: Martin Tuma <martin.tuma@digiteqautomotive.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hugues Fruchet <hugues.fruchet@foss.st.com>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Hans Verkuil <hverkuil@xs4all.nl>, Sergey Kozlov <serjk@netup.ru>, 
 Abylay Ospan <aospan@netup.ru>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Dmitry Osipenko <digetx@gmail.com>, 
 Benjamin Mugnier <benjamin.mugnier@foss.st.com>, 
 Sylvain Petinot <sylvain.petinot@foss.st.com>, 
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, 
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

Unless the fps is smaller than 0.000232829 fps, this fits in a 32 bit
number. Make that explicit.

Found by cocci:
drivers/media/platform/qcom/venus/vdec.c:488:1-7: WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/qcom/venus/vdec.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 29130a9441e7..2b2874aedb2d 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -464,7 +464,7 @@ static int vdec_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
 	struct venus_inst *inst = to_inst(file);
 	struct v4l2_captureparm *cap = &a->parm.capture;
 	struct v4l2_fract *timeperframe = &cap->timeperframe;
-	u64 us_per_frame, fps;
+	u64 us_per_frame;
 
 	if (a->type != V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE &&
 	    a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
@@ -484,10 +484,7 @@ static int vdec_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
 	if (!us_per_frame)
 		return -EINVAL;
 
-	fps = (u64)USEC_PER_SEC;
-	do_div(fps, us_per_frame);
-
-	inst->fps = fps;
+	inst->fps = USEC_PER_SEC / (u32)us_per_frame;
 	inst->timeperframe = *timeperframe;
 
 	return 0;

-- 
2.44.0.769.g3c40516874-goog



Return-Path: <linux-kernel+bounces-145804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9088A5B12
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A975B23E2C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EFD15FA92;
	Mon, 15 Apr 2024 19:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lIyai6wr"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC0715F41E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 19:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209695; cv=none; b=EKFXhdmP9cf6JagYC9AYsa+50Otk+DhjYN3pBLdGiBdZ1AfgHPeNcHjjGeJGlMIdAxAmZvJDkd/Pv9PcS2petHmFBz5WAkJRQl3i2P3BS6tHnV04rjaHhpRySF2pbxZ1osoMZ6PlIwbitW88/ozV76e03yY4itXG4jNlpZ6RPhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209695; c=relaxed/simple;
	bh=3+1Bl8mh/8+eBa7Eij9anNi89S/ycWDT7MhZBO0qMzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j4HM1j2c+Wdz9dXyHlC7EUUpIwtITjN99KAVHSpRmVwR5Yvx60xrm070LPejkovdHaDNBrvPEOkFy7kJ10dN6i5D1ISR5h7ip0XE2LxS/BAmVOzAo5xu44zEGipHRh4i6Ybl53EQjQNFJKH4sg44yYZ22tj5UZYc+lK1s/f572E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lIyai6wr; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c717b7b93aso275228b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713209692; x=1713814492; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ApRUmXHVQV4ipJPLdz2OGTOSZdnvD9pjmVa3NeYIwaE=;
        b=lIyai6wrhkTq1KgJXWND6e7iZcGU3W5PDuicQ9o3kOu9cam4Q//AywMviobqx66UJW
         FY9tN8SVI1UeRsOuMQM2+tJVjWi8wjNJ3LW6NqTuUjqZ45YuMa7pgDv5WAkj1QTS2JYE
         KKskNvykMkRm58jLJoC6w9FB3YaP2y6n8ugSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713209692; x=1713814492;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApRUmXHVQV4ipJPLdz2OGTOSZdnvD9pjmVa3NeYIwaE=;
        b=aC5ELkpzM0ZQgu+Oen/ZF72vZWU34Xo1s81zKIs4pauniRfa4ZDfN1+JJhZ+q2Ze/y
         s4jOBQBNkfmXIjeJbTDJTNBip0KRsNDpb55TyUBl4kpSYcTwYgRiQrJ7E8Rk/P4flUd+
         z9a/kBpM1OFOrm1en6U1fqYQvOuMNpEvtBHu3w7mrrm4Mj4bQHOJ7R1dtPE/Qm5VW1av
         SAvaMtajI218Q8pi9XUUHqOyq7z3sEC+ZUX2kdK3ft4RyEzyCH9+ZIrzp4rRANGLadar
         X+NMcBW500C3FaKv8UNUniQ6ljECCeOk7yr94CZd7fz3hfpEduC3Izxxxg/lG5LQbca4
         X39Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7xhAT2PN8jSQ4PuMlaoOZvC5mn6qix3RRarLNxfqjDwiBBOgXPRII4jQvVdOrKtpD7h5gnr4UvyekyiWXimIIP3NP2XoRb1Jw2nZ2
X-Gm-Message-State: AOJu0YzA537p0AAn3qTxhSsLuRLij/CfQHeZD+/RsOimjckzG+k0X/o6
	xszxfqnjCaLFUzyv6wgfulL4B5jcn7UAq68LrDMajSa2MVSpeLb+owBNzEjVfA==
X-Google-Smtp-Source: AGHT+IGZ58NMkpObXyXFmK/dlwdDRAXnKMQeVrLnGqtYNcTRA6TD/q28Ror56VZ2t4DiW7soUyKUtg==
X-Received: by 2002:a05:6808:128c:b0:3c5:fe95:2371 with SMTP id a12-20020a056808128c00b003c5fe952371mr14036703oiw.29.1713209692296;
        Mon, 15 Apr 2024 12:34:52 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id s26-20020ae9f71a000000b0078d3b54eb76sm6718055qkg.78.2024.04.15.12.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 12:34:51 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 15 Apr 2024 19:34:38 +0000
Subject: [PATCH 21/35] media: venus: Use div64_u64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-fix-cocci-v1-21-477afb23728b@chromium.org>
References: <20240415-fix-cocci-v1-0-477afb23728b@chromium.org>
In-Reply-To: <20240415-fix-cocci-v1-0-477afb23728b@chromium.org>
To: Martin Tuma <martin.tuma@digiteqautomotive.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
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
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Benjamin Mugnier <benjamin.mugnier@foss.st.com>, 
 Sylvain Petinot <sylvain.petinot@foss.st.com>, 
 Jacopo Mondi <jacopo+renesas@jmondi.org>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
 Pavel Machek <pavel@ucw.cz>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, 
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

us_per_frame does not fit in 32 bits. Use the appropriate div function.

Found by cocci:
drivers/media/platform/qcom/venus/vdec.c:488:1-7: WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/qcom/venus/vdec.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 29130a9441e7..1dffeb7de76e 100644
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
+	inst->fps = div64_u64(USEC_PER_SEC, us_per_frame);
 	inst->timeperframe = *timeperframe;
 
 	return 0;

-- 
2.44.0.683.g7961c838ac-goog



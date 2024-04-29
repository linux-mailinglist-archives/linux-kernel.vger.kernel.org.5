Return-Path: <linux-kernel+bounces-162534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9928B5CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC981F20C98
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4F712D776;
	Mon, 29 Apr 2024 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O5mUMjqg"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C92712AAF4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403120; cv=none; b=uPlSvzpu8SIrs4fj1bAI9dAJCbBA8tjhaaruB7UNqOlrnOnV5JyOPHl/V9Qtew3OwWc4Mg9qN5pNxgUbhfYZODJ5NjdK9I8b7UHmxvlN0L2gP66ysOd6oo8R51o4KFLaMC8RLB7SwXThnTUuLR+zKxi2dne5dreAPLSfxVKe1DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403120; c=relaxed/simple;
	bh=lT0gv7t9lJl7WTpTFIwuHIIXL8DRSxK4u4QFsJzyT6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U/keJwWJWwE4cFk2n4py4ke5imE03OQfJXw5oY7kT2ePLKShYjVsuTKQNmooaJgfVZu7z6c2SFXkglzDMWxgXrpKqFxMgh9O9Y8yPF3TAgYqqQP6iHFV3RNlGkfExMNZuMwz92mcr0M3IEosa7G4N98BrVqBRDDft9u+GsFlpI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O5mUMjqg; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78efd533a00so336987485a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714403109; x=1715007909; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WhbcF3TWQTA5MkpkxmSIX7qa4yJQy6aIRpdafwtebNs=;
        b=O5mUMjqg2A8YY4ty5orhIV1NF+pFi2j9bO9hT1HBhVy7haVjZQghrbU2Gh4yMmLPxN
         hnFW8xINxsvHuye4wGSsAfAIjVVKzPJKseKGAujJym+sf53HTSnDz0vS+VyLFaEYs2GL
         89sa+G0eZib/fX6ppH/axvJUnVrvZTELvTt0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714403109; x=1715007909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhbcF3TWQTA5MkpkxmSIX7qa4yJQy6aIRpdafwtebNs=;
        b=MZUAqcbwc9ctxFvzTeUu3YRT/4pZfIsY8tkix0B1LDw5t0uHSZ3w727md/CILqIRbD
         azcYFuZtRYHDXiwYqralywaTvOcjJgstpNlPuAyJYMljY21rSuYtzNOCh5j9BLwj2KU4
         gHF4Xff3Ljlb3bPzDygSHaKPJtc79Sql0Qsv7rnHdofolHgvwB6p1szM7iEirDA9tysE
         uvDs9G9kyLIfOrBDUbrTT0Ixn6TJEsfSXgtEgKQ4jhdmKcBdi1CWcYYu1LBJEMOb4rKe
         YFrGG9b+PLxOiPuQDR4cZbcw6kQNVahCCKtCmq+5rTtKr7qo+YrgbHJPWs7bxytku8aY
         bQmw==
X-Forwarded-Encrypted: i=1; AJvYcCXKXxFELJ1fwcYwS6FLKcj+yHYOHRCNaOOBXXqlNUuSh+98RDBjTXV8Ur3MIX6werug27iOLQqPGDmryFWKOq1zrrnS/YYYwoyURT+s
X-Gm-Message-State: AOJu0Ywg7lSWYjbuwqeJ5jUdOUxkawCQNCtBDh3IonVlo8qQPU/vNfuN
	9YbVRvFB/gexb7kbKzQdEL/Qr1SBUqyqpNYSAgu5g3pzq2HFfgeUMWHIuLZAFw==
X-Google-Smtp-Source: AGHT+IGs4sEEfsd0KHK969uVD2lhoqcTxzDs2zjOqF/5cv6aPK5AvcxX8HFB2EOaJeVcr8eLM013oQ==
X-Received: by 2002:a05:620a:8204:b0:78d:6479:7c39 with SMTP id ow4-20020a05620a820400b0078d64797c39mr7471552qkn.19.1714403109214;
        Mon, 29 Apr 2024 08:05:09 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id p7-20020a05620a056700b0078d3b9139edsm10568591qkp.97.2024.04.29.08.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:05:08 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 29 Apr 2024 15:05:03 +0000
Subject: [PATCH v3 24/26] media: venus: venc: Make the range of
 us_per_frame explicit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240429-fix-cocci-v3-24-3c4865f5a4b0@chromium.org>
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

Found with cocci:
drivers/media/platform/qcom/venus/venc.c:418:1-7: WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/qcom/venus/venc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 3ec2fb8d9fab..f87e33a34610 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -393,7 +393,7 @@ static int venc_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
 	struct venus_inst *inst = to_inst(file);
 	struct v4l2_outputparm *out = &a->parm.output;
 	struct v4l2_fract *timeperframe = &out->timeperframe;
-	u64 us_per_frame, fps;
+	u64 us_per_frame;
 
 	if (a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT &&
 	    a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
@@ -414,11 +414,8 @@ static int venc_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
 	if (!us_per_frame)
 		return -EINVAL;
 
-	fps = (u64)USEC_PER_SEC;
-	do_div(fps, us_per_frame);
-
+	inst->fps = USEC_PER_SEC / (u32)us_per_frame;
 	inst->timeperframe = *timeperframe;
-	inst->fps = fps;
 
 	return 0;
 }

-- 
2.44.0.769.g3c40516874-goog



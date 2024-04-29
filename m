Return-Path: <linux-kernel+bounces-162519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1832F8B5C97
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF2C1C21AEE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DD585C59;
	Mon, 29 Apr 2024 15:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iJF0jV50"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A868380630
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403095; cv=none; b=XaqnAO7YPa7FScZr451UUPNKlIMUv2I2curyCl5XbQ7476Omj6+hnCElU6MQwpfGyPdMjVh35D6QMKg5fFVnWVhYnifT6NPxCVSkoGlA5tTlRMBMDjheIVV/w0Eo/AojUlaES7EGmQYvjndJV6V59+eo+JwQCmFEH8NYIIb0Amw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403095; c=relaxed/simple;
	bh=TYiaV8/876fGs7BbPI/75wYP3iQVyz/w58Jr4KxHpck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aVrCFjUosOF+O97DlidAnC1PfI/0s4zJaNwc4hm42Cn0IzMudOjxmzVOP1w4VLf+03bwVBpOLC1okQR0a4pgAHoB8SMJ1ISySQtvVYlXEow8VQNK1d1NJAS5XjisPk3jpR320m5uDVxOEiHn2JwlmGEYzza30H8bxomM5PVlGC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iJF0jV50; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-23bd61fbd64so1676821fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714403092; x=1715007892; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JNRsm9gIh82mFVXKJ+HUiStpAhIByx8KXG3SUDPUD70=;
        b=iJF0jV503Otz3O1L0GPGJDOBp0iyfSy6chueJazjoL15DmuTfpd/+1JZuvk/E1Sb2G
         euDgh/SGYwcls8BX1DBf+xw7MNx7AlyMI+wwKJqkfTlkD/Qmx8QnJJw2hh9FcRQbq5FF
         UVUMDl6PhSGWbheKVbTq7ZvwykaNesVDU0R9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714403092; x=1715007892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNRsm9gIh82mFVXKJ+HUiStpAhIByx8KXG3SUDPUD70=;
        b=LKvk9lQAn7OLmNq/t0P2IwaPIkScn/Uhh5ed7JEhLPqKhDrOBWBv5aGWwotIAHrZn3
         pfNNavIhC9WLMhgEMaeSUEej7rcBgv+/bXAhDCKF2gACTTJiBarQHT7kTJVkDpWm2gu2
         1DdFrCUts9v28xgkqBRH//tAq27CPhwM67usH97Li+tvBv1ZpJqYvsvi/BbIqAlprY1H
         mzj2sn9bDvZVatg9pnkboXKq50xRymKOrkw2QwOag5sdhCEFiXu2IBf82TcpWZjY228q
         KS5SyIb44+K+5nXtnUyN+IGKv/Kb1xbiuqZEo9X+OVoCNVUlK6OZxJYAw0YOARmTnLKK
         GXgw==
X-Forwarded-Encrypted: i=1; AJvYcCU2QktkDz8EObA83iMBtSgeTe3O51Mr+hCfhbDtSLh1IUQhcvKNJCSAIkEAifN3zX4pdfrzqEKEKNMPmfIHEW/UUUymG2J/1OByklbL
X-Gm-Message-State: AOJu0Yyn1N+FiznZtbSlsDxWbIv5NYLo9sTR8LREA8E+SFqzUijnfFDe
	hIvXeBJT6g8EjSHBLbNqlaCGd8wEzfanitdiPJQmyLVgxOdEKXc2YJsN5cP+jg==
X-Google-Smtp-Source: AGHT+IGXcStN+XAFfYHJlQ/BhJGSDUpZDAykPn1StedMjlrpGT2G5swu1IRQFedvTjeL4JvuXpf10g==
X-Received: by 2002:a05:6871:a416:b0:233:b5ef:3bab with SMTP id vz22-20020a056871a41600b00233b5ef3babmr9216406oab.3.1714403092563;
        Mon, 29 Apr 2024 08:04:52 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id p7-20020a05620a056700b0078d3b9139edsm10568591qkp.97.2024.04.29.08.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:04:52 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 29 Apr 2024 15:04:48 +0000
Subject: [PATCH v3 09/26] media: v4l: async: refactor
 v4l2_async_create_ancillary_links
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240429-fix-cocci-v3-9-3c4865f5a4b0@chromium.org>
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

Return 0 without checking IS_ERR or PTR_ERR if CONFIG_MEDIA_CONTROLLER
is not enabled.

This makes cocci happier:

drivers/media/v4l2-core/v4l2-async.c:331:23-30: ERROR: PTR_ERR applied after initialization to constant on line 319

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/v4l2-core/v4l2-async.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 3a22da443a22..421b2b96bc8a 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -316,9 +316,10 @@ v4l2_async_nf_try_all_subdevs(struct v4l2_async_notifier *notifier);
 static int v4l2_async_create_ancillary_links(struct v4l2_async_notifier *n,
 					     struct v4l2_subdev *sd)
 {
-	struct media_link *link = NULL;
+	struct media_link *link;
 
-#if IS_ENABLED(CONFIG_MEDIA_CONTROLLER)
+	if (!IS_ENABLED(CONFIG_MEDIA_CONTROLLER))
+		return 0;
 
 	if (sd->entity.function != MEDIA_ENT_F_LENS &&
 	    sd->entity.function != MEDIA_ENT_F_FLASH)
@@ -326,8 +327,6 @@ static int v4l2_async_create_ancillary_links(struct v4l2_async_notifier *n,
 
 	link = media_create_ancillary_link(&n->sd->entity, &sd->entity);
 
-#endif
-
 	return IS_ERR(link) ? PTR_ERR(link) : 0;
 }
 

-- 
2.44.0.769.g3c40516874-goog



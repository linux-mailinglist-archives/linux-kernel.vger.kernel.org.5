Return-Path: <linux-kernel+bounces-145788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9B18A5AD0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F44C1C20B7D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E749515AD86;
	Mon, 15 Apr 2024 19:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Eqs+/dL3"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8D8159919
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209676; cv=none; b=Bj+5qSEZmKRFH878/Nn81v9s5kdfrwM1ByLrMmQlUdW1sh6MUK17+ju+fcIbbWBg+kJZqMGmxTahdLyEpghAFO4xhE7v3U5NMqKi1IdmT2R2VncxqJbZgrxAccJC5rnwo4x4n7JNvcLW4heTieaNVfTz7voSuYWCbhil32dBHd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209676; c=relaxed/simple;
	bh=rbJ7o+aKZRgLkZZ5K/uX3oUw9BYyxclmpLca8K2IUdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VdbxJJX1eiNtjzPEh34tla4hWSI6D6lL0+yB2JwIr6zfwv2Q7uaR1neELUFRfMoCyJfOfITzNDhLoNLUZp5qbJOysPYp+7LXElqDNfaxfTurmMRCvx2PEyTcDJnSMVZ/vwJBzVZsWaT7L6LvQPjRUQgLKz9GFiWcevg9lY8PmgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Eqs+/dL3; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78d683c469dso371090685a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713209673; x=1713814473; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8w49vqOwnRlIfNq1dtx4OWinIRfPHFawqCMqrawnhls=;
        b=Eqs+/dL3TDsFUBwMF/AUQDmCgMliHatNPCIByiusLfOlLZNbQR6GtTgqKm0Tw9RCmM
         3Bwp9mPeNo8X1s85Xp8+vlEyPCzczIl6qqG8xu98Ck6q5bD//5sd3wfy6naghVJxg5Tz
         uuu7haHqtV3ig8AW9SJmb/0CBXuz/mu6SHHXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713209673; x=1713814473;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8w49vqOwnRlIfNq1dtx4OWinIRfPHFawqCMqrawnhls=;
        b=kOkvgRtvwafLyw/fNun0UElcpUa8T0fc9IMw+RdNYJuIARP6wiawDyvPSH0RiKYxZ4
         cxv60AQdd1sUA6pqyOdeExeczFzrghiq0uuIOUtqRuJpEnFBdGrxi51QyHLf0/FdOkL+
         8yFmBP2zuIrx0/iKV6eZ8f8eoAU1uCwRnNVIgK/wPpJSXm2e4IBY2EGdbIwzppM3GWCe
         +eyDjHCGTjBrYxZFzl8IhlHzAv5KEhP6o6n2xDLiVvv0A4btzRztY9CnNcvp1CGWgxbf
         hEzofRCk3bf2AtHLYsEMdll3x8TUlfgXpNijLOZeWgnnq38j2iCM/wFsJsf5DXmrYy1L
         ipuA==
X-Forwarded-Encrypted: i=1; AJvYcCWypLCR9s3h8vrDpcpK+PE7b/GdriW1BWZfFqsEEb8wMyM8mogSUkbo3u1pPLMX700udigz/dD4Bp/4rJgbJR4e16oXJHMgnMggL4Q7
X-Gm-Message-State: AOJu0YyFCCX2OFqj8WhfgFBbr/N4lx77lGX42j33bW69PI9XEli/+SHT
	aaROSCQwb96mRYMj+RDcKyGnAhdjQGvg0OhNyc43U0FTQGculENU0lw2HQSuCg==
X-Google-Smtp-Source: AGHT+IF3Z64gOvH813ZrsURn6c5OX0cA+P7DewlH+o86rsWDf5urUOYDJaPeLXGD215pMul/2CCAvg==
X-Received: by 2002:a05:620a:5e48:b0:78e:e7f8:a5e3 with SMTP id ya8-20020a05620a5e4800b0078ee7f8a5e3mr3707352qkn.52.1713209673334;
        Mon, 15 Apr 2024 12:34:33 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id s26-20020ae9f71a000000b0078d3b54eb76sm6718055qkg.78.2024.04.15.12.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 12:34:33 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 15 Apr 2024 19:34:23 +0000
Subject: [PATCH 06/35] media: stm32-dcmipp: Remove redundant printk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-fix-cocci-v1-6-477afb23728b@chromium.org>
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

platform_get_irq() already prints an error message.

Found by cocci:
drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c:444:3-10: line 444 is redundant because platform_get_irq() already prints an error

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c
index bce821eb71ce..c25027b0ca32 100644
--- a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c
+++ b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c
@@ -439,11 +439,8 @@ static int dcmipp_probe(struct platform_device *pdev)
 				     "Could not get reset control\n");
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Could not get irq\n");
+	if (irq <= 0)
 		return irq ? irq : -ENXIO;
-	}
 
 	dcmipp->regs = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(dcmipp->regs)) {

-- 
2.44.0.683.g7961c838ac-goog



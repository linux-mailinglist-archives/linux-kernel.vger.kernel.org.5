Return-Path: <linux-kernel+bounces-145792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE298A5AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5B25B23202
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5965F15CD50;
	Mon, 15 Apr 2024 19:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dR/nUkgH"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A3F15B14D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 19:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209681; cv=none; b=u/iuuEANy0O9wtrjt/J70FRPHGX5AnFwAFx2sCEt5sHNwnsA5cEhnjVOJAC2GskppQx3J7mzf+u5y6FRQvpdn9qbAEOlCNqpVeuzHAG5rFWjBUVg2vnIHxolDQz1+8NakcrSOgxDoKVdxpcUnCjvHZcjG46oLD6UTmCTV3zyC+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209681; c=relaxed/simple;
	bh=Ng1Fn7eoMeabv89dHm9GWidnMSYn3mZgJSyUPHDLcPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ECZkOhIPxDPel7T2msU5Pgt9BLZaN3ZT0bpbTMCtTo5sUCTET6qEshAos3Y1UrwJepYAxUKilEG6a9K7NrgysApVnBuMVs270oIpE3SZDaKPk0/xYEs53taBUGth8u3pCGq5J+4zAxeC6nQNvoaiN3/SlB1ChGO3s4EMuKX4nkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dR/nUkgH; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78d77b309f2so322268385a.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713209678; x=1713814478; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iffer3/QisAZiMzK6e6qkKJFt6oDSvxeznUoOZCft7U=;
        b=dR/nUkgHqcw6zR6+do9dvXSf0WXbjm4Mah1O/E63yGMWIykB+MbPFCVuUBIjt0JIH4
         bMp28a9YylR73sqsnEiGdfNS4Y+isgMBS+O4YDEEDK+pSv9Iwvj1fwZapZJtouzxZptF
         2eS242ihilOPqrzJINSqG3xYAzeGZTxTti6Ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713209678; x=1713814478;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iffer3/QisAZiMzK6e6qkKJFt6oDSvxeznUoOZCft7U=;
        b=lBdP6hk/49q8kJheZajNFuvN4xqPD+QAIz4FwvWv1WVYQTqFVAZqiVJ9B8HkDMY9oR
         mBR0dT1ljmhkmQ//tG/SzULOulUIlUUcoHujYzTtRX8rVedxJhJrWupot4mL4Hxfoo0C
         JgdGB2w2pY9lLgMU1VMCKY1tOn8z+yD0fdH801K072TarIg1SDhTdMdjI8SezfcP6HgH
         6vOCcLex6JbY4iHG6HE3ZopwHyX9HqWkaRfN0GbOhYmqlsxx2StYFu+wiiU6RDmjUhmE
         niJHTR6nt9ne1e0NbTcDCrz050x+LXPofB/WxSauv2bLrEM2C6R9976Yog1q1x/7XPIF
         dgaA==
X-Forwarded-Encrypted: i=1; AJvYcCUdRk3QuiEGpL6shhmFzkWV7oQTZV/8R+ckLPfaCA2zVwxfz2grtQq3s+bu/tp5P1lToaqBWrdlPv0EafILmTZk0y4r1yxa2bz6MOYg
X-Gm-Message-State: AOJu0YxnkVklbhecTlcD83Bck4S/YClaDPM9vKVf3hPpf11D+EtsUJo7
	ZuE5zW5iUkpmaLYwW8eBd0epR9QByrTXEeXgDgcrZcdkXiIdpKqvzpyoTSzVAg==
X-Google-Smtp-Source: AGHT+IFEHU7eIzT8/HtrN2B+e04dqI5HiplT7bCOIBdeXvPZpYPaOGCG3Tv+rHX6H2GzPAb2+GvQRw==
X-Received: by 2002:a05:620a:3b8b:b0:78d:58d2:b600 with SMTP id ye11-20020a05620a3b8b00b0078d58d2b600mr11752858qkn.42.1713209678448;
        Mon, 15 Apr 2024 12:34:38 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id s26-20020ae9f71a000000b0078d3b54eb76sm6718055qkg.78.2024.04.15.12.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 12:34:38 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 15 Apr 2024 19:34:27 +0000
Subject: [PATCH 10/35] staging: media: tegra-video: Use swap macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-fix-cocci-v1-10-477afb23728b@chromium.org>
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

Makes the code simpler and cocci happier:

drivers/staging/media/tegra-video/tegra20.c:324:44-45: WARNING opportunity for swap()

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/tegra-video/tegra20.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/media/tegra-video/tegra20.c b/drivers/staging/media/tegra-video/tegra20.c
index 630e2ff987a3..7b8f8f810b35 100644
--- a/drivers/staging/media/tegra-video/tegra20.c
+++ b/drivers/staging/media/tegra-video/tegra20.c
@@ -317,13 +317,8 @@ static void tegra20_channel_queue_setup(struct tegra_vi_channel *chan)
 		chan->addr_offset_v = chan->addr_offset_u + stride * height / 4;
 
 		/* For YVU420, we swap the locations of the U and V planes. */
-		if (chan->format.pixelformat == V4L2_PIX_FMT_YVU420) {
-			unsigned long temp;
-
-			temp = chan->addr_offset_u;
-			chan->addr_offset_u = chan->addr_offset_v;
-			chan->addr_offset_v = temp;
-		}
+		if (chan->format.pixelformat == V4L2_PIX_FMT_YVU420)
+			swap(chan->addr_offset_u, chan->addr_offset_v);
 
 		chan->start_offset_u = chan->addr_offset_u;
 		chan->start_offset_v = chan->addr_offset_v;

-- 
2.44.0.683.g7961c838ac-goog



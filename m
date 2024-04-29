Return-Path: <linux-kernel+bounces-162535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 237538B5CD9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD84928332E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4680E126F03;
	Mon, 29 Apr 2024 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W+V1pyMU"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4571F129A6B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403121; cv=none; b=S5OvDaqMNGkrdNyKAFuqNKp2Oqhz7sTCnSF1A6F0sk3fbTv465OurWEZ1b6x0qOyqAiYdKjQ4w3bRDcFamvFgjfA/9ekOtE3sQgkZpT+Mv8DlrMp8baZN3ZAJTm3nbs9yrp146z3YMNnKbGIxDystKSRvsBLA2mmPo4QoLB9vYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403121; c=relaxed/simple;
	bh=o6W/vqiRX5/Lnl4n/KralCP6cqo+hBRj8ijp3AUHwA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o9FV9TMLKs5WZbm9Gx7wdKvrf4xoOIJN0RRF/sJYF1/WnuIWzEgh57WMISpAz+2Iq6b2tIQ2VaCwhz/d8p2w+rD3rEKystuBFHS5AcqBTBLDafjlEDW7rftZm3PM9Hy83IBrjunnnsx5L9wzgBSBGOcUS3JKEKg8f3g05iGiLmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W+V1pyMU; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-79100a90868so29725085a.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714403111; x=1715007911; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmuUSFnHzqjHSVO6x2xCi4IdU77yIJvh23Ivq0XCHvQ=;
        b=W+V1pyMU/pnRfJkgi4LCSV4mUqTbVT83LYrZeCJb938fWxHKuhrCsccd3CuhlwQfPP
         226aTPb53vFC3gPaJDYBQuuhcj1A+/gA4dyma6X/eD8XCNOiapVAfUEj58Y2QXbfnHxx
         diuNjYqFLxnmUJqwX3fLr6k7vrMivTqUlBfgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714403111; x=1715007911;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmuUSFnHzqjHSVO6x2xCi4IdU77yIJvh23Ivq0XCHvQ=;
        b=bMlBb1xWl8NtDwu0L0bjZpju1XHvzWgc7pATk6onU2je2aYLM0gd3eUAIbm533Pe1X
         WxnpaqSn/iYujFBRXSia0KhnTm5Y3HaVObaMc6DtnCoBrybbxFWRqo92pRQ7MEJ9kLsK
         AJ/uRIGx0RQC/ihhXWE3/JkDShLsQN0F5eHLS53kmbVw25PxBR2kaU6LeiINh6e2eXp9
         JN1VHN08q+xOpfKIBOpzaz+q1lSFZ062qSO3Y33jGzbBdvPVDsTmVTpSGwwieFCHIDP4
         imz8swsYV3CVtk4u4ZdGZHEOlKffkv0wsq+FHBDwjVXyRQmT+cgUb8KQrU50KVeVeJ3/
         F2hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlUImXBiYjG8YpnyE4BEOLmkyXFfP8lS6QLookj6SlMaVKuHVzcayf80zlL0ZFrmgRYEUM6a11i6AAADiLjsuK+P8Y8OdZHnN3/ftN
X-Gm-Message-State: AOJu0Yze+YaaeYJRtfCcnNIIaeacGb4nVXQE0kNTklilzCaO+qTL6Bul
	Ll3Cec1pmp1+ycrHJIOO40vlEhVEOoVvCRGqOuJRO9ut/zkokAcg2JcHXhLXcA==
X-Google-Smtp-Source: AGHT+IH9sz0tcRc5gxc3Hn2yH4aEBZFdiRiwY4P/N3aVh4I90x1YrGS0c1n2StA1reM2wgrnpB/ryg==
X-Received: by 2002:a05:620a:1665:b0:790:9e62:787f with SMTP id d5-20020a05620a166500b007909e62787fmr11023549qko.28.1714403110567;
        Mon, 29 Apr 2024 08:05:10 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id p7-20020a05620a056700b0078d3b9139edsm10568591qkp.97.2024.04.29.08.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:05:10 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 29 Apr 2024 15:05:04 +0000
Subject: [PATCH v3 25/26] media: dvb-frontends: tda10048: Fix integer
 overflow
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240429-fix-cocci-v3-25-3c4865f5a4b0@chromium.org>
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
 Ricardo Ribalda <ribalda@chromium.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.12.4

state->xtal_hz can be up to 16M, so it can overflow a 32 bit integer
when multiplied by pll_mfactor.

Create a new 64 bit variable to hold the calculations.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/dvb-frontends/tda10048.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/media/dvb-frontends/tda10048.c b/drivers/media/dvb-frontends/tda10048.c
index 5d5e4e9e4422..3e725cdcc66b 100644
--- a/drivers/media/dvb-frontends/tda10048.c
+++ b/drivers/media/dvb-frontends/tda10048.c
@@ -410,6 +410,7 @@ static int tda10048_set_if(struct dvb_frontend *fe, u32 bw)
 	struct tda10048_config *config = &state->config;
 	int i;
 	u32 if_freq_khz;
+	u64 sample_freq;
 
 	dprintk(1, "%s(bw = %d)\n", __func__, bw);
 
@@ -451,9 +452,11 @@ static int tda10048_set_if(struct dvb_frontend *fe, u32 bw)
 	dprintk(1, "- pll_pfactor = %d\n", state->pll_pfactor);
 
 	/* Calculate the sample frequency */
-	state->sample_freq = state->xtal_hz * (state->pll_mfactor + 45);
-	state->sample_freq /= (state->pll_nfactor + 1);
-	state->sample_freq /= (state->pll_pfactor + 4);
+	sample_freq = state->xtal_hz;
+	sample_freq *= state->pll_mfactor + 45;
+	do_div(sample_freq, state->pll_nfactor + 1);
+	do_div(sample_freq, state->pll_pfactor + 4);
+	state->sample_freq = sample_freq;
 	dprintk(1, "- sample_freq = %d\n", state->sample_freq);
 
 	/* Update the I/F */

-- 
2.44.0.769.g3c40516874-goog



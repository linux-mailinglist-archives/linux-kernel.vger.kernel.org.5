Return-Path: <linux-kernel+bounces-151272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB31A8AAC43
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A7EF1C20CAA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA2013281B;
	Fri, 19 Apr 2024 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fkTLAX1A"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3701130E5C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520190; cv=none; b=gLD//+0/0dgnYgeiLsswOSpgekRhCTbyIWglv3OlLKciHISVcelOXM6sgwEJmhcVUpLQCFEHv3yh8zyCYQTVrwOppXXo2v4TsUJ2x9rXwbI3nxkRjaF0J5HrA2f+trwMPAy1fJ74l9kqdNufLPsIwJ8kKoNs3jDbCtxuDrjra/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520190; c=relaxed/simple;
	bh=o6W/vqiRX5/Lnl4n/KralCP6cqo+hBRj8ijp3AUHwA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B9RAyySapB5YI5jVN7ab6/E7n+/OoY+ao8yYTAL1ckRjkjgaz4LRsuS9vr/R+7jQDPJ9d79aGJhfYI0Suemljx1USt+/R9LlGxAWaeu7ws4/sZxPeqxSGNOHeFgXr+LXQNnIxo8YGFOMBIqZ8NZVvrHL8nc+zi8Zvv7JXvWB+gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fkTLAX1A; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78edc49861aso124954485a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 02:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713520188; x=1714124988; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmuUSFnHzqjHSVO6x2xCi4IdU77yIJvh23Ivq0XCHvQ=;
        b=fkTLAX1AOsZvhNrYs4pzfF+g3qT25dJu3IKhvdTzopFrQQoePV4MlxmLj3n3nZ0/HM
         A7l0a++14xaFQNQnEAjmKloJvPkfU2L2daz89mmVfFFzBle9vRg6UzEB9QPIfjT4DUmG
         Uac+zlI7rDdDxZMO48Bb7Qyt3lugaJpIeHKbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713520188; x=1714124988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmuUSFnHzqjHSVO6x2xCi4IdU77yIJvh23Ivq0XCHvQ=;
        b=rb3PEC+rsIEnCV+1O8lUZzikavKVS27qVgjZaOMiwlllZ6vS9VzvlL57U6Y0Mil/EN
         HkFATBEjFxC4HNZfvOi6ScNPquqxiS3sXUiyxnQKXCgCZfef13mYkrzOgppiRg+R6PBD
         pxLm4id3Vph7FtsNisTJ90jF/i3x1Q3ZZV8TLa6hgTDfy2KeoItUmq3pYjqPplEs1mCV
         EUWN9DYYy4emx5QWJ6MEdS/5l8j/xYUea47tP8VyAAUK4B1a92bJzXCQDFJX3YGQP8U/
         1WDY3c8gXde92ZZbTSsa7PArY0gUHdmDkgMbwfFTDrt23C+ssTE0QwER5MOCaNzBopjm
         JaTw==
X-Forwarded-Encrypted: i=1; AJvYcCVq0ocsoccooWzxotsnYiGeMIE1b7O0IGe84YznvCGo3LY7cRMFY3F1lLlzS8iLBALkQimOgCrT243chx3+ZFfo7sK2G3ZIQcIQ09Qw
X-Gm-Message-State: AOJu0Ywx8GybhfXRyNRfb0F0+NX3C5JhiT3zgGJa/tb10C/659ewvF09
	Iwtslf7Ho7u0raNCL0XSQa6ha0K5dqm2DMAOZaeO4Zqhf7wX5uNhaM6lyf5NXA==
X-Google-Smtp-Source: AGHT+IGwmCCN5wh4NaLa8aArMkOF/G4Igcbkk8uWKtclUOXaJ3Z6Gx5Noog7Zc3uSUISJQ5MgoV6TQ==
X-Received: by 2002:ae9:f50d:0:b0:78f:1044:bcc8 with SMTP id o13-20020ae9f50d000000b0078f1044bcc8mr1806809qkg.61.1713520187814;
        Fri, 19 Apr 2024 02:49:47 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id dt14-20020a05620a478e00b0078d735ca917sm1434532qkb.123.2024.04.19.02.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 02:49:47 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 19 Apr 2024 09:48:11 +0000
Subject: [PATCH v2 25/26] media: dvb-frontends: tda10048: Fix integer
 overflow
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-fix-cocci-v2-25-2119e692309c@chromium.org>
References: <20240419-fix-cocci-v2-0-2119e692309c@chromium.org>
In-Reply-To: <20240419-fix-cocci-v2-0-2119e692309c@chromium.org>
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



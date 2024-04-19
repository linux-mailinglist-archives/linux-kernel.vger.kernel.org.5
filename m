Return-Path: <linux-kernel+bounces-151273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 385498AAC46
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAD14B22FB4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B228130AFD;
	Fri, 19 Apr 2024 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZuGUNop+"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECA1131E4F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520192; cv=none; b=SoyHXwhBazSXxClHLtpp9dgCBbXcqlcKJljhhsu4F4rps8PCTN0YmRrpKSzG2fdquQmJ1HuSb6Q5dtgIqDhPYi08hJPbn+EBObpmIfJZvQrOEAdmJ/gSDQqlbrhbFtOtp5cnP2CeGD7hcJ88Spa35KBL890fDiee56cyRV8v6MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520192; c=relaxed/simple;
	bh=17e3seaVPIolCVRnz9dvrXMTILwJmsuH1BK6VcvWdM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lhTXK99bMswqKK7iiD14lWAivG19PAEj/H2z2CzSwzl663tFFvVYWN3vYA7TsY0D/gw4t/JsHILH1Vl2tw1ZxftaLQaSO0EXAs28by8OiWBOTZDOIjDvYR0VB7WkimxwNz8tbeY1gl6lEjpEtw0XlFz/l/8c2KPkXATYn7WxHGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZuGUNop+; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78f05e56cb3so107464485a.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 02:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713520190; x=1714124990; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=STqazHEagBxWlHC69lQFp5WbvQ2Sdx8rB6+uKcUB0cU=;
        b=ZuGUNop+tH0RgKocDXxkRsVvrnFasZvANqzDP7sflrJPFFUsa99CxGy6YdeSw9dE0Q
         nqbKRfp8ZCqtFkO7Qfoloi52OJnTlT79PnBwIwd8OPmT8ZYTH4Nmsnol+D3dWNNhuFAp
         HjSltF1Pp9wdOf7NKt3X4R/38ctkVkgVSO3Ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713520190; x=1714124990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STqazHEagBxWlHC69lQFp5WbvQ2Sdx8rB6+uKcUB0cU=;
        b=jit3LZW6gWAE5e6InLWcaHBjmLWBtYglmGr528cCFFIEDIniZEt+lQoU3j7PH2NdX1
         OhpC6CVPD7SW83Q20J0JfGNENdzRpmQxtJW2VJ9sRiLJ54vflRBRPA97If+LDlciYWhz
         6xBUz+U4o9pwuA/QFrjAczBNoqzwsygCKzsnjsKnJhrIpnNQQibdZ75WYeCU5blfuyt3
         XbJW+0BTdoZvztdKnNLQHb7Gwpiq/wdvLDUIxeWdXa6uW275W+j5+tB9B1UGAfa5hH/A
         Nqk51rDTmMAKhjiFWrMoaglqI+ODmrQSonsdKMsFvTJyVS7tjKH9cRidEnsojpKKJ2r+
         i2gw==
X-Forwarded-Encrypted: i=1; AJvYcCX1lrLUbqeOCJIgppwnACz3+/EbTZL3eFyvx/LeWXQWqihlO3uHNU1D2G0eFwAHn86C14CVX8faDJvjosRRa8NjxhVREgpgq9FPKip5
X-Gm-Message-State: AOJu0Yyy7VoK3FohsKTlru7i/ZC9s8t8pe1oiKhhArsl1Sr06GKl7GC6
	FScSaosZxApDPgqRAAyTQTjRiAP5UKYa/SXoXACmzMY8YXYjmoeid6oMEcPQpQ==
X-Google-Smtp-Source: AGHT+IGB4W3xcDVnLVL+1B0lbE5yrHeQCLWo5Y0evN+/+oC4NuGMNOIMrDzfkEb/6TpNH9rKrh/xtA==
X-Received: by 2002:ae9:f00d:0:b0:78e:fd3c:b6 with SMTP id l13-20020ae9f00d000000b0078efd3c00b6mr1503480qkg.40.1713520189085;
        Fri, 19 Apr 2024 02:49:49 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id dt14-20020a05620a478e00b0078d735ca917sm1434532qkb.123.2024.04.19.02.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 02:49:48 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 19 Apr 2024 09:48:12 +0000
Subject: [PATCH v2 26/26] media: dvb-frontends: tda10048: Make explicit the
 range of z.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-fix-cocci-v2-26-2119e692309c@chromium.org>
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
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

We do not expect the sample_freq to be over 613MHz.

Found by cocci:
drivers/media/dvb-frontends/tda10048.c:345:1-7: WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/dvb-frontends/tda10048.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/tda10048.c b/drivers/media/dvb-frontends/tda10048.c
index 3e725cdcc66b..1886f733dbbf 100644
--- a/drivers/media/dvb-frontends/tda10048.c
+++ b/drivers/media/dvb-frontends/tda10048.c
@@ -328,7 +328,8 @@ static int tda10048_set_wref(struct dvb_frontend *fe, u32 sample_freq_hz,
 			     u32 bw)
 {
 	struct tda10048_state *state = fe->demodulator_priv;
-	u64 t, z;
+	u32 z;
+	u64 t;
 
 	dprintk(1, "%s()\n", __func__);
 
@@ -341,6 +342,7 @@ static int tda10048_set_wref(struct dvb_frontend *fe, u32 sample_freq_hz,
 	/* t *= 2147483648 on 32bit platforms */
 	t *= (2048 * 1024);
 	t *= 1024;
+	/* Sample frequency is under 613MHz */
 	z = 7 * sample_freq_hz;
 	do_div(t, z);
 	t += 5;

-- 
2.44.0.769.g3c40516874-goog



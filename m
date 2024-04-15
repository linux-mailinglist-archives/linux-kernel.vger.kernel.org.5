Return-Path: <linux-kernel+bounces-145805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9032C8A5B15
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D712829D0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1992E161336;
	Mon, 15 Apr 2024 19:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SJfEEZRo"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E8815FA8A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209696; cv=none; b=WPISDdRiTYeb1VzTHsyOZS/v15VXB5DMy35u388MLvs625E9Ilg82ksujFszz2gvh73ySdYDpKiOqs5LSzaw7nHlI9Dl0CWHSd+wsrhP4ZML0ojcDorM2EjzpVo7jmgEFqV11Z1t8W2DmCnasEdBZCTXWJuM2RrTJFx6Ax67CPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209696; c=relaxed/simple;
	bh=qucjJRatI3PfJXMFAbwTvimzuU4TaNNx4LV+bRg/m9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q7WjWiKcPoAvTv0FcmIV06b6n+592TN4HUsc+kUHWJceBIgKe/130Va4RIbE2cROeu5OTtxGlOXqHNERHa4MVFNC0iuGBvudkSXjz/D6xo4MJlozOUmD8t6yq08Pf8hPKKm0+f6mfjoPXG1bD8YQn+l1c8ZfE+IfsQ0K72+01Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SJfEEZRo; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78d6021e2e3so286101585a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713209693; x=1713814493; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/qWsKtiTtM68cPujZgkDbgLJScEQ/KU6IejvF8XzFy8=;
        b=SJfEEZRosqeBrY6kbDJCIviJYUZnRFBODKWFVABQv0Hj9roXmM1Cy+EJdXFatneMG1
         WwV/Eba5DMX0Y2rrfRWGyfJ4E/2CQNf4uKuDDK3rie3CM0y0uzx/UgPwY+u5bupGZynh
         VhUCc9xWHZmYcyI/p+b9jNM0UhxOd04CrfW8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713209693; x=1713814493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qWsKtiTtM68cPujZgkDbgLJScEQ/KU6IejvF8XzFy8=;
        b=GD6fHP23YbDXajAj88VuHRoM2GVTsmrkbVBob4tB0PAd7G0v3YHKKtpVu1wVBm6S9z
         6YMsg9icYfdZCJQPZpf03uHywqKk4g3lu/sazuFQ+GT24aNxX/mC9YCQ5jgRrWJntWBx
         GOSxHqAmV2X2jhtu8aRpG4nkmiZcDnW9z/MqzRQXkYdqMtq8GOiN71vSh/+uVJj+nodQ
         cC3WQfvCOJfddZDT1DShA9OZ55EO4jmjbBsamwdOT9d56gyJoI49iTd9RizYWTSO5pIj
         pkWngtZQGDiyQblzhe7FrBs55CD1dPxqyWmd+TuMK6yOMKl1pnXFC3CEDG9ngaIC7rCH
         7sGg==
X-Forwarded-Encrypted: i=1; AJvYcCVt4m4OJj9X29aEqCZQ2HcWUUKD4okggh891GJBeXwJn7LeVeHnoe6TtPF8p5s6cHCQxDHVzNe6qCFrBxxOhjR8B6LMKCfNsEmjq8yK
X-Gm-Message-State: AOJu0YzVFo3GUZbcVvdSK04JDk9E1zY6sycRKxtsVrOIy4YfXocDemPL
	Rg48cLMJ1Zkbf2UVu8odSwsAMEPnh1+xk2kioSaPQE72mdUIm5kALbWaJelgjg==
X-Google-Smtp-Source: AGHT+IE7tE6n2LOOWlxUIvgFNmo/Vr0dYpoxwwqjlaXwS/vDwhHd4c5esyFK2/v/y9hDaMP9p/kqqQ==
X-Received: by 2002:a05:620a:410a:b0:78e:f439:64ee with SMTP id j10-20020a05620a410a00b0078ef43964eemr19862qko.72.1713209693277;
        Mon, 15 Apr 2024 12:34:53 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id s26-20020ae9f71a000000b0078d3b54eb76sm6718055qkg.78.2024.04.15.12.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 12:34:52 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 15 Apr 2024 19:34:39 +0000
Subject: [PATCH 22/35] media: i2c: st-mipid02: Use the correct div function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-fix-cocci-v1-22-477afb23728b@chromium.org>
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

link_freq does not fit in 32 bits.

Found by cocci:
drivers/media/i2c/st-mipid02.c:329:1-7: WARNING: do_div() does a 64-by-32 division, please consider using div64_s64 instead.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/st-mipid02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
index f250640729ca..93a40bfda1af 100644
--- a/drivers/media/i2c/st-mipid02.c
+++ b/drivers/media/i2c/st-mipid02.c
@@ -326,7 +326,7 @@ static int mipid02_configure_from_rx_speed(struct mipid02_dev *bridge,
 	}
 
 	dev_dbg(&client->dev, "detect link_freq = %lld Hz", link_freq);
-	do_div(ui_4, link_freq);
+	ui_4 = div64_s64(ui_4, link_freq);
 	bridge->r.clk_lane_reg1 |= ui_4 << 2;
 
 	return 0;

-- 
2.44.0.683.g7961c838ac-goog



Return-Path: <linux-kernel+bounces-32876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 168C3836143
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3591C21DE5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB013EA8D;
	Mon, 22 Jan 2024 11:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="j08GBO+H"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15453E48B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921907; cv=none; b=WCbl58osGsD22Ah98qB20Farh7H6azas4GxthE6UifbhgB+MjaQxBU8DxjGEa7CUFf5BINCjxxcn8NYbPJfK9rft7Dori9qUZGM3O/fHf13i4ncatZgeHcj0K88R2XK90T9JwiaoS04g98ITKBn3uIVVFyYp6fH9W6e1yEPp4Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921907; c=relaxed/simple;
	bh=P0pml+XvYXypPwvm13fUsxAbzg1yShpyAM0plENv8P0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VX2hQsK/Kw0NycpdV+iGdmeDySoTBTU6RXmKcK+8AOavcqVB4in1mNapjfI5jQuVKKWrNXxHoS2WoX9s/Cllsn2AjJs81iOhuheWfJyROxFJcxrWoQAnn5QRgvw1Cyw5eU/ghOxyXWsTsN2RabL9pULnljeOsBY5BJiaUZaVxPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=j08GBO+H; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e7c6f0487so3130889e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1705921904; x=1706526704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZsglpxv5Ruw+cmAq+FH/8gH/cxWxlJ7CUyURo/5TWs=;
        b=j08GBO+HdsEhh9qo0bkJ0Iq+yLSlU17x8z4tsHgTSLz3QSK4n1TXEKFSaZLpIIhT11
         Ciagaz+eq2hept+9BLQunqdMrB3HhMsFnFGIQb1LnLcv2guMU9voif9yadlm/AqilRTv
         n0Kb9fGF62aBOHnZ/lWJ26VOTTt61VbraAUFGdwIdmhq0UGAYSVl3lZ97U0v6Tl0IJAJ
         vEhwFy2RtsHKeZSWrP5brLIzCwMliwHwhS5c6Zt9VtG4pK2u3R0x3GIwe2L7fZ1QaL3d
         8BbPIjrzgVHeCuBPt94j+ACTU7ke/4W/nuj1wJPPsC1+sz+HEQTH5a8VsTpweOikXpVd
         dGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705921904; x=1706526704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZsglpxv5Ruw+cmAq+FH/8gH/cxWxlJ7CUyURo/5TWs=;
        b=UC6/n5Yoc97mPWOAslqlLRrAAqj/YxCgWNvaKtEmw81OiiDkIpYBQuxr6vSaOQP8Os
         AUcAxqHNVdjtUb9cuif9MA8PAZ5dZvCUrR9I4XibGEPz85NRZU39W5S/4vX3b6f4WqYL
         YS0LWuPZ2mm0UJ1FWJbVzjw5hg6linRIC1C1CS+jeH+72ZyPcrH6rnM6nFYbJ48VaL+o
         QVhWPnBTKzUxy11g73T7NDpGJhSIAZk6No7Bkc4rYKbqpO+H9ryhrkeeOOlp2T1OpMfR
         wu8Ze9acggnftphtclAaVG22aTeIrQ/kvopXFPKClDBK0F584u4RapKHsNuAHNUmZXwC
         g3gA==
X-Gm-Message-State: AOJu0YzQEaIpAfGzbpIFoW/z82cTWNA0XJ9AiJj1ftdBA3LSKc9FQ623
	edWAIvJLUdoqy1TO6wOik2QRmxHvcGZZKJ3NS1ULfa4aWrndH4I5ztyaQYG22z0=
X-Google-Smtp-Source: AGHT+IFdtngNav7jLN7NRbMBgpNlKLytDtSGZw9R5aAcExfwEd7H5jWK1DXLkRkagwmRGN3K3IIs2w==
X-Received: by 2002:a05:6512:3e19:b0:50e:e2e1:9cc8 with SMTP id i25-20020a0565123e1900b0050ee2e19cc8mr1209162lfv.117.1705921903651;
        Mon, 22 Jan 2024 03:11:43 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.135])
        by smtp.gmail.com with ESMTPSA id t34-20020a056402242200b0055823c2ae17sm14194241eda.64.2024.01.22.03.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 03:11:43 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	biju.das.jz@bp.renesas.com
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 03/10] watchdog: rzg2l_wdt: Check return status of pm_runtime_put()
Date: Mon, 22 Jan 2024 13:11:08 +0200
Message-Id: <20240122111115.2861835-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122111115.2861835-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240122111115.2861835-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

pm_runtime_put() may return an error code. Check its return status.

Fixes: 2cbc5cd0b55f ("watchdog: Add Watchdog Timer driver for RZ/G2L")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/watchdog/rzg2l_wdt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index 4ab9e7c5e771..0554965027cd 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -144,9 +144,13 @@ static int rzg2l_wdt_start(struct watchdog_device *wdev)
 static int rzg2l_wdt_stop(struct watchdog_device *wdev)
 {
 	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
+	int ret;
 
 	rzg2l_wdt_reset(priv);
-	pm_runtime_put(wdev->parent);
+
+	ret = pm_runtime_put(wdev->parent);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
-- 
2.39.2



Return-Path: <linux-kernel+bounces-49395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EAB8469EC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21A728D80D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A19E18030;
	Fri,  2 Feb 2024 07:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="fvEVnsR4"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48AF1802B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706860744; cv=none; b=LhIKEVRIDNYK3AmVRwK/00Fo9z/UydmTok22YvP3do7Few/at2DFnPhXmkuMsgWV9J+uaT2yA1MZBtuGQO+1jzgu/+iCyd8hNf1K545ElZdJC+XE09ZeSchcX0lMEpB0u3nbhLcnrtvfkxiznJJn8h9mzvvjjlQUwVVC9EvLi5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706860744; c=relaxed/simple;
	bh=yJzsH82YeRNBn2dhKcVTfTPMcEuF/ATViwGVT4cd1I0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qa8gkAcF8uAFYMRZ9v+8U4dIZzpv+P3wZmyAU/bvNhggSSp2SSwvMvb0OXFXhu3epOdxqRl3+/g6LCPRji9PDgg8n/+wCy80Eel0c/GnfRROq9IBJfNgNnXVqSdeVQGCXtTOk36oEpRaDuUxTH8lLtf7eynyycY0gr8LWrxEwj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=fvEVnsR4; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a359446b57dso228177066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 23:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706860741; x=1707465541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8cCr64N1JsMEoZ+1d564+a2bzrjumeQcr3OZEAgKNY=;
        b=fvEVnsR41ED3r8njay+mnxtagW1ChbRZIth2uKgrsYfAM3gLCDOHBw8x+QQG3harbC
         amzSBB1QDTAA+LEQTyry1XL8ZQVF6d2rG207jEySRIwhqnfY4JNeOvtwZ9kO4/7aKoFU
         IluaAqXulxXupc+DZ5S95pDM/TxXi2/9rA70pY4Gf4A1dJIQl/lPKzH1syO/n6qzfz5k
         OZNxi1b14CnwInaiAEc/g3/YOCVIy8xTz91v3vmiQ5jGK3dQYMMvSuaKHLBSfCWd2O1P
         a+HZzWe+2MKUBiQcw6wlNCQtJXsCXox2LMteiHBMpWpYv31AbAKVK+mxoEltnEKckoXn
         5DJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706860741; x=1707465541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8cCr64N1JsMEoZ+1d564+a2bzrjumeQcr3OZEAgKNY=;
        b=MmUsJefZ55fs74lHQGFTdJHm2LoFzGLdJ1Q0QAggZ2Ni57KPK9C3WuLYEm01YhsaRe
         eSttjCQwQ5g2QOkIhP5yT307u3GRDStt/X3n5Z/RCH2f7UrXv2/Hzatn/TDMfOXgB5rE
         DZUWs92Wk2vVkuKE8tJ7yk6FnLzuIsrtCyyjwsge+vlv9C/T/uNpKCC8z00ZBycXKtKC
         Js0IEeNO/Oxbi5XqPcNVxzhKBH5aW7XH1qAB/SObEuXCu0uPlowYez81aKh6JoDLACHC
         TvvIGhQa18xp2nzEmpK7+1LK/HWeX8HXvxg/R3wHZV6mF+LSK8Ey47etpC6WZgnHdWMQ
         XJPw==
X-Gm-Message-State: AOJu0YwAl/WAATaz7QtJgNFTJwpycoaKQOKNUn5lhL7JYU8yIFGNt9Va
	vpQaZXtWTzEA4sTmZyZ3n5O/2Ygdfdb4AUTO6FAyUUs4beINH4PPPwiub4TzW8Y=
X-Google-Smtp-Source: AGHT+IFFbL8f/zx/vqzroKTiVtZ5zdjrkPN2Yj0z8oMCooI4WYUUBwMYUO1j0qIdxey58Qu39uCrGw==
X-Received: by 2002:a17:906:354a:b0:a31:13ce:d64f with SMTP id s10-20020a170906354a00b00a3113ced64fmr3285200eja.55.1706860741109;
        Thu, 01 Feb 2024 23:59:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVpTJHJKxVg8GTn4YDufRWJrrmsQBL8RUvAsU3w2F+15W0zkRQwDXjoxxi/zMh5TVzZlgLZciqOSamupsEtYH62KXZl09xdqfR+OVXVBJ25HO8UkYq1dREq1Qv+fSqJygBfTOj41vOT/JArPmJGG6pYgcTctnugIN/OXR/6veFjTUWRdGlbmzpqfazq/5Lky2/1NnvcZyl1kj8r2lbR8fJmcCdjaFH22hLXGkLrs/6M7RWVtY601axImGsZLyRYMlPWigF83LwdQ7KQ1qetJpUcTbC4rfDXqQgeNR1fAtuVMhr9Ye9XiM2FZ0s/MxIo6gzYcuCqABTApCTvbJjImV5NM8MVbXvqrmoBLeHqeSMDlP7aiE1dTx6gzYt6q6g47TxVwJMl8Y8n5f3cDfULSEQgdR46ptR8ioHSeH0a/RIJg0YS5lhEMT1piy4Ne4kb7YbA9VcCRqX0/5GpJ8ppxHBxNQgt8c+WPulasy2nIIO6DBprWx6Ruo7U3O3PvkIsaBF8BWLSaHCK1A==
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id ty13-20020a170907c70d00b00a3715be38c4sm185544ejc.210.2024.02.01.23.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 23:59:00 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 1/8] watchdog: rzg2l_wdt: Select PM
Date: Fri,  2 Feb 2024 09:58:42 +0200
Message-Id: <20240202075849.3422380-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240202075849.3422380-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240202075849.3422380-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The rzg2l_wdt watchdog driver cannot work w/o CONFIG_PM=y (e.g. the
clocks are enabled though pm_runtime_* specific APIs). To avoid building
a driver that doesn't work make it depend on CONFIG_PM.

Suggested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- make driver depend on PM; with that the "unmet direct dependency"
  Reported-by: kernel test robot <lkp@intel.com>
  was also fixed
- adapt commit message

Changes in v2:
- this patch is new

 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 7d22051b15a2..c9abe8f307bb 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -910,7 +910,7 @@ config RENESAS_RZN1WDT
 
 config RENESAS_RZG2LWDT
 	tristate "Renesas RZ/G2L WDT Watchdog"
-	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on (ARCH_RENESAS && PM) || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  This driver adds watchdog support for the integrated watchdogs in the
-- 
2.39.2



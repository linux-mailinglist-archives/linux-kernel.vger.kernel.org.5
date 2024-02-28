Return-Path: <linux-kernel+bounces-84678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE77486AA05
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345951F260C4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3B432C8C;
	Wed, 28 Feb 2024 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ZM/U2kNr"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA0D25778
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109201; cv=none; b=akAx3LN+W/e4EECMqXZlf0j6zgcTrXfqbkWZiQ4uB8fo8ZhvwKGU1MSWa/kXlWt4ohR57iDRF/FWsZiOc9+gTi6KKcSERhNEjmujaWIZ3n69SLgQvFD4rj/4TTAiNgAnyiYzofRvZ/fdl5c20FAv0EGBEXvsJg7XtQHOm18zqMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109201; c=relaxed/simple;
	bh=4KW2eteISFg901CtKgTrDBwePA4eC/YGUAT/SCGnHTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OZU1aVzwkPZQFhqUS54Ao7nT55vKxWuMfcEGws8qTlp13g0TXLXW7QtkpLFOFO5ltkgiL8T5tmxUGU2aqai/Or3ACZsz6FW5rvMCOOX3EqcgYMuf7msqGeY2oL4MBt2UZ1wxFvJUHudVvewM3QFPSF3parJfIwNfLuTzBo3PCfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ZM/U2kNr; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-564a53b8133so4388296a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 00:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1709109197; x=1709713997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnFYEJs3Iq+V6PjN2KZQWymEIOW45yt0wje1tPFg4A4=;
        b=ZM/U2kNrbg19oicg0+uF52u1KwzkGtSQE6bPraHG/u6xA7CkK/nVHrnQRpjOZDP8yt
         1wJiZUP97YwBEqbCmGALYnahyyxN3SN0STzct4OQAhZjpNTcsxFo/ygopK5XwXoxWq4x
         5hfVQuAOWtHgFQzNPlCRss0afFRFoo/bB4LHR8eKXKgutvig9wEXhBLvTkUa7pPLPNSS
         JQB3JVbvcqJsEWdOSuJTXOByFFrNWPGf/2M1m7nF+dL+JOnidcFfVtoYTsONCDsm3b4G
         +CpKXMaSfAyq1FZ7ztE2NeEqu3kRoveRVzP7f1j1Ejx7dJkhw3cIanx7sNvKIPa88hdY
         iDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709109197; x=1709713997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnFYEJs3Iq+V6PjN2KZQWymEIOW45yt0wje1tPFg4A4=;
        b=rDnNW0rHi7b0Grxim1fLzuGzLl06qqK1C/f1q1m3GVHBvUWPDOWe0Zu9kylFKuC6vf
         nIldhYxZ0PaHzqUohhtHEJjWniaF/bPB+QeDt/NItL1F7h0/ORC9JlPovgaBHew24PkX
         67/szeF2wEzywMqewZmZF/PKDQj07r4PIGWFGiHKWfqBtH3J4aec247gbcaGqhda0ehp
         im6FmlHXOfLYnePPN6w5pZKPhAIOI8c+pjFL19RTP8vat73mhnmjEnYeUI8Mm+M9NSGF
         mB+aGVyN1ejDmh1nqORHj9P9m+vPD8yoLvqUHx/LmyN0lUxlGBrEoq7FsXKpU5TSJ1oY
         /5qA==
X-Forwarded-Encrypted: i=1; AJvYcCUokqv93miV8XACpQpAY5bOUeiErtyUuXSjdle3/vfBmbtGDuWf+9Q6KiVcEOVbZZKzxCbWacSu9fxGEJK5L4UPy1O49uQp8G9+VIW2
X-Gm-Message-State: AOJu0Yzf7kCP5P4BuOINPeSPIuQPokmxJSCioF21ttQC2iIJiIlmfIrW
	ZzeCZuDxqo082RME9ILKdhw2zkcw+8Pcj9hiDNv5ZCWZJtTGn2M0p9SLS4h8nSY=
X-Google-Smtp-Source: AGHT+IGZRjze950xjJVA2VcumQb1pOfGPCAVAzPqLCiaxYnVRKaE4zgI53TtdNhF3uybSJmX0D29Ag==
X-Received: by 2002:a17:906:3b55:b0:a43:f927:4432 with SMTP id h21-20020a1709063b5500b00a43f9274432mr641705ejf.77.1709109197347;
        Wed, 28 Feb 2024 00:33:17 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.83])
        by smtp.gmail.com with ESMTPSA id qh16-20020a170906ecb000b00a432777eb77sm1593987ejb.60.2024.02.28.00.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 00:33:17 -0800 (PST)
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
Subject: [PATCH v8 02/10] watchdog: rzg2l_wdt: Make the driver depend on PM
Date: Wed, 28 Feb 2024 10:32:45 +0200
Message-Id: <20240228083253.2640997-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228083253.2640997-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240228083253.2640997-1-claudiu.beznea.uj@bp.renesas.com>
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
a driver that doesn't work make explicit the dependency on CONFIG_PM.

Suggested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

Changes in v8:
- collected tags

Changes in v7:
- updated the dependency to PM || COMPILE_TEST to be able to
  compile-test the driver when compiling for a
  !(ARCH_RZG2L || ARCH_R9A09G011) platform and CONFIG_PM is disabled

Changes in v6:
- update patch description
- fixed the dependency on COMPILE_TEST previously introduced

Changes in v5:
- updated patch description
- added on a new line the dependency on PM and COMPILE_TEST

Changes in v4:
- s/ARCH_RENESAS/ARCH_RZG2L || ARCH_R9A09G011 due to patch 1/9

Changes in v3:
- make driver depend on PM; with that the "unmet direct dependency"
  Reported-by: kernel test robot <lkp@intel.com>
  was also fixed
- adapt commit message

Changes in v2:
- this patch is new

 drivers/watchdog/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index bdd1527bb916..cd2e29da7a54 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -922,6 +922,7 @@ config RENESAS_RZN1WDT
 config RENESAS_RZG2LWDT
 	tristate "Renesas RZ/G2L WDT Watchdog"
 	depends on ARCH_RZG2L || ARCH_R9A09G011 || COMPILE_TEST
+	depends on PM || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  This driver adds watchdog support for the integrated watchdogs in the
-- 
2.39.2



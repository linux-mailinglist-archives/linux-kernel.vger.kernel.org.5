Return-Path: <linux-kernel+bounces-67051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B202185655F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E543F1C23D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DB4132479;
	Thu, 15 Feb 2024 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="NeAhvv37"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E943131E4A
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708006137; cv=none; b=B2/YgdGBe4qlrsU9SfawMo7JDObJWcWO+o7wwEvC9fwM9XMxunCqVIG3h+rQMi8ZufE4Tkxt+0YidD0jugmUNgCvVHB2j322xIN8kvGtYR5nTGvTs8inuAoAmwx/4Gjslt2zK6jY8ko2VFAf1KPLTCFGCbVwCO768my+RPV9MPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708006137; c=relaxed/simple;
	bh=PiBNBbw25q+v4bUnUd4r2iTh5pT2QFis1M2ZPr8jCPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PX6gcH+Td0AYtuYxdOMvlP/dkmMaDrhjUXIxf/ms/D08cFxvavjPX/Bax88B3locFiZdGEHQSwry4gmn9H5M1F3R7ZzQBkVVWQ5QN7e1Ql9QfSw5Kyb83xfOvDrmKIJJQa08+flbep2PVIF3hsnoI17+fzrY7EB2P3D+TFun0Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=NeAhvv37; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4122acb7e56so2154705e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 06:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1708006133; x=1708610933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdEY1bJU0PCtz4SwLFjp8WXUERePjgyQ1aqI/SAhvgU=;
        b=NeAhvv37VL+vkvn/JD+XqXXDTviR71ZQYllvY3uCAZphd/vn9zK4+R9IO4QbZxkWQ/
         k6EKXzeGTRAarL+LISLSr8EmEgBFj9vtGQFvP03Z/0NpJ9usU+SsaeggqyzA9ql/OCci
         DKkixL5GxMaGRPBM+HK5onrBDFxaNnDSHCYaublH3LS8dq+DntnJI14MgIC3NKnqHO1a
         q8vFji0S9Dai4Ln6s6XXCFelJnRUs330tbOQPeybV/KFLNZLaa+Hi9/8ckRidN18WLTh
         D1m9fUPE19cfX1q7kYvED0kTu66HVwoXsUf6DjJz22gZe7ukb/fA6JyJTW45TZ97s52X
         sh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708006133; x=1708610933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdEY1bJU0PCtz4SwLFjp8WXUERePjgyQ1aqI/SAhvgU=;
        b=QL6uQw6fG8PcNPvUrAqVYDr1GrEa7CVx7tKR6kE9ZwdWLP/RZMKeX64f10yQF94nBV
         5h1UQwmMojeUaICIwCrifat88UqyBUpCIK6qc+xCySNYm+5CEJWQHEyMXVE/xaEbhp2F
         JK2O5WJhMq8H/x1JAxinC44NRrijArSTJMKRDIXogpmWzvvtU/2HmuAervb5Iz6c9pBj
         EsvK888w24teDiaFcAIw2/lGrNUZbcII57Ec7Zrbi8xG+gsAxiTKJ/1rGzCxXwBfhQRt
         xWADpnf/JHE68Bkyb8Yuf0e93+W5VqrdXoYYvwLo147pzdmuFgGr0/P5JeAJeth+oqpR
         W34A==
X-Forwarded-Encrypted: i=1; AJvYcCXGknoUZ4Vor28YV0S4PIe6liBr61BA7MwFIDX6SS6QLPxHNNV5YntmAvtImLZzZoCRg9AdrnqhPXcOp9PvgNRM+UaOBF4cH7broQTZ
X-Gm-Message-State: AOJu0YwGal2LbVMYJDf3ixNyBNUncZ9YwAXeOGPtddWD25dbqj7uSpxm
	bEO5IyjKmeYD8wETOt9g6T7UbVppEzetRATFuNaNy2dsZEQ35k3R6U2FDtp1jEA=
X-Google-Smtp-Source: AGHT+IF3AOeMhenbF5cV+9smoAlk3/5t8os0VHvo/WOcaUzNhe50dXel72ETmgnCHRS43Th3tLqYyw==
X-Received: by 2002:a05:600c:4f42:b0:412:6b9:2763 with SMTP id m2-20020a05600c4f4200b0041206b92763mr1459721wmq.21.1708006133489;
        Thu, 15 Feb 2024 06:08:53 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c261100b0040fe4b733f4sm5120950wma.26.2024.02.15.06.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 06:08:52 -0800 (PST)
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
Subject: [PATCH v7 2/9] watchdog: rzg2l_wdt: Make the driver depend on PM
Date: Thu, 15 Feb 2024 16:08:34 +0200
Message-Id: <20240215140841.2278657-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215140841.2278657-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240215140841.2278657-1-claudiu.beznea.uj@bp.renesas.com>
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
---

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



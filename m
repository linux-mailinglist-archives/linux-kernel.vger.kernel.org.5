Return-Path: <linux-kernel+bounces-56511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC4684CB0D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 855A51F25291
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15B477F15;
	Wed,  7 Feb 2024 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="lLIikA5M"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573E377644
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707311286; cv=none; b=jezyd5JeX2YzECd/yHXVWczNhzlhMKafMuhuMnPJXvBn0+fSOGXXhyXXrcQNLmpLKG+p5KnHJSzXQVlujR/0M6gIj/21btjrXhjD/C6731p5Uz+BBhivpn5FXC97MmbiP1ebETdRJ9qA65zqfBGUmtcNlf2WZiAHdoThfeJpl6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707311286; c=relaxed/simple;
	bh=lCkPIhg4eqOebZq2DSdEYJNxd7Hk5Ji+XPkonxMZ21o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ONIVAeeKPGHtMgAJVkiXEd1VZdCZENI0fp8O5vgfC5Er/QU/+5Ovrw9ImNI23zj3itOnlqIkig6nhDzXeq3OUbXsf5E60kSJgrj4AUIEiChUbhzeGYSg3I6PHND/tJemR0C8bANtqy2V658vIOjqJXTy8ZaeuzmTVar2RAeOhIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=lLIikA5M; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-68c4673eff5so3295216d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 05:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707311283; x=1707916083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ob7yffFeJDPnH/PhT3IJv3UmWDx8a+BmeFJCAJI0aa0=;
        b=lLIikA5MRP2evwQoJ3ZFQQ6OkK8AbZfVxIj8E+cRkyIKjXO3QQZ/JOpWUrWcquXiRZ
         U5nfJcQdSiOjpjzHizMh64y6vAG1H1q3kcaWf0O5Rrs/IHfgjr/ksB/qB50Ws8PXJWT2
         jDF9rMpQvM5DBWkP7svIw/N6LuEdwKrC6OEkCRf0He1etmVM2c8PF1NitlN/PrsZIwiF
         Jsbdr5yJjrf82vzg49Y7ap4m4OUfq6i551Ev2zErlHXokbaxRNcF64R9CGYsGh5b7HZ5
         x4eA7/yiKsf486syDORLMevPwEGD1FFyoGGdT7/RMDH+S4o08m52o2j13kWaDF7YpBrb
         +q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707311283; x=1707916083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ob7yffFeJDPnH/PhT3IJv3UmWDx8a+BmeFJCAJI0aa0=;
        b=IqpdFrtrH0EZutWLSTfbZSwtzwTeF7qxY/PUay2J9SL6asleRLMe0A2EBnR83dVNoa
         zPHSOiAW5wAMXzRBBdCfDieuas1lkXCeCJtdaOZlzQZDlZvT6qbWVdESsZWoWkr19BvJ
         ObxwBQ+/cY/+hUE7dPCajZpzsBqDgRybzi941bhfLP7aUipH8GG06wOIRNRzgvdgR/01
         ZRzsXeqxoODwlbC63utcK2TVYpR0LgkHudgcaHjuaKpu3mnbbsBdFYKH+swrISrEDGqo
         +9F9XMnHf//oTCu0tMvVRPACRNVg/rNB4ylGiAn7AwzGSmUzZ1fqpFxiSQUD7K4s7Sne
         C8kA==
X-Forwarded-Encrypted: i=1; AJvYcCUGGYw0qTjLzFoECVBpJm8kpc1o+etv5VDUFDJ4yCQkqwOsJZw9/DcrV4sDy+WKShk4zJjnzhPj6MnrkeLHbZOgfj3cpUJ4vWYnK0zx
X-Gm-Message-State: AOJu0YwToytDXkSZ01um4xXS8SriDKHBlb1wyFQKORCmZiF2lcDy51Q4
	6Lj46uiaYozjY8MKgMr2H5FsqbOVgDeRIp3+qGSBsxnDHn8EEsouvPheY4kRSG4=
X-Google-Smtp-Source: AGHT+IFuUlB7Wqq7bvvtNFOw7fO8vxf3B40HYSZqb+VEzaYo3nbeE6QnPU1SwkcErUi44sPCbzxbLw==
X-Received: by 2002:a05:6214:b61:b0:68c:8193:61d0 with SMTP id ey1-20020a0562140b6100b0068c819361d0mr6939090qvb.64.1707311283227;
        Wed, 07 Feb 2024 05:08:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWqdtEAhXFAGWbz8AYWQn8DAL3dyGGxVaveN45RfKe62dJzuG7lJ1xInYHLamsMR+tviWJFzWlXozBjJmVEtWntPM9BbNZwU2XxNKaXCLBJU6qoM5NGTHK1wCYXZbY2CLdlVEmhdq4eZu56mAOGqhJBU/SbiFOscJYbR5pVTJAH3plExMJ0vr7WXYfJ57ZVWZVQys+Q5UKVZkFPvg5AQkKjP/MPGC29tDieSh4VTXhHfHc2f07PPFX7pAfspn5Lt4XBi4KhhlUYowoBXMveSckEd4pgWVwZL+m5csMegRUH98K/4DcIJnM+Pu16xhmX7JbovHRPxGq2SB+XpEtQh/nZWoQiJ4g2/hVPkKZdEShtDW5DLSGKIE1boG76wWPaVbxi7PTRNyqgmkPRdxx+rTGQv7pMN1dVKTQDG3tmzC3phT+yTUuAo209GxYMohWcPgU+qFGD9dqRah44ljkdCEZKfeZBW1CCNi5vx8s9oVM0Syy+Js2FvBy5L//1qH48KssvbN3y+SM5UA==
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.114])
        by smtp.gmail.com with ESMTPSA id a17-20020a0ca991000000b0068c9cd2cf88sm565455qvb.60.2024.02.07.05.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 05:08:03 -0800 (PST)
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
Subject: [PATCH v5 2/9] watchdog: rzg2l_wdt: Make the driver depend on PM
Date: Wed,  7 Feb 2024 15:07:38 +0200
Message-Id: <20240207130745.1783198-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207130745.1783198-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240207130745.1783198-1-claudiu.beznea.uj@bp.renesas.com>
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
a driver that doesn't work make explicit the dependency on CONFIG_PM. Along
with it the dependency on CONFIG_PM and CONFIG_COMPILE_TEST was moved to a
new line to have the code simpler.

Suggested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

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

 drivers/watchdog/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index f6cb63a0d889..dd0fc44b1ab3 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -910,7 +910,8 @@ config RENESAS_RZN1WDT
 
 config RENESAS_RZG2LWDT
 	tristate "Renesas RZ/G2L WDT Watchdog"
-	depends on ARCH_RZG2L || ARCH_R9A09G011 || COMPILE_TEST
+	depends on ARCH_RZG2L || ARCH_R9A09G011
+	depends on PM || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  This driver adds watchdog support for the integrated watchdogs in the
-- 
2.39.2



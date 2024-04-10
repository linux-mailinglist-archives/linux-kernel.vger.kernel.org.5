Return-Path: <linux-kernel+bounces-138653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F5989F8B0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21D6228B414
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5E416F0C4;
	Wed, 10 Apr 2024 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="R27DNhCm"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1129A16E87A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756472; cv=none; b=FhRG4jtA/mBhwxHZrxUk8zqVesFr4RjgSrsWLT3qMwQqe4IuZFokFQPA8JpFfmgSZWUlt/eepyjPOtQLX/FiZvvVQmfKmcj4hTLVCu/Wcq8CEFDtHEHt6d9afcYJOZteYs/lnkHrdYpw9mWJomlzRYZRyeNMMN2cn2y3zqsYPew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756472; c=relaxed/simple;
	bh=DRGxguGTChX5kxzu5lwWkYnQ/YVRgHMxRSmSOiyZkIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QTw58lUkEyTnhpbz8AQ5zzMKJbKGUPBPJ5omErlTLRLF3taLm1bnRwUw6oU8pHqeyv2NP4jnFmEI+RUr69HXR9/ClddYGJ6BcJa6kwkfqgj4c8TyntpOJpnlwk57TpXHy/8uxn7MRB/AMF8YQ1gt+queCeGPT2atd0rkMdGuHjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=R27DNhCm; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-417c56569fbso1143735e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1712756467; x=1713361267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwOQ2Kcf4Va+sLm73V1zpQTlEUytHotkzWfwqgI7DKM=;
        b=R27DNhCmmLW/Bo/m+nXb+aMvkD8LNNuWu65MIc5yGANp1o8HqrlKHRCoGE9bQagUsK
         cYOZ2aMiwrSSC3P3bbq9upL9pgXLrER4GhYfeX3kuVw1QPOy7eZ45xXOBWMDNg76MpcY
         lmdYN+T1kEsWvKYP5CsaLS7aiS+pfXe+np06VOj/NxktPAJyfE8N1BgFuhpSysL63wje
         HYkC8FYSim2eVTvQ6Nz6UNAlQWGwALm+dGKynBmjjG38QBJBuu3Fot+yG1/OgjWOqp4q
         qrWwdE/mNUPThiBVthg+d8NwXLx3IrCodpse6AmKfYbcy7RUkL3rVignldPf/TVwUdwQ
         E/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712756467; x=1713361267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwOQ2Kcf4Va+sLm73V1zpQTlEUytHotkzWfwqgI7DKM=;
        b=tJV+kjNFpX0nXlCGHcf2i3zyAudYH9pGBUZHbQsYGGL2tidqYDNi3MOht5GtSS8Mw9
         +SnFzUcy8PeaCps8cVmhSEOmGsxmuyXTM1AFJnOBRol3/jNadMHWceJ/AFcWfCrvGba9
         OA91OAN6CYvArN9Ga9HckXjonoubfBjvt2CHCUMlFmmR3EnMvHpa7Z2oVK9a/+JzA6zj
         1sQ3F/FdDiZG9TDD5LxdJAAVU+ggaoIx/rEA/ZwQ5QUXmPBSzttjGyzQmaX3XZhAMWix
         LynFm28oODZSZFseaYLvlFh6HU+Tr6aCecm8alZjfr/6NGIWzXtBXDr3jIULUC76caNm
         7xPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoTfXrQ4QexzgdDvcTnIToRQyTAeAm4CNS+FKNk75MWDH4eCoSGPOzkn3noJHWrrPfGXKHYYgS4ff+oYcIRAPYmi2CgiGHdYJiiTX5
X-Gm-Message-State: AOJu0YyT7arFhssmx9zIfUjpSYjq1lUOm/qD470E0WTznJ6EDDUW0N5V
	A46KCD5Lqll9jRxxiC8yBujIv4NPxXiNp/NWmF6nmCCEeWUQV8c3/dW74SKeNjc=
X-Google-Smtp-Source: AGHT+IEPXf1BG80gY9pVAu8MeGUgez3LQFO6YvkYXi5gPVxX16YoW/dOOwGsI76EZlMbjzlzAwlevw==
X-Received: by 2002:a05:600c:45ce:b0:416:3a07:43b3 with SMTP id s14-20020a05600c45ce00b004163a0743b3mr2216725wmo.3.1712756467561;
        Wed, 10 Apr 2024 06:41:07 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.8])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c500f00b00417c0fa4b82sm872528wmr.25.2024.04.10.06.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:41:07 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
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
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH RESEND v8 02/10] watchdog: rzg2l_wdt: Make the driver depend on PM
Date: Wed, 10 Apr 2024 16:40:36 +0300
Message-Id: <20240410134044.2138310-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410134044.2138310-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240410134044.2138310-1-claudiu.beznea.uj@bp.renesas.com>
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
Closes: https://lore.kernel.org/linux-devicetree/202402020445.TOBlFPcS-lkp@intel.com
  was also fixed
- adapt commit message

Changes in v2:
- this patch is new

 drivers/watchdog/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index e2439967417a..7b66fe06ac85 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -921,6 +921,7 @@ config RENESAS_RZN1WDT
 config RENESAS_RZG2LWDT
 	tristate "Renesas RZ/G2L WDT Watchdog"
 	depends on ARCH_RZG2L || ARCH_R9A09G011 || COMPILE_TEST
+	depends on PM || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  This driver adds watchdog support for the integrated watchdogs in the
-- 
2.39.2



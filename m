Return-Path: <linux-kernel+bounces-71983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766CE85AD68
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91FAE1C23E32
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF3154FA7;
	Mon, 19 Feb 2024 20:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y2xgjGJc"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D064A535C6
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708375369; cv=none; b=atvTGUqqti1jRVOuQWfGwDmXSZw1rC0lY+3yBUA8k4k59XNqIjiYHTACPT3ELgBmxx0iFK4vtbfeYaQPGWO9nM5CMKWJ76URfkcqyF1zaTg/9Ps0BIvmFWdw1wYnUC8J1dP6yt8rZNkuTJwQ1+mXixKyJgKb6zMWXQS2kxCadrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708375369; c=relaxed/simple;
	bh=0qlxg4Wl4LV4zmhyFrXH9tW2Y2omtNhqxGLvqo65VnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7GyKMW2xVkB2qHhBuAeEIYdH2EnVXvyxuBA4gBvpEEIRUkXMUnMfniIzmLOM+/3jEcaXFr4Bkn53p4Pmgo3EU2/or/oOV6u+tMrrKwkXpbcf86o6pnc6TOxChM4dABisTz/MohJdgf3Y2lt3hnD7TnTblMGp+HRHe3vm6UGkuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y2xgjGJc; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33d4c0b198aso739124f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708375366; x=1708980166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daii2vCQdv00wY9FjSBPTiVONH9pzRxUrLR+kFtKtA4=;
        b=y2xgjGJcOlH7IL7GMCQGPV2NXmJd10ZYfSYkU2FBiReg7CJKEuIKHvEIY4hgOuOGQW
         0mb8MFcCNJ4q/s7kzLA3yhxz8G9jRQQYid7twKvpSKnWRcCFLEDcy1ae6RwsZ07RgYIs
         j2ZizWZow1J7oWgKgFde/9WPsxlqdMLWgiaHS9qF/OHREs4913wZd8BH0MiHGaM2ZlFT
         JwAXVDACSc03gH38MQv60dqRd8P3dVJwATdVXMUm7nt5q25GM1xd9Eg1FMW0C8R366az
         Fkd1Ni25TlfHCLJMteX+Ki6MYmzopztyqJtEibKCa9FGH3nBPUSPBnzmOI8114hkUykU
         AEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708375366; x=1708980166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=daii2vCQdv00wY9FjSBPTiVONH9pzRxUrLR+kFtKtA4=;
        b=w+dojxXvDVEcw+07+yzYnBhNLzpr+SdwOM6EehLU1Xe8BdKtOKKqQaEyFQfDc8muHg
         91WlSV92IBXVaW8klfuykQQRsm/q/uKC1/VeD1B1QvAZQ6wt8vJbjKNVeEFpxbYJRkn7
         Kj+4ch4Y4CaPOKPVlEsXUKKaYg8DxloaSrWbDhuUUO2vSvvjaFQYf3dI1fBVwVwyPMTd
         bWXZZeV9dvi663CWxRGIR9EZru/2BeqqDF2VZFqadSVM0zlx4AsLw+JuhA53iVzvxzOp
         TwXLTCUDRdkrHpRMr4ODgwcdz3XWbIFNZH/TbACjl8xrP0i+aEHyXhKC0Up3CPn5zfpK
         nV9g==
X-Forwarded-Encrypted: i=1; AJvYcCW1wMIc9v2So35DAJiNVTSja/R7lC/tBHaUBD0Rq0bdY7pvs0XJ0/yy/qFpOKrsclTfm93mdcBbQxZdMwK68RoA/0qrgO6Oi82McYo/
X-Gm-Message-State: AOJu0YyMUIeMDejIo+xkQiW5vC6pAqOY3a5rp/v7hgl8cersKE78U4Z9
	z7nZiP40wp6AkbF1Mh0B8XOQ5NvhdidDZhedYxKlWmLBoqCgxl+c39u5nQu2qL4=
X-Google-Smtp-Source: AGHT+IEcLCWqzEAqp5iQ3VVJMqv2pDXsuNSFdg1jtINv2Aw7ij2NaJ/bQGx00hCn5zu5haX9xWIfMw==
X-Received: by 2002:a5d:624b:0:b0:33b:381d:a71e with SMTP id m11-20020a5d624b000000b0033b381da71emr8750226wrv.17.1708375366132;
        Mon, 19 Feb 2024 12:42:46 -0800 (PST)
Received: from gpeter-l.lan (host-92-18-74-232.as13285.net. [92.18.74.232])
        by smtp.gmail.com with ESMTPSA id bx15-20020a5d5b0f000000b0033d202abf01sm10561000wrb.28.2024.02.19.12.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 12:42:45 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
To: arnd@arndb.de,
	krzysztof.kozlowski@linaro.org,
	linux@roeck-us.net,
	wim@linux-watchdog.org,
	alim.akhtar@samsung.com,
	jaewon02.kim@samsung.com,
	semen.protsenko@linaro.org
Cc: alexey.klimov@linaro.org,
	kernel-team@android.com,
	peter.griffin@linaro.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	linux-fsd@tesla.com,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH v5 2/2] watchdog: s3c2410_wdt: use exynos_get_pmu_regmap_by_phandle() for PMU regs
Date: Mon, 19 Feb 2024 20:42:38 +0000
Message-ID: <20240219204238.356942-3-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240219204238.356942-1-peter.griffin@linaro.org>
References: <20240219204238.356942-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Obtain the PMU regmap using the new API added to exynos-pmu driver rather
than syscon_regmap_lookup_by_phandle(). As this driver no longer depends
on mfd syscon remove that header and Kconfig dependency.

Tested-by: Alexey Klimov <alexey.klimov@linaro.org>
Tested-by: Sam Protsenko <semen.protsenko@linaro.org>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/watchdog/Kconfig       | 1 -
 drivers/watchdog/s3c2410_wdt.c | 8 ++++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 7d22051b15a2..d78fe7137799 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -512,7 +512,6 @@ config S3C2410_WATCHDOG
 	tristate "S3C6410/S5Pv210/Exynos Watchdog"
 	depends on ARCH_S3C64XX || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
 	select WATCHDOG_CORE
-	select MFD_SYSCON if ARCH_EXYNOS
 	help
 	  Watchdog timer block in the Samsung S3C64xx, S5Pv210 and Exynos
 	  SoCs. This will reboot the system when the timer expires with
diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 349d30462c8c..686cf544d0ae 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -24,9 +24,9 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/of.h>
-#include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 #include <linux/delay.h>
+#include <linux/soc/samsung/exynos-pmu.h>
 
 #define S3C2410_WTCON		0x00
 #define S3C2410_WTDAT		0x04
@@ -699,11 +699,11 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 		return ret;
 
 	if (wdt->drv_data->quirks & QUIRKS_HAVE_PMUREG) {
-		wdt->pmureg = syscon_regmap_lookup_by_phandle(dev->of_node,
-						"samsung,syscon-phandle");
+		wdt->pmureg = exynos_get_pmu_regmap_by_phandle(dev->of_node,
+						 "samsung,syscon-phandle");
 		if (IS_ERR(wdt->pmureg))
 			return dev_err_probe(dev, PTR_ERR(wdt->pmureg),
-					     "syscon regmap lookup failed.\n");
+					     "PMU regmap lookup failed.\n");
 	}
 
 	wdt_irq = platform_get_irq(pdev, 0);
-- 
2.44.0.rc0.258.g7320e95886-goog



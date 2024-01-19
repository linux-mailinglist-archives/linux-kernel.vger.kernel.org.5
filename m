Return-Path: <linux-kernel+bounces-31035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DBF8327DD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD4C1C21769
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D614D128;
	Fri, 19 Jan 2024 10:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tKm2wN3F"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3E84C3CD
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661137; cv=none; b=bTmYeoZr+VmhVT7YVC8Ox6wiVAIs4dNy8uD0ZJC+i0XuKLQNey0D4BRGChXfhU+RonJNysWWmM3H1wf/+Un5wJjufclSFEDRRYa9d7VECDiaO8vJHcZqcCMcO6v3PuLjIwdPafpfNClEnuYXizq5K+xgXasHIv0GZe4m/IjrQWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661137; c=relaxed/simple;
	bh=/DF+tSTszWj2uKRB4Z1qpd0yWVCMU7iJvLB0kXUUb6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwS58BPhPNPzlTuigv4qXxrdKkK2O6D67ZN73vN1x5QtBYLHk4HToGe+uMfUCTVeoO4fb7l0RTgJ26wmNRoRUXRVNpRsIKNmQSFCHwlNFdskBbU9lvM0sRn6a1N1TmqM0FYMz2LVAFIVzL+fPHNn0XbcEFLPlCzMvtzzqE+IlfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tKm2wN3F; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e9101b5f9so6680445e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 02:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705661132; x=1706265932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRO/29BBu0wOqLjfgi9jbts6vS9S++O3BcU4FggPnxQ=;
        b=tKm2wN3FkQVhZ6+j6lzy0JDANhqiFRMacHyKHokeyyFmbIWCdF4ELnZoDzV6ndtW31
         YN7hv24ebjq6v/ka0QqWO84lpRXakB9oNzyqBJp73xSYgFhVvOcuqgp42oL5mLwBna8a
         sc74VusamouXvVZq1sZkgr5w9uI5f74bJe1gzyMgY4hH1jXQAybliazFSD0jM/3j2gAD
         94AJDm4Tx9K4+wWDzotxoOHXQL0TTa/SiWXICnUmDLzHSAnGxgU/AUAnfGZ78yLRW9S2
         tYu6nfUT7ZM93eOeRXj6yax/F4SqfItWgRfXHpiMj5WHW+dxP8n5KVc+mWCzWw9o0pIc
         9Jjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705661132; x=1706265932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRO/29BBu0wOqLjfgi9jbts6vS9S++O3BcU4FggPnxQ=;
        b=OIQAsTk/m2CKSR5YHOgYi7T+iUNn2s0dXMh0iHIXjAStQJ6qV3moxSd9gd1DboB1Tp
         iqFn1XsKsBtJgvlN36Lkzhb8CAc4fU9lqFLxpdEetiQmiv9CFR6OBZRiapIgsB8cTeX0
         iK2neetRI9tKmmPpbooSzwSbYThvWski8kHBc31ZvjOmD+DUMXENEbVGKdAYPwCSgXZK
         HgBEuTOEGxO9WS0wH9BhA1TrZxSP0v2xo7hxdd31C8eVovK+c6puiILDYJHeWtRQUtaX
         5RxlSA9eXCLMX50ExKri9KgYAWedypGIpGq/R30KBCGIPDM//mCq2gPCpMIe46qiLQlQ
         EhSQ==
X-Gm-Message-State: AOJu0Yx5y62Bv8mIN5nrfrikjCWxi5MQIm429yggwL1+7l9cA1756+8a
	DQP2Mq63D+h5uYYEg6jooa8qM9jwvkTkvx/e9kDLEbEzekkB3XDI4KmMD7JKJUI=
X-Google-Smtp-Source: AGHT+IGrA5J+z8EbYw2wyRH3MCBXeZ1K10bB38FMjwSnkyuqVvhBeOxNJ4f01saw5T3Tqey5/1SUhA==
X-Received: by 2002:a1c:790f:0:b0:40e:4d1b:27e0 with SMTP id l15-20020a1c790f000000b0040e4d1b27e0mr1506294wme.20.1705661132761;
        Fri, 19 Jan 2024 02:45:32 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id fm16-20020a05600c0c1000b0040ea10178f3sm77470wmb.21.2024.01.19.02.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 02:45:32 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 04/19] tty: serial: samsung: set UPIO_MEM32 iotype for gs101
Date: Fri, 19 Jan 2024 10:45:11 +0000
Message-ID: <20240119104526.1221243-5-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240119104526.1221243-1-tudor.ambarus@linaro.org>
References: <20240119104526.1221243-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GS101's Connectivity Peripheral blocks (peric0/1 blocks) which
include the I3C and USI (I2C, SPI, UART) only allow 32-bit
register accesses.

Instead of specifying the reg-io-width = 4 everywhere, for each node,
the requirement should be deduced from the compatible.

Infer UPIO_MEM32 iotype from the "google,gs101-uart" compatible.
Update the uart info name to be GS101 specific in order to
differentiate from the other exynos platforms. All the other settings
are not changed.

exynos_fifoszdt_serial_drv_data was replaced by gs101_serial_drv_data
because the iotype restriction is gs101 specific and there was no other
user of exynos_fifoszdt_serial_drv_data.

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 38 +++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 9d3767021f9c..7a1b1ca82511 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2494,25 +2494,43 @@ static const struct s3c24xx_serial_drv_data exynos850_serial_drv_data = {
 	.fifosize = { 256, 64, 64, 64 },
 };
 
-/*
- * Common drv_data struct for platforms that specify samsung,uart-fifosize in
- * device tree.
- */
-static const struct s3c24xx_serial_drv_data exynos_fifoszdt_serial_drv_data = {
-	EXYNOS_COMMON_SERIAL_DRV_DATA(),
+static const struct s3c24xx_serial_drv_data gs101_serial_drv_data = {
+	.info = {
+		.name		= "Google GS101 UART",
+		.type		= TYPE_S3C6400,
+		.port_type	= PORT_S3C6400,
+		.iotype		= UPIO_MEM32,
+		.has_divslot	= 1,
+		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,
+		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,
+		.rx_fifofull	= S5PV210_UFSTAT_RXFULL,
+		.tx_fifofull	= S5PV210_UFSTAT_TXFULL,
+		.tx_fifomask	= S5PV210_UFSTAT_TXMASK,
+		.tx_fifoshift	= S5PV210_UFSTAT_TXSHIFT,
+		.def_clk_sel	= S3C2410_UCON_CLKSEL0,
+		.num_clks	= 1,
+		.clksel_mask	= 0,
+		.clksel_shift	= 0,
+	},
+	.def_cfg = {
+		.ucon		= S5PV210_UCON_DEFAULT,
+		.ufcon		= S5PV210_UFCON_DEFAULT,
+		.has_fracval	= 1,
+	},
+	/* samsung,uart-fifosize must be specified in the device tree. */
 	.fifosize = { 0 },
 };
 
 #define EXYNOS4210_SERIAL_DRV_DATA (&exynos4210_serial_drv_data)
 #define EXYNOS5433_SERIAL_DRV_DATA (&exynos5433_serial_drv_data)
 #define EXYNOS850_SERIAL_DRV_DATA (&exynos850_serial_drv_data)
-#define EXYNOS_FIFOSZDT_DRV_DATA (&exynos_fifoszdt_serial_drv_data)
+#define GS101_SERIAL_DRV_DATA (&gs101_serial_drv_data)
 
 #else
 #define EXYNOS4210_SERIAL_DRV_DATA NULL
 #define EXYNOS5433_SERIAL_DRV_DATA NULL
 #define EXYNOS850_SERIAL_DRV_DATA NULL
-#define EXYNOS_FIFOSZDT_DRV_DATA NULL
+#define GS101_SERIAL_DRV_DATA NULL
 #endif
 
 #ifdef CONFIG_ARCH_APPLE
@@ -2600,7 +2618,7 @@ static const struct platform_device_id s3c24xx_serial_driver_ids[] = {
 		.driver_data	= (kernel_ulong_t)ARTPEC8_SERIAL_DRV_DATA,
 	}, {
 		.name		= "gs101-uart",
-		.driver_data	= (kernel_ulong_t)EXYNOS_FIFOSZDT_DRV_DATA,
+		.driver_data	= (kernel_ulong_t)GS101_SERIAL_DRV_DATA,
 	},
 	{ },
 };
@@ -2623,7 +2641,7 @@ static const struct of_device_id s3c24xx_uart_dt_match[] = {
 	{ .compatible = "axis,artpec8-uart",
 		.data = ARTPEC8_SERIAL_DRV_DATA },
 	{ .compatible = "google,gs101-uart",
-		.data = EXYNOS_FIFOSZDT_DRV_DATA },
+		.data = GS101_SERIAL_DRV_DATA },
 	{},
 };
 MODULE_DEVICE_TABLE(of, s3c24xx_uart_dt_match);
-- 
2.43.0.429.g432eaa2c6b-goog



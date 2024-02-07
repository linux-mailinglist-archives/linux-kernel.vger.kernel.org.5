Return-Path: <linux-kernel+bounces-56376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9935184C972
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03C36B2681B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60C228DC1;
	Wed,  7 Feb 2024 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z7PjOecY"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09021E482
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304526; cv=none; b=pXtkKcb34KHwy0pMtSpS92eoNY84irc9iwDDj4j0NHhjFEL2ls+N4z9LpyBBK+gG+YoJotcNTgJWWR50p3+kXO545EXJgTGBsK/SZu3lalFor4MSwa4blbDE82+ES8lDq0QjGkR6d8GVIcNwCniwXruEa5F3LDy3GpcMR6vJcXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304526; c=relaxed/simple;
	bh=OIO0Jdw0rKx9pnTeOXamc0BX8ibgMh/GcNFiiLOTq8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZqnT8/fKjZZRREkKTtr/OXlwHK6uoY+l231m1dFUL9SHrr3QK/6HJ04Xl7NIl9v9DsN1ykj8T/MtGAxlkCHM31suUjQFO4IGg4XWjLsxU0xim0DHQNf6F9StAveJmwbS9/c1nTjswVkHtuQfYdjxsALnzlhuY24nVEl2LAXVpDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z7PjOecY; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5115fcef9e9so581417e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 03:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707304523; x=1707909323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dn0uxZFDo6NWePr2qdwdP08ijlsAxDoEPw964FSIz1A=;
        b=z7PjOecYXXm+kVZFx6anxNnMBzFt5PK7acSZ4Wb13Vso1G7nBAJZfb7efH6+pXUASC
         3hdCYABBkHNvj7YpLGM9Whr7S7qplprKiMot4Z/Pv5oF3hKjjCC1J1Jc68amaE0iolTV
         AsAGV3D3Al0nu0Uh0Q6eXCYe7klY0dEXDN4q7YHX9PTrd1ZHkdLlBgXF8l9jLsCKD3Yc
         dqM04hj7BgWzgphc4iducJcwhlZICTptuF3Y1/a/GWZGTxBGm3wmt4ZHzQyKSTLnEQTO
         G4NoHpCCL5emR5TVwGuJJvAIcuJoj7xCZd5NGQwJveE9V09+zOvTsO6Mik5rYB78jjRT
         zI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707304523; x=1707909323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dn0uxZFDo6NWePr2qdwdP08ijlsAxDoEPw964FSIz1A=;
        b=e3vh+R2fQOYGFMzEoJf0OTXRKQvxlBIqyLC793epZ2Wum/7QEeuwZKWWC6TyYRyOUk
         jVGHjNfGjVBqoAFlamyWCC/FPlAfFfJRizq5Wf7FIrDyB6oPKSQl4I+tFlnd26SwVVyS
         OFMO4uTBhHXKOB3BTwEvLB4NTEuSw9ouyUOHXQ97QPa9S24mybP/7rwRpBvRNXBlgFjz
         DZTdcrbdtLiMdMi5NKXUbvvmMD4v4efow6fag2hFAo1gIDdYYfZovbdouMmxmT1VQbq4
         ahB7W8h9x+9HbtpLEzjmUjRe5a8kyaKBHqaFTVqLP7JIrzLI+KyTK3MCthSQqsPIS66E
         +d9Q==
X-Gm-Message-State: AOJu0YzYWKn3cegcjnoKGbl2T9UZM1nSSHtgXyOkC6MrlYRM9QREWt//
	IOaP7TLpniMcWHqvTj59kUXviBuyY0OijJ1jEHkuN0AnGXhXtZOdV7OT6v2mrik=
X-Google-Smtp-Source: AGHT+IE5eIKLuUmb8h+vJQhTopUxE+vxpnmBvmCs+6cqfMZAcpiMEAKVIc99ZTC/OMFtO9lArP2XLw==
X-Received: by 2002:a19:f80a:0:b0:511:5e49:766 with SMTP id a10-20020a19f80a000000b005115e490766mr3055134lff.23.1707304523154;
        Wed, 07 Feb 2024 03:15:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWpHmBFshfk+OSUXB7ANNEbw1MqbQNWZ1mwdFgbfeK2iC+AXM8eorwCeMYn6Qk77+424RjJ4E7ST0wUsphxqtaN4qo+VFdiEgSheX4t1LqFECen46n0V7MHAhqv4BUlrmCZICQRZdDA23T5iQWfsJtKJLDwoXSk5Z73VJDuhOwH9xL79Bs8GtSnqU+EwuUM3uQ8Xrf59laCDWiQCCiPEWpU6hS3m1/ag4kNIcmEgXQuDu103ECJC/afRpf8IIDuNqfSXRCJW639Zhv730GM4m4EgAcBRtzlfxoXuMagO7Pp2twztw4u7RNL/7BD5rKgDeKbDPj7Ws0a+x223wUqbMOO2byVhNXsNPI/pDNxb3n8zUrrHUTKlGFcZpyFtppRP9TKDUfv/IxZ4Vi7J32S+5OB+XiaDbU0M1RzNbIlEsdVGWEzYu5JOj6y3bwz6xyFRC46AyshRTpHg9dk1JvpzcSX9eULRFzrejotGkif+etjoANhVgRpvAZ8AMHCTbbK+EPyXaR7WA3i4G8s3SENMOjoR+oJ2FH9gH3xLMYZBdeO2i1r22TQULwWZH5lLEThSob/74OD+55soHL4ffGRKeCY9w==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c4f0e00b0040ec8330c8asm4983260wmq.39.2024.02.07.03.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 03:15:21 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 4/4] spi: s3c64xx: add support for google,gs101-spi
Date: Wed,  7 Feb 2024 11:15:16 +0000
Message-ID: <20240207111516.2563218-5-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240207111516.2563218-1-tudor.ambarus@linaro.org>
References: <20240207111516.2563218-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for GS101 SPI. GS101 integrates 16 SPI nodes, all with 64
bytes FIFOs. GS101 allows just 32 bit register accesses, otherwise a
Serror Interrupt is raised. Do the write reg accesses in 32 bits.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 014fcc933c90..7ab3f3c2e9aa 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -17,7 +17,7 @@
 
 #include <linux/platform_data/spi-s3c64xx.h>
 
-#define MAX_SPI_PORTS		12
+#define MAX_SPI_PORTS		16
 #define S3C64XX_SPI_QUIRK_CS_AUTO	(1 << 1)
 #define AUTOSUSPEND_TIMEOUT	2000
 
@@ -1534,6 +1534,19 @@ static const struct s3c64xx_spi_port_config fsd_spi_port_config = {
 	.quirks		= S3C64XX_SPI_QUIRK_CS_AUTO,
 };
 
+static const struct s3c64xx_spi_port_config gs101_spi_port_config = {
+	.fifo_lvl_mask	= { 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
+			    0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f},
+	.rx_lvl_offset	= 15,
+	.tx_st_done	= 25,
+	.clk_div	= 4,
+	.high_speed	= true,
+	.clk_from_cmu	= true,
+	.has_loopback	= true,
+	.use_32bit_io	= true,
+	.quirks		= S3C64XX_SPI_QUIRK_CS_AUTO,
+};
+
 static const struct platform_device_id s3c64xx_spi_driver_ids[] = {
 	{
 		.name		= "s3c2443-spi",
@@ -1546,6 +1559,9 @@ static const struct platform_device_id s3c64xx_spi_driver_ids[] = {
 };
 
 static const struct of_device_id s3c64xx_spi_dt_match[] = {
+	{ .compatible = "google,gs101-spi",
+			.data = &gs101_spi_port_config,
+	},
 	{ .compatible = "samsung,s3c2443-spi",
 			.data = (void *)&s3c2443_spi_port_config,
 	},
-- 
2.43.0.687.g38aa6559b0-goog



Return-Path: <linux-kernel+bounces-31033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B02F8327DA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA3B1C21F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355904CE19;
	Fri, 19 Jan 2024 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LkwZvy5v"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1214C3DB
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 10:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661136; cv=none; b=umqCIumCflpd8bXmJthClrqkxEjomPr4DDw2ZjYqavgP0G/+NQ22KS3YOZoxvE6H9hVIu0IDKqQoQA97+yrA9WGKU3Iy+iRZUCD+vJVrYwesQQXHfGkg90toojWuFOe6BJV31I/aEBJMYCr380p3j4D6OT4rytrtY0U74t2oMbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661136; c=relaxed/simple;
	bh=f5+jITnMGsSkoaGcJ9ivQf1KA/7qNNBfZvlzYP28SkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVl6hnTPbuR+oF/yZTr+tIouIyzr6YlV19njjc9ER2X04oQyKTuwfcbYjzP9qi5Es7yd1jPaTI8GokceCbyyY2SdbIKdiik9/v2/CtSQqUdTVp4eHS6SwthHa/WTDP6eXq2Vlymh3ylVkH71NWJvtm6hzRX7BfEf+S+JCKz92Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LkwZvy5v; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e586a62f7so7077525e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 02:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705661131; x=1706265931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTC4DdEvy8g2SMCw/JI6FV7yDSpa07/4JczZdfD8XG0=;
        b=LkwZvy5vh7vbLaW/8pJmTy0jMLKyY4Oto277rPomyDnrAffvRqeclZDpZtTbNiB6W3
         q2ytO/DFQWbBOAy/6CopA0mIqd//i/gD/KncMh0mf5A/3oP9h1Ucz/X2fSZMURdsycX4
         J4gy0te4HviSt5qdyZDHW+e+BY3vFcEzBXLXoc9ZLGWEX44YGcQ6dw3HQ5e/ZGmkU9z7
         /b6AZjaN/JCSQzBBHMjkGySX4yJQHbHDOPq+xF98SAS2L99KRhpSPzKSBYRxHbwioEn5
         cpm3y0T3sdj4kwUcarU2wYARCn8lyxG3RY43Rs2JOsRVDw9OE4xMFCRX+3kg86sozO9M
         U6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705661131; x=1706265931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTC4DdEvy8g2SMCw/JI6FV7yDSpa07/4JczZdfD8XG0=;
        b=a2CB0uygGCfKHFZtsvJcBFt8eZzcEJ1CzHn6lqv+O1QZmhfvBi2ofabC0rFwZkliSG
         6LrzEuJE1uScspaaBpX59y3ADF31yGIbIrRbdcIRWFN8CfPbzgmH0Alabh9GhoxlFMLq
         +CpVwy7e4DWv/tB34htx3WcwiLtFoswcsUd2Zb67Uezu7ibDnuQpoxte2/Rev2aTgmxG
         KPwBb70Nxuqo0I1CKae7w71Kyf8IRfkozqLsaTe9YWiMgVlDIACG3kPhiZL3ArjR8lrW
         cmM4N4iQetouXOpRKghELjpHPU3FWgcZYeDOapCYO0kDPd0c3Qr3wyCbmEL6W3vWcYuY
         zMEg==
X-Gm-Message-State: AOJu0YygHJKMen3W3fmi57bauKMjAHKANQAcj1YEjHqMLRicSdOT0DQA
	O4WtGkrzNQhA9yG6azLkPnxaIT2MGWJbFeu0y1x2IUcCjt+5lxDsGkaLqmKZoDc=
X-Google-Smtp-Source: AGHT+IFMYe0iBaJgLM0jN4384HDBV4gkQcxKrLQJyf9nqc8RpGHq9WbRuPOO/CoLSCk5Y4JF+E0+vA==
X-Received: by 2002:a05:600c:3014:b0:40e:4870:d2a4 with SMTP id j20-20020a05600c301400b0040e4870d2a4mr1622675wmh.59.1705661131795;
        Fri, 19 Jan 2024 02:45:31 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id fm16-20020a05600c0c1000b0040ea10178f3sm77470wmb.21.2024.01.19.02.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 02:45:31 -0800 (PST)
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
Subject: [PATCH v2 03/19] tty: serial: samsung: prepare for different IO types
Date: Fri, 19 Jan 2024 10:45:10 +0000
Message-ID: <20240119104526.1221243-4-tudor.ambarus@linaro.org>
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
register accesses. If using 8-bit register accesses, a SError
Interrupt is raised causing the system unusable.

Instead of specifying the reg-io-width = 4 everywhere, for each node,
the requirement should be deduced from the compatible.

Prepare the samsung tty driver to allow IO types different than
UPIO_MEM. ``struct uart_port::iotype`` is an unsigned char where all
its 8 bits are exposed to uapi. We can't make NULL checks on it to
verify if it's set, thus always set it from the driver's data.
Use u8 for the ``iotype`` member of ``struct s3c24xx_uart_info`` to
emphasize that the iotype is an 8 bit mask.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 6fdb32b83346..9d3767021f9c 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -84,6 +84,7 @@ struct s3c24xx_uart_info {
 	unsigned long		clksel_mask;
 	unsigned long		clksel_shift;
 	unsigned long		ucon_mask;
+	u8			iotype;
 
 	/* uart port features */
 
@@ -1741,7 +1742,6 @@ static void s3c24xx_serial_init_port_default(int index) {
 
 	spin_lock_init(&port->lock);
 
-	port->iotype = UPIO_MEM;
 	port->uartclk = 0;
 	port->fifosize = 16;
 	port->flags = UPF_BOOT_AUTOCONF;
@@ -1988,6 +1988,8 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 		break;
 	}
 
+	ourport->port.iotype = ourport->info->iotype;
+
 	if (np) {
 		of_property_read_u32(np,
 			"samsung,uart-fifosize", &ourport->port.fifosize);
@@ -2398,6 +2400,7 @@ static const struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
 		.name		= "Samsung S3C6400 UART",
 		.type		= TYPE_S3C6400,
 		.port_type	= PORT_S3C6400,
+		.iotype		= UPIO_MEM,
 		.fifosize	= 64,
 		.has_divslot	= 1,
 		.rx_fifomask	= S3C2440_UFSTAT_RXMASK,
@@ -2427,6 +2430,7 @@ static const struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 		.name		= "Samsung S5PV210 UART",
 		.type		= TYPE_S3C6400,
 		.port_type	= PORT_S3C6400,
+		.iotype		= UPIO_MEM,
 		.has_divslot	= 1,
 		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,
 		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,
@@ -2456,6 +2460,7 @@ static const struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 		.name		= "Samsung Exynos UART",	\
 		.type		= TYPE_S3C6400,			\
 		.port_type	= PORT_S3C6400,			\
+		.iotype		= UPIO_MEM,			\
 		.has_divslot	= 1,				\
 		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,	\
 		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,	\
@@ -2516,6 +2521,7 @@ static const struct s3c24xx_serial_drv_data s5l_serial_drv_data = {
 		.name		= "Apple S5L UART",
 		.type		= TYPE_APPLE_S5L,
 		.port_type	= PORT_8250,
+		.iotype		= UPIO_MEM,
 		.fifosize	= 16,
 		.rx_fifomask	= S3C2410_UFSTAT_RXMASK,
 		.rx_fifoshift	= S3C2410_UFSTAT_RXSHIFT,
@@ -2545,6 +2551,7 @@ static const struct s3c24xx_serial_drv_data artpec8_serial_drv_data = {
 		.name		= "Axis ARTPEC-8 UART",
 		.type		= TYPE_S3C6400,
 		.port_type	= PORT_S3C6400,
+		.iotype		= UPIO_MEM,
 		.fifosize	= 64,
 		.has_divslot	= 1,
 		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,
-- 
2.43.0.429.g432eaa2c6b-goog



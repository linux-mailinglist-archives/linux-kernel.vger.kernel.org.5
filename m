Return-Path: <linux-kernel+bounces-31047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D8A83280E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378C41C22E45
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5960151031;
	Fri, 19 Jan 2024 10:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qTc8qlV5"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A935A5024C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 10:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661148; cv=none; b=NM8mGFuIl/c8+/HeSXZDBy0fEAYf7hgAd/whLu3Jb3ywAyH5VwXWh+ytKYZJ+nZKkl51Nrm8lslimg5BcJXkMUJppBEktwc7RY5JlYNz1kSmuJlPuHykPCB9gUrE+aEILfhbTRD/l81Fyg+lIhL58YmcYYKKagDvC3WvjmAeRbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661148; c=relaxed/simple;
	bh=ZFSueeqJOG50kpfUkqWZIIakY/L+wXXiARZ0cSz/CKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrhRm38gDAW25EcLygwjvumzfmI4R3p3RS83pFFH28x3PyEYPRId9COVMVEfuLeA9PgML2yxUY7kdbb8nZ6PAmHUo0JkmwHSjBfiNo1XZqoH9hFZhtJiSbxRS20QO3wt7GWNvGs3LyFR+jY3h8MyKoyDXIN2EVx3kxryZFEY3RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qTc8qlV5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e7065b7bdso6626245e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 02:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705661145; x=1706265945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nwo45PT47NHmv38PG0rfELhMxvzOHKS168E5xQGMKNU=;
        b=qTc8qlV5brIp3i10rpuf2Wny+Ysd3EH9O50JGwdKQGn1nWIT2VWv6XR0Uojsi7FOa/
         KB05+DM6/q5ZQJKR0+6T1AedB4wFFX3ccBeRGdnwKIuQOY5r7KlnHaQGbmuZscPJ5fbI
         pfa4dBpqov3WiEiniuLGZxUeKavMJpETq3ReZthVfFLYXso69NsLz4rY1qXUmFnY3tAM
         ARHBzmwf0fcPJJtnWsbrg5s81WI14eSUrA/D96CnZOpBWjbN2vmos8DXjihZW8zOH2DW
         rT7oKOsvK+WVA+mSf8f83jCdMtSQqDuVGetd6LH4vIQcT6sg6sKujvMxPmEfiApuN4m/
         vnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705661145; x=1706265945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nwo45PT47NHmv38PG0rfELhMxvzOHKS168E5xQGMKNU=;
        b=wlKPoYMI2dHTqFghTohhlxFaZVcWa77YnJeKFZ3p3ieJ6J0gqtw+S5Yp2CFkiJAL5e
         ngMIeHjeXAq+vlJpRm6dqDfklx6DiJWd7YVuCEots4aXs2L5kH2LrGBKLwu6H2/Autx+
         ROsmkIo8H67u35+ghf/9cX4dcOanPz/+HHF5S7wljxDMR1mzMNw4w684CdTULO8CYuZp
         co45kYrVtN+TL8jXSqIqQgGtO3QUFBVlQazD0wNeUW/5KvvUGm3NQQyLgmVCnrYAMVkC
         yLM7QIAZ898RiYtP773DyGcQ0uVQ9sHXMyzKPN8XvM94Q71crE4HoYvJ2pd0R+PsAa77
         ZSxg==
X-Gm-Message-State: AOJu0Yx+YIBTfAzdEhmjCZonqhutRdraY2RllHAI/+fxNI3Ga3irNg1M
	b7HNRA5P0A2LUP4BC5okgw0OvHUc4VgYCPSzC4Ihn9Zc0l8jn2QtU6HcQZeAGP4=
X-Google-Smtp-Source: AGHT+IGDB9vqcXlGOfTsqQDi0fDJITgrOZsH9TN5J8Bnk1BdqNWsb0qFE7oeW7Dj1+a5XuLSTOkUiA==
X-Received: by 2002:a7b:cbcd:0:b0:40d:6f34:5c13 with SMTP id n13-20020a7bcbcd000000b0040d6f345c13mr920130wmi.231.1705661145026;
        Fri, 19 Jan 2024 02:45:45 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id fm16-20020a05600c0c1000b0040ea10178f3sm77470wmb.21.2024.01.19.02.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 02:45:44 -0800 (PST)
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
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 17/19] tty: serial: samsung: shrink the clock selection to 8 clocks
Date: Fri, 19 Jan 2024 10:45:24 +0000
Message-ID: <20240119104526.1221243-18-tudor.ambarus@linaro.org>
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

<linux/serial_s3c.h> provides a clock selection pool of maximum 4 clocks.
Update the driver to consider a pool selection of maximum 8 clocks.
u8 is large enough to allow more clocks than are supported by the driver
now, and not too big to cause spanning of ``struct s3c24xx_uart_info``
through 2 cachelines when compiled for arm64. The goal is to reduce the
memory footprint of ``struct s3c24xx_uart_info``.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 149f618e22ce..c429029c0207 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -81,11 +81,11 @@ struct s3c24xx_uart_info {
 	unsigned long		tx_fifomask;
 	unsigned long		tx_fifoshift;
 	unsigned long		tx_fifofull;
-	unsigned int		def_clk_sel;
-	unsigned long		num_clks;
 	unsigned long		clksel_mask;
 	unsigned long		clksel_shift;
 	unsigned long		ucon_mask;
+	u8			def_clk_sel;
+	u8			num_clks;
 	u8			iotype;
 
 	/* uart port features */
@@ -1340,7 +1340,7 @@ static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
 
 #define MAX_CLK_NAME_LENGTH 15
 
-static inline int s3c24xx_serial_getsource(struct uart_port *port)
+static inline u8 s3c24xx_serial_getsource(struct uart_port *port)
 {
 	const struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
 	u32 ucon;
@@ -1353,8 +1353,7 @@ static inline int s3c24xx_serial_getsource(struct uart_port *port)
 	return ucon >> info->clksel_shift;
 }
 
-static void s3c24xx_serial_setsource(struct uart_port *port,
-			unsigned int clk_sel)
+static void s3c24xx_serial_setsource(struct uart_port *port, u8 clk_sel)
 {
 	const struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
 	u32 ucon;
@@ -1373,14 +1372,15 @@ static void s3c24xx_serial_setsource(struct uart_port *port,
 
 static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
 			unsigned int req_baud, struct clk **best_clk,
-			unsigned int *clk_num)
+			u8 *clk_num)
 {
 	const struct s3c24xx_uart_info *info = ourport->info;
 	struct clk *clk;
 	unsigned long rate;
-	unsigned int cnt, baud, quot, best_quot = 0;
+	unsigned int baud, quot, best_quot = 0;
 	char clkname[MAX_CLK_NAME_LENGTH];
 	int calc_deviation, deviation = (1 << 30) - 1;
+	u8 cnt;
 
 	for (cnt = 0; cnt < info->num_clks; cnt++) {
 		/* Keep selected clock if provided */
@@ -1473,9 +1473,10 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 	struct clk *clk = ERR_PTR(-EINVAL);
 	unsigned long flags;
-	unsigned int baud, quot, clk_sel = 0;
+	unsigned int baud, quot;
 	unsigned int udivslot = 0;
 	u32 ulcon, umcon;
+	u8 clk_sel = 0;
 
 	/*
 	 * We don't support modem control lines.
@@ -1776,10 +1777,9 @@ static int s3c24xx_serial_enable_baudclk(struct s3c24xx_uart_port *ourport)
 	struct device *dev = ourport->port.dev;
 	const struct s3c24xx_uart_info *info = ourport->info;
 	char clk_name[MAX_CLK_NAME_LENGTH];
-	unsigned int clk_sel;
 	struct clk *clk;
-	int clk_num;
 	int ret;
+	u8 clk_sel, clk_num;
 
 	clk_sel = ourport->cfg->clk_sel ? : info->def_clk_sel;
 	for (clk_num = 0; clk_num < info->num_clks; clk_num++) {
@@ -2287,9 +2287,9 @@ s3c24xx_serial_get_options(struct uart_port *port, int *baud,
 {
 	struct clk *clk;
 	unsigned long rate;
-	unsigned int clk_sel;
 	u32 ulcon, ucon, ubrdiv;
 	char clk_name[MAX_CLK_NAME_LENGTH];
+	u8 clk_sel;
 
 	ulcon  = rd_regl(port, S3C2410_ULCON);
 	ucon   = rd_regl(port, S3C2410_UCON);
-- 
2.43.0.429.g432eaa2c6b-goog



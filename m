Return-Path: <linux-kernel+bounces-146153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930CE8A6168
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E13F0B21813
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD0918EAB;
	Tue, 16 Apr 2024 03:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcR4q1ln"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8963315AF6;
	Tue, 16 Apr 2024 03:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237435; cv=none; b=Uzba+73RwhtTRIav/7Rpx9XIutMeIgnlIq0G+nR9gniS8tOJvnJMJY8gvmZHIg6yYXTfKEU/ky1gS7bu+P6/1nY/bofIzvPKEMEL58XSIdM5bpE8V2W0cB+9TEE+S6An8dBopd3ILyal3rkr/cMWrf2DfemsZQ4xymiSKgTmRmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237435; c=relaxed/simple;
	bh=9CKw6Ns0L5YcJd4x32/1S2dc5YX3XZimEZZwa+KRFmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=I1zUh9bDQDbNDdsMHptuPjyMB2NnTOwDGOg5gkTYvb40sVEvSPoKoPQ0HHqX43RdgCPVqotdjkorySJTwcWyMJsv6/WdcLy0wJCmPkeyw1LX+dN/6GVPXVZIrOMJ7TrLCoE6DpXUaHJ2CWVaLlKNbaEROhl0Lz7H2gfonWQZ/jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcR4q1ln; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ed32341906so3456160b3a.1;
        Mon, 15 Apr 2024 20:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713237434; x=1713842234; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KtroaYqcnyMYBjqOiDrOLUzCkiqYy/oQzAEHksV6GfE=;
        b=kcR4q1lnlfXuS4UMeH5f5vkE2Up1kCIW9DT8HeL8/NPdWL/HhkBMaLOO3NxLf7QNSU
         mWuJk+pUQT8YMhtF7laMzm+zlgs5vg2oSA6cMMpmEeYj4HR/wVj9dygxnYbsIpQG4kTZ
         IBljhm6tqgKcocwhjtvQTUmMGyxTXAd9VoUu3GcAM843TldtU6UbCLkqSP3xmEhYD1UL
         YiBUzU72BY8sI2vE6jfB+AHIlV2E9bVbrag23iziaMe4zbFbAyJ3flGSdAzCa7EMlKIE
         EOuPztqCni/0WY0ybFBLbBrhME+HdGIt+2sB4POKXXFC9PHzxAa1eWG8+l97W+kXSGgR
         N/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713237434; x=1713842234;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KtroaYqcnyMYBjqOiDrOLUzCkiqYy/oQzAEHksV6GfE=;
        b=EE7XtO+RkhiXHeWPhPJGtQaw5ddK88Iw6cTi06Lzqtx7fjsn57eBrXT2lLai73RaDh
         khEOp/Riw5+hBAvo1cSh7rwA7K/adIvP+ZfFVcNmvBFNx/OzezVg5RdSVTgdNrf9Mq5I
         OLoriw8DopF4UMf1iRQpZQDkhTLarkatQxclY8uoi0XOVEguUhsqCODosah5kaMeOl7F
         +EFNsAQf6F+u8OkmUG8YOK0wmiw7xkG0QdcNPN3jjGfQSyQ6yzC71sviAYlDlCxLOU48
         okTs9HeAcu1TGMH4SQYJfKlt6VDdCG8k20zOpohQ+zOQ7Vc0eqdebelv0S5eSepJcEv0
         0vzg==
X-Forwarded-Encrypted: i=1; AJvYcCWjQGzBtVPvMXl8UFK6pfLeTAOcivw1BCOfbhFKWBGi0aWJOy5VE7431KESQ/igSd71Ee9nf5gTIBuFJbD81N2EfU/bBsWAQPzN/lGrKw6jn2tFL74h/nY/c9KRpLDYWEKmJInFSv27sBo1
X-Gm-Message-State: AOJu0YyHmRPYc8ryEkIoROBW/rEs10S2/PKTLfg2IurIq3UP1GO2COEV
	6Jc+VyMdo3CXQMaLfzlNMOJKxeJd35de5HofsNBsFQr6xrsNi1DI
X-Google-Smtp-Source: AGHT+IGZ+pHtvHVAPYrf1SMPpr7pKM/v8Z0oeVFJ8UiC0oaGbmOZGtsexEtbO9Nc7cRX4xEeBcD7jQ==
X-Received: by 2002:a05:6a20:3244:b0:1a7:59b5:4276 with SMTP id hm4-20020a056a20324400b001a759b54276mr8858620pzc.54.1713237433780;
        Mon, 15 Apr 2024 20:17:13 -0700 (PDT)
Received: from localhost.localdomain ([43.159.199.34])
        by smtp.gmail.com with ESMTPSA id n4-20020a17090a5a8400b002a5d684a6a7sm8658616pji.10.2024.04.15.20.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 20:17:13 -0700 (PDT)
From: Guanbing Huang <albanhuang0@gmail.com>
To: gregkh@linuxfoundation.org,
	andriy.shevchenko@intel.com,
	rafael.j.wysocki@intel.com
Cc: linux-acpi@vger.kernel.org,
	tony@atomide.com,
	john.ogness@linutronix.de,
	yangyicong@hisilicon.com,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	lvjianmin@loongson.cn,
	albanhuang@tencent.com,
	tombinfan@tencent.com
Subject: [PATCH v8 3/3] serial: 8250_pnp: Support configurable reg shift property
Date: Tue, 16 Apr 2024 11:16:59 +0800
Message-Id: <4726ecea8f7bfbfe42501b4f6ad9fe5b38994574.1713234515.git.albanhuang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1713234515.git.albanhuang@tencent.com>
References: <cover.1713234515.git.albanhuang@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Guanbing Huang <albanhuang@tencent.com>

The 16550a serial port based on the ACPI table requires obtaining the
reg-shift attribute. In the ACPI scenario, If the reg-shift property
is not configured like in DTS, the 16550a serial driver cannot read or
write controller registers properly during initialization.

Signed-off-by: Guanbing Huang <albanhuang@tencent.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Bing Fan <tombinfan@tencent.com>
Tested-by: Linheng Du <dylanlhdu@tencent.com>
---
v6 -> v7: add a "Reviewed-by" tag
v5 -> v6: fix the issue that the cover letter is not chained with the patch series
v4 -> v5: modify to obtain the value of mapsize through the pnp_mem_len function,
          add annotations for the iotype variable, delete excess uart.port.flags operation
v3 -> v4: dependent on two pre patches: "pnp: Add dev_is_pnp() macro" and
          "serial: 8250_port: Add support of pnp irq to  __uart_read_properties()",
          the iotype is reserved, the mapsize is initialized, fix the UPF_SHARE_IRQ
	  flag, check for IRQ being absent
v2 -> v3: switch to use uart_read_port_properties(), change "Signed-off-by" to "Reviewed-by" and "Tested-by"
v1 -> v2: change the names after "Signed off by" to the real names

 drivers/tty/serial/8250/8250_pnp.c | 40 +++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 1974bbadc975..8f72a7de1d1d 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -435,6 +435,7 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 {
 	struct uart_8250_port uart, *port;
 	int ret, line, flags = dev_id->driver_data;
+	unsigned char iotype;
 
 	if (flags & UNKNOWN_DEV) {
 		ret = serial_pnp_guess_board(dev);
@@ -443,37 +444,46 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 	}
 
 	memset(&uart, 0, sizeof(uart));
-	if (pnp_irq_valid(dev, 0))
-		uart.port.irq = pnp_irq(dev, 0);
 	if ((flags & CIR_PORT) && pnp_port_valid(dev, 2)) {
 		uart.port.iobase = pnp_port_start(dev, 2);
-		uart.port.iotype = UPIO_PORT;
+		iotype = UPIO_PORT;
 	} else if (pnp_port_valid(dev, 0)) {
 		uart.port.iobase = pnp_port_start(dev, 0);
-		uart.port.iotype = UPIO_PORT;
+		iotype = UPIO_PORT;
 	} else if (pnp_mem_valid(dev, 0)) {
 		uart.port.mapbase = pnp_mem_start(dev, 0);
-		uart.port.iotype = UPIO_MEM;
+		uart.port.mapsize = pnp_mem_len(dev, 0);
+		iotype = UPIO_MEM;
 		uart.port.flags = UPF_IOREMAP;
 	} else
 		return -ENODEV;
 
-	dev_dbg(&dev->dev,
-		 "Setup PNP port: port %#lx, mem %#llx, irq %u, type %u\n",
-		 uart.port.iobase, (unsigned long long)uart.port.mapbase,
-		 uart.port.irq, uart.port.iotype);
+	uart.port.uartclk = 1843200;
+	uart.port.dev = &dev->dev;
+	uart.port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
+
+	ret = uart_read_port_properties(&uart.port);
+	/* no interrupt -> fall back to polling */
+	if (ret == -ENXIO)
+		ret = 0;
+	if (ret)
+		return ret;
+
+	/*
+	 * The previous call may not set iotype correctly when reg-io-width
+	 * property is absent and it doesn't support IO port resource.
+	 */
+	uart.port.iotype = iotype;
 
 	if (flags & CIR_PORT) {
 		uart.port.flags |= UPF_FIXED_PORT | UPF_FIXED_TYPE;
 		uart.port.type = PORT_8250_CIR;
 	}
 
-	uart.port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
-	if (pnp_irq_flags(dev, 0) & IORESOURCE_IRQ_SHAREABLE)
-		uart.port.flags |= UPF_SHARE_IRQ;
-	uart.port.uartclk = 1843200;
-	device_property_read_u32(&dev->dev, "clock-frequency", &uart.port.uartclk);
-	uart.port.dev = &dev->dev;
+	dev_dbg(&dev->dev,
+		 "Setup PNP port: port %#lx, mem %#llx, size %#llx, irq %u, type %u\n",
+		 uart.port.iobase, (unsigned long long)uart.port.mapbase,
+		 (unsigned long long)uart.port.mapsize, uart.port.irq, uart.port.iotype);
 
 	line = serial8250_register_8250_port(&uart);
 	if (line < 0 || (flags & CIR_PORT))
-- 
2.17.1



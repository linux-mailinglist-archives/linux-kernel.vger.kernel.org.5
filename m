Return-Path: <linux-kernel+bounces-141865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0DB8A2464
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C055A1F23BDA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B7A17BAB;
	Fri, 12 Apr 2024 03:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/8zladS"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C324C1B81F;
	Fri, 12 Apr 2024 03:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712892315; cv=none; b=OAdqam3s6OKO+gvdEKY2FiZKtV0vEbq1R1OABu7XzUvh9zo3PCRojbaKlp/KMh+JVrTpybQLJMydomau4sl8ANWIHdRAvrHB508mpd2N/l4jQaX5VDkA7+YVhq+p5/ydtJcmDmCrlHtDRjF65KDaXTCLFhLAu3AfNhkFMf8zJPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712892315; c=relaxed/simple;
	bh=9CKw6Ns0L5YcJd4x32/1S2dc5YX3XZimEZZwa+KRFmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Pyh/ftPjBDDjaWBWRXeIcJjNdgEzvl2bdvUSCxh1IE4xD4vVFA/6SJLywJ6S82gSzq8KFi/gUnvfiXkA7i2x9Ei1Cn5NDEGM5gtJtz8dnMNuRq9AdmCrjE2VneWwdQGofRLrHqDDctdW+LJR/7qZNZmBJA4rKfojOpFio01f2KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/8zladS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e5aa82d1f6so779335ad.0;
        Thu, 11 Apr 2024 20:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712892313; x=1713497113; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KtroaYqcnyMYBjqOiDrOLUzCkiqYy/oQzAEHksV6GfE=;
        b=i/8zladSzdgTy++lKKjKSaAgQU0Xigqp8hqPz8yHxmpZsw1QdSPmTGB0ynt9eihr7e
         HfFVqN8XeiEkCzgpj/fe2VffnCKHhkXeviGEOmINBTxl0nJT5tl24OOCOdBMWTUQ2cK+
         M+Wo0gURf8bUqTqRXJtkUjQiRQhbCGR4XL3kiK6fZhg2suEyBGCZpeIl8MnxfjmWYKJh
         tjkUi1jUEPdJEIFU10rc/YWtAz+jm9Xl6AoxDTjCbaFjaC7clhbRKzayQf7A03bs6k86
         EO8BaY+rOWyLpWJn6G2zTOYsbo2SKxlDYM5ejCrQYguUi0Sb9fFV6fYhAWlzfjTCzm0W
         la5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712892313; x=1713497113;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KtroaYqcnyMYBjqOiDrOLUzCkiqYy/oQzAEHksV6GfE=;
        b=nUmWp6jpa2QuFoz6Bnqe0rVSk2sT5S4eTjYNxAkh47UL6NrOIjiJtz6/L2swMTuFKo
         2cDwNRaHewSlRKRUCi4xQw5RrY0JSOuHGGI0tAfwLRlamFH9G4/tKJpD7pveUMPSdHKa
         zxvzVtVlZJJ6xO+dBOwZzK7sFgWLWpTxG3jGbk4QrVrUsiwXibfz8IZHM7eb+RzpCnHw
         iCaxzmKeEuGh8/eiOqVBAZWOGe95mhVpWCAV+NrvqnRuOV6IRNN+0IKk3ftavLjrWhRa
         mKSQ6n7ByADonaXlQqrHzAwX8okdCkDmOXX1z47CmdY9ZGduT/e7Iiv28+d+eTDQBWzT
         HUFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjMBdsXyU7a7dJLLC/2rfbDBxyQi3DGYuvBuEc6tRwC0zG2zqIT3+1VbcwoiEpwC+jcHv5Kc8iIvm0CL6b9vfEsOiVBUUlmkhrDT/B1VKInUgRJXCU47fX17tcFoUVXic3++xhjNh6HnhG
X-Gm-Message-State: AOJu0YynY/t7H8kso7L4fdz2d8AnP+rfzyaQltMAo1XOTzV48dZ1QT06
	j8U97aNelO23+5D/70UW594/PNW1gaFJe7eLpxT8zsM5J0kN06ya
X-Google-Smtp-Source: AGHT+IEMY4KXDDxPHpKKS/lhFPTqrezbvbayAaJrcKofTls9PlHc7z5waKT5mT0P09D+6Cxaw9fIlg==
X-Received: by 2002:a17:902:ce8d:b0:1e4:3909:47e9 with SMTP id f13-20020a170902ce8d00b001e4390947e9mr6194342plg.11.1712892313048;
        Thu, 11 Apr 2024 20:25:13 -0700 (PDT)
Received: from localhost.localdomain ([43.159.199.34])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902a3c700b001e2b36d0c8esm1972448plb.7.2024.04.11.20.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 20:25:12 -0700 (PDT)
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
Subject: [PATCH v7 3/3] serial: 8250_pnp: Support configurable reg shift property
Date: Fri, 12 Apr 2024 11:24:58 +0800
Message-Id: <8c4bdae45363f4beb885fa5c88682b630a35f9af.1712890897.git.albanhuang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1712890897.git.albanhuang@tencent.com>
References: <cover.1712890897.git.albanhuang@tencent.com>
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



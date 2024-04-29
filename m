Return-Path: <linux-kernel+bounces-162603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583068B5DE6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1455A280E74
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E77E8287A;
	Mon, 29 Apr 2024 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpCY4KKc"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142437E0F6;
	Mon, 29 Apr 2024 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405216; cv=none; b=NsH8Vh8sNYby5zrTXFnvUYmx9vnFALtPzi8rgYZaR/B+iyWLv9+avF3C7p6vJdlzxyshW4Ypy8xEad1x/9+HjwzzifXewyMrvISRuxyq3Udl3GTeC5o/d7rjiydxNEhuVvQOK7fgt3hHQXvei+sr68AYE5qzzScw7mYgmBJxDZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405216; c=relaxed/simple;
	bh=zXY1ffgM5q+lSr46Op+3+XcAUtlsLSzt87wdaCFSWfw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g9XVjq8ve7aD0AEsA5VqsOiwndC7vQJcev523PqH57xjfnb+NCjQCoxQA04Bk4B4MgWfBKolQZkmEltonEjfOFBGLHsZvsWByB/NIuXW+qF1ho4G+4bCkH0kQGTLFrG1GUv8aP9dAwZ15SV8bSZ8DXYAzgI9JOlzhLj8KplNOOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpCY4KKc; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e9320c2ef6so33110085ad.2;
        Mon, 29 Apr 2024 08:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714405214; x=1715010014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fBrnMC0Gct0UOxf9AGIaJ9EyFFBNBd1gd9JECoTWjF4=;
        b=FpCY4KKcHaxCE9rgyiF5maCAMl7Ska+5gFg5rsrj2J2RNMivZo2Ej7/g49nY5/uw7n
         z/VYs2V9XpNhV4aU1jD+3IrSoS4xPgOKGAVKmBQ/QbtgLyMG6rv/LZ/6PRUrUQh81h1h
         ThbflVqGMGMUWFNjtXsfVBzcN4Rr/D5cQ/6V3hwkNYiJ2GhZMMAEIMXJ9EKtpUxFBOFH
         47hCAdsDrSFGZLqRmo/CTCNqa0493Ep1eEG4YZ9BxdEXHK2w6J72PskbgXVjVyFjdbLl
         1bJ2frHSnjuyHQI7QrSSsRxpBz+8ZNyVCfSBRAjz7kmIOqdD0IZSv8BW+MpkMNoD0+//
         mJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714405214; x=1715010014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBrnMC0Gct0UOxf9AGIaJ9EyFFBNBd1gd9JECoTWjF4=;
        b=VAEYSZni1BMcDQKp9QI4fNE5pblr5Zl7TBKZbuds3vg4l5RLce7S8t4pe4MqyFGT2p
         qa8CJVBrg0uZzpHjk6dSEkf7EbEe8RKEWfsIJ1S0YQprm7V9zhVvv8Qs97QNlHxAoj6F
         aUOpXS98hkqwWaCainLRvfFcesrFe9YuJwrSaifsbgLg64zqphWREcjjCFUkxYuv6OR9
         YKX730FXW5HAt19ikjk1Dim4dv9xUhr2gkg3lM1MHoCcOEC/H+1OGqhUYD9tdGqv6NER
         SbN7SAeZECht+sAjl7tG84Osry/l8snq8QYye4ayiIOnyGWKIpuSAQOOR1KB2rpe3H+h
         fHMg==
X-Forwarded-Encrypted: i=1; AJvYcCVLJj3RzcE1Hy5s6K32e6llfyJuwwMOMIrBK9w9StMrleJDHIcQNRGPPhBtqnaor7glaAgWTnQgSDF08LCC+ZeJKhanJ3YwUsIBCEiWC2o+t/CUQl0t1SdWQPdamg+6mTPhMNlkgqyC
X-Gm-Message-State: AOJu0YxhtxX3zUNz5n9YTgvWMf8lyZtips5oaLe7noDUTgnBrKwjHaV1
	+Exd4PS2k4ZzrQ3LSH8zKMiC+5xiNr5IGECW+MrvG+n2wcfBJMre+SlNRQ==
X-Google-Smtp-Source: AGHT+IHX3jssBR2NBSuP9IzxUteP7JRQ78cKHaa2dWPkHCSDXoK6eOHwWJKTbkbk/H/hPXQCk7woLA==
X-Received: by 2002:a17:902:a60a:b0:1e4:9d6f:593 with SMTP id u10-20020a170902a60a00b001e49d6f0593mr4767plq.36.1714405214379;
        Mon, 29 Apr 2024 08:40:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b001dd707d5fe6sm20863719plb.158.2024.04.29.08.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:40:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Laight <David.Laight@aculab.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3] usb: ohci: Prevent missed ohci interrupts
Date: Mon, 29 Apr 2024 08:40:10 -0700
Message-Id: <20240429154010.1507366-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Testing ohci functionality with qemu's pci-ohci emulation often results
in ohci interface stalls, resulting in hung task timeouts.

The problem is caused by lost interrupts between the emulation and the
Linux kernel code. Additional interrupts raised while the ohci interrupt
handler in Linux is running and before the handler clears the interrupt
status are not handled. The fix for a similar problem in ehci suggests
that the problem is likely caused by edge-triggered MSI interrupts. See
commit 0b60557230ad ("usb: ehci: Prevent missed ehci interrupts with
edge-triggered MSI") for details.

Ensure that the ohci interrupt code handles all pending interrupts before
returning to solve the problem.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Laight <David.Laight@aculab.com>
Cc: stable@vger.kernel.org
Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: Check if any interrupts are pending before reading intrenable
    Add 'Cc: stable@vger.kernel.org'
v2: Only repeat if the interface is still active

Note that I did not apply Alan's Reviewed-by: tag since I was not sure
if that was appropriate after the code change.

 drivers/usb/host/ohci-hcd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 4f9982ecfb58..5cec7640e913 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -888,6 +888,7 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
 	/* Check for an all 1's result which is a typical consequence
 	 * of dead, unclocked, or unplugged (CardBus...) devices
 	 */
+again:
 	if (ints == ~(u32)0) {
 		ohci->rh_state = OHCI_RH_HALTED;
 		ohci_dbg (ohci, "device removed!\n");
@@ -982,6 +983,13 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
 	}
 	spin_unlock(&ohci->lock);
 
+	/* repeat until all enabled interrupts are handled */
+	if (ohci->rh_state != OHCI_RH_HALTED) {
+		ints = ohci_readl(ohci, &regs->intrstatus);
+		if (ints && (ints & ohci_readl(ohci, &regs->intrenable)))
+			goto again;
+	}
+
 	return IRQ_HANDLED;
 }
 
-- 
2.39.2



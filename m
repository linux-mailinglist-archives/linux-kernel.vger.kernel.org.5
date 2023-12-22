Return-Path: <linux-kernel+bounces-10090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D35981CFE6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99400284A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93682FC4D;
	Fri, 22 Dec 2023 22:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F9hx13r2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5302F84B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 22:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78129bc62deso72819785a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 14:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703285347; x=1703890147; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o2i334eTq3BuKE++cIjl9cMjhdqV78OcXKbB9KI96cQ=;
        b=F9hx13r2VY1NUuUY5u1Dj0t8Ji3jONWxsSLH7tvjkZvMj4Q4ToQPxJoKdxAmg120lN
         8cIMOeMPHWCwl78L1bkHaU2UL3ho4MENV9SH6/nSCrS+6ykyzIa+uvLBlyu722tvhy/D
         Vgz1FHFUZ23quIZEfbjGXhb3r3bB9amcnJkdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703285347; x=1703890147;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o2i334eTq3BuKE++cIjl9cMjhdqV78OcXKbB9KI96cQ=;
        b=UJbs0Xs6i2wHcYxg6OxeuPEPPjbV4WH6YZtHJJ0I/eWkCW/rj937ZCGdpK6lkC247v
         xDI1HWTO+xgzRt0drNsUSeYbfYIxr1Y2zyum6/qu8TKhbmQCpzUVfsboDVeX5lrkrWIP
         lD1ryrcEYfaJr5pyi7DkfaQj0Tk650tA3iHdLvSN4D6WGkpP+5g0VUzbZ7SxLOfKIDfa
         NWCM2evMphGvIvr453KO3V0iLvQXfsSrnmWkOAPfcP3fkRrxI0AJoREsHv+j2RG9p2Qn
         T8JFQOeKgTL8ZpvA+bzxxuwTrEErcogJrVOI39lB7152WbelkxjnV3vrnmuLKPvpduDJ
         6eqQ==
X-Gm-Message-State: AOJu0YxwSG6SdvU2to7ejLfV7ZziPl3Op9lMQljVA30jia7aqkYaMHhz
	e2mzB1hijBxktHoGUGtIvlQCSnguM8Hcc8Y5pCByUV13GQ==
X-Google-Smtp-Source: AGHT+IEJcu6vJ19xBj14+zUuTLhAr4vb4xeSyeabv8Dz4dJPelHnv1JgPxCYjSBCXQxEL3WOoYbaAQ==
X-Received: by 2002:a05:620a:4eb:b0:77e:fc1c:97d8 with SMTP id b11-20020a05620a04eb00b0077efc1c97d8mr1833685qkh.36.1703285346729;
        Fri, 22 Dec 2023 14:49:06 -0800 (PST)
Received: from denia.c.googlers.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id vy23-20020a05620a491700b0078101bf693fsm1632404qkn.96.2023.12.22.14.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 14:49:06 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Dec 2023 22:48:59 +0000
Subject: [PATCH] usb: core: Add quirk for Logitech Rallybar
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-rallybar-v1-1-82b2a4d3106f@chromium.org>
X-B4-Tracking: v=1; b=H4sIAFoShmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDIyMj3aLEnJzKpMQiXUPL5FSDZDOTFNNUMyWg8oKi1LTMCrBR0bG1tQA
 7yQmIWgAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.3

Logitech Rallybar devices, despite behaving as UVC camera, they have a
different power management system than the rest of the other Logitech
cameras.

USB_QUIRK_RESET_RESUME causes undesired USB disconnects, that make the
device unusable.

These are the only two devices that have this behavior, and we do not
have the list of devices that require USB_QUIRK_RESET_RESUME, so lets
create a new lit for them that un-apply the USB_QUIRK_RESET_RESUME
quirk.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Tested with a Rallybar Mini with an Acer Chromebook Spin 513
---
 drivers/usb/core/quirks.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 15e9bd180a1d..cedb619994d2 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -553,6 +553,15 @@ static const struct usb_device_id usb_interface_quirk_list[] = {
 	{ }  /* terminating entry must be last */
 };
 
+static const struct usb_device_id usb_interface_unsupported_quirk_list[] = {
+	/* Logitech Rallybar VC systems*/
+	{ USB_DEVICE(0x046d, 0x089b), .driver_info = USB_QUIRK_RESET_RESUME },
+	{ USB_DEVICE(0x046d, 0x08d3), .driver_info = USB_QUIRK_RESET_RESUME },
+
+	{ }  /* terminating entry must be last */
+};
+
+
 static const struct usb_device_id usb_amd_resume_quirk_list[] = {
 	/* Lenovo Mouse with Pixart controller */
 	{ USB_DEVICE(0x17ef, 0x602e), .driver_info = USB_QUIRK_RESET_RESUME },
@@ -718,6 +727,8 @@ void usb_detect_interface_quirks(struct usb_device *udev)
 	u32 quirks;
 
 	quirks = usb_detect_static_quirks(udev, usb_interface_quirk_list);
+	quirks &= ~usb_detect_static_quirks(udev,
+					usb_interface_unsupported_quirk_list);
 	if (quirks == 0)
 		return;
 

---
base-commit: c0f65a7c112b3cfa691cead54bcf24d6cc2182b5
change-id: 20231222-rallybar-19ce0c64d5e6

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>



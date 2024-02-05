Return-Path: <linux-kernel+bounces-52423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CEF8497EA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C54CB20FBC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF45417730;
	Mon,  5 Feb 2024 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5SECKt6"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B0E175B1;
	Mon,  5 Feb 2024 10:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707129657; cv=none; b=LuJdVu4f6Q8LY/R03afv4XDjWDd426gOkCnyufEYpepqA5QJj0dVuivTnFqdWrcf7z183x1mXUnAH1XDObMxCxXXzqZT+ew67CPB8uinEWG1+M4fRaheksdNe7F44YKFWrlgKqEwECQjjHdybYVUSl0LlYgAMz63SrjztU1J9PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707129657; c=relaxed/simple;
	bh=LhTvWM2ZS2yUbBwmJjrq1gAc3nJor+n0fSTLCF4bO+Q=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=RLXA/3jblZm0Hji1gK7tw9qhwpbuOAMdgReYRhn5v21s4Z4ihaML2+sTM+CKpVqkFeqK5ZgE3Zk99jWzL3/GcWWwgbclhZk0XZYnCyK1UkYWckaxzEGOT8OTDPZgcw+Z45LUqxBgbuNH0q13HoPbL/na7XYmzk3zHc9oQsk+jGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5SECKt6; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51025cafb51so6370951e87.2;
        Mon, 05 Feb 2024 02:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707129653; x=1707734453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/WvPuNNfdDMZhJiuwXWBrrqoa62yLY/Out7LD8kuSYA=;
        b=I5SECKt62XX/3w2WoAJXGs2HHqD5NSaDXwHa/SGgbq9i39syemz32ZncokkYg84pBo
         dlxQ2Jf2wLqJFH6/IcIulpGGbybOFFI453zVMbcQ0rDfXFDbselVmMenevfK1FGdts/c
         uGdn1+1DucVBVK9ztfbB+egyZCjWne7nxSD0a2s/8DKO+yyTD6MtRDbKK/4Z/K8dPSwt
         SOM+gUnCLKtcSNXqDUEXKTdiT02a05I3WOyq6cDThmIfQ5pylcPZ8W5UhR1xcDajCjSU
         G4AlwGJbSII4patQjyybc/x27VSOAHa/AppggWcPN9slNezcXCBW+pXi1TEWlmB931vS
         tpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707129653; x=1707734453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/WvPuNNfdDMZhJiuwXWBrrqoa62yLY/Out7LD8kuSYA=;
        b=OHVVWNDZu4ddzSxKExG8cyBsQT4nclRcCRVr7g+DdUCQrNCqC01ZUF9IR1wWmq3uvO
         EZp2Byw2bCxHhHkuxUIJbd4Tu+k4eijNWSTOMrM8tnsmNdCC1GHP3RhLxICjW2EL6tiv
         S6XiOJZHLnQoPtSC0xIrn9HB85hlACTnXiRHdmMjBwpcbiNVtMeGMylwlQOjmdjq/LvW
         AwCGySyfRuUjpEbOsb3WrEzYne2huYcR0XObX4SjFxnjacH80AgyORvd80tLT9P6v8Ha
         KhPGTiTmaeZl0tQQBs4jNnpS3ZC1V4FsKPJ3tdQcc+SZ0JyBCppM7t1JXkeHhtql0Tma
         Bu/g==
X-Gm-Message-State: AOJu0YwXrrT55NUBPSfKtmdMvnh0+GEjo5LI6qc8QYWd1qYVMBUZqHXM
	w/gytL0YSYV/q/Oxmcx1sZTd5BeYMyWulBo/Su7xmh3Qc+BIxbuh
X-Google-Smtp-Source: AGHT+IGEWxOTXFdrlIILxxDafqG+a9Cohoq+KoAMUrPZTtTYgoZ4TSX9sXLOpsL9K7AisRmcUzyV2A==
X-Received: by 2002:a05:6512:2145:b0:511:5572:2869 with SMTP id s5-20020a056512214500b0051155722869mr231576lfr.48.1707129653261;
        Mon, 05 Feb 2024 02:40:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW+QdzNJinxxT8NQKsvq/b4wuY4ZvzgM9f5satAk8FY5MBp2apYVjcdKhMqTfO87UoFKQg0Nm8ZEWOhyftUFNKtFSPadKV4bsH38QB58ivrWhT/pycBHyl4UJvSivFyJRNW95IcWISVDeHrzUwgwjVr/26lYdQwsFC7Ym+54waT2EkA9/c3xi5/y9YH3P2p9CS8iz1qqstrWezlem+k0H6bAt+LvB68aeVHhHvUdzpnXq4ddMk5c5gqIGy4BaAVOhWYAsIp9hG0hlzjqjxPrAA=
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id fm24-20020a05600c0c1800b0040ee8765901sm8299011wmb.43.2024.02.05.02.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 02:40:52 -0800 (PST)
From: Christian Hewitt <christianshewitt@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Grant Grundler <grundler@chromium.org>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] net: asix: add 0b95:1790 to AX88179A device list
Date: Mon,  5 Feb 2024 10:40:48 +0000
Message-Id: <20240205104049.48900-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a generic AX88179A entry for the 0b95:1790 device id:

kernel: usb 2-1: New USB device found, idVendor=0b95, idProduct=1790, bcdDevice= 2.00
kernel: usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
kernel: usb 2-1: Product: AX88179A
kernel: usb 2-1: Manufacturer: ASIX
kernel: usb 2-1: SerialNumber: 00D24DC0
kernel: asix 2-1:1.0 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32
kernel: asix: probe of 2-1:1.0 failed with error -32
kernel: ax88179_178a 2-1:1.0 (unnamed net_device) (uninitialized): Failed to read reg index 0x0040: -32
kernel: ax88179_178a 2-1:1.0 eth1: register 'ax88179_178a' at usb-0000:01:00.0-1, ASIX AX88179 USB 3.0 Gigabit Ethernet, 20:7b:d2:d2:4d:c0

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
The change is tested by a LibreELEC (distro) user who reports the NIC to be working
fine (and logs support this) but the "Failed to read reg index 0x0000: -32" errors
suggest ax88178_info might not be the correct choice. I'm not a serious coder so I
need to "ask the audience" for suggestions on what more might be needed?

 drivers/net/usb/asix_devices.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index f7cff58fe044..9a7b1136cd98 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -1506,6 +1506,10 @@ static const struct usb_device_id	products [] = {
 	// ASIX AX88178 10/100/1000
 	USB_DEVICE (0x0b95, 0x1780),
 	.driver_info = (unsigned long) &ax88178_info,
+}, {
+	// ASIX AX88179A 10/100/1000
+	USB_DEVICE(0x0b95, 0x1790),
+	.driver_info = (unsigned long)&ax88178_info,
 }, {
 	// Logitec LAN-GTJ/U2A
 	USB_DEVICE (0x0789, 0x0160),
-- 
2.34.1



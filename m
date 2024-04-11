Return-Path: <linux-kernel+bounces-141616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F44B8A20BD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1951AB21CC1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A541C381B1;
	Thu, 11 Apr 2024 21:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FgXs8HVU"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973B31805A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712870275; cv=none; b=D8Avy/t9FlNy5cNPeVk1IZeJwO6LxA5DtfZlGIIuhaW6JzQ+fONrDVc9QYoXXY8CNs8URrDXwaZ+GmQsDp/VvVYDFTpFTKv6uMuEjs/opCTGxXhkFXoqlORWZLCN1ASZSDSt36YgxH+j/2qnLh5UYyU5Xvveyfj1OlUJ7R/SBX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712870275; c=relaxed/simple;
	bh=s6xMOF20B4qYnFL8ZR3c00RdegXMuufiIQSgbqLKoU0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KmNW+dt9EEebTnN2elrWIb9guRqegASluDlj3kXCrdJBDjIlWaSDxxD8br/BMe0Bwni8Tuynj+ehT6PvDR8IOyQCSJhRB4GI0t5e2RUb7pGDSq+jtJC01QNP8VvHMc/YznftGJ2DH4etpCZrBMYHM5NzFROeuWu2DBfqoOxDJyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FgXs8HVU; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-436433a44bcso1233081cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712870272; x=1713475072; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UXgieRcG+rkonTZ60EMAThjqhGOmVBK8DdZAwLfR+j4=;
        b=FgXs8HVUtq81G/AaJN9rvkiHoIUc+NzYiHLFaEW7KrkdutgOBEdmLM015OotKBVdMP
         ntBBAy+89jodwV6Q36Y5XGtvGAkWtUSBm79gwNc5Ki+fI+VMMYrO8kVSc1XygMiHEz1P
         1lw5cH3zjXubIWb9oyVXLtZ3vdtusB+U5r6j8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712870272; x=1713475072;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXgieRcG+rkonTZ60EMAThjqhGOmVBK8DdZAwLfR+j4=;
        b=hf/nRmmfOu597JiJBwqZIG0i1Rg1fgvaRKJVO3OdKNEbLCQtw2BopWao776PbeAz6p
         kah3HL+4riQHvCdG0Ws4Lug5IHvs3lHggmxYEIMALJ0y2IjpfULcw7z1WIAl58y/n1q8
         dFW8NZeSvaamuQPtLoCfQ8HbSQKoDpN1vXm9stw+9AOgIudHIGeCU0mbFDk2Cyayb001
         TWbKIDWc9ehrJGSNfvnmtNtL3YJFULpnYDgd3GHToSwSHdLISnxANuxl5d+dmcpSfN1g
         Q16v4zARlavmG5AghWPS0T7x1rj6Xd1qziUppQmGVCOn7Ww0ZGJ3V9OvCETow/uoCfUu
         EXJw==
X-Forwarded-Encrypted: i=1; AJvYcCXC7hqHiuLO3IzkWD4J++LAsHSysI8ktpTto8u/hqJjpyD/7pVHYFcBRh7N+maNlAWMlLtCVCgWlOZcKyk3eCiKx1p047ta9ChFciK4
X-Gm-Message-State: AOJu0Yw/mcziX+dFbAxMnR8P+YBo5GwBo+S3q7SsaRAgxtsHJLmmxLWR
	SIw0gQoAffxjHNDHwYdKm1a4M2pnSTCI5nNHsgrP0MAaoIoTFOslvsI+egj2iuXI8pZ/GcmvbvR
	8jA==
X-Google-Smtp-Source: AGHT+IHY9n56LQHya8nQxc7cMaUBUO8W0KGUpEX4EunQu29vFiKFzzjnJBArAMIAzXk3xsAFMZxSxw==
X-Received: by 2002:a05:622a:1189:b0:434:7189:d688 with SMTP id m9-20020a05622a118900b004347189d688mr980610qtk.30.1712870272592;
        Thu, 11 Apr 2024 14:17:52 -0700 (PDT)
Received: from denia.c.googlers.com (200.234.86.34.bc.googleusercontent.com. [34.86.234.200])
        by smtp.gmail.com with ESMTPSA id k20-20020ac84794000000b00434d7c4f9fasm1373362qtq.8.2024.04.11.14.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 14:17:52 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/7] media: Fix more smatch warnings
Date: Thu, 11 Apr 2024 21:17:49 +0000
Message-Id: <20240411-fix-smatch-v1-0-045f92467937@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH1TGGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0ND3bTMCt3i3MSS5Axd4yTDFAMjU8s0U1NjJaCGgqJUoCzYsOjY2lo
 Aqn9jdlwAAAA=
To: Bluecherry Maintainers <maintainers@bluecherrydvr.com>, 
 Anton Sviridenko <anton@corp.bluecherry.net>, 
 Andrey Utkin <andrey_utkin@fastmail.com>, 
 Ismael Luceno <ismael@iodev.co.uk>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ricardo Ribalda <ribalda@chromium.org>, Shuah Khan <shuah@kernel.org>
X-Mailer: b4 0.12.4

This has only been compile tested.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Ricardo Ribalda (7):
      media: solo6x10: Use pcim functions
      media: solo6x10: Use devm functions
      media: saa7134: Use devm_request_irq
      media: c8sectpfe: Refactor load_c8sectpfe_fw
      media: tunner: xc5000: Refactor firmware load
      media: dvb-frontends: drx39xyj: Refactor firmware upload
      media: dvb-usb: dib0700_devices: Add missing release_firmware()

 drivers/media/dvb-frontends/drx39xyj/drx_driver.h  |  2 -
 drivers/media/dvb-frontends/drx39xyj/drxj.c        | 49 ++++++++++------------
 drivers/media/pci/saa7134/saa7134-alsa.c           |  9 +---
 drivers/media/pci/solo6x10/solo6x10-core.c         | 16 ++-----
 .../platform/st/sti/c8sectpfe/c8sectpfe-core.c     |  2 +-
 drivers/media/tuners/xc5000.c                      | 39 ++++++++---------
 drivers/media/usb/dvb-usb/dib0700_devices.c        | 18 ++++++--
 7 files changed, 62 insertions(+), 73 deletions(-)
---
base-commit: b14257abe7057def6127f6fb2f14f9adc8acabdb
change-id: 20240411-fix-smatch-3b1d0259f553

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>



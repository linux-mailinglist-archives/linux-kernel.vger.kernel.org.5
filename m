Return-Path: <linux-kernel+bounces-30452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53D6831EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80CB1C262D4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615852D057;
	Thu, 18 Jan 2024 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvZA7GmF"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D802D608
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 18:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705600869; cv=none; b=t2cy8sgggGO3IUUeEPg6S8VRqO14hNxQx1uH+omUVR1psTBhtTE9JLYDUQHKm4MP72eAQ/DTxEH3dXNvrX7Yp3MpH5S//p9ZLxHSNzFrOwFoFR2ft9NMFrUzX+js0Esy9ROQT2Ye0DTkL9/JdymXAvAo2hPgLkYgh4jBvKjOZEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705600869; c=relaxed/simple;
	bh=OrU1H4UzGzxdl1Ds1iMEsFMSWtaNQCoi3wOtLuEophc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NCPxd4bje60WrNR5bB+AWYMV2JylqX/0XqRSfqQomrvjB9sCuH1RC6LEnZxUzf9Z6ZW56GG2LURnQVOF2w7S/tPJRB5YwL86IVE+6+3tLrdmEEDBqJGPCfabMPmGp8YYzuI6kAVIJ/D6oXH/5Zq+TrLEOaXS7rU01O5viMnABUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvZA7GmF; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-598a2136259so666121eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 10:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705600867; x=1706205667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAKbu+IwB+CV3y388Ck6W4m5EwM/Dk1UA+arbmrM5gI=;
        b=FvZA7GmFcvvHj16iRNxB8Rdz8ts/pdhso5KIcWEmC+BUdrLTE+NzEi4ZBEVGbIkOq7
         uuSV8PyCadkj9Q/eCx8kqbJMi0KKnUg/tPG0fSP2fs/ABJUHQeenQ8OziPkrVx/U26YC
         MrdjQp8LMkVFiYYT12QkucfzryG7+ekwfGXAXKQSoB1700D2KpuSkkBTAGtACZgOBtj3
         V817Dfb/EZTHH1d1l4oGKPdHh+DXBsZE56CYmXNagREbR2e+uRXf3983nOY7oqHXpESG
         6/t7HLjkBksnhDZztwQ9eBnywMKS9vwEk93ufT0MoH3BNS9/DLoUDX+h1MOekW59bIUL
         xgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705600867; x=1706205667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZAKbu+IwB+CV3y388Ck6W4m5EwM/Dk1UA+arbmrM5gI=;
        b=QobJppiJrRwgLNsisMcIK1d1e5rruZqF20JAA9LUZp7V+fHmxrQTuBKTgAB9Ta4T2s
         ccNqFR9eBmQ/wwS5oT1GO25oGKAqWzsZYZOBdAFgp3tYsduYtKuKziB8HUU6ARFCQYeF
         xOAeaAwrUx6sHRm87tY/7whf3pTQfGqjCwojIBiAMkoggRnBDF5fD64+oYOxVniHC8Ld
         ObRyFx7zSNKwQFPB1atGWpWcpohyfRd2fQp8qBHhqkfVa/UzcmdG07naGuf0CTZFVtS0
         6MxYPFvGlfvQCwnmNIJopFD0ec+f3wMZ8OLILGUmmjX9P9SXbVqEa8C+aTTI+ituGCDQ
         H3WA==
X-Gm-Message-State: AOJu0YzB0AVibkxvxWFQxZqJsp/EIbTMhxlEJlc3nAWsAFwfUjtYw9Cb
	U2b3DCYYw895I3a8OHDnOkVy1lYVl+uNb0qbuvSScWHo5qVtSA+zC5/l8sWYyU430A==
X-Google-Smtp-Source: AGHT+IENe9TQ+w/mpdRhglVCwG6JuvtbY6kZkbrpGvUXZZCBXdumy0ENO5bEn/zAVlcRf/y+QZaC+Q==
X-Received: by 2002:a05:6820:2e01:b0:598:c88d:2f44 with SMTP id ec1-20020a0568202e0100b00598c88d2f44mr2493975oob.1.1705600866374;
        Thu, 18 Jan 2024 10:01:06 -0800 (PST)
Received: from me.mynetworksettings.com (pool-74-98-201-227.pitbpa.fios.verizon.net. [74.98.201.227])
        by smtp.gmail.com with ESMTPSA id lz6-20020a0562145c4600b006818a1e269csm837236qvb.102.2024.01.18.10.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 10:01:05 -0800 (PST)
From: Jacob Lott <jklott.git@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Jacob Lott <jklott.git@gmail.com>
Subject: [PATCH v3] staging: rts5208: Add more details to Kconfig help
Date: Thu, 18 Jan 2024 12:59:48 -0500
Message-Id: <20240118175947.82297-1-jklott.git@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current help text is short and triggers a
warning from checkpatch.pl. This patch adds more
details to the help text which should provide better
information for whether or not to enable the driver.

Signed-off-by: Jacob Lott <jklott.git@gmail.com>
---
 drivers/staging/rts5208/Kconfig | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rts5208/Kconfig b/drivers/staging/rts5208/Kconfig
index b864023d3ccb..c4664a26ba3b 100644
--- a/drivers/staging/rts5208/Kconfig
+++ b/drivers/staging/rts5208/Kconfig
@@ -3,7 +3,11 @@ config RTS5208
 	tristate "Realtek PCI-E Card Reader RTS5208/5288 support"
 	depends on PCI && SCSI
 	help
-	  Say Y here to include driver code to support the Realtek
-	  PCI-E card reader rts5208/rts5288.
+	  Choose Y here to enable support for the Realtek PCI-E card reader
+	  RTS5208/5288. This driver facilitates communication between the Linux
+	  kernel and the Realtek PCI-E card reader.
 
-	  If this driver is compiled as a module, it will be named rts5208.
+	  If you opt to compile this driver as a module, it will be named rts5208.
+	  Selecting N will exclude this driver from the kernel build. Choose option
+	  Y if your system includes the Realtek PCI-E card reader rts5208/rts5288.
+	  When in doubt, it is generally safe to select N.
-- 
2.34.1

v3 fixes the tab spacing for line 6 in Kconfig


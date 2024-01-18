Return-Path: <linux-kernel+bounces-30375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1F5831DE9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEFF91C2535C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A522C6AE;
	Thu, 18 Jan 2024 16:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVNvbwbJ"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571352C6A2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705596896; cv=none; b=CQ+SovCvG51KgJ8/qsIzZQeLUy6mUIFyDnDwTaNFbHINQegd1Ad+XL+x9ULPFrmJDigV6PbyLJ7og9XS2Rscs7QWp9lhqcc5aLYwxJeICRcjk2ly3qQ6eJfZgzPkxPZLJwode6G9GmCAIed87nRu0+Gulc73r2x0AbMIrbt39Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705596896; c=relaxed/simple;
	bh=O3B5hl/PkwgxfzcSFsKmiroJsVntteBP+PH82CDvc9A=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=eX4EDxC0mkqCM+nhpH9xwTlchbp2SHvVdkJMlX1s1Nbe5P8NSR3SlSbN1Wgqq0mjsu/FtMRtp8VWG7rkSnY7jjLuYy7iZVJLGN86DBERzYRAiwSJy5LUfx3ezzOHnWxLVXoyRS3qEnTHNw6NtMynfO8/YvZevCeP5+pfJOuknXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVNvbwbJ; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-598a2136259so655609eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 08:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705596894; x=1706201694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7rpaFisTUShqKJQAtnulPrrm08KwxaoEZy1neHhi4+c=;
        b=ZVNvbwbJDy1BRNumRxREMkp6qC3CWgX6hy2bsXCIhZuzx51BSbDea16601wz364pME
         bdq8KojM6DJhBtji+LgFmtIjZY8oc4YjzCEUZI3QBrRt9wZijFnngCw/jK7aQkM3Evgs
         HUZjqRaDpyNTk8jqbWWp3xMXhpPx9vASRypfmcX4wMGRdEWaq+HI7iizYZ8TwtiFKW5u
         IwCcSo+eYmLPt7N7QB6x4EQed+yvU3I/1I4pB6zIVGnzgb+wuD1JUZRhibwLy5tvZyDh
         NOpj+840UVhIewIlEO7jyOP5gXlSzOFrdLCzem6/BmzKrvfVwdnij4lofRdkvF7bHFM4
         RTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705596894; x=1706201694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7rpaFisTUShqKJQAtnulPrrm08KwxaoEZy1neHhi4+c=;
        b=bxGP99mhRgOPAvrNrCeQQSQDA0t7lt+RCao/yT9bbVS9j4eqnZPW8n/VrnN8+KKENB
         Id+Ldswpw0tkBa5lc5Q202Hh0Y/unTuOibUQ+BDTk65UmQfsdrBwqrfHxbWfX7lqmLtF
         KFyP5mcdOVW8FUnmgV+zBXyyf6XtX/NsNlfT/qqdEjjFjmZpDPuL97BWeIEj773kgz+O
         0zT9uHX8Icqe4FGBxSfvSgrJTRu10B+MRzXh0ccV4VGp+CBlrBJoSTLmnWs7owcluB+4
         jgtkXtfvi0Lk/nzqvrGWsTlWWE6ihHDPv0SpD+AFb6Jy6hdN/b3c17tHnrXXFBPqnsX1
         98rQ==
X-Gm-Message-State: AOJu0Yzgs57K3uwtF8SaO6zdHNZ8y1ee3pJZ8tr9CYYaOIgY/D0yLr3E
	4FpROIJ7/CF2icmkTB4AoI2ydWASw/6+N+EJjD8aLo2Ra65HA919XnIhQHZHBpuHuQ==
X-Google-Smtp-Source: AGHT+IGoEwXFQLpN25iosPFOeAiXmbx51OYsIn48U2RlsUuRx34712DQab1roSOg4L1qhrDyU7r+aw==
X-Received: by 2002:a05:6820:2b13:b0:598:c118:30d1 with SMTP id dt19-20020a0568202b1300b00598c11830d1mr2219146oob.0.1705596894462;
        Thu, 18 Jan 2024 08:54:54 -0800 (PST)
Received: from me.mynetworksettings.com (pool-74-98-201-227.pitbpa.fios.verizon.net. [74.98.201.227])
        by smtp.gmail.com with ESMTPSA id j22-20020a05620a147600b007832104bba9sm5425176qkl.23.2024.01.18.08.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 08:54:54 -0800 (PST)
From: Jacob Lott <jklott.git@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Jacob Lott <jklott.git@gmail.com>
Subject: [PATCH v3] staging: rts5208: Add more details to Kconfig help
Date: Thu, 18 Jan 2024 11:54:47 -0500
Message-Id: <20240118165447.78727-1-jklott.git@gmail.com>
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



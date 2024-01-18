Return-Path: <linux-kernel+bounces-30498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CAC831F82
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F1128670C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123B42E401;
	Thu, 18 Jan 2024 19:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4PySXhc"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CAFA53
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605385; cv=none; b=sOFKKwq/tpGL8G9NAHdx61Uz38bVDi7sSDSue+w22CZAE1pSrfksYR0EaX+HVlYvZvR1/wxdRigDhKV8ep0ewXPqINexxIF9nkWm6mepLIQ7ZIUemhCALh7umGVtpp5kYt9vIJzj9cX/cbLBMr3ATH+8dFubKcwK+S8eD7PfFfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605385; c=relaxed/simple;
	bh=N6PD4Pn8xXOy0winBMEC77MBySNJREQE9WnU3qOPXNU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dp1+SHI07m9aKya5/VkAN5jPyksr19e11/CLmL/KcDVNDnqV76wVDKV2Vnbibl80nNwOBbm7e1EMe5rZWBbRRJ+1EcNRfiotfIiIOO9ylbAURL4IHWzVZYmyDX5FdMwR3uu5/XUcZhgyaJbphdCIfqiFm+5ZeswU5vMDFiYNqyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4PySXhc; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-429bf893300so43341cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705605382; x=1706210182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VwsWXj+/LmbABlQqMCfmA7LGZR+IInP1jMSwsO/WAjk=;
        b=k4PySXhcS2+3NcOMgA1UsdeuI2eophfzIXR2IkSKuZvmtTBDxsE5xfpwaNmSGagrLf
         FT71HjDhHzw3hcJhMq7vb3RyvKKOMob7K+Lvyv/+0YrcMX/EFAEmbmHnQErGf9qrEuWq
         crK37X8Moy41B1nCTcZYZ/VcQwL49UAqj+Oa+thgOWFb/BIG5jE93NYpKb6WwxhVJ4lo
         BpdxhEK+dN2xZAW+H26yqzJ8DVv29X/GCX8Rkc6mAql40hrHZ++aRcnTJiVMINWPUh5t
         XbSP+DnKjq+TiSm9KnKycbHFv+KCjy0vsp2W39aeWZ+AiE03o6ThbUc955973oZhk8En
         tCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705605382; x=1706210182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VwsWXj+/LmbABlQqMCfmA7LGZR+IInP1jMSwsO/WAjk=;
        b=eGUWUAPg04f8vDYeWX/sof2QU0Nbsst64iJPKij48vTBWVkYxUX/ugqcEgG/UIMHZW
         ZIp8TYxKCmUEWN6ll1LjLTKAfRBWwDfmJfElc7tcL6KGJtERJNJqrwON8E9rCnAJcJnl
         vxyV74DIX6hIGzZ6IbTx/TnQ3lU17RGkumf+Fpd5BgLOqh7y7CLwHxr1NaBu9/08gbxg
         s5Jhq1JNfx2j7gw4RVbwefqsGXfLWybaRoA6XYOtvByKG/84viVyBfjgab2wynJF6Enb
         d1vCoyLvBuynbtd/JkD3kIqxTNXWRMIp4kwrq2x5GqLt1jS0ErIu8BUPdvwhrylNoDZ9
         x2+g==
X-Gm-Message-State: AOJu0YzxNY+q++VybM7OA5lK3WxdCsGWW5/u7RAD9mnr+xrBXZrNr77Y
	5NHf2Gfk5qzUKHFIOwny1nyaE5V78J3MjFwJsdETWoebfo0yj6J8
X-Google-Smtp-Source: AGHT+IGknJjns6pk5kfe9DNG6dAYa2dEE3uGt6EfY2L2Oyp98/vIPpgsItT3n+9iiguWhpWTg5gMzQ==
X-Received: by 2002:a05:6214:cc6:b0:681:91e3:919a with SMTP id 6-20020a0562140cc600b0068191e3919amr2419003qvx.1.1705605381946;
        Thu, 18 Jan 2024 11:16:21 -0800 (PST)
Received: from me.mynetworksettings.com (pool-74-98-201-227.pitbpa.fios.verizon.net. [74.98.201.227])
        by smtp.gmail.com with ESMTPSA id l15-20020ad4452f000000b006818004d4efsm1428290qvu.126.2024.01.18.11.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 11:16:21 -0800 (PST)
From: Jacob Lott <jklott.git@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Jacob Lott <jklott.git@gmail.com>
Subject: [PATCH v3] staging: rts5208: Add more details to Kconfig help
Date: Thu, 18 Jan 2024 14:14:26 -0500
Message-Id: <20240118191425.88826-1-jklott.git@gmail.com>
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
v2 -> v3: Fixed spacing and newline in text
v1 -> v2: Corrected line spacing based off feedback

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


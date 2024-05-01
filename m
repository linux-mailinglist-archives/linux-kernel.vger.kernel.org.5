Return-Path: <linux-kernel+bounces-165302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910228B8AED
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4E21C208D6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F8412F37F;
	Wed,  1 May 2024 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L3JxEcRE"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA6912EBCE
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714568899; cv=none; b=SBrqOP0AaM2jftr3+8yFu8g30QeTJfgXRR0Et5i8ThXXu8MZFr669vlqJGzI5boNGfVjenroQ04Osz/QmC4i9t/6jKa5xNP489EGOCG8YdYX2fH4Np3QOISCX0oU9s48X4iPn3uwJ53rfiABT77Ojl6YGTX8KoojQhDjd03lJh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714568899; c=relaxed/simple;
	bh=8+k4R0J4GKcNe8Lj0qIl9PpvkxpwHa0NvERQqlYiLVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DaaFyf9h0jfGoIa2gohKBg6hPgaom5XnDvc9ejbGt4LG7JOhFcpCpYgbAHu17Zpv326XeGaDvKF1FPqUsz/VPhw8rvclPJdm6nNw1z+5q75rsFDkNnnfO/x8GE9NM8cPUifVWNtf5EAs7WBwr0bJOzOHSGKGHVU/lVRz/4cGGwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L3JxEcRE; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6a0a7cf89deso20644296d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 06:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714568897; x=1715173697; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MGnbq45Q3aIVVsIxi/7+e6D9e9h4LgaesLx5MBsPbWY=;
        b=L3JxEcREpm0+XuYTQT5Dw3VzuQ9GPLgTHgwG+7Gz7HGnn2qJsaVtJ6dN7n0BLqWaKn
         uobUOKSRaBn2epv9xC5XldpuwDxgxcxMz/CO4geA3k4VPshDePg0B5VgzHi6GBxMzcIW
         lTSl6qON3jw4IoiQ4KrdSS9Bq9QKMTNusynsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714568897; x=1715173697;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGnbq45Q3aIVVsIxi/7+e6D9e9h4LgaesLx5MBsPbWY=;
        b=jQsMATXV7c+8xYC4wuFU60Wwcyfa2EIjBfTYgnpKQKL0Cgy3s6d1TLa7PFxN1T/kwH
         h50hdF4ajshJ7khPEgbdRkEn/e2L/HFBpU/Xzia8gaARshWu37veHsxhdXr2L6hgLHOH
         BYFfLNn8dFwlhEvVeHQ4oY1rlyVfr4gbyg6rJD6deQ1RTlR+EdKd2e4aJg+FPRodR/Kr
         +AIakvWc7g8/3c5O6pCErAr0417lzQtkDZpiW7NcHv4lWZLAuTr28V0xML1xRWDmTxjV
         I0nbi1fd7dULaigT7RrrY06M+nDOkYi4pckH/DO5aLkiO11+USh1WaGthsRltM6fcbyw
         4LCg==
X-Forwarded-Encrypted: i=1; AJvYcCUH2mtsv8Li7MtRIj70Id/a11MQWV9eg+O5CG2LjqIfc+JiDom3mxn8h7r1DXknAfFKAXogOg8K7CfZIU2+PCCc+yP0ENEWPlnuZ7fT
X-Gm-Message-State: AOJu0YwVBmAbzOIHYMwZKcXcCKMt3c5GvSJjpmWF9MGAiiWJYMUhSZuX
	9aHb8jlN4qKLhsqMINsVZq7MaaV3TtOWE+m1yxX/ZhkseQjb4gJm/9oPbkrB2w==
X-Google-Smtp-Source: AGHT+IGUk7F34auoiq/zONzAUqrqK5yTPvc/Cyz94Sk8XJVQJ4h13ALDlS5aFFnC8XNMPBZjW49Tng==
X-Received: by 2002:a05:6214:258b:b0:6a0:9361:f988 with SMTP id fq11-20020a056214258b00b006a09361f988mr2350953qvb.30.1714568897459;
        Wed, 01 May 2024 06:08:17 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id l26-20020a0c979a000000b0069b10d78445sm12430971qvd.142.2024.05.01.06.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 06:08:16 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 01 May 2024 13:08:11 +0000
Subject: [PATCH v2 3/5] media: intel/ipu6: Switch to RUNTIME_PM_OPS() and
 SYSTEM_SLEEP_PM_OPS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240501-fix-ipu6-v2-3-a5629a37a0fb@chromium.org>
References: <20240501-fix-ipu6-v2-0-a5629a37a0fb@chromium.org>
In-Reply-To: <20240501-fix-ipu6-v2-0-a5629a37a0fb@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bingbu Cao <bingbu.cao@intel.com>, Tianshu Qiu <tian.shu.qiu@intel.com>
Cc: linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hans Verkuil <hverkuil@xs4all.nl>, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

Replace the old helpers with its modern alternative.
Now we do not need to set '__maybe_unused' annotations when we are not
enabling the PM configurations.

Fixes:
drivers/media/pci/intel/ipu6/ipu6.c:841:12: warning: ‘ipu6_runtime_resume’ defined but not used [-Wunused-function]
drivers/media/pci/intel/ipu6/ipu6.c:806:12: warning: ‘ipu6_resume’ defined but not used [-Wunused-function]
drivers/media/pci/intel/ipu6/ipu6.c:801:12: warning: ‘ipu6_suspend’ defined but not used [-Wunused-function]

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/intel/ipu6/ipu6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/intel/ipu6/ipu6.c b/drivers/media/pci/intel/ipu6/ipu6.c
index 4b1f69d14d71..7bcd9c5a381a 100644
--- a/drivers/media/pci/intel/ipu6/ipu6.c
+++ b/drivers/media/pci/intel/ipu6/ipu6.c
@@ -860,8 +860,8 @@ static int ipu6_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops ipu6_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(&ipu6_suspend, &ipu6_resume)
-	SET_RUNTIME_PM_OPS(&ipu6_suspend, &ipu6_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(&ipu6_suspend, &ipu6_resume)
+	RUNTIME_PM_OPS(&ipu6_suspend, &ipu6_runtime_resume, NULL)
 };
 
 MODULE_DEVICE_TABLE(pci, ipu6_pci_tbl);

-- 
2.45.0.rc0.197.gbae5840b3b-goog



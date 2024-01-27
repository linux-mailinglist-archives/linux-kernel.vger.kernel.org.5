Return-Path: <linux-kernel+bounces-41131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2252983EC4B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 10:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552D91C21CA2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 09:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047AC1E88C;
	Sat, 27 Jan 2024 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhL0FgxQ"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC0814A93;
	Sat, 27 Jan 2024 09:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706347545; cv=none; b=rHeExlwULYPlnil3Lcc4KvxgrXdwy6v89Ymgty37kSUuLCLHrGLe2uFQStNAFWs91d4FrpvAOgE6W9Whk210tiDrbeY5iOGI5bProkoCepxdImv4xVBe1xfYfl19jL4A7/6LxcCxqD4r25M46sXVifIFGgJoBLMRkm6zzu3HxBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706347545; c=relaxed/simple;
	bh=qkrj99AfSCojvLylDCab2Zz4IsT3Ic2c+mpfByQQ1Wk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DFkOldENOJNIAKTuS8k5ZMrVukgo7njo48QDiLM5u7boDs7WfTtunZwH1hGTM/FSlnfzWZ4pvxakgvVA2ylGLoyA+MVGCIMLRizLzYHgHh7Bxm8XsyfXopvA7LT9vda1sHUZWx57n9mAqlitlXuqgrzVFIBKSw3OMeW+BBp40MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhL0FgxQ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5100fd7f71dso2231594e87.1;
        Sat, 27 Jan 2024 01:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706347541; x=1706952341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pMBCjyZtyEIPkJpg94JFyUe7lU10QyArXbvWyTawL3Q=;
        b=dhL0FgxQt6fwLT6DvYjmCIwXHJCKDO55XzntxV/wUxiV+txJW/00e2ACjDip5fd/JD
         CUIFrSRBcUlHadlKiqC17L5yVYIC+yN5Ftf55l18mwbtQE4Wev1JaAE+rWMiNQBVhw7b
         TibtI1FvN2QjvhQ9HC467AlJ9BNscDGS47vOp0LFFiamdrN7BIBb8zk01F+tFaxiKauS
         4HDp7pqvF/DZXFeMb70mxAruzaUo+WE4oUoYQeF61PlCs/emUQGD0Sy/aUEGG0S+yI6e
         8zJh7CCRxEFCJArLmmNBmCsiPaKAnk6Qab2SdKiE+z3MevAk7GiW0+JQ0Ii5EkZKGbAx
         CrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706347541; x=1706952341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMBCjyZtyEIPkJpg94JFyUe7lU10QyArXbvWyTawL3Q=;
        b=c05qhxHo52SgDKtRddxZ0e2giJ2nKSJ3v4rUkc8pEiKXiQJeyWQkSuGRd+lB5GjSr4
         sd0xdM7SurY+MVBRX6du8ZWF2gkluiJ7qTusJnMKlEROf/irgpufX1lvAR27xThShWKS
         zF3mI5m8m5atYXhl8IJTu2uX/JkQ6Hi060q3bPQMTG81Xyne8uBcm+25F7r2ajoThSj5
         1t4lfophRWqi4jWRgDT6WyCEN9sOAQs3FCfjlF5Jkmwh/9o74X+Ci3+cVMIATWfMp1rr
         PqDGjjWtPuzO56XRCJkw7Hbgfzw0bnpLdzp0/AkXc2LTijpkKv0ZgpuV5JsUfF+UrZnf
         Rkdw==
X-Gm-Message-State: AOJu0YxjGDtWhRItga/ncKynj8Ul7FSNhLpXl/FcpbYx25yQm0B7fhUU
	jZhl+20Vjelk8ZbwwrF+KaCMRVRs8i2JVipdHOS5PsItoLyvdc8E
X-Google-Smtp-Source: AGHT+IF/gsr5dLuI2DGBgMnvn6qgdFpkQVSQSa/c22i0rQQ50zqirQ/tMRoceABdihkdBjOhMmysdw==
X-Received: by 2002:a05:6512:3e19:b0:510:8cd:231b with SMTP id i25-20020a0565123e1900b0051008cd231bmr859484lfv.21.1706347541216;
        Sat, 27 Jan 2024 01:25:41 -0800 (PST)
Received: from localhost.localdomain (broadband-46-242-13-133.ip.moscow.rt.ru. [46.242.13.133])
        by smtp.googlemail.com with ESMTPSA id m12-20020a056512114c00b005101bd871e9sm444594lfg.154.2024.01.27.01.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 01:25:40 -0800 (PST)
From: Konstantin Aladyshev <aladyshev22@gmail.com>
To: 
Cc: Konstantin Aladyshev <aladyshev22@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>,
	Naresh Solanki <Naresh.Solanki@9elements.com>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] hwmon: (pmbus/mp2975) Fix driver initialization for MP2975 device
Date: Sat, 27 Jan 2024 12:25:16 +0300
Message-Id: <20240127092516.1641-1-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 1feb31e810b0 ("hwmon: (pmbus/mp2975) Simplify VOUT code")
has introduced a bug that makes it impossible to initialize MP2975
device:
"""
mp2975 5-0020: Failed to identify chip capabilities
i2c i2c-5: new_device: Instantiated device mp2975 at 0x20
i2c i2c-5: delete_device: Deleting device mp2975 at 0x20
"""
Since the 'read_byte_data' function was removed from the
'pmbus_driver_info ' structure the driver no longer reports correctly
that VOUT mode is direct. Therefore 'pmbus_identify_common' fails
with error, making it impossible to initialize the device.

Restore 'read_byte_data' function to fix the issue.

Tested:
- before: it is not possible to initialize MP2975 device with the
'mp2975' driver,
- after: 'mp2975' correctly initializes MP2975 device and all sensor
data is correct.

Fixes: 1feb31e810b0 ("hwmon: (pmbus/mp2975) Simplify VOUT code")

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
Changes in v4:
 - Correct comment inside the 'mp2975_read_byte_data' function as
suggested by Patrick Rudolph

Changes in v3:
 - Drop accidentally added file from patch

Changes in v2:
 - Fix indentation issues

 drivers/hwmon/pmbus/mp2975.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
index b9bb469e2d8f..e5fa10b3b8bc 100644
--- a/drivers/hwmon/pmbus/mp2975.c
+++ b/drivers/hwmon/pmbus/mp2975.c
@@ -126,6 +126,21 @@ static const struct regulator_desc __maybe_unused mp2975_reg_desc[] = {
 
 #define to_mp2975_data(x)  container_of(x, struct mp2975_data, info)
 
+static int mp2975_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+	switch (reg) {
+	case PMBUS_VOUT_MODE:
+		/*
+		 * Report direct format as configured by MFR_DC_LOOP_CTRL.
+		 * Unlike on MP2971/MP2973 the reported VOUT_MODE isn't automatically
+		 * internally updated, but always reads as PB_VOUT_MODE_VID.
+		 */
+		return PB_VOUT_MODE_DIRECT;
+	default:
+		return -ENODATA;
+	}
+}
+
 static int
 mp2975_read_word_helper(struct i2c_client *client, int page, int phase, u8 reg,
 			u16 mask)
@@ -869,6 +884,7 @@ static struct pmbus_driver_info mp2975_info = {
 		PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
 		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP | PMBUS_HAVE_POUT |
 		PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT | PMBUS_PHASE_VIRTUAL,
+	.read_byte_data = mp2975_read_byte_data,
 	.read_word_data = mp2975_read_word_data,
 #if IS_ENABLED(CONFIG_SENSORS_MP2975_REGULATOR)
 	.num_regulators = 1,
-- 
2.34.1



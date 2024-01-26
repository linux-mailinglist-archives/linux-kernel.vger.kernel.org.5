Return-Path: <linux-kernel+bounces-40639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F4283E384
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BDE61C21DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D53C2420C;
	Fri, 26 Jan 2024 20:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1IDWxdp"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3AA24A09;
	Fri, 26 Jan 2024 20:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706302766; cv=none; b=WircJq/7Bi9EbEhW25crsiIwGVnjRV1uUySJTRXb0W3NXl96MA+adW75n//YWoUIBFd/4/r+MlJb4iq2nCLPtc5q0PGDMsod8ZgZA8/0huhXIOZCy1qZyXmwfcCLAwhdIPYEeBqKllE41vwrNVqFTnhe2JrePC4jls3zrU0wKmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706302766; c=relaxed/simple;
	bh=d5lnbFB1kRhdfOGtL24zlryF/VXTIqx8E+zK0Lfx4ts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QSSLF/lW5QjFD58/vKsiHoBW9v6c55EpDMLjzxIiPLiw7+DVqB5ldtCYhQ6O2IZGMfpMHdMUEvm/Mwkwa9Je2pCIbmE+K22xuRD/jJNV3S79FnY3GlJaYM65kw9YjZfQHcXZDKfg/jlCWnHhAMRd4OMCCNwlkOkqeDLmv3JAxG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1IDWxdp; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cf4a845a76so9609651fa.3;
        Fri, 26 Jan 2024 12:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706302762; x=1706907562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HgUr7JNxvuTwGjQqxQ6rYpOlzqBbvDPhSHnCMKxoYXc=;
        b=e1IDWxdp3LY1beDv4Ja//6Oj0zLWzFG6A6e5Pfa5dLEZdnTYu3epyuyYO/SOE1hjZg
         CcBVOzZFJFvMHmk0HHS9spfLSC4cR4WeE8ic0AKwf+WV+UKkx1i/dT7y2Td2eakVC6H1
         QDn4ViakVpmEdHu7QMrFhomMJBGO0lr1OS6ApDGKShH7nqympNH0gVnEuR5mt5V316EX
         MbNBxuvApyUc7XN1qsPdTg0at5uSTNOQ3AH5zWvHJhUdopDT5xiSaBHNZjNh7sgUQG8U
         Msvp+h2bEIJPzRn4U9C/RgbC7VUv4zG94CG/AKhmLiw/fnbIt5HomUjbOJ9eYEPwNZWD
         wt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706302762; x=1706907562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HgUr7JNxvuTwGjQqxQ6rYpOlzqBbvDPhSHnCMKxoYXc=;
        b=BG4kJb9Musp+obgoja5r5TnSYn/56XNs2+9nG/mnL/vKPlGCgZlWBIKOcJ5veiM/pl
         L11vRryl398VjPGRmiYszvXERZwSxtZ2z7LCxK+Jobi1NeG6xFJOvegbG3716p4SHZBK
         S0goFwQlRgVQcvL41z1DT4NYuGd+GWJpqvTkzhS8IoxSmMwIAHqLik5XPbDhkZ3y/RlH
         18ZaJ/TM0mBwK6wisBPsvpw0HajUOrwOTiKWjpMS8pSxewfodd7z7bI4YMJT33lnHC1c
         meqBuU/BOrwodFAapDTyjt+SDKkySW8mNO7eiYugMoRvs1R+Jv06GuCaVknDT/MyI8JR
         ECbA==
X-Gm-Message-State: AOJu0Yx7YE/N80atn/m0TJhaG1Nvj7YZqxdI1600j4r9TC4fufudMVO5
	xr8brZOdIm5kDWmge3DkV/vfdy8t1VKShvlqK4hoSFm9kmM1EdJk
X-Google-Smtp-Source: AGHT+IEZpV6MYS9liQqd1foY1cgs3BraQYTyZ1tQHkG/Lp8ebm3EwJzgjtDOYMCvSVAC09NOYo5W6g==
X-Received: by 2002:a05:651c:2007:b0:2cc:e51c:4d0c with SMTP id s7-20020a05651c200700b002cce51c4d0cmr251569ljo.66.1706302762311;
        Fri, 26 Jan 2024 12:59:22 -0800 (PST)
Received: from localhost.localdomain (broadband-46-242-13-133.ip.moscow.rt.ru. [46.242.13.133])
        by smtp.googlemail.com with ESMTPSA id d9-20020a2eb049000000b002cd187bb0f1sm259458ljl.49.2024.01.26.12.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 12:59:22 -0800 (PST)
From: Konstantin Aladyshev <aladyshev22@gmail.com>
To: 
Cc: Konstantin Aladyshev <aladyshev22@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>,
	Naresh Solanki <Naresh.Solanki@9elements.com>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] hwmon: (pmbus/mp2975) Fix driver initialization for MP2975 device
Date: Fri, 26 Jan 2024 23:57:14 +0300
Message-Id: <20240126205714.2363-1-aladyshev22@gmail.com>
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
Changes in v3:
 - Drop accidentally added file from patch

Changes in v2:
 - Fix indentation issues

 drivers/hwmon/pmbus/mp2975.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
index b9bb469e2d8f..5bbfdacb61a7 100644
--- a/drivers/hwmon/pmbus/mp2975.c
+++ b/drivers/hwmon/pmbus/mp2975.c
@@ -126,6 +126,22 @@ static const struct regulator_desc __maybe_unused mp2975_reg_desc[] = {
 
 #define to_mp2975_data(x)  container_of(x, struct mp2975_data, info)
 
+static int mp2975_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+	switch (reg) {
+	case PMBUS_VOUT_MODE:
+		/*
+		 * Enforce VOUT direct format, since device allows to set the
+		 * different formats for the different rails. Conversion from
+		 * VID to direct provided by driver internally, in case it is
+		 * necessary.
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
@@ -869,6 +885,7 @@ static struct pmbus_driver_info mp2975_info = {
 		PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
 		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP | PMBUS_HAVE_POUT |
 		PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT | PMBUS_PHASE_VIRTUAL,
+	.read_byte_data = mp2975_read_byte_data,
 	.read_word_data = mp2975_read_word_data,
 #if IS_ENABLED(CONFIG_SENSORS_MP2975_REGULATOR)
 	.num_regulators = 1,
-- 
2.34.1



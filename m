Return-Path: <linux-kernel+bounces-56996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED8084D27B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1F4287580
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C91086AD2;
	Wed,  7 Feb 2024 19:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evHphc0j"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3FD8286B;
	Wed,  7 Feb 2024 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707335825; cv=none; b=lzXMeAzC47K+wam8K0Q4ut9vQU2clF/PIXAUbUSc48645xiOHWGClEdkVKK9y90kK65ZOIKL31gqaIri9IfJQW1kYjYKSExT3JILWNF39IKYh/vfZIctmbZOCp/oI7hHdPVyqO2tWBO91yaIlwA3AzcMIdAZ75rjyKW3J6EMJf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707335825; c=relaxed/simple;
	bh=/FcFb9qUU0AFc7ntQBhM1DYybql7YvNG3j0P9y2MGhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ir6yUS/3lEI88VrjrANMZkys2PfwWYPFSD1rUfXEKRDz+QiF0f5g7d6y6YkaXA3p23bGG6HekPh2hu041l7EgHRNLfKAzGdqWRujfg+SPFDLxtcLgZsbf/3EaFhjdHkuP+aCn94v3O9qVfcNXDGT/A8ENAWF4+qpaahvA5IPo14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evHphc0j; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a39e31e1aa9so9845666b.0;
        Wed, 07 Feb 2024 11:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707335822; x=1707940622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uPhDmGaNbr+vXWHveZBJmP7AayoiCUUwJqSBYw/j+Y=;
        b=evHphc0jwG3eqkM+ybCJI9bM7H5e4u2OTLHTy1CPnlGWEYL2f4i30k45QYEFx6wf2R
         AvKRSJW8lJaVNS8lYty4k8TIYTnNe2k1w3Pc35tZbHGhJ6bLYoxWvVmQmmvMldiKm2A3
         kadgp0sEN4ePDla9EifOaDlatMMfGuxbZR6kofHQ1OnhsiJ2YRkMMSzXyoKKHxczOY2R
         B5b9G0yaRGjQrKkgxTWHACXwnawWYnDOLtTqJzky0takj07uP35QAapoii25F0Xrby1q
         Xjs7e9gap33g6ueiIOdF60GMDmPUWZ1aMNEU1ACe3f//V1i9mF/J5NTcEAHNo37M52E4
         cHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707335822; x=1707940622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3uPhDmGaNbr+vXWHveZBJmP7AayoiCUUwJqSBYw/j+Y=;
        b=Ue9MQtpBMrL5T97FaWoPDsBlJfo+HgufIzlrLWkgAcFwe/vVFiZR0RGxcfYWlzV1iS
         le1Av0uWM0pllVL+Kh2d4lNp28gWuh8Ky5ErWqOcvkBgy0GHYgEVvGq6i3oBXJ132Y14
         eHKzQQRkS4sj7NL7cnlShNcbn74wb58xaFIJ5viZpK5C8z4XxeSTEx7kFMC2zzXaNaPR
         hybNoEDtmOGdoZiAORqVDSxIQXpBcXyqjbhRrKArPtH4b27o7BbZqbY7HW+m/tBni+gf
         UY45XnABojFBAU0VqgON8tdTvcgYw6gohyIJVcdFEojrQe3+TJhk8fzKlOJZBbiNqlWZ
         F5tw==
X-Gm-Message-State: AOJu0YzfQU0Q8PWezm6ddWsueLJdcKVYth0YW8BZdJTbBuAKrMSPT+Ny
	Dhfjb6g1WzWDTgbNonLu6SGIdZuG/lVgw9ZQrPGBw5wxVao1YHvh
X-Google-Smtp-Source: AGHT+IEk+obbIzohAZ2Cb9TslRpGBO1bLg1Qbs9SXH09Foh5WinxJwTiiAubuQhQN0RLHTQqfL/OgQ==
X-Received: by 2002:a17:906:ca2:b0:a37:3525:d227 with SMTP id k2-20020a1709060ca200b00a373525d227mr5543066ejh.27.1707335822056;
        Wed, 07 Feb 2024 11:57:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWak2uUE8YgnUnWJshSf3V14sOhgfgMZCSz114ya52S0qjEjhlTLLU+sN2hiZ5vNDLKS1E1TgjyS282mvbYjIM4iKbYwyXHJnYfXah1ZCTOZIOvbIfSjCjIDhx+3zKfuWh6L1HWFWnKwxFb0ndgO7KlDt5dHK4ftcqa1MWLAvAjbmRs7A==
Received: from localhost.localdomain (i577B69E7.versanet.de. [87.123.105.231])
        by smtp.gmail.com with ESMTPSA id rf19-20020a1709076a1300b00a353ca3d907sm1086438ejc.217.2024.02.07.11.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 11:57:01 -0800 (PST)
From: Jesus Gonzalez <jesusmgh@gmail.com>
To: andriy.shevchenko@linux.intel.com,
	jic23@kernel.org,
	lars@metafoo.de
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jesus Gonzalez <jesusmgh@gmail.com>
Subject: [PATCH v4 1/1] Add 10EC5280 to bmi160_i2c ACPI IDs to allow binding on some devices
Date: Wed,  7 Feb 2024 20:55:50 +0100
Message-ID: <20240207195549.37994-2-jesusmgh@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZcOLql2RGmPP10EY@smile.fi.intel.com>
References: <ZcOLql2RGmPP10EY@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"10EC5280" is used by several manufacturers like Lenovo, GPD, or AYA (and
probably others) in their ACPI table as the ID for the bmi160 IMU. This
means the bmi160_i2c driver won't bind to it, and the IMU is unavailable
to the user. Manufacturers have been approached on several occasions to
try getting a BIOS with a fixed ID, mostly without actual positive
results, and since affected devices are already a few years old, this is
not expected to change. This patch enables using the bmi160_i2c driver for
the bmi160 IMU on these devices.

Here is the relevant extract from the DSDT of a GPD Win Max 2 (AMD 6800U
model) with the latest firmware 1.05 installed. GPD sees this as WONTFIX
with the argument of the device working with the Windows drivers.

	Device (BMA2)
	{
	    Name (_ADR, Zero)  // _ADR: Address
	    Name (_HID, "10EC5280")  // _HID: Hardware ID
	    Name (_CID, "10EC5280")  // _CID: Compatible ID
	    Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
	    Name (_UID, One)  // _UID: Unique ID
	    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
	    {
		Name (RBUF, ResourceTemplate ()
		{
		    I2cSerialBusV2 (0x0069, ControllerInitiated, 0x00061A80,
		        AddressingMode7Bit, "\\_SB.I2CC",
		        0x00, ResourceConsumer, , Exclusive,
		        )
		})
		Return (RBUF) /* \_SB_.I2CC.BMA2._CRS.RBUF */
	    }
	    
	    ...
	    
	}

Signed-off-by: Jesus Gonzalez <jesusmgh@gmail.com>
---
v4: Moved comment back to relevant position inside function

 drivers/iio/imu/bmi160/bmi160_i2c.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
index 81652c08e644..a081305254db 100644
--- a/drivers/iio/imu/bmi160/bmi160_i2c.c
+++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
@@ -43,6 +43,15 @@ static const struct i2c_device_id bmi160_i2c_id[] = {
 MODULE_DEVICE_TABLE(i2c, bmi160_i2c_id);
 
 static const struct acpi_device_id bmi160_acpi_match[] = {
+	/*
+	 * FIRMWARE BUG WORKAROUND
+	 * Some manufacturers like GPD, Lenovo or Aya used the incorrect
+	 * ID "10EC5280" for bmi160 in their DSDT. A fixed firmware is not
+	 * available as of Feb 2024 after trying to work with OEMs, and
+	 * this is not expected to change anymore since at least some of
+	 * the affected devices are from 2021/2022.
+	 */
+	{"10EC5280", 0},
 	{"BMI0160", 0},
 	{ },
 };
-- 
2.43.0



Return-Path: <linux-kernel+bounces-95502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A78874E6D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8BD1C22BB9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865D8129A98;
	Thu,  7 Mar 2024 11:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKPelkEM"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDCB129A72;
	Thu,  7 Mar 2024 11:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709812675; cv=none; b=B92GCGaZplNm2Hv4oUB7GPF/RjmjGxm80s+NXbU7yMXD5psejiV2ICTHe1Atxo5uiThH/9YjgSdA88xNxLVNWOU+0mpzx6wd829tSu6bsaod4Yjin3D814L1CL5exm4nFBBDc7b5wkN7V5Vf68BUciBwVhjcZnbw0mLgcCRmwK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709812675; c=relaxed/simple;
	bh=J86UKY8qhazKaB7pPML7j0nM+vkhkOPEx5DuuIIA3J8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PCcry7tefH44Ia3qqHzUEKceLJSLwnCU7JbAQ7o9fQmbPJ4ie8uA7HCTBODmZBUfnduPHTQftIgDaRsZDnZUF+gDQ0glGhDHNXYLpu9aaZNH93BCn4fQ5MMaxSSBqaT5Lg+2qvk+Rs1QZIWLVaDOwGL464fvtWvpVb1HASxY0cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKPelkEM; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so657265a12.1;
        Thu, 07 Mar 2024 03:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709812674; x=1710417474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnDe8WtbZ9hcODNTV3jRGEgDe7+iT2YCtcCLNf4Qsns=;
        b=JKPelkEMPcXIaOxjKzKvJfNaJXgH8pc9Ej3xlH1GvengBtze6GwrVyclaj9KFj1QqN
         ua1F90If9HQV2l5MpwA8EQ63HvAbsyRp4pXSuJE5sy8dGlDPWd0d96eJv4hb1aQB3lwO
         I7ONpCUrtzNVMojZgOgwOCkQ4y83ElfCbx5BNnnhhTsf0T30ljbdjX1Wy1Wm9vAPT76V
         ouSEoApFTO6IfvnxAS82dviTPec5xR2b4zN4UdFTohmE+0qDxygEt+ORz6wwopVjmb2h
         NwxP258R4n9hB1z850MeCvTZBlZ8myS1tveZGfkpw5G8Xt4zi02G8Y/85G4hY5HMniJ6
         J/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709812674; x=1710417474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GnDe8WtbZ9hcODNTV3jRGEgDe7+iT2YCtcCLNf4Qsns=;
        b=ZlNOjMvev5cDBFrI5dcdOq2Ci6PdBvR5cTW4grc1w9Fcu/Kw21oF4w7evx3GIfkm9S
         6x7Iwps7cNkgyJrCJbO1wZOEfwa4mX3VbQVCCexxzYXof850OtYNtdnsPEDSz85S0U9e
         8AKyh55qKQeMfLMQV0X0Cpg1B8bng9J3yRsNqy7QFIKzBgF86EULIyfHhiucGvCaO/D/
         s2ZdGBt87J5zTvsirHFIU6cFMhQBT4U1F+sA3FRFsHNpN+yuXlp2ioPbIOj+EYdTR2MZ
         bj+dB+l6LhKv4pwGZ88lghCV95ig+Jw2wYZrpq7ffI6tMTi2V9E/iKQHePz+yV8JAD4g
         yEgA==
X-Forwarded-Encrypted: i=1; AJvYcCVL4lsdZrV6FUfeeAtxQAFgYbZGEwJnj1+C8KgtnQvCr+kdB04spG+MtSs3vu6b3ts+beWWcnx1JO9Tz6Ss/rtpm1W/cVBmU7HRxE3z
X-Gm-Message-State: AOJu0YwHqPjar0FOBkZk+xpzxliuc9HTccYOrIMA+ahnnrfuZ6dPIroL
	g85Reh+rQ0e/XbjaU2VGLADUMrrIR9G+b2xD2q7eSg1ea2ZJrPJ1
X-Google-Smtp-Source: AGHT+IGh+oenmFUHmGunUsmpdxKdgB27yRhLeGFEaRlazILAGetA315ev5uBqawUMt3AexyzdHKHHQ==
X-Received: by 2002:a05:6a20:ba84:b0:1a1:4df8:1ec4 with SMTP id fb4-20020a056a20ba8400b001a14df81ec4mr6282239pzb.19.1709812673611;
        Thu, 07 Mar 2024 03:57:53 -0800 (PST)
Received: from VM-147-239-centos.localdomain ([14.22.11.162])
        by smtp.gmail.com with ESMTPSA id q4-20020a63e944000000b005dc1edf7371sm12722063pgj.9.2024.03.07.03.57.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2024 03:57:53 -0800 (PST)
From: Yongzhi Liu <hyperlyzcs@gmail.com>
To: hdegoede@redhat.com,
	wentong.wu@intel.com,
	gregkh@linuxfoundation.org,
	andi.shyti@linux.intel.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jitxie@tencent.com,
	huntazhang@tencent.com,
	Yongzhi Liu <hyperlyzcs@gmail.com>
Subject: [PATCH V2] usb: misc: ljca: Fix double free in error handling path
Date: Thu,  7 Mar 2024 19:57:43 +0800
Message-Id: <20240307115743.13104-1-hyperlyzcs@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <2c77e58a-fe07-464f-9032-3933080be349@redhat.com>
References: <2c77e58a-fe07-464f-9032-3933080be349@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When auxiliary_device_add() returns error and then calls
auxiliary_device_uninit(), callback function ljca_auxdev_release
calls kfree(auxdev->dev.platform_data) to free the parameter data
of the function ljca_new_client_device. The callers of
ljca_new_client_device shouldn't call kfree() again
in the error handling path to free the platform data.

Fix this by cleaning up the redundant kfree() in all callers and
adding kfree() the passed in platform_data on errors which happen
before auxiliary_device_init() succeeds .

Fixes: acd6199f195d ("usb: Add support for Intel LJCA device")
Signed-off-by: Yongzhi Liu <hyperlyzcs@gmail.com>
---
 drivers/usb/misc/usb-ljca.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/misc/usb-ljca.c b/drivers/usb/misc/usb-ljca.c
index 35770e608c64..bd9ccbea6e72 100644
--- a/drivers/usb/misc/usb-ljca.c
+++ b/drivers/usb/misc/usb-ljca.c
@@ -518,8 +518,10 @@ static int ljca_new_client_device(struct ljca_adapter *adap, u8 type, u8 id,
 	int ret;
 
 	client = kzalloc(sizeof *client, GFP_KERNEL);
-	if (!client)
+	if (!client) {
+		kfree(data);
 		return -ENOMEM;
+	}
 
 	client->type = type;
 	client->id = id;
@@ -535,8 +537,10 @@ static int ljca_new_client_device(struct ljca_adapter *adap, u8 type, u8 id,
 	auxdev->dev.release = ljca_auxdev_release;
 
 	ret = auxiliary_device_init(auxdev);
-	if (ret)
+	if (ret) {
+		kfree(data);
 		goto err_free;
+	}
 
 	ljca_auxdev_acpi_bind(adap, auxdev, adr, id);
 
@@ -590,12 +594,8 @@ static int ljca_enumerate_gpio(struct ljca_adapter *adap)
 		valid_pin[i] = get_unaligned_le32(&desc->bank_desc[i].valid_pins);
 	bitmap_from_arr32(gpio_info->valid_pin_map, valid_pin, gpio_num);
 
-	ret = ljca_new_client_device(adap, LJCA_CLIENT_GPIO, 0, "ljca-gpio",
+	return ljca_new_client_device(adap, LJCA_CLIENT_GPIO, 0, "ljca-gpio",
 				     gpio_info, LJCA_GPIO_ACPI_ADR);
-	if (ret)
-		kfree(gpio_info);
-
-	return ret;
 }
 
 static int ljca_enumerate_i2c(struct ljca_adapter *adap)
@@ -626,13 +626,9 @@ static int ljca_enumerate_i2c(struct ljca_adapter *adap)
 		i2c_info->capacity = desc->info[i].capacity;
 		i2c_info->intr_pin = desc->info[i].intr_pin;
 
-		ret = ljca_new_client_device(adap, LJCA_CLIENT_I2C, i,
+		return ljca_new_client_device(adap, LJCA_CLIENT_I2C, i,
 					     "ljca-i2c", i2c_info,
 					     LJCA_I2C1_ACPI_ADR + i);
-		if (ret) {
-			kfree(i2c_info);
-			return ret;
-		}
 	}
 
 	return 0;
@@ -666,13 +662,9 @@ static int ljca_enumerate_spi(struct ljca_adapter *adap)
 		spi_info->id = desc->info[i].id;
 		spi_info->capacity = desc->info[i].capacity;
 
-		ret = ljca_new_client_device(adap, LJCA_CLIENT_SPI, i,
+		return ljca_new_client_device(adap, LJCA_CLIENT_SPI, i,
 					     "ljca-spi", spi_info,
 					     LJCA_SPI1_ACPI_ADR + i);
-		if (ret) {
-			kfree(spi_info);
-			return ret;
-		}
 	}
 
 	return 0;
-- 
2.36.1



Return-Path: <linux-kernel+bounces-98844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA2C87802F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B07D1C21096
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F253D388;
	Mon, 11 Mar 2024 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeW2k1ZU"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DFC22064;
	Mon, 11 Mar 2024 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710161880; cv=none; b=LLAtxWkZ0W/DCN4jVCqhlMa5xt9VICMATqb9SzARQ6vg11C8zsm3fJCGArwHCHqQLvE6bZah5EFDVtkQbs1qFwpawaXcxlNy+3K8wDAIX7jCZ7Eyf/U/CnWqUK06Sk8lHX4AKHO/Sgy3+cC3Wlcr9rlYDCywwNmmHXAihnxbgWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710161880; c=relaxed/simple;
	bh=EUyIvcW8FlmcqL302oY0iGqszU3ChNJmaialSfxbKz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gDRqz75XFOvbW9RfYqL58399XaBDHvjv3gUFDBw8PLbd7GgzX181ZrULtmMlaBesFIrDi/K/9TO4w29VCoKwyfRfj7fdAxcJmJVesivknmHG71BCDZ776JXhP3WMWN8nLgY9fa7g0MphLoE82xidLup/FQZ/aFHp33oKySj3xNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeW2k1ZU; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso3673312a12.0;
        Mon, 11 Mar 2024 05:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710161878; x=1710766678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQxHW+GvX+Ck+RHTpVlbPLH7yeTCk+IQ8c2Qe9Rhlfc=;
        b=MeW2k1ZUZL14Ni1VyyQPsbzawDUADeIPJLzUj8R8VV1BWsIxizYQ21j1IVdx2nD989
         ffe5gYYKAkDmhF+1Kzx4XotHoXaBXIQ1jBnhNsO+40AaENCHuC7ELXAQt/aKQbZPRZ6o
         mdhaRrM7zTdlGHgnE1ERYHAvWOSuo9G4wEDnhdJMFQMWpV+t1vZuWL0VwH1cZoQgTUgZ
         tFYtY30QJPj4HzS2vrGIw1hJ4isWrn0lKrilNGuA56Jvy5fGEKv2NXX8R7ufnuSD1dv5
         fC/UChXSs1XC2N8g+jGTWByLwtm7idGWSyFIRmSU6bmzVKlOyt+XJNEglFoNpLZCnQJQ
         RCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710161878; x=1710766678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQxHW+GvX+Ck+RHTpVlbPLH7yeTCk+IQ8c2Qe9Rhlfc=;
        b=F5R+GDpaVKo437MxQiPgUMYBuGzIHnPtxcTdfJYgs308jU16RMqVik97kPn7H9vRkB
         3DRsvEdR8AlRPm4r2YlLc7CYBWf+hrfu0pJ4zqoLYAeW2eS1J3G1ETj+E/NJsm7I26hM
         AbkaqLYjUtWxBtccDjlvm1Fv6hlof8azQkoQwTb1EYPQF4vCLIaYsQJWtq9US0uQ1fGo
         IE+SIAy2oH94OyMCRHXMutLJZJOVBGeMXNoECOddi/qebJng3rTUE/MsfmHel/6waam7
         nW+jhFrdOq38HQRYSADigMPma2l0c8h4Alt0SgCAq7vOVubUxvQ8Y2M5MTC3vAwi0KLQ
         QHNw==
X-Forwarded-Encrypted: i=1; AJvYcCVu8+CipPsXnOwW4HAFkqmzJMw3pZ30ZKIU3+raqsvoZOs2yfd1W+F4GtvGwliLh53+7m1AfzxUMHjIsgi5Q0w18CQvRiqw/p/HnE8d
X-Gm-Message-State: AOJu0Yw/ppvkEetdiUnIaMl2Ic1qC5I2+pbsP7hyM/7QXel/jN3GpQvK
	G3iNRFJEk9fqVNqcsx5YTo2zE9XBIlgk5JjxX2+p0MB1plylopqJeNKYLKDd7dc=
X-Google-Smtp-Source: AGHT+IH7NpuCKxknX3Cmttbabr0nc9IaOJ6HIjgROFgO63EbeUm9OpYEWutFQBq+Yqm4cbsZzTLhjA==
X-Received: by 2002:a05:6a20:d48c:b0:1a1:7fbf:6a9f with SMTP id im12-20020a056a20d48c00b001a17fbf6a9fmr8353604pzb.46.1710161878399;
        Mon, 11 Mar 2024 05:57:58 -0700 (PDT)
Received: from VM-147-239-centos.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090322c600b001dd98195371sm2394255plg.181.2024.03.11.05.57.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2024 05:57:58 -0700 (PDT)
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
Subject: [PATCH V3] usb: misc: ljca: Fix double free in error handling path
Date: Mon, 11 Mar 2024 20:57:48 +0800
Message-Id: <20240311125748.28198-1-hyperlyzcs@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <36e56422-d027-4edd-af6e-8ebcebc1dfe3@redhat.com>
References: <36e56422-d027-4edd-af6e-8ebcebc1dfe3@redhat.com>
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
 drivers/usb/misc/usb-ljca.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/misc/usb-ljca.c b/drivers/usb/misc/usb-ljca.c
index 35770e608c64..2d30fc1be306 100644
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
@@ -629,10 +629,8 @@ static int ljca_enumerate_i2c(struct ljca_adapter *adap)
 		ret = ljca_new_client_device(adap, LJCA_CLIENT_I2C, i,
 					     "ljca-i2c", i2c_info,
 					     LJCA_I2C1_ACPI_ADR + i);
-		if (ret) {
-			kfree(i2c_info);
+		if (ret)
 			return ret;
-		}
 	}
 
 	return 0;
@@ -669,10 +667,8 @@ static int ljca_enumerate_spi(struct ljca_adapter *adap)
 		ret = ljca_new_client_device(adap, LJCA_CLIENT_SPI, i,
 					     "ljca-spi", spi_info,
 					     LJCA_SPI1_ACPI_ADR + i);
-		if (ret) {
-			kfree(spi_info);
+		if (ret)
 			return ret;
-		}
 	}
 
 	return 0;
-- 
2.36.1



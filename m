Return-Path: <linux-kernel+bounces-141623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFB98A20CA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085E61C21FD4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC254643A;
	Thu, 11 Apr 2024 21:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bCxvtOHZ"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80CD4596E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712870285; cv=none; b=t0sYM6rUk6tUW+O+a3WyMX0pBFI1imZpgxFbSkzv/tPrU4NqrrFrlZ9fR8wEiXvu5Ajscko4KCLt1DjsTtFEMOQs29i8zrEgw/siefG970L9+WtTt2ORZSe2M6Bmu0zhXgEZ4mB6YPYO5za5BRROEG/adLtW7V2t7Ti5Ub5enMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712870285; c=relaxed/simple;
	bh=jWvovnNbCjwB2C+VXHGftHmA5T8gil6/DHr34mWgtoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ONLUvr43rDM6Q/6UObaZcULQ4qcC6/6MJewNzt8tDhdnzgRUKHog60iHRBLr3jP1fR2QGKfHTFPVWI7mu5YLXpoSdcbDdfHhgCdicht0UgHZ5nG6ICr1eDaelRxpDtHlfXGmXxYyI10uHhBm8sSh3YCddNX27H3e6akqTcxfN6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bCxvtOHZ; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so137424b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712870283; x=1713475083; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IOIqD2cEf2Ajo/2bzueQZnF061I92Ltj+ENaeP2eHJQ=;
        b=bCxvtOHZLkuithzlYNA0ADaPlt5s5uEzOGaLTqUGhjnH1nblKRIXwclN4Op6w0MTmm
         qI1AXJrRWIM9jOMCWxAAUaLwUBlp7XJO0RAvONF4UzdBg9G1qjAsjvCHLGUJKd8VFhJ7
         COLjgMLLu8TywhN5x8AomQ7Zrn6UkNvhlZ0uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712870283; x=1713475083;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOIqD2cEf2Ajo/2bzueQZnF061I92Ltj+ENaeP2eHJQ=;
        b=ek+/7QYGzId4/59Wsqk7pO7e5zrLpQZlB/72GeoxyYWMFFJF3XkN1zA2Lvh/UJ8a70
         1PueiOBl1HsKtP2SbSW2iXFLduIn3UlWQ3O74QFS4z5zLjv1qjBO9So4SxdBU/76SVLD
         8aFzSXnjigjrK7fMjuh4uZUw+a6GxmG0kDrUTKemJDUATweTIvYmEpyymKPVvhiptOea
         0J/ptPvKIZVTWgCGhmf1CInESUuQL/BP3Pp72HkWYYAqQcY2c4aomx2Hhl0UJFvO+pVq
         5UHDoZnkYZcpVCSUghHtsGLCaWbiHLCwseWz0pi+xkILDyWZeGraGpsJiqxZBQPRo0dd
         SAug==
X-Forwarded-Encrypted: i=1; AJvYcCWQeV7TCv4lUWa+9OOBWZ2OiLZYvrnQOzdye+3yEb1C1e7KESxBG0wd+MsUpluoOxIfW49ZBl7lHsOYQsa7B+GveLMn0d1BLPEKpKpH
X-Gm-Message-State: AOJu0Yx5EABTaGpdE1LK5fNFnOXw5fkuI/1dzc2iM7ftkz0TPIAoWg3C
	aaZ1Rib1e26FeKRuQITuo0zFjhSqURUyP4Cps/Lu/1JBXU/QqVtf+obLJ3jS9g==
X-Google-Smtp-Source: AGHT+IFC+MhkQWiHdHFKMOyxd+8dV1gTziJ5gXLj4MpOfJR3ww+hXqqwT2lBycXPTw1zfx8RyZUR8w==
X-Received: by 2002:a05:6808:198e:b0:3c6:beb:20b2 with SMTP id bj14-20020a056808198e00b003c60beb20b2mr665356oib.51.1712870281598;
        Thu, 11 Apr 2024 14:18:01 -0700 (PDT)
Received: from denia.c.googlers.com (200.234.86.34.bc.googleusercontent.com. [34.86.234.200])
        by smtp.gmail.com with ESMTPSA id k20-20020ac84794000000b00434d7c4f9fasm1373362qtq.8.2024.04.11.14.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 14:18:01 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 11 Apr 2024 21:17:56 +0000
Subject: [PATCH 7/7] media: dvb-usb: dib0700_devices: Add missing
 release_firmware()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-fix-smatch-v1-7-045f92467937@chromium.org>
References: <20240411-fix-smatch-v1-0-045f92467937@chromium.org>
In-Reply-To: <20240411-fix-smatch-v1-0-045f92467937@chromium.org>
To: Bluecherry Maintainers <maintainers@bluecherrydvr.com>, 
 Anton Sviridenko <anton@corp.bluecherry.net>, 
 Andrey Utkin <andrey_utkin@fastmail.com>, 
 Ismael Luceno <ismael@iodev.co.uk>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

Add missing release_firmware on the error paths.

drivers/media/usb/dvb-usb/dib0700_devices.c:2415 stk9090m_frontend_attach() warn: 'state->frontend_firmware' from request_firmware() not released on lines: 2415.
drivers/media/usb/dvb-usb/dib0700_devices.c:2497 nim9090md_frontend_attach() warn: 'state->frontend_firmware' from request_firmware() not released on lines: 2489,2497.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/dvb-usb/dib0700_devices.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/dib0700_devices.c b/drivers/media/usb/dvb-usb/dib0700_devices.c
index 3af594134a6de..6ddc205133939 100644
--- a/drivers/media/usb/dvb-usb/dib0700_devices.c
+++ b/drivers/media/usb/dvb-usb/dib0700_devices.c
@@ -2412,7 +2412,12 @@ static int stk9090m_frontend_attach(struct dvb_usb_adapter *adap)
 
 	adap->fe_adap[0].fe = dvb_attach(dib9000_attach, &adap->dev->i2c_adap, 0x80, &stk9090m_config);
 
-	return adap->fe_adap[0].fe == NULL ?  -ENODEV : 0;
+	if (!adap->fe_adap[0].fe) {
+		release_firmware(state->frontend_firmware);
+		return -ENODEV;
+	}
+
+	return 0;
 }
 
 static int dib9090_tuner_attach(struct dvb_usb_adapter *adap)
@@ -2485,8 +2490,10 @@ static int nim9090md_frontend_attach(struct dvb_usb_adapter *adap)
 	dib9000_i2c_enumeration(&adap->dev->i2c_adap, 1, 0x20, 0x80);
 	adap->fe_adap[0].fe = dvb_attach(dib9000_attach, &adap->dev->i2c_adap, 0x80, &nim9090md_config[0]);
 
-	if (adap->fe_adap[0].fe == NULL)
+	if (!adap->fe_adap[0].fe) {
+		release_firmware(state->frontend_firmware);
 		return -ENODEV;
+	}
 
 	i2c = dib9000_get_i2c_master(adap->fe_adap[0].fe, DIBX000_I2C_INTERFACE_GPIO_3_4, 0);
 	dib9000_i2c_enumeration(i2c, 1, 0x12, 0x82);
@@ -2494,7 +2501,12 @@ static int nim9090md_frontend_attach(struct dvb_usb_adapter *adap)
 	fe_slave = dvb_attach(dib9000_attach, i2c, 0x82, &nim9090md_config[1]);
 	dib9000_set_slave_frontend(adap->fe_adap[0].fe, fe_slave);
 
-	return fe_slave == NULL ?  -ENODEV : 0;
+	if (!fe_slave) {
+		release_firmware(state->frontend_firmware);
+		return -ENODEV;
+	}
+
+	return 0;
 }
 
 static int nim9090md_tuner_attach(struct dvb_usb_adapter *adap)

-- 
2.44.0.683.g7961c838ac-goog



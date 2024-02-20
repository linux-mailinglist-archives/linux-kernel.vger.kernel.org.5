Return-Path: <linux-kernel+bounces-73716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D8785C7AA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711FE1F26037
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D281152DED;
	Tue, 20 Feb 2024 21:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFDIPs8k"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16C2151CD8;
	Tue, 20 Feb 2024 21:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463703; cv=none; b=s2JBotVfW7Sauyu2Tr5q90F3GKPkAmYgGCIZ1HxVdtYAwQT8EWpnPGgVx+khHS4ctKr6G8MXqwLC/btC+sM4qj17MmQi/49/7d2tlXvwOJqfhlsIcxu8pHvS8wxDcdHbh5WAjbm5Sr72Eg2d40ybVXrJz/m26K/HK6BrcI0YaR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463703; c=relaxed/simple;
	bh=YAdBiDoe8/IZ+rByvKGy+92HAzwV14CR2j87H09rlQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rvFjk/r0rZK1Oh1Ahv2zK382LOhN2C0zE3ZMJ456M1SNLvQgoKPfQy+N5HCHOmvyR9+MtyS9uviCesk+eAprgjCAeJBz7/sFk6suXAzTkyib1AgFnur7vK0e7cx6KKET++a9kVku3qpkX8iNcLIqMaoGadCktPkA+pX977SEINk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFDIPs8k; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-564f1876a2fso182468a12.3;
        Tue, 20 Feb 2024 13:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708463699; x=1709068499; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bysFB8VOUQG0rzhFX0FiWlnp+/R7B0ro194OzpL/Ots=;
        b=dFDIPs8kMh7zW5TezWJD9/piGlTVWvbdCj+dXP4vA6O7byI2I6gUmbBlgPJ1J8L2qU
         cyJYbnQ3htxyw3Z7hepiMGZzRiF7uDZ3aGpqr8euY88QlLCsR4kWyFrO6fOFeFnMtJA/
         LeOz0EE/YnE3cTS2G9gY8ux1B3w8ndqtqIaLdDSWIdfaxNd/NHUW2kB+akHkyg3Rp5Q5
         3WVIduZsqGARjTV2hQXcqVi0PGYPFtdH4JIURb6kj2OvqWrlW7o+IiXvknOKuhGQO+Dt
         8gBlN8fd4l3rNr+w6n7+jXVMXEso9EhEyjTZKVSDbARX7tEDq6DGjWZ5v4nNO8cRL4gW
         0cHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708463699; x=1709068499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bysFB8VOUQG0rzhFX0FiWlnp+/R7B0ro194OzpL/Ots=;
        b=iYHKVKUMeJSyqiPoewVpzWOwA3OZZGYnjPrXlP5insjoazD6kqDvsEj6BC3ucOZF1s
         poNqG0Irja/0H+KwMzEPLWQ9IxQoV4i+GZxZ5mk9do7PlD9W8fOcq5R76f4K04JCKMgz
         dZFPbsbD2mHDyLnL7HWebGw2LTzysRQmq+jEAhDZtNLD/oqNK8QMMzSCErT6MbQftGro
         JNmSumvngCw25RQFI/7e/QrxxAm5HbVPK382S0D9rWv7apsuGsxc5I7FiIpBKUI4Cyo7
         7VhxIE7ADRKUHcSTk92aqdjrDuUjj29tTMkdV12rGRrKSwuf9qCfGkwbi65o0ahErg0f
         U9nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJl+cpd4+OtACrz2ctjrKSMn+26AYiIH4h2A8FHlmXNTkLvbUEgoOobWCEpT85tuCk7P3TNXRjTGsEVN/b9FrsQUAgyJQf3AZhEjlgtklM9yZzYCpr0RIWHnW7D++PaUY7+5IdRK1B1fHkyREckBh/B0znYkq/7OkaqgTAybZQ4QDxeA==
X-Gm-Message-State: AOJu0Yy2k3BU1gCOh2tbJSdDDXM2S4K7iH3juiFNY+icUbaQ1r28aII6
	ZpgOgljGWCZhhcOjkNsg0g/3+RzglTaHPuknrWrumuyjyM1jh7i0Dad5apeEEaTn4g==
X-Google-Smtp-Source: AGHT+IGSPLCsLihF242E3zFQ9jIuA+UjxTaFXWPkdjKz6Ly4l5wpe3Ds8j7TmwBJQQmsFZWkGT6hmw==
X-Received: by 2002:a05:6402:1b1a:b0:561:4460:6726 with SMTP id by26-20020a0564021b1a00b0056144606726mr11742594edb.26.1708463699172;
        Tue, 20 Feb 2024 13:14:59 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-d60d-797f-077b-a805.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d60d:797f:77b:a805])
        by smtp.gmail.com with ESMTPSA id fj21-20020a0564022b9500b00564da28dfe2sm538137edb.19.2024.02.20.13.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 13:14:58 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 20 Feb 2024 22:14:55 +0100
Subject: [PATCH 1/4] iio: humidity: hdc3020: Add Makefile, Kconfig and
 MAINTAINERS entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-hdc3020-pm-v1-1-d8e60dbe79e9@gmail.com>
References: <20240220-hdc3020-pm-v1-0-d8e60dbe79e9@gmail.com>
In-Reply-To: <20240220-hdc3020-pm-v1-0-d8e60dbe79e9@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Li peiyu <579lpy@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev-8b532
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708463696; l=2533;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=3a3IuUcHgpMvkEUVjsKil8/rhpG6FeILz6O7U1hUYAU=;
 b=gGUgj8fQzp3mrh6qVNaD4Mp8ODKE+0ZKjE/fJH6Je6P8LXHjsET6x4VCxYTdkNa05X76EBG4g
 By3Wp7P6h3XD0c9mAuxBq5ZhYf+S4UJtRlzvliB6DiaPGqvoy7NdxI2
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Something when wrong when applying the original patch and only the
c file made it in.  Here the rest of the changes are applied.

Fixes: c9180b8e39be ("iio: humidity: Add driver for ti HDC302x humidity sensors")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Li peiyu <579lpy@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 MAINTAINERS                   |  8 ++++++++
 drivers/iio/humidity/Kconfig  | 12 ++++++++++++
 drivers/iio/humidity/Makefile |  1 +
 3 files changed, 21 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6add3fde252d..fde7456438b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22023,6 +22023,14 @@ F:	Documentation/devicetree/bindings/media/i2c/ti,ds90*
 F:	drivers/media/i2c/ds90*
 F:	include/media/i2c/ds90*
 
+TI HDC302X HUMIDITY DRIVER
+M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
+M:	Li peiyu <579lpy@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
+F:	drivers/iio/humidity/hdc3020.c
+
 TI ICSSG ETHERNET DRIVER (ICSSG)
 R:	MD Danish Anwar <danishanwar@ti.com>
 R:	Roger Quadros <rogerq@kernel.org>
diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
index 2de5494e7c22..b15b7a3b66d5 100644
--- a/drivers/iio/humidity/Kconfig
+++ b/drivers/iio/humidity/Kconfig
@@ -48,6 +48,18 @@ config HDC2010
 	  To compile this driver as a module, choose M here: the module
 	  will be called hdc2010.
 
+config HDC3020
+	tristate "TI HDC3020 relative humidity and temperature sensor"
+	depends on I2C
+	select CRC8
+	help
+	  Say yes here to build support for the Texas Instruments
+	  HDC3020, HDC3021 and HDC3022 relative humidity and temperature
+	  sensors.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called hdc3020.
+
 config HID_SENSOR_HUMIDITY
 	tristate "HID Environmental humidity sensor"
 	depends on HID_SENSOR_HUB
diff --git a/drivers/iio/humidity/Makefile b/drivers/iio/humidity/Makefile
index f19ff3de97c5..5fbeef299f61 100644
--- a/drivers/iio/humidity/Makefile
+++ b/drivers/iio/humidity/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_AM2315) += am2315.o
 obj-$(CONFIG_DHT11) += dht11.o
 obj-$(CONFIG_HDC100X) += hdc100x.o
 obj-$(CONFIG_HDC2010) += hdc2010.o
+obj-$(CONFIG_HDC3020) += hdc3020.o
 obj-$(CONFIG_HID_SENSOR_HUMIDITY) += hid-sensor-humidity.o
 
 hts221-y := hts221_core.o \

-- 
2.40.1



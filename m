Return-Path: <linux-kernel+bounces-26451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BCD82E119
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C160283610
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886A618EB2;
	Mon, 15 Jan 2024 20:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kz6qoITo"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5F818E20;
	Mon, 15 Jan 2024 20:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e586a62f7so68316295e9.2;
        Mon, 15 Jan 2024 12:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705348944; x=1705953744; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R7c2Oay6GZqDXqP0jwlRhkTWw64z9Y+I5NYDH+I+iMs=;
        b=Kz6qoITo6f+GXTAKguCM5JW/aApNBe90XD0jPPeC18gfZn1AZ/ycpfgygaXJkWjOa4
         sonfB46tEjXUGfyCWgm9UariQw7+Vck3j2WjLvVNPJwR/uiXMD4zWXyMxfQPlgsFprmD
         u5aOZqKYXY3uNNWxlAe22vL0hg+OdsySagJ/c2Cr7VzLwavg7u1TdVhpouz9fEp9WyFx
         ngjDRkjopPJvnmhMQMsPsVnOmtDNZVhFAjUv6jrkY/PTEW4mNos74N1pfeQFA2JsV7at
         syG20D23ASComuliMdcJTAwUPqcqBEZ71+APnQ7JAg2bZ7/7Dzpf38+DQzymVtfP1yOk
         xA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705348944; x=1705953744;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R7c2Oay6GZqDXqP0jwlRhkTWw64z9Y+I5NYDH+I+iMs=;
        b=g10+X/4e4nXxVcXTvuUcm8T+g7WIpVBeP/82KKGBcVA/5spnVZwOl1iKFjSdMQHHes
         Yz2qDNcreoQ3J9EuqAS83FmdZsFOMqBjTWjveRoVMi3vruUEzbGf7UgAVk5Q1yACHRRG
         wKU6sGm7hV5MxvxsBmW4bpZIiQRbu6/op+yMsJ8H2xw1nnLouZ7yxucFWzwdGnEt+Ao8
         B5/QHZXmy1sdutxTevgkr8jQuaajrA970SlJgSKRb8xCglh7z39yajTK7HyImtDSgcv5
         fJJOPM0aUmcw0BkZoMMowx+huxJ0cdsUTrH4BCeKM6Hd4zuqGOUQjBsYesadeqI5Vsxk
         0/0A==
X-Gm-Message-State: AOJu0YydvLRKGEqLhQIRO8o8ewmIAITpuOdr+kbP6dMvyIphbLIhQfp0
	xX9+6XQZmsHdEoF5+wqnckM=
X-Google-Smtp-Source: AGHT+IEiTb/ZhutEctWo+bHhnsGpLsJE5X7MQpMSzLphCU+kdew5e2IRLkJ+9c6G6pWDMnBaL9TWYw==
X-Received: by 2002:a7b:cc12:0:b0:40e:556e:5f2c with SMTP id f18-20020a7bcc12000000b0040e556e5f2cmr3604498wmh.63.1705348944450;
        Mon, 15 Jan 2024 12:02:24 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-bf32-c470-1874-c1ad.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:bf32:c470:1874:c1ad])
        by smtp.gmail.com with ESMTPSA id m26-20020a7bca5a000000b0040e54381a85sm16377924wml.26.2024.01.15.12.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 12:02:24 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v5 0/5] hwmon: Add support for Amphenol ChipCap 2
Date: Mon, 15 Jan 2024 21:02:20 +0100
Message-Id: <20240115-topic-chipcap2-v5-0-0cc7a15aeece@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEyPpWUC/33NSWrEMBAF0Ks0WkehVJI8ZJV7hF5oKLUL4gHJm
 DSN7x65VyEhXv4q3v8PUSgzFfF2eYhMGxeepxrsy0WEwU03khxrFgioFSDIdV44yDDwEtyCkjB
 2fWeNhoCiIu8KSZ/dFIaDja6slI/Hkinx13Pp41rzwGWd8/05vKnj+u/GpiRI6FpCFY1XFN9vo
 +PP1zCP4qja8Jxj5ckGjbZvmhT9b67Pua7ceu29BWcT/OHmnJvK295ASK5tlHY/+b7v33rrseK
 CAQAA
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705348943; l=4074;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=mYR8sNDnHt0dntdqvuPMWOgHUwh02hx6R3JhqMuvwwM=;
 b=6eq52m7dd8LWQuo3LzExCqtuouPqg1APUs6wDQDRPFm0lI52evx3LhyY54c1BgLorQ5JX1E1C
 W8K6rqoBeZwDztB/TlDbvyrefjEAq8eBrrhiu5ajyT6G5XxYmbperzY
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

This series adds support and documentation for the Amphenol ChipCap 2
humidity and temperature sensor in its digital version.

This I2C device provides 14-bit humidity and temperature measurements as
well as low (minimum) and high (maximum) humidity alarms. A ready signal
is also available to reduce delays while fetching data.

The proposed driver implements the logic to perform measurements with
and without the ready signal, EEPROM configuration and alarm signaling.

The features this driver does not support (I2C address and command
window length modification) have been documented in the "Known Issues"
section.

The complete supported functionality has been tested with a CC2D33S
sensor connected to a Raspberry Pi Zero 2 w.
Different device tree node definitions (with and without ready and/or
alarm signals) have been positively tested.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v5:
- dt-bindings: add "amphenol,cc2d23" to "compatible" in the example.
- Link to v4: https://lore.kernel.org/r/20231020-topic-chipcap2-v4-0-7940cfa7613a@gmail.com

Changes in v4:
- chipcap2.c: require exclusive regulator to trigger command mode.
- chipcap2.c: keep the device off until a measurement is required.
  Because the device makes an automatic measurement after the power-up
  sequence, no differentiation between sleep and non-sleep modes is
  required anymore.
- chipcap2.c: retrieve alarm settings from the device instead of storing
  them locally.
- dt-bindings: add vdd-supply to required properties.
- dt-bindings: default to 'amphenol,cc2d23' compatible (same
  functionality for all compatibles).
- Link to v3: https://lore.kernel.org/r/20231020-topic-chipcap2-v3-0-5b3bb50a5f0b@gmail.com

Changes in v3:
- ABI: sysfs-class-hwmon: documented humidity min/max alarms.
- General: reorder patches (bindings first to remove checkpatch
  warnings).
- General: remove part number wildcards and use real part numbers.
- chipcap2.c: improve error path in probe function.
- chipcap2.c: fix error handling if regulator could not be registered.
- chipcap2.c: use absolute values for hysteresis (for both ABI
  compatibility and simplicity).
- chipcap2.c: minor code-style fixes and variable renaming.
- Link to v2: https://lore.kernel.org/r/20231020-topic-chipcap2-v2-0-f5c325966fdb@gmail.com

Changes in v2:
- vendor-prefixes: full company name in the vendor description (Krzystof
  Kozlowski)
- chipcap2.c: proper i2c_device_id table, coding style fixes, cleaner
  error path in the probe function (Krzystof Kozlowski)
- dt-bindings: per-item description and lowercase names (Krzystof
  Kozlowski)
- MAINTAINERS: fix manufacturer name (Krzystof Kozlowski)
- Link to v1: https://lore.kernel.org/r/20231020-topic-chipcap2-v1-0-087e21d4b1ed@gmail.com

---
Javier Carrasco (5):
      dt-bindings: vendor-prefixes: add Amphenol
      hwmon: (core) Add support for humidity min/max alarm
      ABI: sysfs-class-hwmon: add descriptions for humidity min/max alarms
      dt-bindings: hwmon: Add Amphenol ChipCap 2
      hwmon: Add support for Amphenol ChipCap 2

 Documentation/ABI/testing/sysfs-class-hwmon        |  18 +
 .../bindings/hwmon/amphenol,chipcap2.yaml          |  77 ++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 Documentation/hwmon/chipcap2.rst                   |  73 ++
 Documentation/hwmon/index.rst                      |   1 +
 MAINTAINERS                                        |   8 +
 drivers/hwmon/Kconfig                              |  10 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/chipcap2.c                           | 835 +++++++++++++++++++++
 drivers/hwmon/hwmon.c                              |   2 +
 include/linux/hwmon.h                              |   4 +
 11 files changed, 1031 insertions(+)
---
base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
change-id: 20231020-topic-chipcap2-e2d8985430c2

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>



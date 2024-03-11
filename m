Return-Path: <linux-kernel+bounces-99139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEC48783F1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89C39B22EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBB14206E;
	Mon, 11 Mar 2024 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAv9V3L/"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051C711712;
	Mon, 11 Mar 2024 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710171436; cv=none; b=glwppY/V00JYXUeVlLbLn5WJweVsrePNhGFQrnSI8yo1qZnTHNHWydir39ynYZ28M5cgWELhtrehvWNEObzG5NYDDmpncgDrtTmleIgwJTOeopRQtcJ2BnO/pUNu3CVjRheAvwi8qHlIGaEViSQXmhMJ3f8w7hK4a67TUDVyuqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710171436; c=relaxed/simple;
	bh=cliPdiykPFBQPB8kg+98KHCWqrNa1qp0dIqnZuPxJz8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=oLyBshptwYPXWFmfThBYIYAM3r+VGYq+P7kfUn4sRMeVgmiIn3//qO71SxTIQavnXmzUSlFMp95TzIra0H2742f4sL46l/ES2519Yb+X8b9srClxzrWDHUOzZuUXBa2YuolDL69G4Rhj8ENnEkBGdElBtHgLlJLRJWVd593tKQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAv9V3L/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e56787e691so3653780b3a.0;
        Mon, 11 Mar 2024 08:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710171433; x=1710776233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=g9x+X3NiSdQxM/kQ/xGr9qo5cclebFReU5Z734InRe8=;
        b=nAv9V3L/neGnU0FTiFDva7EFb+e8ioi2XwJpIMbzZm+plyBtH42kxslomSzIXj2Z19
         L5L0ySAEOewhKFtgyigqL5td7mx8FC5kzrd4cbykcrxhXkfPKl5wPUWzCnUH6XbK0kGY
         1TgbVqTBesyQS1c14wEhBvG2im5v06YWobGU2nLqZE7RUVfURuMCX8nCIFACw0Cpffib
         Smo1ebQ+WPyKm5WdUuaXHvKO46KXpoD04EHz+sH+KGNp8lCKBf+JBeewfT4o7Baz3nNK
         VRRnARXTKe8GANvyTqHehtY0dUP3021U8JZaM7ehDSSIksMvjGT76I1FrAFIfIdruwyB
         QgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710171433; x=1710776233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9x+X3NiSdQxM/kQ/xGr9qo5cclebFReU5Z734InRe8=;
        b=GZH7ICkkDeEahkkgNGUwUb83tE1mgIfCCL1hWHJEM8uBLVfxIGCqADcjJ4mwci8yyK
         lxXxXOdQ2xbFRVUWbTzR/80pZ5f5MNxS4sX5JS22aXbShbm68hHt/JnE3jekUrKhg87d
         1fi1JfrVELIYOyioAuqpSzXKaokoxMgic/MzIVs9JKNhNTD8SEG+FTby29Vjmo2TSNY3
         v8wh0WewrvwhifDd4/CP5CRVyDeEN2i1utFmV0+4i1lckCjmqgua2ZdXwdFEtefycfrl
         jcxHgX123HIcKvk9UBqmYM33qKDbDUxEQrR3BbhHmkX4TMP4+MucubUAy/xkrMjZ8ScH
         /73Q==
X-Forwarded-Encrypted: i=1; AJvYcCXeUF7F09tS6rWuoPiVjmin6rELgALzSofHcK236L9FcM02HZJ4kSsq3KCPDQe7Zvyxb0ZKQV6D2E0VOl9Q38YHvk9ZonO/PaxENwpR
X-Gm-Message-State: AOJu0YzfwTKKCFw3OhL7aDrXMdTOPe0iPbwZMxr4M/QMK1C3u558dqsj
	NnWAr0LTG1eEVi/8DnvhCP/WuGFQOAyDXgNOImdIZXHizNvY7OFkewkeP8XY
X-Google-Smtp-Source: AGHT+IFg+o+chH8Nv3KtLpomrSWBDBUqtKiDEke+ek860iDblbCcavDPnBfdI8oYmnzDDokm07pVnA==
X-Received: by 2002:a05:6a20:3ca9:b0:1a1:491e:8aba with SMTP id b41-20020a056a203ca900b001a1491e8abamr9691506pzj.22.1710171433006;
        Mon, 11 Mar 2024 08:37:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ei4-20020a056a0080c400b006e5619b2f83sm4522089pfb.7.2024.03.11.08.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 08:37:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v6.9
Date: Mon, 11 Mar 2024 08:37:10 -0700
Message-Id: <20240311153710.3137686-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull hwmon updates for Linux v6.9 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.9

Depending on who comes first, there will be a context conflict in

  Documentation/devicetree/bindings/trivial-devices.yaml

between commit:

  7e6707f7da31 ("dt-bindings: Add MPQ8785 voltage regulator device")

and commit:

  6284d33d1749 ("dt-bindings: trivial-devices: sort entries alphanumerically")

from the devicetree tree.

Thanks,
Guenter
------

The following changes since commit 841c35169323cd833294798e58b9bf63fa4fa1de:

  Linux 6.8-rc4 (2024-02-11 12:18:13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.9

for you to fetch changes up to 8debe3c1295ef36958dae77487eed9cf6584c008:

  hwmon: (dell-smm) Add XPS 9315 to fan control whitelist (2024-03-10 12:58:18 -0700)

----------------------------------------------------------------
hwmon updates for v6.9

* New drivers for

  - Amphenol ChipCap 2

  - ASPEED g6 PWM/Fan tach

  - Astera Labs PT5161L retimer

  - ASUS ROG RYUJIN II 360 AIO cooler

  - LTC4282

  - Microsoft Surface devices

  - MPS MPQ8785 Synchronous Step-Down Converter

  - NZXT Kraken X and Z series AIO CPU coolers

* Additional chip support in existing drivers

  - Ayaneo Air Plus 7320u (oxp-sensors)

  - INA260 (ina2xx)

  - XPS 9315 (dell-smm)

  - MSI customer ID (nct6683)

* Devicetree bindings updates

  - Common schema for hardware monitoring devices

  - Common schema for fans

  - Update chip descriptions to use common schema

  - Document regulator properties in several drivers

  - Explicit bindings for infineon buck converters

* Other improvements

  - Replaced rbtree with maple tree register cache in several drivers

  - Added support for humidity min/max alarm and volatage fault attributes
    to hwmon core

  - Dropped non-functional I2C_CLASS_HWMON support for drivers w/o detect()

  - Dropped obsolete and redundant entried from MAINTAINERS

  - Cleaned up axi-fan-control and coretemp drivers

  - Minor fixes and improvements in several other drivers

----------------------------------------------------------------
Aleksa Savic (2):
      hwmon: Add driver for NZXT Kraken X and Z series AIO CPU coolers
      hwmon: Add driver for ASUS ROG RYUJIN II 360 AIO cooler

Armin Wolf (1):
      hwmon: (dell-smm) Add XPS 9315 to fan control whitelist

Billy Tsai (2):
      dt-bindings: hwmon: Support Aspeed g6 PWM TACH Control
      hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED g6 PWM/Fan tach

Bo Liu (9):
      hwmon: (adt7x10) convert to use maple tree register cache
      hwmon: (emc1403) convert to use maple tree register cache
      hwmon: (ina3221) convert to use maple tree register cache
      hwmon: (jc42) convert to use maple tree register cache
      hwmon: (lm83) convert to use maple tree register cache
      hwmon: (max31760) convert to use maple tree register cache
      hwmon: (nct7802) convert to use maple tree register cache
      hwmon: (sch5627) convert to use maple tree register cache
      hwmon: (tmp401) convert to use maple tree register cache

Charles Hsu (2):
      dt-bindings: Add MPQ8785 voltage regulator device
      hwmon: Add driver for MPS MPQ8785 Synchronous Step-Down Converter

Conor Dooley (2):
      dt-bindings: hwmon/pmbus: ti,lm25066: document regulators
      regulator: dt-bindings: promote infineon buck converters to their own binding

Cosmo Chou (3):
      dt-bindings: vendor-prefixes: add asteralabs
      dt-bindings: trivial-devices: add Astera Labs PT5161L
      hwmon: Add driver for Astera Labs PT5161L retimer

Forest Crossman (1):
      hwmon: (nct6683) Add another customer ID for MSI

Guenter Roeck (6):
      MAINTAINERS: Drop entries for hwmon devices with unreachable maintainers
      MAINTAINERS: Drop redundant hwmon entries
      dt-bindings: hwmon: nuvoton,nct6775: Add compatible value for NCT6799
      hwmon: (pmbus/tda38640) Use PMBUS_REGULATOR_ONE to declare regulator
      hwmon: (pmbus/lm25066) Use PMBUS_REGULATOR_ONE to declare regulator
      hwmon: (pmbus/ir38064) Use PMBUS_REGULATOR_ONE to declare regulator

Heiner Kallweit (2):
      hwmon: Remove I2C_CLASS_HWMON from drivers w/o detect() and address_list
      hwmon: Drop non-functional I2C_CLASS_HWMON support for drivers w/o detect()

Ivor Wanders (1):
      hwmon: add fan speed monitoring driver for Surface devices

Jani Nikula (1):
      hwmon: put HWMON_CHANNEL_INFO() initializers in rodata

Javier Carrasco (7):
      dt-bindings: vendor-prefixes: add Amphenol
      hwmon: (core) Add support for humidity min/max alarm
      ABI: sysfs-class-hwmon: add descriptions for humidity min/max alarms
      dt-bindings: hwmon: Add Amphenol ChipCap 2
      hwmon: Add support for Amphenol ChipCap 2
      hwmon: (chipcap2) fix uninitialized variable in cc2_get_reg_val()
      hwmon: (chipcap2) fix return path in cc2_request_alarm_irqs()

Josua Mayer (1):
      hwmon: (amc6821) add of_match table

Krzysztof Kozlowski (6):
      dt-bindings: hwmon: add common properties
      dt-bindings: hwmon: ti,ina2xx: use common hwmon schema
      dt-bindings: hwmon: adi,adm1275: use common hwmon schema
      dt-bindings: hwmon: lltc,ltc4286: use common hwmon schema
      dt-bindings: hwmon: reference common hwmon schema
      hwmon: (sis5595) drop unused DIV_TO_REG function

Michal Simek (3):
      dt-bindings: hwmon: ina2xx: Add label property
      dt-bindings: hwmon: ina2xx: Describe #io-channel-cells property
      dt-bindings: hwmon: ina2xx: Describe ina260 chip

Naresh Solanki (2):
      dt-bindings: hwmon: tda38640: Add interrupt & regulator properties
      dt-bindings: hwmon: fan: Add fan binding to schema

Nuno Sa (6):
      dt-bindings: hwmon: Add LTC4282 bindings
      hwmon: add fault attribute for voltage channels
      hwmon: Add driver for LTC4282
      hwmon: (axi-fan-control) Use device firmware agnostic API
      hwmon: (axi-fan-control) Make use of sysfs_emit()
      hwmon: (axi-fan-control) Make use of dev_err_probe()

Okan Akyuz (1):
      hwmon: (max6620) Update broken Datasheet URL in driver documentation

Patrick Rudolph (1):
      hwmon: (pmbus_core) Allow to hook PMBUS_SMBALERT_MASK

Sebastian Kranz (1):
      hwmon: (oxp-sensors) Add support for Ayaneo Air Plus 7320u.

Stefan Gloor (1):
      hwmon: (sht3x) read out sensor serial number

Théo Lebrun (1):
      dt-bindings: hwmon: lm75: use common hwmon schema

Zhang Rui (8):
      hwmon: (coretemp) Introduce enum for attr index
      hwmon: (coretemp) Remove unnecessary dependency of array index
      hwmon: (coretemp) Replace sensor_device_attribute with device_attribute
      hwmon: (coretemp) Remove redundant pdata->cpu_map[]
      hwmon: (coretemp) Abstract core_temp helpers
      hwmon: (coretemp) Split package temp_data and core temp_data
      hwmon: (coretemp) Remove redundant temp_data->is_pkg_data
      hwmon: (coretemp) Use dynamic allocated memory for core temp_data

 Documentation/ABI/testing/sysfs-class-hwmon        |   27 +
 .../devicetree/bindings/hwmon/adi,adm1177.yaml     |    5 +-
 .../devicetree/bindings/hwmon/adi,adm1275.yaml     |    7 +-
 .../devicetree/bindings/hwmon/adi,ltc2945.yaml     |    5 +-
 .../devicetree/bindings/hwmon/adi,ltc4282.yaml     |  159 ++
 .../bindings/hwmon/amphenol,chipcap2.yaml          |   77 +
 .../bindings/hwmon/aspeed,g6-pwm-tach.yaml         |   71 +
 .../devicetree/bindings/hwmon/fan-common.yaml      |   79 +
 .../devicetree/bindings/hwmon/hwmon-common.yaml    |   19 +
 .../devicetree/bindings/hwmon/lltc,ltc4151.yaml    |    5 +-
 .../devicetree/bindings/hwmon/lltc,ltc4286.yaml    |    9 +-
 Documentation/devicetree/bindings/hwmon/lm75.yaml  |    3 +-
 .../devicetree/bindings/hwmon/nuvoton,nct6775.yaml |    1 +
 .../bindings/hwmon/pmbus/infineon,tda38640.yaml    |   28 +
 .../bindings/hwmon/pmbus/ti,lm25066.yaml           |   17 +-
 .../devicetree/bindings/hwmon/ti,ina2xx.yaml       |   11 +-
 .../devicetree/bindings/hwmon/ti,tmp513.yaml       |    5 +-
 .../devicetree/bindings/hwmon/ti,tps23861.yaml     |    5 +-
 .../bindings/regulator/infineon,ir38060.yaml       |   45 +
 .../devicetree/bindings/trivial-devices.yaml       |   12 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |    4 +
 Documentation/hwmon/aspeed-g6-pwm-tach.rst         |   26 +
 Documentation/hwmon/asus_rog_ryujin.rst            |   47 +
 Documentation/hwmon/chipcap2.rst                   |   73 +
 Documentation/hwmon/emc2305.rst                    |    1 -
 Documentation/hwmon/index.rst                      |    8 +
 Documentation/hwmon/ltc4282.rst                    |  133 ++
 Documentation/hwmon/max6620.rst                    |    2 +-
 Documentation/hwmon/mpq8785.rst                    |   94 ++
 Documentation/hwmon/nct6683.rst                    |    1 +
 Documentation/hwmon/nzxt-kraken3.rst               |   74 +
 Documentation/hwmon/oxp-sensors.rst                |    1 +
 Documentation/hwmon/pt5161l.rst                    |   42 +
 Documentation/hwmon/sht3x.rst                      |   11 +
 Documentation/hwmon/surface_fan.rst                |   25 +
 MAINTAINERS                                        |  167 +-
 drivers/hwmon/Kconfig                              |   76 +
 drivers/hwmon/Makefile                             |    7 +
 drivers/hwmon/adm1177.c                            |    1 -
 drivers/hwmon/adt7310.c                            |    2 +-
 drivers/hwmon/adt7410.c                            |    4 +-
 drivers/hwmon/amc6821.c                            |   11 +
 drivers/hwmon/aspeed-g6-pwm-tach.c                 |  549 ++++++
 drivers/hwmon/asus_rog_ryujin.c                    |  609 +++++++
 drivers/hwmon/axi-fan-control.c                    |   73 +-
 drivers/hwmon/chipcap2.c                           |  822 +++++++++
 drivers/hwmon/coretemp.c                           |  204 +--
 drivers/hwmon/dell-smm-hwmon.c                     |   13 +
 drivers/hwmon/ds1621.c                             |    1 -
 drivers/hwmon/ds620.c                              |    1 -
 drivers/hwmon/emc1403.c                            |    2 +-
 drivers/hwmon/emc2305.c                            |    5 -
 drivers/hwmon/hwmon.c                              |    3 +
 drivers/hwmon/ina209.c                             |    1 -
 drivers/hwmon/ina238.c                             |    1 -
 drivers/hwmon/ina3221.c                            |    2 +-
 drivers/hwmon/jc42.c                               |    2 +-
 drivers/hwmon/lm83.c                               |    2 +-
 drivers/hwmon/ltc4282.c                            | 1782 ++++++++++++++++++++
 drivers/hwmon/max127.c                             |    1 -
 drivers/hwmon/max31760.c                           |    3 +-
 drivers/hwmon/max31790.c                           |    1 -
 drivers/hwmon/max31827.c                           |    1 -
 drivers/hwmon/max6621.c                            |    1 -
 drivers/hwmon/max6697.c                            |    1 -
 drivers/hwmon/nct6683.c                            |    3 +
 drivers/hwmon/nct7802.c                            |    2 +-
 drivers/hwmon/nzxt-kraken3.c                       | 1008 +++++++++++
 drivers/hwmon/occ/p8_i2c.c                         |    1 -
 drivers/hwmon/oxp-sensors.c                        |   10 +
 drivers/hwmon/pmbus/Kconfig                        |    9 +
 drivers/hwmon/pmbus/Makefile                       |    1 +
 drivers/hwmon/pmbus/ir36021.c                      |    1 -
 drivers/hwmon/pmbus/ir38064.c                      |    2 +-
 drivers/hwmon/pmbus/lm25066.c                      |    2 +-
 drivers/hwmon/pmbus/mpq8785.c                      |   90 +
 drivers/hwmon/pmbus/pmbus_core.c                   |    2 +-
 drivers/hwmon/pmbus/tda38640.c                     |    2 +-
 drivers/hwmon/powr1220.c                           |    1 -
 drivers/hwmon/pt5161l.c                            |  667 ++++++++
 drivers/hwmon/sbrmi.c                              |    1 -
 drivers/hwmon/sbtsi_temp.c                         |    1 -
 drivers/hwmon/sch5627.c                            |    2 +-
 drivers/hwmon/sht3x.c                              |   66 +-
 drivers/hwmon/sis5595.c                            |    8 +-
 drivers/hwmon/surface_fan.c                        |   91 +
 drivers/hwmon/tmp401.c                             |    2 +-
 drivers/hwmon/w83773g.c                            |    1 -
 include/linux/hwmon.h                              |   18 +-
 89 files changed, 7136 insertions(+), 335 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc4282.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/amphenol,chipcap2.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/hwmon-common.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/infineon,ir38060.yaml
 create mode 100644 Documentation/hwmon/aspeed-g6-pwm-tach.rst
 create mode 100644 Documentation/hwmon/asus_rog_ryujin.rst
 create mode 100644 Documentation/hwmon/chipcap2.rst
 create mode 100644 Documentation/hwmon/ltc4282.rst
 create mode 100644 Documentation/hwmon/mpq8785.rst
 create mode 100644 Documentation/hwmon/nzxt-kraken3.rst
 create mode 100644 Documentation/hwmon/pt5161l.rst
 create mode 100644 Documentation/hwmon/surface_fan.rst
 create mode 100644 drivers/hwmon/aspeed-g6-pwm-tach.c
 create mode 100644 drivers/hwmon/asus_rog_ryujin.c
 create mode 100644 drivers/hwmon/chipcap2.c
 create mode 100644 drivers/hwmon/ltc4282.c
 create mode 100644 drivers/hwmon/nzxt-kraken3.c
 create mode 100644 drivers/hwmon/pmbus/mpq8785.c
 create mode 100644 drivers/hwmon/pt5161l.c
 create mode 100644 drivers/hwmon/surface_fan.c


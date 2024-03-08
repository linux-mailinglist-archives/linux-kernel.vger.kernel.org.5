Return-Path: <linux-kernel+bounces-96842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE85876215
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE771C20A40
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F6D55C34;
	Fri,  8 Mar 2024 10:35:18 +0000 (UTC)
Received: from esa2.ltts.com (unknown [14.140.155.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9664E53E01;
	Fri,  8 Mar 2024 10:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.140.155.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709894118; cv=none; b=Rdai3E8/7CzztD5/QTwdbqCAVnigaiGWCUye+DB5HzBOhD2/qzS8TOqP3ro/7oKEt7c2oV6qYahCW2ma8eBReoezoGq5FzDq3+3f5pDfD8SWGkCusmkxaljaQUq3WM84FX6ab3ITbYkI5LpbhHRj0AZeNpzHU77vKl6FsALpwCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709894118; c=relaxed/simple;
	bh=gM3MAYJOfpZENBvRKZcil7tVc/21ayCvY/Ke+cDMGZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OG79rSS9Yy3qjdEufHbDPKcZ27gRuwz9EdIeaNa3qERHdTkDz1b3lG944CWk8sSSsddzHo6BwtFD0yvPE0tI7IHT1IWidGdN5DKI4PWKGEiqi0KQdR9qaaXVLD7Hs1YgyoM7Mr6s8Jnu+M7mRumB9m7Avl2zddu4uiAzNTe34vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=14.140.155.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: ReLryFVYQ6WYWximSVQqvE4vhKq8wseJb6Vy9p7gIabixbxOqeTn+W5BejpV6ekcHQkET2kX3+
 HI73MVhwYT1Q==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa2.ltts.com with ESMTP; 08 Mar 2024 16:05:06 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: linux-kernel@vger.kernel.org
Cc: m.nirmaladevi@ltts.com,
	lee@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jpanis@baylibre.com,
	devicetree@vger.kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	linus.walleij@linaro.org,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	eblanc@baylibre.com,
	Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [PATCH v3 00/11] Add support for TI TPS65224 PMIC
Date: Fri,  8 Mar 2024 16:04:44 +0530
Message-Id: <20240308103455.242705-1-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series modifies the existing TPS6594 drivers to add support for the
TPS65224 PMIC device that is a derivative of TPS6594. TPS65224 has a
similar register map to TPS6594 with a few differences. SPI, I2C, ESM,
PFSM, Regulators and GPIO features overlap between the two devices.

TPS65224 is a Power Management IC (PMIC) which provides regulators and
other features like GPIOs, Watchdog, Error Signal Monitor (ESM) and
Pre-configurable Finite State Machine (PFSM). The SoC and the PMIC can
communicate through the I2C or SPI interfaces. The PMIC TPS65224
additionally has a 12-bit ADC.
Data Sheet for TPS65224: https://www.ti.com/product/TPS65224-Q1

Driver re-use is applied following the advice of the following series:
https://lore.kernel.org/lkml/2f467b0a-1d11-4ec7-8ca6-6c4ba66e5887@baylibre.com/

The features implemented in this series are:
- TPS65224 Register definitions
- Core (MFD I2C and SPI entry points)
- PFSM	
- Regulators
- Pinctrl

TPS65224 Register definitions:
This patch adds macros for register field definitions of TPS65224
to the existing TPS6594 driver.  

Core description:
I2C and SPI interface protocols are implemented, with and without
the bit-integrity error detection feature (CRC mode).

PFSM description:
Strictly speaking, PFSM is not hardware. It is a piece of code.
PMIC integrates a state machine which manages operational modes.
Depending on the current operational mode, some voltage domains
remain energized while others can be off.
PFSM driver can be used to trigger transitions between configured
states.

Regulators description:
4 BUCKs and 3 LDOs.
BUCK12 can be used in dual-phase mode.

Pinctrl description:
TPS65224 family has 6 GPIOs. Those GPIOs can also serve different
functions such as I2C or SPI interface or watchdog disable functions.
The driver provides both pinmuxing for the functions and GPIO capability.

This series was tested on linux-next tag: next-20240118

Test logs can be found here:
https://gist.github.com/LeonardMH/58ec135921fb1062ffd4a8b384831eb0

Changelog v2 -> v3:
- Corrected comments and refactored ioctl fn in pfsm driver
- Commit message and description changes in SPI
- Removed unwanted comments, fixing indentation and minor refactoring 
  in regulator driver
- ESM driver is removed from linux as it will be handled from MCU side

Bhargav Raviprakash (8):
  mfd: tps6594: use volatile_table instead of volatile_reg
  mfd: tps6594: add regmap config in match data
  dt-bindings: mfd: ti,tps6594: Add TI TPS65224 PMIC
  mfd: tps6594-i2c: Add TI TPS65224 PMIC I2C
  mfd: tps6594-spi: Add TI TPS65224 PMIC SPI
  mfd: tps6594-core: Add TI TPS65224 PMIC core
  misc: tps6594-pfsm: Add TI TPS65224 PMIC PFSM
  arch: arm64: dts: ti: k3-am62p5-sk: Add TPS65224 PMIC support in AM62P
    dts

Nirmala Devi Mal Nadar (3):
  mfd: tps6594: Add register definitions for TI TPS65224 PMIC
  regulator: tps6594-regulator: Add TI TPS65224 PMIC regulators
  pinctrl: pinctrl-tps6594: Add TPS65224 PMIC pinctrl and GPIO

 .../devicetree/bindings/mfd/ti,tps6594.yaml   |   1 +
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       |  95 +++++
 drivers/mfd/tps6594-core.c                    | 253 ++++++++++--
 drivers/mfd/tps6594-i2c.c                     |  41 +-
 drivers/mfd/tps6594-spi.c                     |  43 +-
 drivers/misc/tps6594-pfsm.c                   |  48 ++-
 drivers/pinctrl/pinctrl-tps6594.c             | 287 ++++++++++++--
 drivers/regulator/Kconfig                     |   4 +-
 drivers/regulator/tps6594-regulator.c         | 236 +++++++++--
 include/linux/mfd/tps6594.h                   | 369 +++++++++++++++++-
 10 files changed, 1239 insertions(+), 138 deletions(-)


base-commit: 2863b714f3ad0a9686f2de1b779228ad8c7a8052
-- 
2.25.1



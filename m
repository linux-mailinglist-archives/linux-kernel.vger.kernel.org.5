Return-Path: <linux-kernel+bounces-57717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860CA84DCB0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50171C20F32
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8636D1CA;
	Thu,  8 Feb 2024 09:20:56 +0000 (UTC)
Received: from esa2.ltts.com (unknown [14.140.155.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54836A8C5
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.140.155.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384056; cv=none; b=r87O54IJYuLzC9Aios9FZf5WuNO2ep+eKU1/tKovuGOhu0qBtNqJQUIBFUgKo5sQZ0hB45Epwo8cYm16kBW/cJzP7ciDlak5uZOHDtcTZGZxUytvogPWG2YlJ5GjeHUzxRnR70eOpkuD2pwpaYtKRrEMEjbJEoj4d/ayTqYeFBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384056; c=relaxed/simple;
	bh=NGlHW/aBv9IHGU3rIPQqJQrm5GA1wX8GLiD/3YcDe2w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q8PrUcNRDpZr9IXGq1dzsyCW2DxcKRMHceQls6i8/OfHUy/FrLGpBU44Z4OLVgr6HDTVDZse/1ryXldVpXniCkR6onJ08YyvlvAvwZxHYOzPLJNLVVEm9zOtFCrK/pDLFUcU5hoMW1NyJPfhnpcv4CkDjY06n8WivwbY3pl6tgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=14.140.155.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: kzBwBmKbnKnMQJw5TtnNKHnu9j9fDgoAAxUSYxY0CR+LQO5yAy3Uo/3GKU3yCGhw3WBpD6eDDi
 eDTQjHF5oSgw==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa2.ltts.com with ESMTP; 08 Feb 2024 14:49:39 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: linux-kernel@vger.kernel.org
Cc: m.nirmaladevi@ltts.com,
	lee@kernel.org,
	Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [PATCH v1 00/13]  Add support for TI TPS65224 PMIC
Date: Thu,  8 Feb 2024 14:49:20 +0530
Message-Id: <20240208091922.1206916-1-bhargav.r@ltts.com>
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
- ESM
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

ESM description:
This device monitors the SoC error output signal at its nERR_MCU
input pin. On error detection, ESM driver toggles the PMIC nRSTOUT pin
to reset the SoC.

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

Bhargav Raviprakash (10):
  mfd: tps6594: use volatile_table instead of volatile_reg
  dt-bindings: mfd: ti,tps6594: Add TI TPS65224 PMIC
  mfd: tps6594-i2c: Add TI TPS65224 PMIC I2C
  mfd: tps6594-spi: Add TI TPS65224 PMIC SPI
  mfd: tps6594-core: Add TI TPS65224 PMIC core
  misc: tps6594-pfsm: Add TI TPS65224 PMIC PFSM
  misc: tps6594-esm: reversion check limited to TPS6594 family
  misc: tps6594-esm: use regmap_field
  misc: tps6594-esm: Add TI TPS65224 PMIC ESM
  arch: arm64: dts: ti: k3-am62p5-sk: Add TPS65224 PMIC support in AM62P
    dts

Nirmala Devi Mal Nadar (3):
  mfd: tps6594: Add register definitions for TI TPS65224 PMIC
  regulator: tps6594-regulator: Add TI TPS65224 PMIC regulators
  pinctrl: pinctrl-tps6594: Add TPS65224 PMIC pinctrl and GPIO

 .../devicetree/bindings/mfd/ti,tps6594.yaml   |   1 +
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       |  95 +++++
 drivers/mfd/tps6594-core.c                    | 258 ++++++++++++-
 drivers/mfd/tps6594-i2c.c                     |  20 +-
 drivers/mfd/tps6594-spi.c                     |  18 +-
 drivers/misc/tps6594-esm.c                    |  89 +++--
 drivers/misc/tps6594-pfsm.c                   |  55 ++-
 drivers/pinctrl/pinctrl-tps6594.c             | 287 ++++++++++++--
 drivers/regulator/Kconfig                     |   4 +-
 drivers/regulator/tps6594-regulator.c         | 244 ++++++++++--
 include/linux/mfd/tps6594.h                   | 358 +++++++++++++++++-
 11 files changed, 1272 insertions(+), 157 deletions(-)


base-commit: 2863b714f3ad0a9686f2de1b779228ad8c7a8052
-- 
2.25.1



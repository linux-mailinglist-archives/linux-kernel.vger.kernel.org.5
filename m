Return-Path: <linux-kernel+bounces-95248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 158D7874B3E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98FA228213A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C514E84FBB;
	Thu,  7 Mar 2024 09:48:11 +0000 (UTC)
Received: from esa2.ltts.com (unknown [14.140.155.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6383E84052;
	Thu,  7 Mar 2024 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.140.155.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709804891; cv=none; b=GKmUVgeo3ZhYum6Wktyu2QrcX7vO847pbUEdB9xZEcXXEiBwURE6vn6NduDee7NDU2rZPiTH3PQToizaqdqSFmszk/7zEOYPVMs/Onck6pzXu6XR5285Bpenr83HgCGDdPuy6baKZYUMxp5rJIZFgakXl9U4CGwjM3VbdVSZrxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709804891; c=relaxed/simple;
	bh=T0vQqe3wQDgCmBiHKB5MY86dFbkqqis5Rjc6YBC2yFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/DKWZZWnoU/XmDmu/hRiv35yLlIRSAc7ei7Iok9v5oSrqIy4ZyQymfm0mX4q7Xx+uJc4EoHN+OCs8c7gbg/7ff/Ir4pD6luF8PPyAv8AcNgDXSkR7JyI3eB+LEdSrHKXdjYlbqST9Tw1Z7QCIFKAQlvr0zQbXCXTKcu2p7gGU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=14.140.155.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: /xSOhYlBDg1N1Qpcfld4tp3hwf86Wtgkqc8oDDR80mtX1KUxvoAXE2Xl6xhnORuxBOL+RyNVIm
 ilK25fQs9Vlw==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa2.ltts.com with ESMTP; 07 Mar 2024 15:18:04 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: lee@kernel.org
Cc: arnd@arndb.de,
	bhargav.r@ltts.com,
	broonie@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jpanis@baylibre.com,
	kristo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	lgirdwood@gmail.com,
	linus.walleij@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m.nirmaladevi@ltts.com,
	nm@ti.com,
	robh+dt@kernel.org,
	vigneshr@ti.com
Subject: Re: [PATCH v2 00/14]  Add support for TI TPS65224 PMIC
Date: Thu,  7 Mar 2024 15:17:53 +0530
Message-Id: <20240307094753.172319-1-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240229174952.GC1209090@google.com>
References: <20240229174952.GC1209090@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On Thu, 29 Feb 2024 17:49:52 +0000, Lee Jones wrote:
> On Fri, 23 Feb 2024, Bhargav Raviprakash wrote:
> 
> > This series modifies the existing TPS6594 drivers to add support for the
> > TPS65224 PMIC device that is a derivative of TPS6594. TPS65224 has a
> > similar register map to TPS6594 with a few differences. SPI, I2C, ESM,
> > PFSM, Regulators and GPIO features overlap between the two devices.
> > 
> > TPS65224 is a Power Management IC (PMIC) which provides regulators and
> > other features like GPIOs, Watchdog, Error Signal Monitor (ESM) and
> > Pre-configurable Finite State Machine (PFSM). The SoC and the PMIC can
> > communicate through the I2C or SPI interfaces. The PMIC TPS65224
> > additionally has a 12-bit ADC.
> > Data Sheet for TPS65224: https://www.ti.com/product/TPS65224-Q1
> > 
> > Driver re-use is applied following the advice of the following series:
> > https://lore.kernel.org/lkml/2f467b0a-1d11-4ec7-8ca6-6c4ba66e5887@baylibre.com/
> > 
> > The features implemented in this series are:
> > - TPS65224 Register definitions
> > - Core (MFD I2C and SPI entry points)
> > - PFSM	
> > - ESM
> > - Regulators
> > - Pinctrl
> > 
> > TPS65224 Register definitions:
> > This patch adds macros for register field definitions of TPS65224
> > to the existing TPS6594 driver.  
> > 
> > Core description:
> > I2C and SPI interface protocols are implemented, with and without
> > the bit-integrity error detection feature (CRC mode).
> > 
> > PFSM description:
> > Strictly speaking, PFSM is not hardware. It is a piece of code.
> > PMIC integrates a state machine which manages operational modes.
> > Depending on the current operational mode, some voltage domains
> > remain energized while others can be off.
> > PFSM driver can be used to trigger transitions between configured
> > states.
> > 
> > ESM description:
> > This device monitors the SoC error output signal at its nERR_MCU
> > input pin. On error detection, ESM driver toggles the PMIC nRSTOUT pin
> > to reset the SoC.
> > 
> > Regulators description:
> > 4 BUCKs and 3 LDOs.
> > BUCK12 can be used in dual-phase mode.
> > 
> > Pinctrl description:
> > TPS65224 family has 6 GPIOs. Those GPIOs can also serve different
> > functions such as I2C or SPI interface or watchdog disable functions.
> > The driver provides both pinmuxing for the functions and GPIO capability.
> > 
> > This series was tested on linux-next tag: next-20240118
> > 
> > Test logs can be found here:
> > https://gist.github.com/LeonardMH/58ec135921fb1062ffd4a8b384831eb0
> > 
> > Changelog v1 -> v2:
> > - Changes to patch sign-off
> > - Commit message change in dt-bindings patch
> > - regmap config included in the of_match_table data field
> > 
> > Bhargav Raviprakash (11):
> >   mfd: tps6594: use volatile_table instead of volatile_reg
> >   mfd: tps6594: add regmap config in match data
> >   dt-bindings: mfd: ti,tps6594: Add TI TPS65224 PMIC
> >   mfd: tps6594-i2c: Add TI TPS65224 PMIC I2C
> >   mfd: tps6594-spi: Add TI TPS65224 PMIC SPI
> >   mfd: tps6594-core: Add TI TPS65224 PMIC core
> >   misc: tps6594-pfsm: Add TI TPS65224 PMIC PFSM
> >   misc: tps6594-esm: reversion check limited to TPS6594 family
> >   misc: tps6594-esm: use regmap_field
> >   misc: tps6594-esm: Add TI TPS65224 PMIC ESM
> >   arch: arm64: dts: ti: k3-am62p5-sk: Add TPS65224 PMIC support in AM62P
> >     dts
> > 
> > Nirmala Devi Mal Nadar (3):
> >   mfd: tps6594: Add register definitions for TI TPS65224 PMIC
> >   regulator: tps6594-regulator: Add TI TPS65224 PMIC regulators
> >   pinctrl: pinctrl-tps6594: Add TPS65224 PMIC pinctrl and GPIO
> > 
> >  .../devicetree/bindings/mfd/ti,tps6594.yaml   |   1 +
> >  arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       |  95 +++++
> >  drivers/mfd/tps6594-core.c                    | 266 +++++++++++--
> >  drivers/mfd/tps6594-i2c.c                     |  41 +-
> >  drivers/mfd/tps6594-spi.c                     |  41 +-
> >  drivers/misc/tps6594-esm.c                    |  89 +++--
> >  drivers/misc/tps6594-pfsm.c                   |  55 ++-
> >  drivers/pinctrl/pinctrl-tps6594.c             | 287 ++++++++++++--
> >  drivers/regulator/Kconfig                     |   4 +-
> >  drivers/regulator/tps6594-regulator.c         | 244 ++++++++++--
> >  include/linux/mfd/tps6594.h                   | 369 +++++++++++++++++-
> >  11 files changed, 1325 insertions(+), 167 deletions(-)
> 
> Does this set have to be taken in wholesale?
> 
> -- 
> Lee Jones [李琼斯]

The drivers do not have to be applied in lockstep or taken in wholesale.

Regards,
Bhargav


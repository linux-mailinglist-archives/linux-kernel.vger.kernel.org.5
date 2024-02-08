Return-Path: <linux-kernel+bounces-57875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 610C984DE78
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91EEC1C22C65
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB0267E83;
	Thu,  8 Feb 2024 10:39:25 +0000 (UTC)
Received: from esa2.ltts.com (unknown [14.140.155.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FD441A88
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 10:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.140.155.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707388765; cv=none; b=C74Q/DL7qXO0TNPTdY0o9BYCFc3+izNwaz0EIgtqtnj5jMSMiZ7iV9uRkclKCFAubu/doiMqjGyk7ywQQef7CEH6ZHWh419VQXBViRjd4cmVPsIetyWjhdryYEkjftgPs+l4um/KGh4vbkzhn0GTh0ulCLQ9Qpl9JjQgQxUTStQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707388765; c=relaxed/simple;
	bh=uuZUc5/bStUBBFvA6FpAi/msK+Mtr2MZzsPpEsU0W0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qGbYcrRHTpHIGpB+ilzQmfRtIZ211sOIgv6ttuHDMS3zJRBndeZePl5sgFEY/JfLKqDo0k8/mGrk4qBKUIGSHrEuBkhg1amKgsF7BrQDG/V+37/hu75Kt88g48IoM5w6w0gUYlvfXMHauXcBq+eFjTvFQ+oIzHQDQi4QzGZYlIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=14.140.155.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: JUXvMWBuNUUlufPqTdUUCNu/a+SoloYiq+G0CHjUqa1fCicCecUaZPj/eDBdgNNq7Gslq5F5od
 RgWYTo4LxrJg==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa2.ltts.com with ESMTP; 08 Feb 2024 16:09:19 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: lee@kernel.org
Cc: bhargav.r@ltts.com,
	linux-kernel@vger.kernel.org,
	m.nirmaladevi@ltts.com
Subject: Re :  Re: [PATCH v1 00/13]  Add support for TI TPS65224 PMIC
Date: Thu,  8 Feb 2024 16:08:53 +0530
Message-Id: <20240208103853.1212108-1-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240208101912.GD689448@google.com>
References: <20240208101912.GD689448@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On Thu 2/8/2024 3:49 PM, Lee Jones wrote:
> On Thu, 08 Feb 2024, Bhargav Raviprakash wrote:
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
> > Bhargav Raviprakash (10):
> >   mfd: tps6594: use volatile_table instead of volatile_reg
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
> 
> How did you send this set?
> 
> Any idea how it ended up in 3 separate threads?
> 
> Tracking this set is going to cause issues.
> 
> Also, please send all patches to all maintainers.
>

Thanks for the feedback.
I will resend all the patches to all maintainers. While sending I did not do this,
this might have caused the patch-set to end up in three different threads.

> > Nirmala Devi Mal Nadar (3):
> >   mfd: tps6594: Add register definitions for TI TPS65224 PMIC
> >   regulator: tps6594-regulator: Add TI TPS65224 PMIC regulators
> >   pinctrl: pinctrl-tps6594: Add TPS65224 PMIC pinctrl and GPIO
> > 
> >  .../devicetree/bindings/mfd/ti,tps6594.yaml   |   1 +
> >  arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       |  95 +++++
> >  drivers/mfd/tps6594-core.c                    | 258 ++++++++++++-
> >  drivers/mfd/tps6594-i2c.c                     |  20 +-
> >  drivers/mfd/tps6594-spi.c                     |  18 +-
> >  drivers/misc/tps6594-esm.c                    |  89 +++--
> >  drivers/misc/tps6594-pfsm.c                   |  55 ++-
> >  drivers/pinctrl/pinctrl-tps6594.c             | 287 ++++++++++++--
> >  drivers/regulator/Kconfig                     |   4 +-
> >  drivers/regulator/tps6594-regulator.c         | 244 ++++++++++--
> >  include/linux/mfd/tps6594.h                   | 358 +++++++++++++++++-
> >  11 files changed, 1272 insertions(+), 157 deletions(-)
> > 
> > 
> > base-commit: 2863b714f3ad0a9686f2de1b779228ad8c7a8052
> > -- 
> > 2.25.1
> > 
> 
> -- 
> Lee Jones [李琼斯]

Regards,
Bhargav


Return-Path: <linux-kernel+bounces-12468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416CB81F52F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C59A2823ED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 06:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A2D3D72;
	Thu, 28 Dec 2023 06:53:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7948063AB;
	Thu, 28 Dec 2023 06:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id CE72724DBFD;
	Thu, 28 Dec 2023 14:53:30 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 28 Dec
 2023 14:53:30 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 28 Dec
 2023 14:53:25 +0800
From: Alex Soo <yuklin.soo@starfivetech.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter
	<adrian.hunter@intel.com>, Yangtao Li <frank.li@vivo.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Linus Walleij
	<linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>, "Paul
 Walmsley" <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alex Soo <yuklin.soo@starfivetech.com>
Subject: [PATCH 0/3] Add driver for Cadence SD6HC SD/eMMC controller
Date: Thu, 28 Dec 2023 14:53:19 +0800
Message-ID: <20231228065322.1176351-1-yuklin.soo@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

Starfive JH8100 SoC consists of a Cadence SD/eMMC host controller
(Version 6) with Combo PHY which provides DFI interface to SD/eMMC
removable or embedded devices. This patch adds initial SD/eMMC support
for JH8100 SoC by providing device drivers for Cadence SD/eMMC Version 6
host controller and Combo PHY.  This patch series is depending on the
JH8100 base patch series in [1], [2], and [3].
The relevant dt-bindings documentation has been updated accordingly.

[1] https://lore.kernel.org/lkml/20231201121410.95298-1-jeeheng.sia@starf=
ivetech.com/
[2] https://lore.kernel.org/lkml/20231206115000.295825-1-jeeheng.sia@star=
fivetech.com/
[3] https://lore.kernel.org/lkml/20231221083622.3445726-1-yuklin.soo@star=
fivetech.com/=20

Alex Soo (3):
  dt-bindings: mmc: sdhci-cadence6: add DT bindings documentation
  mmc: sdhci-cadence6: add Cadence SD6HC support
  riscv: dts: starfive: jh8100: Add SD/eMMC device tree nodes

 .../devicetree/bindings/mmc/cdns,sd6hci.yaml  |  65 +++
 MAINTAINERS                                   |   6 +
 arch/riscv/boot/dts/starfive/jh8100.dtsi      |  34 ++
 drivers/mmc/host/Kconfig                      |  11 +
 drivers/mmc/host/Makefile                     |   2 +
 drivers/mmc/host/sdhci-cadence6-phy.c         | 384 +++++++++++++
 drivers/mmc/host/sdhci-cadence6.c             | 531 ++++++++++++++++++
 drivers/mmc/host/sdhci-cadence6.h             | 148 +++++
 8 files changed, 1181 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/cdns,sd6hci.yam=
l
 create mode 100644 drivers/mmc/host/sdhci-cadence6-phy.c
 create mode 100644 drivers/mmc/host/sdhci-cadence6.c
 create mode 100644 drivers/mmc/host/sdhci-cadence6.h

--=20
2.25.1



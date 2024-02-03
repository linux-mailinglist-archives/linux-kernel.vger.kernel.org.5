Return-Path: <linux-kernel+bounces-50774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 747A1847DC7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDDEF1F27D06
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18E180A;
	Sat,  3 Feb 2024 00:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="nVoSGtgI"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD2D622;
	Sat,  3 Feb 2024 00:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706920143; cv=none; b=USxwAAgScTkOrZCfYXj19w31kmdc189iZbH2KcWOzjwNHuL+DhcpfJtixd2fiQTEEjPHOnR2cRqouIL6YSG/jkF22NWeCNE3wc6mmrInPpXxcqOUGvb2GOyvWldbE9WS6Fkmge3w3grUq8CAKwL8a4jd3il2W29YA+JzcdzdEjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706920143; c=relaxed/simple;
	bh=6IQ2jaFQHup3JsKNrVAd3gd6vlUrscEJfijinF/hldk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j/jOnqCRUJdjOdqTGrp9OZHXrwG20HR3jedV1EPh3BO7v9FcAl77T2i7jvmGHaDhLnk5I8qoeebsJAgSba/6xFJg8rbmG75kE2xUjCoB+SULbMGjV7aNeGA2eBI2g7/xo63nWmrB2/K82QCAJAmD2JyWGnmZhjwS5Gg98LH57HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=nVoSGtgI; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 4E384C001668;
	Fri,  2 Feb 2024 16:28:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 4E384C001668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1706920135;
	bh=6IQ2jaFQHup3JsKNrVAd3gd6vlUrscEJfijinF/hldk=;
	h=From:To:Cc:Subject:Date:From;
	b=nVoSGtgI+VGLYpVsku7u3qKIEEu4jKfcDFkG2JnJsn4rlXIIN5mS1AfXg8E8LcarT
	 Q/0Df0cBhKderf+SST47yI3qWo1UUUtqD5TILU0ZZ31pgGC4Tju4NJCRKOCSjWWc0V
	 IHcwbKjELiKVZxpvTXPlpbQrFaEoB2G3AbhtaSzk=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.173.232.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id C3D4A18041CAC4;
	Fri,  2 Feb 2024 16:28:53 -0800 (PST)
From: William Zhang <william.zhang@broadcom.com>
To: Linux MTD List <linux-mtd@lists.infradead.org>,
	Linux ARM List <linux-arm-kernel@lists.infradead.org>,
	Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc: f.fainelli@gmail.com,
	kursad.oney@broadcom.com,
	joel.peshkin@broadcom.com,
	anand.gore@broadcom.com,
	dregan@mail.com,
	kamal.dasu@broadcom.com,
	tomer.yacoby@broadcom.com,
	dan.beygelman@broadcom.com,
	William Zhang <william.zhang@broadcom.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Kamal Dasu <kdasu.kdev@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Shawn Guo <shawnguo@kernel.org>,
	David Regan <dregan@broadcom.com>,
	devicetree@vger.kernel.org,
	Alexandre TORGUE <alexandre.torgue@st.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Brian Norris <computersforpeace@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH v4 00/12] dt-bindings: mtd: brcmnand: Updates for bcmbca SoCs
Date: Fri,  2 Feb 2024 16:28:21 -0800
Message-Id: <20240203002834.171462-1-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series is an update from the previous version [1] after
exex_op support and fixes (patch 1 to 4 from the previous version.)

It updates all the BCMBCA SoC to support the nand controller and add
functions to handle BCMBCA specific needs on ECC and Write Protection
usage. The device tree document is also updated accordingly with the new
properties needed by the driver.

In addition there is a bug fix for exec_op helper functions and log
level adjustment on uncorrectable ECC error.

[1] https://lore.kernel.org/lkml/20230606231252.94838-1-william.zhang@broadcom.com/

Changes in v4:
- Split the yaml changes into three patches.
- Move the WP pin property to a new patch and change it to boolean type.
- Move ecc strap property to a new patch and remove some non-binding 
related text from the description
- Add a new patch for bcm4908 based router board dts update
- Move the board related dts setting from SoC dtsi to board dts
- Update the comments for ecc setting selection
- Use the new brcm,wp-not-connected property based on the dts binding
change
- Fix the commit id in the fixes tag
- Revert the log level change for correctable ecc error

Changes in v3:
- Update brcm,nand-use-wp description
- Revert the description change to BCM63168 SoC-specific NAND controller
- Updated bcmbca_read_data_bus comment

Changes in v2:
- Revert the new compatible string nand-bcmbca
- Drop the BCM63168 compatible fix to avoid any potential ABI
Incompatibility issue
- Simplify the explanation for brcm,nand-use-wp
- Keep the interrupt name requirement when interrupt number is specified
- Add nand controller node label for 4908 so it is consistent with other
SoC's and can be referenced by board dts file
- Drop the is_param argument to the read data bus function now that we
have the exec_op API to read the parameter page and ONFI data
- Minor cosmetic fixes
- Added patches 8, 9, 10 to patch series

David Regan (2):
  mtd: rawnand: brcmnand: exec_op helper functions return type fixes
  mtd: rawnand: brcmnand: update log level messages

William Zhang (10):
  dt-bindings: mtd: brcmnand: Updates for bcmbca SoCs
  dt-bindings: mtd: brcmnand: Add WP pin connection property
  dt-bindings: mtd: brcmnand: Add ecc strap property
  ARM: dts: broadcom: bcmbca: Add NAND controller node
  arm64: dts: broadcom: bcmbca: Add NAND controller node
  arm64: dts: broadcom: bcmbca: Update router boards
  mtd: rawnand: brcmnand: Rename bcm63138 nand driver
  mtd: rawnand: brcmnand: Add BCMBCA read data bus interface
  mtd: rawnand: brcmnand: Add support for getting ecc setting from strap
  mtd: rawnand: brcmnand: Support write protection setting from dts

 .../bindings/mtd/brcm,brcmnand.yaml           |  29 +++-
 arch/arm/boot/dts/broadcom/bcm47622.dtsi      |  14 ++
 arch/arm/boot/dts/broadcom/bcm63138.dtsi      |   7 +-
 arch/arm/boot/dts/broadcom/bcm63148.dtsi      |  14 ++
 arch/arm/boot/dts/broadcom/bcm63178.dtsi      |  14 ++
 arch/arm/boot/dts/broadcom/bcm6756.dtsi       |  14 ++
 arch/arm/boot/dts/broadcom/bcm6846.dtsi       |  14 ++
 arch/arm/boot/dts/broadcom/bcm6855.dtsi       |  14 ++
 arch/arm/boot/dts/broadcom/bcm6878.dtsi       |  14 ++
 arch/arm/boot/dts/broadcom/bcm947622.dts      |  10 ++
 arch/arm/boot/dts/broadcom/bcm963138.dts      |  10 ++
 arch/arm/boot/dts/broadcom/bcm963138dvt.dts   |  14 +-
 arch/arm/boot/dts/broadcom/bcm963148.dts      |  10 ++
 arch/arm/boot/dts/broadcom/bcm963178.dts      |  10 ++
 arch/arm/boot/dts/broadcom/bcm96756.dts       |  10 ++
 arch/arm/boot/dts/broadcom/bcm96846.dts       |  10 ++
 arch/arm/boot/dts/broadcom/bcm96855.dts       |  10 ++
 arch/arm/boot/dts/broadcom/bcm96878.dts       |  10 ++
 .../bcmbca/bcm4906-netgear-r8000p.dts         |   5 +
 .../bcmbca/bcm4906-tplink-archer-c2300-v1.dts |   5 +
 .../bcmbca/bcm4908-asus-gt-ac5300.dts         |   6 +-
 .../boot/dts/broadcom/bcmbca/bcm4908.dtsi     |   4 +-
 .../boot/dts/broadcom/bcmbca/bcm4912.dtsi     |  14 ++
 .../boot/dts/broadcom/bcmbca/bcm63146.dtsi    |  14 ++
 .../boot/dts/broadcom/bcmbca/bcm63158.dtsi    |  14 ++
 .../boot/dts/broadcom/bcmbca/bcm6813.dtsi     |  14 ++
 .../boot/dts/broadcom/bcmbca/bcm6856.dtsi     |  14 ++
 .../boot/dts/broadcom/bcmbca/bcm6858.dtsi     |  14 ++
 .../boot/dts/broadcom/bcmbca/bcm94908.dts     |  10 ++
 .../boot/dts/broadcom/bcmbca/bcm94912.dts     |  10 ++
 .../boot/dts/broadcom/bcmbca/bcm963146.dts    |  10 ++
 .../boot/dts/broadcom/bcmbca/bcm963158.dts    |  10 ++
 .../boot/dts/broadcom/bcmbca/bcm96813.dts     |  10 ++
 .../boot/dts/broadcom/bcmbca/bcm96856.dts     |  10 ++
 .../boot/dts/broadcom/bcmbca/bcm96858.dts     |  10 ++
 drivers/mtd/nand/raw/brcmnand/Makefile        |   2 +-
 drivers/mtd/nand/raw/brcmnand/bcm63138_nand.c |  99 --------------
 drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c   | 126 ++++++++++++++++++
 drivers/mtd/nand/raw/brcmnand/brcmnand.c      | 126 +++++++++++++++---
 drivers/mtd/nand/raw/brcmnand/brcmnand.h      |   2 +
 40 files changed, 623 insertions(+), 134 deletions(-)
 delete mode 100644 drivers/mtd/nand/raw/brcmnand/bcm63138_nand.c
 create mode 100644 drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c

-- 
2.37.3



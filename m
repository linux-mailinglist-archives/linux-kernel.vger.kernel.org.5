Return-Path: <linux-kernel+bounces-36380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BC9839FDD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D971F21F36
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D2553A1;
	Wed, 24 Jan 2024 03:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HkemFHKl"
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644F946B4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706065533; cv=none; b=WVJRgFQiZXk95AhEeyIAuwfZVfv+tJ6tMtnvNpMPaw814BHe/W2UVLUUQp/nF2/UOpwrLc2nxRDVQF3Lujvvi0GbqS1s/dzJ9nM8ri6xmEHJL4P2lq1aEHpMUSgl44zfSFB90F6buv4/TdwhBtm0vwBL4cZt+JNZ3alHok80/wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706065533; c=relaxed/simple;
	bh=WI45SXsWFu1Ah06uFE4I5T18exvgsHj2sXehHkmuaw8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=nQGUbcGFnAuhLJT07isgjt2+ue05LscSlF1vVA7zztBgth9UE39h691Uf54bHFHgBjjEx8NmTeoqTKkoZYUaXGEAKiLOHd9uXozmV7k8NiXyAJQXbVE/BWcdz3Y/4mA1yJc55xStjxea9lZUxj73TAT6A8oKMJ8CkC/g7+NJDH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HkemFHKl; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-214917ed35aso637851fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706065530; x=1706670330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=H7KxdgIABAQGBD38+JxvgSmrGDmsE+8Sj0czftnrUzU=;
        b=HkemFHKlB1lJ08CrqcMC0TI72q71SQwTS2ob/uCxO5vTxDCV/APy9AvN9JFQJ+b8hN
         1yqymrDqck3bIuUMw6NamvgMRGYASw0NevHhdO0jpjrqS8a3uUlG1l1TLsYo4WirCmuo
         80qrk3UP5/DKXeBM9Ar/EVvZuHljdSDjl35ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706065530; x=1706670330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7KxdgIABAQGBD38+JxvgSmrGDmsE+8Sj0czftnrUzU=;
        b=i3X+Lp+8Tb15Qz6FChORwc7/u41SbZuoFAfIJ3M1OuE4qiXq5O0dJSkJkWNUPyVckt
         vPsiK728b2dVpoGhREwitWr+69mu8iyxuHTiJJRcgeKfjTm8pLZY+bgNA0hpVbgfSPYG
         L0s40h5cyy7UOfW6zrOTDCLaN5C+fC46eXEnHGeHLJywHkxaqwvhhkitr9z8PiRxyKxH
         1vZVGQrBYpH4mMvobNhucY/0GhgIyNoZHkJTgZ/8ZcEw0XoME9jviZzbQbgA7dwU8jMO
         tlW/R/+541PuNNgHJZdLArDcKhZ9308z4/0muLmp5s2ESImzfpirzduw5F8a8VLws9C4
         +IJA==
X-Gm-Message-State: AOJu0YwK7XBU/N7c1e1nBFpxwAdg1Oj/shLAUwAqiCCBc42kuSf6aUku
	Kf60Q9TvrYEz5EfvjvUkV6Bob9go8tiVTDpjgBReYjvaC9cpyu2GLndlyaIaljG5a+Uox/Z5sIR
	sElfVMIQ3/qQbmXAYRm5zz2AgMdaZZA==
X-Google-Smtp-Source: AGHT+IEJxubg1f0YZ0+rItm2W/njIh4Ow/SOhAglwE4uM77J3dRR0uKAb7I+RPN4THEmri6Sp3Ho+paKfgBN
X-Received: by 2002:a05:6871:b07:b0:210:9789:7457 with SMTP id fq7-20020a0568710b0700b0021097897457mr2828052oab.99.1706065530407;
        Tue, 23 Jan 2024 19:05:30 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp-relay.gmail.com with ESMTPS id c22-20020a056830349600b006dc7502beabsm455320otu.3.2024.01.23.19.05.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2024 19:05:30 -0800 (PST)
X-Relaying-Domain: broadcom.com
From: David Regan <dregan@broadcom.com>
To: dregan@broadcom.com,
	dregan@mail.com,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	computersforpeace@gmail.com,
	kdasu.kdev@gmail.com,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joel.peshkin@broadcom.com,
	tomer.yacoby@broadcom.com,
	dan.beygelman@broadcom.com,
	william.zhang@broadcom.com,
	anand.gore@broadcom.com,
	kursad.oney@broadcom.com,
	florian.fainelli@broadcom.com,
	rafal@milecki.pl,
	bcm-kernel-feedback-list@broadcom.com,
	andre.przywara@arm.com,
	baruch@tkos.co.il,
	linux-arm-kernel@lists.infradead.org,
	dan.carpenter@linaro.org
Subject: [PATCH v3 00/10] mtd: rawnand: brcmnand: driver and doc updates
Date: Tue, 23 Jan 2024 19:04:48 -0800
Message-Id: <20240124030458.98408-1-dregan@broadcom.com>
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

In addition there is a bug fix for exec_op helper functions and on-die ECC.

[1] https://lore.kernel.org/lkml/20230606231252.94838-1-william.zhang@broadcom.com/

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

William Zhang (7):
  dt-bindings: mtd: brcmnand: Updates for bcmbca SoCs
  ARM: dts: broadcom: bcmbca: Add NAND controller node
  arm64: dts: broadcom: bcmbca: Add NAND controller node
  mtd: rawnand: brcmnand: Rename bcm63138 nand driver
  mtd: rawnand: brcmnand: Add BCMBCA read data bus interface
  mtd: rawnand: brcmnand: Add support for getting ecc setting from strap
  mtd: rawnand: brcmnand: Support write protection setting from dts

David Regan (3):
  mtd: rawnand: brcmnand: exec_op helper functions return type fixes
  mtd: rawnand: brcmnand: update log level messages
  mtd: rawnand: brcmnand: allow for on-die ecc

 .../bindings/mtd/brcm,brcmnand.yaml           |  37 ++++-
 arch/arm/boot/dts/broadcom/bcm47622.dtsi      |  17 ++
 arch/arm/boot/dts/broadcom/bcm63138.dtsi      |  10 +-
 arch/arm/boot/dts/broadcom/bcm63148.dtsi      |  17 ++
 arch/arm/boot/dts/broadcom/bcm63178.dtsi      |  17 ++
 arch/arm/boot/dts/broadcom/bcm6756.dtsi       |  17 ++
 arch/arm/boot/dts/broadcom/bcm6846.dtsi       |  17 ++
 arch/arm/boot/dts/broadcom/bcm6855.dtsi       |  17 ++
 arch/arm/boot/dts/broadcom/bcm6878.dtsi       |  17 ++
 arch/arm/boot/dts/broadcom/bcm947622.dts      |   4 +
 arch/arm/boot/dts/broadcom/bcm963138.dts      |   4 +
 arch/arm/boot/dts/broadcom/bcm963138dvt.dts   |  12 +-
 arch/arm/boot/dts/broadcom/bcm963148.dts      |   4 +
 arch/arm/boot/dts/broadcom/bcm963178.dts      |   4 +
 arch/arm/boot/dts/broadcom/bcm96756.dts       |   4 +
 arch/arm/boot/dts/broadcom/bcm96846.dts       |   4 +
 arch/arm/boot/dts/broadcom/bcm96855.dts       |   4 +
 arch/arm/boot/dts/broadcom/bcm96878.dts       |   4 +
 .../boot/dts/broadcom/bcmbca/bcm4908.dtsi     |   5 +-
 .../boot/dts/broadcom/bcmbca/bcm4912.dtsi     |  17 ++
 .../boot/dts/broadcom/bcmbca/bcm63146.dtsi    |  17 ++
 .../boot/dts/broadcom/bcmbca/bcm63158.dtsi    |  17 ++
 .../boot/dts/broadcom/bcmbca/bcm6813.dtsi     |  17 ++
 .../boot/dts/broadcom/bcmbca/bcm6856.dtsi     |  17 ++
 .../boot/dts/broadcom/bcmbca/bcm6858.dtsi     |  17 ++
 .../boot/dts/broadcom/bcmbca/bcm94912.dts     |   4 +
 .../boot/dts/broadcom/bcmbca/bcm963146.dts    |   4 +
 .../boot/dts/broadcom/bcmbca/bcm963158.dts    |   4 +
 .../boot/dts/broadcom/bcmbca/bcm96813.dts     |   4 +
 .../boot/dts/broadcom/bcmbca/bcm96856.dts     |   4 +
 .../boot/dts/broadcom/bcmbca/bcm96858.dts     |   4 +
 drivers/mtd/nand/raw/brcmnand/Makefile        |   2 +-
 drivers/mtd/nand/raw/brcmnand/bcm63138_nand.c |  99 ------------
 drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c   | 126 +++++++++++++++
 drivers/mtd/nand/raw/brcmnand/brcmnand.c      | 146 +++++++++++++++---
 drivers/mtd/nand/raw/brcmnand/brcmnand.h      |   2 +
 36 files changed, 578 insertions(+), 138 deletions(-)
 delete mode 100644 drivers/mtd/nand/raw/brcmnand/bcm63138_nand.c
 create mode 100644 drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c

-- 
2.37.3



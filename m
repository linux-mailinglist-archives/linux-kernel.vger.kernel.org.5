Return-Path: <linux-kernel+bounces-30531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D92D831FF9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04F421F23B54
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BFB2E642;
	Thu, 18 Jan 2024 19:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fB3++jEZ"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22D42E620
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705607665; cv=none; b=RXiyV+xR5fbRUOaqyFNnhLI1LHZPXvHFKbLGXNj5SzX5qUJ45igQyacD5dD4ms4hQ/QjYPBotY91gWPnKyZBIuLBrJrs1zvYTltyW6A5mdTcWEuosyNI93uxyBl3YC/aNiOOHoj5QM+ItHf+64XUO+lLV/4Ox/Y43pISvxbAo34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705607665; c=relaxed/simple;
	bh=lwmGzM8D/DsKOwpziwD+eg4vluIE54Sx00TNVz8Fat8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=sungf0kWyWrrJxGS91RxgVwhQ4NxyU5P8mr04DnuZpEbQeRpDMD7kZ2KknYYn4OtOyrJji33nAueR7GrqIHL8wIaJa3M7T7REztuxdMoPMnJYT6NcASBhmoWVKo55TYZ/CXx+9zhSvwgZbmOMiV8zEusSNgT6retbqmLvxv67Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fB3++jEZ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5cdfed46372so25203a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1705607663; x=1706212463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IFnqHhzfXfGsBcGKTh6i/IxLQyyEDg67xxlpXPYw8NY=;
        b=fB3++jEZzDJp++BlZC2kzStHE7WPci0AhC+q1aiFkQmpj7NpfxIgiRAsBa1vCVQUr4
         f9URWh+h3FjQa97wkgogSbgNOmKXolTuH4s95Tel9iT5oR1yTjOml1J3Y6Aa2pcdb+ge
         0Cl/+kt2eazLBvjQFkCPWk17wvfUAuVieLJ2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705607663; x=1706212463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IFnqHhzfXfGsBcGKTh6i/IxLQyyEDg67xxlpXPYw8NY=;
        b=OYn2yGdSboxrti9KhEU9DWsYCl3EUQm+dXnNW2dXCWC2HL0wq15g2hXuk3zBXfl3QA
         qcX7lbGjWcjO1G+DaTdROuY8F/YrJTNKigZVHPA1nzGAITUMtxqfQhMAwlCfpqDOy+uU
         IdGUIQaDaq030chqfKmTbpzKaedHKNrkf5XEa0EomXQLEILcTil3HNhEv5Kqy1bnx97k
         AlFVSPoVD7ciG9zFx0504zL+97MCkbuJ67xW0T2QFkWEybJ9juKkIdAnyJqCXDMImwUx
         xp4viKuvLcDVKZDIDjqTb3t5GEUOZnXuruam/rkW2PGKUWqdyNnBbjRj8Eu6zDwED2nP
         3Quw==
X-Gm-Message-State: AOJu0YzBGB7EPHTzcMnQsjp6HlvdUWLQ4vqmHgy4magyksMtk/fcBgfb
	Y5J+v8qZL7nkScuMI8Vq4vEMeHDfLKLHbtgh0DYQP4mcKhSnW0dwLGinm29h0w==
X-Google-Smtp-Source: AGHT+IFLcvCL/9hqBlYEM8zweYTHrBmeLTcHJFleUdviSh98eTvEiqMjeYkNEnRyXIECSfhyc563Ow==
X-Received: by 2002:a17:90b:1107:b0:290:26d:acef with SMTP id gi7-20020a17090b110700b00290026dacefmr1200568pjb.38.1705607663026;
        Thu, 18 Jan 2024 11:54:23 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id rr12-20020a17090b2b4c00b0028d9b5d41edsm2263805pjb.38.2024.01.18.11.54.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2024 11:54:22 -0800 (PST)
From: dregan@broadcom.com
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
Subject: [PATCH v2 00/10] mtd: rawnand: brcmnand: driver and doc updates
Date: Thu, 18 Jan 2024 11:53:46 -0800
Message-Id: <20240118195356.133391-1-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Regan <dregan@broadcom.com>

This patch series is an update from the previous version [1] after
exex_op support and fixes (patch 1 to 4 from the previous version.)

It updates all the BCMBCA SoC to support the nand controller and add
functions to handle BCMBCA specific needs on ECC and Write Protection
usage. The device tree document is also updated accordingly with the new
properties needed by the driver.

In addition there is a bug fix for exec_op helper functions and on-die ECC.

[1] https://lore.kernel.org/lkml/20230606231252.94838-1-william.zhang@broadcom.com/

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

../bindings/mtd/brcm,brcmnand.yaml           |  36 ++++-
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
 36 files changed, 576 insertions(+), 139 deletions(-)
 delete mode 100644 drivers/mtd/nand/raw/brcmnand/bcm63138_nand.c
 create mode 100644 drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c

-- 
2.37.3



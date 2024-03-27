Return-Path: <linux-kernel+bounces-120687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0086388DB77
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95FE71F28D07
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A924952F91;
	Wed, 27 Mar 2024 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcIj3Gx1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24A6225D9;
	Wed, 27 Mar 2024 10:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711536292; cv=none; b=TO1zgNbdeVLsRXXWSZ3QJAo7/OffaS1H6TddtbZgcQrya+v3NfWFyA07an4C0Kc0ANRsujUh8va6+Uhkuaviy7hXAEtZ+Fox26TtmE3++rhH+MpMZLi6Wsm5FLlqqfu4/hxUl0+vbLgT5q5Tz44f7hpb3qxayIFw6KQXHnstoIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711536292; c=relaxed/simple;
	bh=5LDshXlu0PfiuyoM4qYt8E3ozT2zpeM2FAiCZBLBCNs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mWZ0TwLyDcHlGFT4gZE35b9xVNafT8Lu9uypMu9T9SqjBQouufX3wkeEVbapuizoK3e3yrTASXzh/eboXv0LQ7S4WFII44eax/1xH3xZgT+LUXEog2D8P5KLzuMhjGE3RQs8JGxSAwMaZyJi1ti3bsxvRIUMN8PFQ2jI2dGNjvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcIj3Gx1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AC9AC433C7;
	Wed, 27 Mar 2024 10:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711536291;
	bh=5LDshXlu0PfiuyoM4qYt8E3ozT2zpeM2FAiCZBLBCNs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=YcIj3Gx1N7OWP4vqM44BuQyumKsHRw6KseVbyAmED9ONAHzDYw/If8qCmwVIgm3t7
	 6s+BW6eutu/q6ksvVSX/clWxXSRPvZgfsPFurLBbOIJ2KJqG6LqA02wH8+gDaTcLet
	 a2vysw7wwWEqAjb7gs/Q/GwtzXtFGSjlheWsclE1zcNMCsIlQoP9dNQhUqpdTwczXu
	 io2bJFX2uCmSSZrrxPlYZgmf+SL8NM8f6wFd/1SmeC8OWJ/oXjLxI1M/7fVeoQN1T0
	 gjKNn1guYI+tg2MQ/qVuj7IjUG+qx74T0iai8lBTWyJbE3S5nNx/9GbE+q0bNbobFq
	 00pAfb5uSHVgA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8813CCD11DF;
	Wed, 27 Mar 2024 10:44:51 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Subject: [PATCH v6 0/3] Add support for Loongson-1 NAND
Date: Wed, 27 Mar 2024 18:43:58 +0800
Message-Id: <20240327-loongson1-nand-v6-0-7f9311cef020@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG74A2YC/zWNyw7CIBBFf6WZtUN4VLCu/A/jgpSBElswoMbY9
 N9FEzc3OYt7zgqVSqQKx26FQs9YY04N9K6DcbIpEEbXGCSXPVdC45xzCjUngckmh8NBSeOMIe4
 1tNOtkI+vn/B8aexLXvA+FbJ/jeD7trKXQjEzcIMCrxQercXe3+IpLDbObMwLbNsHP9fsmqAAA
 AA=
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, devicetree@vger.kernel.org, 
 Keguang Zhang <keguang.zhang@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711536289; l=2068;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=5LDshXlu0PfiuyoM4qYt8E3ozT2zpeM2FAiCZBLBCNs=;
 b=3RTvOkvFiswtfYQcWbIvcSER2itdIL0AeQVtEs/e5MrHwNDzLk5E+H6/2S30psHNXdtb6+jed
 pv25qL0eBUqAmGtwVhy5+Sj4Dx+dqMpuibTVWD+W7vTe++nIoskh5DK
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com

Add the driver and dt-binding document for Loongson-1 NAND.
And modify nand_read_subpage() to allow subpage read by a single operation.

Changes in v6:
- Amend Kconfig
- Add the dt-binding document
- Modify nand_read_subpage() to allow subpage read by a single operation
- Add DT support for driver
- Use DT data instead of platform data
- Remove MAX_ID_SIZE
- Remove case NAND_OP_CMD_INSTR in ls1x_nand_set_controller()
- Move ECC configuration to ls1x_nand_attach_chip()
- Rename variable "nand" to "ls1x"
- Rename variable "nc" to "nfc"
- Some minor fixes
- Link to v5: https://lore.kernel.org/all/20210520224213.7907-1-keguang.zhang@gmail.com

Changes in v5:
- Update the driver to fit the raw NAND framework.
- Implement exec_op() instead of legacy cmdfunc().
- Use dma_request_chan() instead of dma_request_channel().
- Some minor fixes and cleanups.

Changes in v4:
- Retrieve the controller from nand_hw_control.

Changes in v3:
- Replace __raw_readl/__raw_writel with readl/writel.
- Split ls1x_nand into two structures:
ls1x_nand_chip and ls1x_nand_controller.

Changes in v2:
- Modify the dependency in Kconfig due to the changes of DMA module.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
Keguang Zhang (3):
      dt-bindings: mtd: Add Loongson-1 NAND Controller
      mtd: rawnand: Enable monolithic read when reading subpages
      mtd: rawnand: Add Loongson-1 NAND Controller driver

 .../devicetree/bindings/mtd/loongson,ls1x-nfc.yaml |  66 ++
 drivers/mtd/nand/raw/Kconfig                       |   7 +
 drivers/mtd/nand/raw/Makefile                      |   1 +
 drivers/mtd/nand/raw/loongson1_nand.c              | 748 +++++++++++++++++++++
 drivers/mtd/nand/raw/nand_base.c                   |   5 +-
 include/linux/mtd/rawnand.h                        |   5 +
 6 files changed, 830 insertions(+), 2 deletions(-)
---
base-commit: 084c8e315db34b59d38d06e684b1a0dd07d30287
change-id: 20240316-loongson1-nand-98327d77e0f6

Best regards,
-- 
Keguang Zhang <keguang.zhang@gmail.com>




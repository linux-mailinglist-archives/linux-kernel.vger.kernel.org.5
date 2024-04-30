Return-Path: <linux-kernel+bounces-163828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1B68B72C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F4F51C21B41
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A913912DD91;
	Tue, 30 Apr 2024 11:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/+3JsSU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCCD12D20F;
	Tue, 30 Apr 2024 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475493; cv=none; b=nL0lKCTP8Iia3TSyf25ON7lvYuVVPiJDPxCqY8IVQUA0a09ju7WkNKSYzG5Gs9Zeb1qCV9ufvnfjTBxlA+aJSLd8hZeJ9dsLfX04oW+OvOGhfCV+3/GMQnzvkytNLNJGtl8CTzK2cjy3rxhn4W9W9247Et6A1BURvoqxyQnhwN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475493; c=relaxed/simple;
	bh=OEZfaxKF5ZU2ktXmlXA2zI10IqUQ7mPBu+B5L+gYq0U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a8qSGte0vXl8JYwPZiVd5rHl9gB9O+vUfcK//ekLc+pJjXcKbKZfFDaeDliIF/xNWcqFLyNw77J2+EJdW2/EGcD5JOBmKlxb6Hzs//rNLE539E23IgwDVxZPdNIehfHccxh50aL8ozcJKu8bj8mT7JjBqRD6yTpA5JRbo5RU8VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/+3JsSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 935B6C4AF19;
	Tue, 30 Apr 2024 11:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714475493;
	bh=OEZfaxKF5ZU2ktXmlXA2zI10IqUQ7mPBu+B5L+gYq0U=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=D/+3JsSU0ZQe9OSr8IWr+cPr6CkXLFAUYNYtgJfbLcYh3AA86hKZ+yKbekrEh2SO6
	 7HQ1PFkYANdVWbfnNdXnsxkEgETUrDOsScMOENfHxuLZIcRPpRtGyrzarEIDC3KfnS
	 3JAXcvv7tjbG1IxyC2IBA7VxtkSy9uYr4Hu1bAuO93xYHaF9fvfBWq9RvTRQJJiXE8
	 guicSscxoZKjjeuziQQ0klih8DNnYIoo1ttaWYpSMq3sEFi+ebupX6U7AYJq+JyXm+
	 4UP/oLqR1nbtzVEsHss79Tn5zCEpwip168GtFfR1tazMY10Pr1SuSwJoEa8ceASmVh
	 OZLDN08lowNCg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82412C10F16;
	Tue, 30 Apr 2024 11:11:33 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Subject: [PATCH v7 0/3] Add support for Loongson-1 NAND
Date: Tue, 30 Apr 2024 19:11:09 +0800
Message-Id: <20240430-loongson1-nand-v7-0-60787c314fa4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM7RMGYC/12OzQ6CMBAGX8X07JL+YCuefA/DoYFtaYTWtEhUw
 rtbiCbGyyZz2PlmJgmjw0ROu5lEnFxywWdQ+x1pOu0tgmszE055SQWT0IfgbQqegde+heoouGq
 VQmokyU+3iMY9NuGlzmxiGGDsIuqvhtFDvrzkTBSqogoYXNHe81bxWhfPdtCuL5owrL7OpTHE5
 9Y3ydX6SeHqP2WSQEGZSjDWoKGc/pjqZVnemPQfiOwAAAA=
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, devicetree@vger.kernel.org, 
 Keguang Zhang <keguang.zhang@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714475491; l=2270;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=OEZfaxKF5ZU2ktXmlXA2zI10IqUQ7mPBu+B5L+gYq0U=;
 b=hwxNWFMKDlRXils8CJGuEeMePaS3aFaXpabooj7K3FH22BhA6kh2hIorxi51q3NMwq6ZjXOZY
 Kewg6Zw9t+vD2GXqyqj6rBUhb0xqT6M9rAKI5XP95b17Bx/XHjlcrfg
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com

Add the driver and dt-binding document for Loongson-1 NAND.
And modify nand_read_subpage() to allow subpage read by a single operation.

Changes in v7:
- Rename the file to loongson,ls1b-nfc.yaml
- Rename the dependency to LOONGSON1_APB_DMA
- Link to v6: https://lore.kernel.org/r/20240327-loongson1-nand-v6-0-7f9311cef020@gmail.com

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

 .../devicetree/bindings/mtd/loongson,ls1b-nfc.yaml |  66 ++
 drivers/mtd/nand/raw/Kconfig                       |   7 +
 drivers/mtd/nand/raw/Makefile                      |   1 +
 drivers/mtd/nand/raw/loongson1_nand.c              | 748 +++++++++++++++++++++
 drivers/mtd/nand/raw/nand_base.c                   |   5 +-
 include/linux/mtd/rawnand.h                        |   5 +
 6 files changed, 830 insertions(+), 2 deletions(-)
---
base-commit: d04466706db5e241ee026f17b5f920e50dee26b5
change-id: 20240316-loongson1-nand-98327d77e0f6

Best regards,
-- 
Keguang Zhang <keguang.zhang@gmail.com>




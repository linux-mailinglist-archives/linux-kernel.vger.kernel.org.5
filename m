Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3242C7C6B1C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377780AbjJLK3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343654AbjJLK3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:29:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5B1B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:29:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C60CC433C8;
        Thu, 12 Oct 2023 10:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697106551;
        bh=pUW2UZ0iy4cmzd6/+KDXWEa/Dy0ELBQNtzS85l2Lunk=;
        h=From:To:Cc:Subject:Date:From;
        b=brE3CEeTWq27Cqw8KEMugSZoqYW30hCkl4n/stfchAv4ITSXMFJSE8EKQRRAjCFrn
         AdOD0ZDpihTgzC9V36GYQ23NrFGDm186yigFclM080X2lmXPpu73yTJOCX3rAzbmBQ
         l1dLuvqQjCAGHodCUUS6ezGo9yVtSX1IpTTySYLGav7LZkrRo3q9CJfd9UQzvl02SL
         z7CJvRM4J0+Mtz6iKKAn0Vkniv80Rgt41ZvAdzMMyb3hubChs9OS7W0od5/E/A6/8R
         /ejjo5niRARbD4QXsCST7aVe8ZeTeYpy5vs0/OzMeDSBg/iSPe2yQJuaFSDhEwK3Lv
         SNnXAAoc66RIg==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Gabriel Somlo <somlo@cmu.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Alistair Francis <alistair.francis@wdc.com>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
Subject: [PATCH v2] riscv, qemu_fw_cfg: Add support for RISC-V architecture
Date:   Thu, 12 Oct 2023 12:28:52 +0200
Message-Id: <20231012102852.234442-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

Qemu fw_cfg support was missing for RISC-V, which made it hard to do
proper vmcore dumps from qemu.

Add the missing RISC-V arch-defines.

You can now do vmcore dumps from qemu. Add "-device vmcoreinfo" to the
qemu command-line. From the qemu monitor:
  (qemu) dump-guest-memory vmcore

The vmcore can now be used, e.g., with the "crash" utility.

Acked-by: "Michael S. Tsirkin" <mst@redhat.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Clément Léger <cleger@rivosinc.com>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
v2: Fixed typo (Clément)
    ...and collected A-b/T-bs
---
 drivers/firmware/Kconfig       | 2 +-
 drivers/firmware/qemu_fw_cfg.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b59e3041fd62..f05ff56629b3 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -155,7 +155,7 @@ config RASPBERRYPI_FIRMWARE
 
 config FW_CFG_SYSFS
 	tristate "QEMU fw_cfg device support in sysfs"
-	depends on SYSFS && (ARM || ARM64 || PARISC || PPC_PMAC || SPARC || X86)
+	depends on SYSFS && (ARM || ARM64 || PARISC || PPC_PMAC || RISCV || SPARC || X86)
 	depends on HAS_IOPORT_MAP
 	default n
 	help
diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index a69399a6b7c0..1448f61173b3 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -211,7 +211,7 @@ static void fw_cfg_io_cleanup(void)
 
 /* arch-specific ctrl & data register offsets are not available in ACPI, DT */
 #if !(defined(FW_CFG_CTRL_OFF) && defined(FW_CFG_DATA_OFF))
-# if (defined(CONFIG_ARM) || defined(CONFIG_ARM64))
+# if (defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_RISCV))
 #  define FW_CFG_CTRL_OFF 0x08
 #  define FW_CFG_DATA_OFF 0x00
 #  define FW_CFG_DMA_OFF 0x10

base-commit: 1c8b86a3799f7e5be903c3f49fcdaee29fd385b5
-- 
2.39.2


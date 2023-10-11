Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE387C526A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344784AbjJKLrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbjJKLr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:47:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74F398
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:47:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073EAC433C9;
        Wed, 11 Oct 2023 11:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697024848;
        bh=5eol+w9isDPPTceO0nec+Q5JC7nAOskqOPXHsIAf75Q=;
        h=From:To:Cc:Subject:Date:From;
        b=rn63VAU0/bWUAp3lCxWWpkSw9gd9a42ATMVADGPkaClKeM6rE5K2L3RtE0+uAMYeS
         8tu7jbJSDzs+gLhP+5LZK8j8Gg4F8Zr4jd2pf1PuhaPXprA9XeS6lu5f/Kd20pxWTg
         qc5D1dnzOnztti8h0IlLDHg52+bahm8Edro1oexxTO5TnwfqWAbL8wMybH7HVghNXB
         2v/XkKWu1P9WLthhCx5fxuV55ZKZZUflHJypPLIg/WT/62a/6c2Tume2Yc8hcl00S6
         ptFuxGkq6EEdNl3n7SW7ygbHETur+TiHQXsOpzFXjkkqLpfLjKJmHDms62y6rfV3ts
         7BAeo8HCGH/5A==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Gabriel Somlo <somlo@cmu.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH] riscv, qemu_fw_cfg: Add support for RISC-V architecture
Date:   Wed, 11 Oct 2023 13:47:21 +0200
Message-Id: <20231011114721.193732-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
qemu command-line. From the qemu montior:
  (qemu) dump-guest-memory vmcore

The vmcore can now be used, e.g., with the "crash" utility.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF7780DDF9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 23:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345533AbjLKWGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345457AbjLKWGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:06:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7E3AF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:06:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1BCC433C7;
        Mon, 11 Dec 2023 22:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702332415;
        bh=GJIc4lcmbnE1QNCXgfA52Krp47pye0PnIUxJw5mQkV0=;
        h=From:To:Cc:Subject:Date:From;
        b=SjoP21CtsyjRX/8L/C9NP2DGApb80nFM3iwiEe07Hd5Klq1nOOWjh4xrzXMbUK7b+
         vrwfsu6sZ3PjzOBMug0mPszLIth6elZoHiPnAueSpvBBDx84+RczDfkzUktL28RVX6
         DQocX8a3Wm+NX9jHFzNoBivFvtOEOIFABAXJrlKGipBKxLXKmKbkjWIqcvDrqxNYdm
         H3ljXrIuRxfFqgUc/H17di/S+0yfi7DGWStIXYZ8cibdk6Jd0CyTG7wP8IUY3PiVbQ
         RbZ5V/hHLmTrAXXv2CI+N0bTRFTSnuquLRs52r4uv/ecnjIEK3kBuGhSd9JRObgO5u
         BOpT77Gj8zMNg==
From:   Conor Dooley <conor@kernel.org>
To:     linux-riscv@lists.infradead.org
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] soc: renesas: make ARCH_R9A07G043 depend on !DMA_DIRECT_REMAP
Date:   Mon, 11 Dec 2023 22:06:36 +0000
Message-Id: <20231211-primate-arbitrate-fbcd307a0b00@spud>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1934; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=QZakA2jngPjyPv1mx6ddYU3DUAgBXMmCEkYM0tqgkJ0=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKnl7a82avC45SVsOHSnMmD9kqi39+oOv/E4eGLKiSyF7 VN/TtBY21HKwiDGwSArpsiSeLuvRWr9H5cdzj1vYeawMoEMYeDiFICJPNRk+KfM9DVladJpqQ75 m0teZL07tsT4/tX4e0/S9Rbr6P7c0VjI8D/TrVIzd+K13GU5e46oLdrQJREb+yKi8eFNtiuPHyq XpTMDAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Randy reported yet another build issue with randconfigs on rv32:
WARNING: unmet direct dependencies detected for DMA_GLOBAL_POOL
  Depends on [n]: !ARCH_HAS_DMA_SET_UNCACHED [=n] && !DMA_DIRECT_REMAP [=y]
  Selected by [y]:
  - ARCH_R9A07G043 [=y] && SOC_RENESAS [=y] && RISCV [=y] && NONPORTABLE [=y] && RISCV_ALTERNATIVE [=y] && !RISCV_ISA_ZICBOM [=n] && RISCV_SBI [=y]

This happens when DMA_DIRECT_REMAP is selected by the T-Head CMO erratum
option and DMA_GLOBAL_POOL is selected by the Andes CMO erratum. Block
selecting the RZ/Five config option, and by extension DMA_GLOBAL_POOL,
if DMA_DIRECT_REMAP has already been enabled.

Fixes: 484861e09f3e ("soc: renesas: Kconfig: Select the required configs for RZ/Five SoC")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Closes: https://lore.kernel.org/all/24942b4d-d16a-463f-b39a-f9dfcb89d742@infradead.org/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
I don't know what the exact fixes tag here is as I did not bisect with
the randconfig, so I blamed the one that added DMA_GLOBAL_POOL.

CC: Geert Uytterhoeven <geert+renesas@glider.be>
CC: Magnus Damm <magnus.damm@gmail.com>
CC: Conor Dooley <conor.dooley@microchip.com>
CC: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: linux-renesas-soc@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 drivers/soc/renesas/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 0071864c2111..0986672f6375 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -340,6 +340,7 @@ if RISCV
 config ARCH_R9A07G043
 	bool "RISC-V Platform support for RZ/Five"
 	depends on NONPORTABLE
+	depends on !DMA_DIRECT_REMAP
 	depends on RISCV_ALTERNATIVE
 	depends on !RISCV_ISA_ZICBOM
 	depends on RISCV_SBI
-- 
2.39.2


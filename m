Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100BC7B8371
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbjJDPVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbjJDPVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:21:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1C7BF;
        Wed,  4 Oct 2023 08:21:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714F4C433C8;
        Wed,  4 Oct 2023 15:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696432873;
        bh=BR+PVMz/ReRBIlT1fOhImOYNK5ZWPSxCh5WYYcVu/ys=;
        h=From:To:Cc:Subject:Date:From;
        b=Chh7oeJ+A4mln+ikBhojpHDOIhJBfLVXn5Ws6cF1qsi1LuJhWKt/H7zp4KUGfv5aH
         YKMR9ORLbYksk1FP9WZZhXKgAdFi4hNuEq5rAZ54KOAtbsXqdMc67AbjSA1LjWeHL7
         RuUViLrYsPxjUFx6ewqpeTIXS0RNvGaS8WwAdxXRiCi6RKDBhdlSBGuIPXoxWdXWd1
         WosubUYRotDeRfR0r8ekOLw7Q4NSQ6JlSEbrLb/NTb5bTJ9YssmeBVLu9e1tVDlVld
         tCNRqw7X+vWOMQ14fHTv7mcQghtrG8ql6dTzkgZiVpSzlnKoUGutzwuFjKzqzpFqmj
         bSvA3bz3Hgrqw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH] soc: renesas: make ARCH_R9A07G043 (riscv version) depend on NONPORTABLE
Date:   Wed,  4 Oct 2023 23:08:56 +0800
Message-Id: <20231004150856.2540-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
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

Drew found "CONFIG_DMA_GLOBAL_POOL=y causes ADMA buffer alloc to fail"
the log looks like:
[    3.741083] mmc0: Unable to allocate ADMA buffers - falling back to standard DMA

The logic is: generic riscv defconfig selects ARCH_RENESAS then
ARCH_R9A07G043 which selects DMA_GLOBAL_POOL, which assumes all
non-dma-coherent riscv platforms have a dma global pool, this assumption
seems not correct. And I believe DMA_GLOBAL_POOL should not be
selected by ARCH_SOCFAMILIY, instead, only ARCH under some specific
conditions can select it globaly, for example NOMMU ARM and so on,
because it's designed for special cases such as "nommu cases where
non-cacheable memory lives in a fixed place in the physical address
map" as pointed out by Robin.

Fix the issue by making ARCH_R9A07G043 (riscv version) depend on
NONPORTABLE, thus generic defconfig won't select ARCH_R9A07G043 by
default. And even for random config case, there will be less debug
effort once we see NONPORTABLE is enabled.

Reported-by: Drew Fustini <dfustini@baylibre.com>
Closes: https://lore.kernel.org/linux-riscv/ZRuamJuShOnvP1pr@x1/
Fixes: 484861e09f3e ("soc: renesas: Kconfig: Select the required configs for RZ/Five SoC")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/soc/renesas/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 5a75ab64d1ed..12040ce116a5 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -333,6 +333,7 @@ if RISCV
 
 config ARCH_R9A07G043
 	bool "RISC-V Platform support for RZ/Five"
+	depends on NONPORTABLE
 	select ARCH_RZG2L
 	select AX45MP_L2_CACHE if RISCV_DMA_NONCOHERENT
 	select DMA_GLOBAL_POOL
-- 
2.40.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058C37C6BF7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378101AbjJLLLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347144AbjJLLLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:11:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCD390;
        Thu, 12 Oct 2023 04:11:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B8CC433C9;
        Thu, 12 Oct 2023 11:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697109092;
        bh=EwQiuwFbaomZXmqROHOgDtEVeRGwSi1MJ7v1qwvt4U8=;
        h=From:To:Cc:Subject:Date:From;
        b=TDW/XJtLTjapueGdc6tOzLelydwQawimtJHdTy4w646oMoHw5hB+qJiH/TL5Zt+M7
         4l2v6s56C7T7GlYiiDhiPvlSsAlRyywEaIETaNK4UWuPMLtmQuEKDfPEwOqh8HcLc7
         Y8NG5AaDZXtIu4/DyIMKe5amcwegPH1yRGNWCl6MiO80UJpRMmLgWp14m1lcOqoN+W
         m/G0ZiWYhzWOxz7z1MwN6Ob/3v8gZd+GnNzUGWN847DgDUzPPH3R66npcpngsLZfHt
         3Nog6y3nQIFkA6A9GIunPY+CKXhgNKzujFx8PnQa/ckwim4/c6uEFYDHmoglRO6bcH
         14VcnT4FJaSxg==
From:   Conor Dooley <conor@kernel.org>
To:     linux-renesas-soc@vger.kernel.org
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v2] soc: renesas: make ARCH_R9A07G043 depend on required options
Date:   Thu, 12 Oct 2023 12:04:28 +0100
Message-Id: <20231012-pouch-parkway-7d26c04b3300@spud>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2727; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=/uJK29z5MEJs0TMvy3aTBY0JfPs/7EpvP/EZ3xWqtiI=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKnql3ZJMAgc4KjPf30teJfwLK76hmsr5inOelbaaLqIU z+0u2BzRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACbi/5bhf5F3dgxb0Nq/906w c4RM11GfvD3e7SNPkPmWuS5OmZeExRgZXn65kqwy8/iutZstK19bc0meOfBDVHiLm//k6M7pP8r fMgIA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
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

From: Conor Dooley <conor.dooley@microchip.com>

Randy reported a randconfig build issue against linux-next:
WARNING: unmet direct dependencies detected for ERRATA_ANDES
  Depends on [n]: RISCV_ALTERNATIVE [=n] && RISCV_SBI [=y]
  Selected by [y]:
  - ARCH_R9A07G043 [=y] && SOC_RENESAS [=y] && RISCV [=y] && NONPORTABLE [=y] && RISCV_SBI [=y]

../arch/riscv/errata/andes/errata.c:59:54: warning: 'struct alt_entry' declared inside parameter list will not be visible outside of this definition or declaration
   59 | void __init_or_module andes_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,

On RISC-V, alternatives are not usable in XIP kernels, which this
randconfig happened to select. Rather than add a check for whether
alternatives are available before selecting the ERRATA_ANDES config
option, rework the R9A07G043 Kconfig entry to depend on the
configuration options required to support its non-standard cache
coherency implementation.

Without these options enabled, the SoC is effectively non-functional to
begin with, so there's an extra benefit in preventing the creation of
non-functional kernels.

The "if RISCV_DMA_NONCOHERENT" can be dropped, as ERRATA_ANDES_CMO will
select it.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/all/09a6b0f0-76a1-45e3-ab52-329c47393d1d@infradead.org/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---

I dropped Randy's t-b etc since this patch is quite different.

v2: drop the extra condition on the select of ERRATA_ANDES, move instead
to depending on required options.

CC: Geert Uytterhoeven <geert+renesas@glider.be>
CC: Magnus Damm <magnus.damm@gmail.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Albert Ou <aou@eecs.berkeley.edu>
CC: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: linux-renesas-soc@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-riscv@lists.infradead.org
---
 drivers/soc/renesas/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 7b74de732718..adedf02897c6 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -340,10 +340,12 @@ if RISCV
 config ARCH_R9A07G043
 	bool "RISC-V Platform support for RZ/Five"
 	depends on NONPORTABLE
+	depends on RISCV_ALTERNATIVE
+	depends on RISCV_SBI
 	select ARCH_RZG2L
-	select AX45MP_L2_CACHE if RISCV_DMA_NONCOHERENT
+	select AX45MP_L2_CACHE
 	select DMA_GLOBAL_POOL
-	select ERRATA_ANDES if RISCV_SBI
+	select ERRATA_ANDES
 	select ERRATA_ANDES_CMO if ERRATA_ANDES
 	help
 	  This enables support for the Renesas RZ/Five SoC.
-- 
2.39.2


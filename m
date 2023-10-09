Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DD77BD4EC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345478AbjJIIMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345456AbjJIIMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:12:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2288F;
        Mon,  9 Oct 2023 01:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1696839119; x=1728375119;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E3CND1oVozdmN9W0JejJjJ0D+lE+Z95291t40RDveyk=;
  b=IsbnsBfDgceyolx7raRGKE4jpJadyisFDgZ3mtNac5D9BJT/UaiWiVOF
   RElloLwiPr6VFTVzNggzdJY43wgEnzDz7p0Eqph7zqjrJyQdprZZyrk4I
   i6vXEQWQEkZuyp2rm1BG5pDYTE2Fp0eDitM5KZB34WlKA+k0rxWWhJtDo
   XZJBvCXOYZ/WLreOCsUWT+616DuArUiNYjM/paf6kKJMBLeT2lgteh40i
   li33ZqGoDbkiFdIMP+9xZOiFj/jBl7SOpQsgAGAHlnQbtbc/nyBzRGjFY
   S/qUBovkZ/SB2o10Qg18vos9HseWXazKd9vn8+4URBAvcSWH9iQYm+YOZ
   g==;
X-CSE-ConnectionGUID: XpXTSLP4Ty6wgcE8HJnZgw==
X-CSE-MsgGUID: yVezVkv5TO2viORuFs6tnw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="9261218"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2023 01:11:48 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 9 Oct 2023 01:11:47 -0700
Received: from wendy.microchip.com (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 9 Oct 2023 01:11:44 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <linux-renesas-soc@vger.kernel.org>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Magnus Damm" <magnus.damm@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH] soc: renesas: select ERRATA_ANDES for R9A07G043 only when alternatives are present
Date:   Mon, 9 Oct 2023 09:11:16 +0100
Message-ID: <20231009-sandbar-botch-0f398fd2e289@wendy>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2092; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=E3CND1oVozdmN9W0JejJjJ0D+lE+Z95291t40RDveyk=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKnKWxdas1qKH/XSOb61bOl0g6X/+VtfGpRu+1zZzRZ8eHLs XIPtHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjIjXRGhiadnbuvN0UoHa+p3dK8Om +5MPdH/h3CKgHam3+nuj0un87wvy4039TNcUHL6SjF8Nh7SeIxv6rXy/sxJqzr3zaV90ESCwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy reported a randconfig build issue against linux-next:
WARNING: unmet direct dependencies detected for ERRATA_ANDES
  Depends on [n]: RISCV_ALTERNATIVE [=n] && RISCV_SBI [=y]
  Selected by [y]:
  - ARCH_R9A07G043 [=y] && SOC_RENESAS [=y] && RISCV [=y] && NONPORTABLE [=y] && RISCV_SBI [=y]

../arch/riscv/errata/andes/errata.c:59:54: warning: 'struct alt_entry' declared inside parameter list will not be visible outside of this definition or declaration
   59 | void __init_or_module andes_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,

On RISC-V, alternatives are not usable in XIP kernels, which this
randconfig happened to select. Add a check for whether alternatives are
available before selecting the ERRATA_ANDES config option.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/all/09a6b0f0-76a1-45e3-ab52-329c47393d1d@infradead.org/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
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
 drivers/soc/renesas/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 7b74de732718..a97bf8e897cd 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -343,7 +343,7 @@ config ARCH_R9A07G043
 	select ARCH_RZG2L
 	select AX45MP_L2_CACHE if RISCV_DMA_NONCOHERENT
 	select DMA_GLOBAL_POOL
-	select ERRATA_ANDES if RISCV_SBI
+	select ERRATA_ANDES if (RISCV_SBI && RISCV_ALTERNATIVE)
 	select ERRATA_ANDES_CMO if ERRATA_ANDES
 	help
 	  This enables support for the Renesas RZ/Five SoC.
-- 
2.40.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE3A79C840
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjILHgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjILHgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:36:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E69E73
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:36:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA49C433C7;
        Tue, 12 Sep 2023 07:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694504173;
        bh=NEBCs0obZ/Zb3TNso8vqG2Frf4fuv/wh7I2pZQ8DKS0=;
        h=From:To:Cc:Subject:Date:From;
        b=g3oyoBfGxbLRWsS9qGBEirOD91LnZvsQhdoc/VuVTmra+dcBJaraJ568IV4ZX+bld
         DKm6qi/sRIKg5T6gMOlfYGfIbZ56gpVO5uBsM2eQ+IA87+jzQFDM0ZBIVT25SJ7s/8
         2LLQDs7pVB42q8MXA/9Hsw6VUvkQhNyoy0Y2hPui1eUMl96csq36Xx/8I1kuOcFP8R
         OF54GqJgjTHkjGPvB9mxPy8oI4s1njA/Epr+hsZx47n5lK6z1svkNEYvedNNkcC6JE
         j5KKHK1b6xwnoqcEFuEk53QuQXzT78K54NU7jTfCZ5p/4aYhHwEsCcjvv6yfvt+d8q
         oC4ZedOXBmUAQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Icenowy Zheng <uwu@icenowy.me>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH v3] riscv: errata: fix T-Head dcache.cva encoding
Date:   Tue, 12 Sep 2023 15:24:10 +0800
Message-Id: <20230912072410.2481-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <uwu@icenowy.me>

The dcache.cva encoding shown in the comments are wrong, it's for
dcache.cval1 (which is restricted to L1) instead.

Fix this in the comment and in the hardcoded instruction.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Tested-by: Sergey Matyukevich <sergey.matyukevich@syntacore.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Guo Ren <guoren@kernel.org>
Tested-by: Drew Fustini <dfustini@baylibre.com>
---

This is a renew of Icenowy patch series[1], patch1 is necessary to
make T-Head C910 powered SoCs CMO work correctly.

Link: https://lore.kernel.org/linux-riscv/20230103062610.69704-1-uwu@icenowy.me/ [1]

Since v2:
  - rebase on linux 6.6-rc1
  - collect Tested-by tag
  - remove patch2 since I want patch1 to be applied as fix for
    linux-6.6. patch2 will be sent separately.

Since v1:
  - rebase on linux 6.5-rc7
  - collect Reviewed-by tag


 arch/riscv/include/asm/errata_list.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index e2ecd01bfac7..b55b434f0059 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -105,7 +105,7 @@ asm volatile(ALTERNATIVE(						\
  * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
  *   0000001    01001      rs1       000      00000  0001011
  * dcache.cva rs1 (clean, virtual address)
- *   0000001    00100      rs1       000      00000  0001011
+ *   0000001    00101      rs1       000      00000  0001011
  *
  * dcache.cipa rs1 (clean then invalidate, physical address)
  * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
@@ -118,7 +118,7 @@ asm volatile(ALTERNATIVE(						\
  *   0000000    11001     00000      000      00000  0001011
  */
 #define THEAD_inval_A0	".long 0x0265000b"
-#define THEAD_clean_A0	".long 0x0245000b"
+#define THEAD_clean_A0	".long 0x0255000b"
 #define THEAD_flush_A0	".long 0x0275000b"
 #define THEAD_SYNC_S	".long 0x0190000b"
 
-- 
2.40.1


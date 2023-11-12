Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BD77E8EB2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 07:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjKLGSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 01:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjKLGRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 01:17:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A023A87
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 22:17:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAE4C433C9;
        Sun, 12 Nov 2023 06:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699769831;
        bh=xvz1rya1E02xCfXGsQlwgCTl+atNWzPl7o+rS0iSLkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fBDFivBo3T7J24ZloTMhISNIG/bND0s7vrrL2C1z8x/tqG8opLe99Kjlqlz3jI79y
         uhVNHaWLH1ArFXGXJEiub688pP0XTpJCHrrhV2xUf6gEw2MjHITF02A1OGHKPSvyMm
         gNV7Nk3ktsoNitWRPxry1/3uJKsYM9LO/fesvwLysYBUXJAdctqslxu60+Xi3YOeZG
         Nz4hNdgyJbdNDW+icuW/5mS5/HQq4rq8O/X2y7OsxXv5Ro6gNIRmAyXqNN58djw1sI
         PbAF/PpwCCzWVyeqctUo5NQ6CWFpLrSM5VNtrKLDVlU2i4CyPLVAQfVkRd+2tI6xaF
         ABhUyCTRybIjg==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, conor.dooley@microchip.com, heiko@sntech.de,
        apatel@ventanamicro.com, atishp@atishpatra.org, bjorn@kernel.org,
        paul.walmsley@sifive.com, anup@brainfault.org, jiawei@iscas.ac.cn,
        liweiwei@iscas.ac.cn, wefu@redhat.com, U2FsdGVkX1@gmail.com,
        wangjunqiang@iscas.ac.cn, kito.cheng@sifive.com,
        andy.chiu@sifive.com, vincent.chen@sifive.com,
        greentime.hu@sifive.com, wuwei2016@iscas.ac.cn, jrtc27@jrtc27.com,
        luto@kernel.org, fweimer@redhat.com, catalin.marinas@arm.com,
        hjl.tools@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH V2 17/38] riscv: s64ilp32: Adjust TASK_SIZE for s64ilp32 kernel
Date:   Sun, 12 Nov 2023 01:14:53 -0500
Message-Id: <20231112061514.2306187-18-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231112061514.2306187-1-guoren@kernel.org>
References: <20231112061514.2306187-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Guo Ren <guoren@linux.alibaba.com>

The RV64ILP32 32-bit Linux kernel uses the same userspace address range
as the 64-bit Linux compat mode, about 2GB. They have no difference from
the hardware view, and all are running ILP32 on a 64-bit ISA. But the
standard 32ilp32 Linux has a slightly bigger userspace address space,
about 2.4GB.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/pgtable.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 75970ee2bda2..e5e7a929949a 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -839,20 +839,25 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
  * "load and store effective addresses, which are 64bits, must have bits
  * 63–48 all equal to bit 47, or else a page-fault exception will occur."
  */
+#define TASK_SIZE_32	(_AC(0x80000000, UL) - PAGE_SIZE)
+
 #ifdef CONFIG_64BIT
 #define TASK_SIZE_64	(PGDIR_SIZE * PTRS_PER_PGD / 2)
 #define TASK_SIZE_MIN	(PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
 
 #ifdef CONFIG_COMPAT
-#define TASK_SIZE_32	(_AC(0x80000000, UL) - PAGE_SIZE)
 #define TASK_SIZE	(test_thread_flag(TIF_32BIT) ? \
 			 TASK_SIZE_32 : TASK_SIZE_64)
 #else
 #define TASK_SIZE	TASK_SIZE_64
 #endif
 
+#else
+#ifdef CONFIG_ARCH_RV64ILP32
+#define TASK_SIZE	TASK_SIZE_32
 #else
 #define TASK_SIZE	FIXADDR_START
+#endif
 #define TASK_SIZE_MIN	TASK_SIZE
 #endif
 
-- 
2.36.1


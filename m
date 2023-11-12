Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BB37E8EAB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 07:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjKLGRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 01:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjKLGRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 01:17:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EF730EA
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 22:16:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1329EC433C7;
        Sun, 12 Nov 2023 06:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699769819;
        bh=qenSRo414Gnjw+wPdqdNQw1NfHZPaPnw9rVg2h6yowQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GW5NoU+InHnAHzio8lhZKosW6whn3JdHi4Q/dDOScdYFN7QjZKPUKXXs98dTQuw5h
         45fW+a6Y1YPCVIa5T3cobF6lQUZPjawcP2Rzn99jvtgGE2vyakm09BCpPlZb+f/Wpq
         V7/4h6YGJTPwA6oP6a40o0SLfLK1XOhj0GOTCKell0jihsJuECN2NX8iPeKiTVDdC3
         Cuu39HlcRospB1qSF0c6582N41+vi7tkSLS1EraM9vhN/CiwbKNoyOwJUVU4DgYCVt
         boYhSj6vK3kQM6iBLcEMiNPReyKIpaZOH1WO1KMsffukC32HjUXV4rWj7RpgPeJVkF
         64h+bIhWZynBQ==
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
Subject: [RFC PATCH V2 15/38] riscv: s64ilp32: Add asid support
Date:   Sun, 12 Nov 2023 01:14:51 -0500
Message-Id: <20231112061514.2306187-16-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231112061514.2306187-1-guoren@kernel.org>
References: <20231112061514.2306187-1-guoren@kernel.org>
MIME-Version: 1.0
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

The s32ilp32 uses 9 bits as asid_bits because of the xlen=32
limitation of CSR. The xlen of s64ilp32 is 64 bits in width, and
the SATP CSR format is the same for Sv32, Sv39, Sv48, and Sv57. So
this patch makes asid mechanism support s64ilp32 with maximum
num_asids.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/tlbflush.h |  2 +-
 arch/riscv/mm/context.c           | 16 ++++++++++------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index a09196f8de68..6793c3f835a0 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -12,7 +12,7 @@
 #include <asm/errata_list.h>
 
 #ifdef CONFIG_MMU
-extern unsigned long asid_mask;
+extern xlen_t asid_mask;
 
 static inline void local_flush_tlb_all(void)
 {
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 12e22e7330e7..9eab9aa87dc6 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -20,9 +20,9 @@
 
 DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
 
-static unsigned long asid_bits;
+static xlen_t asid_bits;
 static unsigned long num_asids;
-unsigned long asid_mask;
+xlen_t asid_mask;
 
 static atomic_long_t current_version;
 
@@ -227,14 +227,18 @@ static inline void set_mm(struct mm_struct *prev,
 
 static int __init asids_init(void)
 {
-	unsigned long old;
+	xlen_t old;
 
 	/* Figure-out number of ASID bits in HW */
 	old = csr_read(CSR_SATP);
 	asid_bits = old | (SATP_ASID_MASK << SATP_ASID_SHIFT);
 	csr_write(CSR_SATP, asid_bits);
 	asid_bits = (csr_read(CSR_SATP) >> SATP_ASID_SHIFT)  & SATP_ASID_MASK;
-	asid_bits = fls_long(asid_bits);
+#if __riscv_xlen == 64
+	asid_bits = fls64(asid_bits);
+#else
+	asid_bits = fls(asid_bits);
+#endif
 	csr_write(CSR_SATP, old);
 
 	/*
@@ -267,9 +271,9 @@ static int __init asids_init(void)
 		static_branch_enable(&use_asid_allocator);
 
 		pr_info("ASID allocator using %lu bits (%lu entries)\n",
-			asid_bits, num_asids);
+			(ulong)asid_bits, num_asids);
 	} else {
-		pr_info("ASID allocator disabled (%lu bits)\n", asid_bits);
+		pr_info("ASID allocator disabled (%lu bits)\n", (ulong)asid_bits);
 	}
 
 	return 0;
-- 
2.36.1


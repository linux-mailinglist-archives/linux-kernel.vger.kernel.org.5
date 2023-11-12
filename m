Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31E37E8EBE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 07:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjKLGSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 01:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjKLGSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 01:18:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D2349E8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 22:17:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A01C433D9;
        Sun, 12 Nov 2023 06:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699769867;
        bh=DJd0JPnD4tdXPL2F5/pVMn7+3pGHc/BdFV5e1StNJ0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u3mYKvvVcCXgok8Svx8v4kF7mGHdEIkfptFpvN3AkwLdtO3ntnvI1tFetv8IzkGud
         QsqcEzsuLOpPvYOMq//OcMmUt1bX8nDoBgAPmTAQ3RWqjuHAZ6Dde0eSs6C2/y+VxI
         PDCLedfjiu12dGTFD/L2dYd544DJHkuziYtfgdvNe+TXgj8RPvV5f8jK6eJT4fAhxf
         aqzzh/LVK8k8ktL94w2cpBMh0gvgCZ0CJTHTeQQHWNyUaWzvHLESSAINDdDCvDxL1V
         uaLDgFyGRBaolDP18QX6VtyYB/IDSyturZGmHAbMRjanSPG5ujOcv/4DT0ZxwCN0zU
         kKb1zgIB6qstA==
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
Subject: [RFC PATCH V2 23/38] riscv: s64ilp32: Enable native atomic64
Date:   Sun, 12 Nov 2023 01:14:59 -0500
Message-Id: <20231112061514.2306187-24-guoren@kernel.org>
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

The traditional rv32 Linux (s32ilp32) uses a generic version of the
lib/atomic64.c, which are inaccurate atomic64 primitives and couldn't
co-work with READ_ONCE/WRITE_ONCE,  atomic_8/16/32. The s64ilp32 could
use native AMO instructions to implement accurate atomic64 primitives.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig              | 2 +-
 arch/riscv/include/asm/atomic.h | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index f364d2436b1d..0fc03aa076e6 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -65,7 +65,7 @@ config RISCV
 	select CPU_PM if CPU_IDLE || HIBERNATION
 	select EDAC_SUPPORT
 	select GENERIC_ARCH_TOPOLOGY
-	select GENERIC_ATOMIC64 if !64BIT
+	select GENERIC_ATOMIC64 if ARCH_RV32I
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_ENTRY
diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index f5dfef6c2153..8f6579b33ecc 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -16,6 +16,12 @@
 # endif
 #endif
 
+#ifdef CONFIG_ARCH_RV64ILP32
+typedef struct {
+	s64 counter;
+} atomic64_t;
+#endif
+
 #include <asm/cmpxchg.h>
 #include <asm/barrier.h>
 
-- 
2.36.1


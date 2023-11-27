Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FB67F9D98
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjK0Kcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbjK0Kcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:32:45 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5FDE1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:32:51 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50aab20e828so5764250e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701081170; x=1701685970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlWvEkOns6bxM9iRll9a5EQf2qEz96P+1R1KRbDkkn8=;
        b=iPsOo0xfotl+oYMGstYFj+BqF+SaRQTvd9D8SFWpGP62fwk9yKjPzLh9N6aO+sc39K
         CWIFsjQksqwr6OU7fNO65lMcMqdikApBWfTggDuzsM5x9g6jnctuKQ2isbMPhI34r+bl
         Q5cPnGJ6zXfGE0Y3A/QgznQE8DHQj2d81jM0trXjCpnUvdGOiQKPmqlZdBDr9T3uoNj0
         HV3k3IeJ8ai+k94DAn9cWFUqntRzTlsFC7OTVyXAZh6ntJc/a8oX6yshKBWSSBKNSrqj
         eCNwJO1Ae/iiHJJ7NdX1+8G2INd4621oWtcq3HcwzIt0hcLzGfqJrt26O9T79/7m3MNt
         Qzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701081170; x=1701685970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlWvEkOns6bxM9iRll9a5EQf2qEz96P+1R1KRbDkkn8=;
        b=SOpqElASBSCwe0x+2Cm/Jdv7/2r+3aWjB+OKMukATiqQxUirU6iDUNxPMksP8o2+kY
         ztW9Zie0G5e0e9z2sEXfUZ3VFeBM493Q95vrKz1x4VdHvGUMgxvWzLRDgrZXqIgKrIql
         CH6k+aApv/EVoVetDMXbk11JDpKgQm6jYUQFgEx7K4dlpU81LZZR+bPuE8aHxa747toT
         wLrMreTW0Lgv1/ZmUjIfm6c3AzXVIbEWahLrAEEoEU/kyO7Baw4P0Vi3FF3mqA3SfU25
         F6Gs6F8j/yqPh3Z+lAbeYxuJ4i5ZCqh2RTKkTFXtlAz0A9lJ2hy+aSyffKYDZ59ZejNn
         lYZQ==
X-Gm-Message-State: AOJu0YzOUVIaWlIu4+VMRMXz0pP7dFkif9h35azzsgFgJpUid868SUn/
        GCZ99CR3fnBPFx1eFGZFBc8=
X-Google-Smtp-Source: AGHT+IEmtc6uvQGHjQLB9+xWuIWqr4VYfYT2cWLzoUOI6Ju7O3zk6InUUChkFS9o9nkpyFuwYTm+lw==
X-Received: by 2002:a05:6512:3903:b0:500:9f7b:e6a4 with SMTP id a3-20020a056512390300b005009f7be6a4mr5841895lfu.32.1701081169590;
        Mon, 27 Nov 2023 02:32:49 -0800 (PST)
Received: from andrea.wind3.hub ([31.189.63.178])
        by smtp.gmail.com with ESMTPSA id p5-20020a056402044500b00540ea3a25e6sm5142057edw.72.2023.11.27.02.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 02:32:49 -0800 (PST)
From:   Andrea Parri <parri.andrea@gmail.com>
To:     mathieu.desnoyers@efficios.com, paulmck@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     mmaas@google.com, hboehm@google.com, striker@us.ibm.com,
        charlie@rivosinc.com, rehn@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH 2/2] membarrier: riscv: Provide core serializing command
Date:   Mon, 27 Nov 2023 11:32:35 +0100
Message-Id: <20231127103235.28442-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127103235.28442-1-parri.andrea@gmail.com>
References: <20231127103235.28442-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RISC-V uses xRET instructions on return from interrupt and to go back
to user-space; the xRET instruction is not core serializing.

Use FENCE.I for providing core serialization as follows:

 - by calling sync_core_before_usermode() on return from interrupt (cf.
   ipi_sync_core()),

 - via switch_mm() and sync_core_before_usermode() (respectively, for
   uthread->uthread and kthread->uthread transitions) to go back to
   user-space.

On RISC-V, the serialization in switch_mm() is activated by resetting
the icache_stale_mask of the mm at prepare_sync_core_cmd().

Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Suggested-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 .../membarrier-sync-core/arch-support.txt     |  2 +-
 arch/riscv/Kconfig                            |  3 ++
 arch/riscv/include/asm/sync_core.h            | 29 +++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/sync_core.h

diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
index d96b778b87ed8..f6f0bd871a578 100644
--- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
+++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
@@ -43,7 +43,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
-    |       riscv: | TODO |
+    |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 95a2a06acc6a6..3e2734a3f2957 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -27,14 +27,17 @@ config RISCV
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_MMIOWB
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API
+	select ARCH_HAS_PREPARE_SYNC_CORE_CMD
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_DIRECT_MAP if MMU
 	select ARCH_HAS_SET_MEMORY if MMU
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_STRICT_MODULE_RWX if MMU && !XIP_KERNEL
+	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
diff --git a/arch/riscv/include/asm/sync_core.h b/arch/riscv/include/asm/sync_core.h
new file mode 100644
index 0000000000000..9153016da8f14
--- /dev/null
+++ b/arch/riscv/include/asm/sync_core.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_SYNC_CORE_H
+#define _ASM_RISCV_SYNC_CORE_H
+
+/*
+ * RISC-V implements return to user-space through an xRET instruction,
+ * which is not core serializing.
+ */
+static inline void sync_core_before_usermode(void)
+{
+	asm volatile ("fence.i" ::: "memory");
+}
+
+#ifdef CONFIG_SMP
+/*
+ * Ensure the next switch_mm() on every CPU issues a core serializing
+ * instruction for the given @mm.
+ */
+static inline void prepare_sync_core_cmd(struct mm_struct *mm)
+{
+	cpumask_setall(&mm->context.icache_stale_mask);
+}
+#else
+static inline void prepare_sync_core_cmd(struct mm_struct *mm)
+{
+}
+#endif /* CONFIG_SMP */
+
+#endif /* _ASM_RISCV_SYNC_CORE_H */
-- 
2.34.1


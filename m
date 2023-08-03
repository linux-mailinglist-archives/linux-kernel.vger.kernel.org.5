Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B1576DF40
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 06:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjHCECZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 00:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbjHCECD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 00:02:03 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410943C3A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 21:01:43 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-522dd6b6438so541600a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 21:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691035302; x=1691640102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UEjxagX1ha9UkBtXsYKg8a/M1LhAYSchZkCQVHioNKw=;
        b=L6MckNBosanRieexx3Ken0o7OsS27m/H15wUVvReQA0XEvY1kk//LcvLGjQMnMN+/T
         UiCK5U3Vub3KKXvySUk/G354nHszOKE20wKyeZMcnc9Nlmp8RfOlqzD7V9X4F5+1obC0
         nuo+IO3m9MK39HUnN4cwnlT0nkE4ZfsiSMWWBZSvNQ1wbmTXUfpDo3GYupUUnTMdLW+E
         TUoEWxtE8TZDnRIJCzGCWbZ9lSQYiUF05dtO2MLPE5gEZaconQdfyR3H+dQRXiOJFhQG
         1wcx/EDSXwuj+Qb9SGQxjPaqj2lvW6rC+J7EXMszcmEFW1kmvSMovN449LKjdyWbZSOl
         0XZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691035302; x=1691640102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UEjxagX1ha9UkBtXsYKg8a/M1LhAYSchZkCQVHioNKw=;
        b=lfQogzzuKTAdVR7iT7GOiwvjI33DqeLyK/B5rSoniDZbzrpU5vGixcgyDXeDhZ1u8b
         n/KErwZsNO9IdeEg0Noz7fkwV4fbugomp8T+nmvO4VQScivENZxpXlFaLkpE312TqBgC
         hvzDsPIZM4cD3SkGcM6JnlyWIa+UI21g6Vc+FeDCx4R0dbT25zFVuqIesfs+mWV/EJVI
         nQQmAMUPXXdRQ9Dgsp57gSwypQZgpaFPrWUXOt86piE158xl0aP/d1DV9RR0PuCD5ouh
         pS1givuIsEzX/Py5w2YcTRAL9IxZVFBb7+kK/QOLOJ2IDomkH4vtssAdDfZD6Pcv6oyS
         YLDA==
X-Gm-Message-State: ABy/qLYm/UdOdcg7e0/6+NrcW+b9LmX+yrIuZor/ZwYLtA69x4lWuBtd
        J5qa4jYTwGDgslqP5S2pcF0=
X-Google-Smtp-Source: APBJJlErJQNEoLPOnJ89zXgzBb6SuF73dvEG2kCU9/luu3iAoGcPo7AdNAHOk463+WRJXksbGRwuVA==
X-Received: by 2002:a17:906:7682:b0:993:ec0b:1a24 with SMTP id o2-20020a170906768200b00993ec0b1a24mr6401251ejm.7.1691035301466;
        Wed, 02 Aug 2023 21:01:41 -0700 (PDT)
Received: from andrea.. (host-82-57-177-142.retail.telecomitalia.it. [82.57.177.142])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709060dc900b0099bc038eb2bsm9851388eji.58.2023.08.02.21.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 21:01:40 -0700 (PDT)
From:   Andrea Parri <parri.andrea@gmail.com>
To:     mathieu.desnoyers@efficios.com, paulmck@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [RFC PATCH] membarrier: riscv: Provide core serializing command
Date:   Thu,  3 Aug 2023 06:01:11 +0200
Message-Id: <20230803040111.5101-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Suggested-by: Palmer Dabbelt <palmer@dabbelt.com>
---
For the MEMBARRIER maintainers:  RISC-V does not have "core serializing
instructions", meaning that there is no occurence of such a term in the
RISC-V ISA.  The discussion and git history about the SYNC_CORE command
suggested the implementation below: a FENCE.I instruction "synchronizes
the instruction and data streams" [1] on a CPU; in litmus parlance,

  (single-hart test)

  CPU0

  UPDATE text   ;
  FENCE.I       ;
  EXECUTE text  ;  /* <-- will execute the updated/new text */


  (message-passing test)

  CPU0             CPU1

  UPDATE text   |  IF (flag) {     ;
  WMB           |    FENCE.I       ;
  SET flag      |    EXECUTE text  ;  /* execute the new text */
                |  }               ;


  (and many others, including "maybe"s!  ;-) )

How do these remarks resonate with the semantics of "a core serializing
instruction" (to be issued before returning to user-space)?

RISCV maintainers, I'm missing some paths to user-space? (besides xRET)

  Andrea

[1] https://github.com/riscv/riscv-isa-manual/blob/main/src/zifencei.adoc


 .../sched/membarrier-sync-core/arch-support.txt   |  2 +-
 arch/riscv/Kconfig                                |  2 ++
 arch/riscv/include/asm/sync_core.h                | 15 +++++++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/sync_core.h

diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
index 23260ca449468..a17117d76e6d8 100644
--- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
+++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
@@ -44,7 +44,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
-    |       riscv: | TODO |
+    |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 4c07b9189c867..ed7ddaedc692e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -27,6 +27,7 @@ config RISCV
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_MMIOWB
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API
@@ -35,6 +36,7 @@ config RISCV
 	select ARCH_HAS_SET_MEMORY if MMU
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_STRICT_MODULE_RWX if MMU && !XIP_KERNEL
+	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_VDSO_DATA
diff --git a/arch/riscv/include/asm/sync_core.h b/arch/riscv/include/asm/sync_core.h
new file mode 100644
index 0000000000000..d3ec6ac47ac9b
--- /dev/null
+++ b/arch/riscv/include/asm/sync_core.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_SYNC_CORE_H
+#define _ASM_RISCV_SYNC_CORE_H
+
+/*
+ * Ensure that a core serializing instruction is issued before returning
+ * to user-mode.  RISC-V implements return to user-space through an xRET
+ * instruction, which is not core serializing.
+ */
+static inline void sync_core_before_usermode(void)
+{
+	asm volatile ("fence.i" ::: "memory");
+}
+
+#endif /* _ASM_RISCV_SYNC_CORE_H */
-- 
2.34.1


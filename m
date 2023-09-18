Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E5C7A429C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240431AbjIRHcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240336AbjIRHbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:31:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F92122;
        Mon, 18 Sep 2023 00:31:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D66C4160E;
        Mon, 18 Sep 2023 07:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695022292;
        bh=Bxy7NNRI6l4akC8Uk0JGSyZsyMn1J934EmvkFA96qyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sUl4tcVd+CE1RIfDd+iHzBuo/TtqH+sjUX4AKoidjsBhiPE9N8u5sBFCrh0U2OnnW
         02VNXIu/PasFZvJmqp4LQS/fRSyOWf9W0w4R1mThqbVlQHxfh9deE8Gen6PrybSKrA
         HQTfOkMmKWxzdY89y0l1tlT8/WpmYk4oOHqiKiyXMFacErx4oC2oV4nkojcJ6bpZun
         9S9TLaBh1Kth+hdxlxcmXjxDVU8y/jq3PgPfSmOZxNeFoZYJdyBqlLfSCGOoTzYYQr
         s02+6pJi35T4N9EWcJQvWIbsw2teHNSr/sLV1vIIuBQWC8WuxxKTSKFPi24i20hJWy
         PMgDbwaP/8Fzw==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Song Liu <song@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: [PATCH v3 08/13] riscv: extend execmem_params for generated code allocations
Date:   Mon, 18 Sep 2023 10:29:50 +0300
Message-Id: <20230918072955.2507221-9-rppt@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230918072955.2507221-1-rppt@kernel.org>
References: <20230918072955.2507221-1-rppt@kernel.org>
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

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

The memory allocations for kprobes and BPF on RISC-V are not placed in
the modules area and these custom allocations are implemented with
overrides of alloc_insn_page() and  bpf_jit_alloc_exec().

Slightly reorder execmem_params initialization to support both 32 and 64
bit variants, define EXECMEM_KPROBES and EXECMEM_BPF ranges in
riscv::execmem_params and drop overrides of alloc_insn_page() and
bpf_jit_alloc_exec().

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/riscv/kernel/module.c         | 21 ++++++++++++++++++++-
 arch/riscv/kernel/probes/kprobes.c | 10 ----------
 arch/riscv/net/bpf_jit_core.c      | 13 -------------
 3 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 343a0edfb6dd..31505ecb5c72 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -436,20 +436,39 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 	return 0;
 }
 
-#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
+#ifdef CONFIG_MMU
 static struct execmem_params execmem_params __ro_after_init = {
 	.ranges = {
 		[EXECMEM_DEFAULT] = {
 			.pgprot = PAGE_KERNEL,
 			.alignment = 1,
 		},
+		[EXECMEM_KPROBES] = {
+			.pgprot = PAGE_KERNEL_READ_EXEC,
+			.alignment = 1,
+		},
+		[EXECMEM_BPF] = {
+			.pgprot = PAGE_KERNEL,
+			.alignment = 1,
+		},
 	},
 };
 
 struct execmem_params __init *execmem_arch_params(void)
 {
+#ifdef CONFIG_64BIT
 	execmem_params.ranges[EXECMEM_DEFAULT].start = MODULES_VADDR;
 	execmem_params.ranges[EXECMEM_DEFAULT].end = MODULES_END;
+#else
+	execmem_params.ranges[EXECMEM_DEFAULT].start = VMALLOC_START;
+	execmem_params.ranges[EXECMEM_DEFAULT].end = VMALLOC_END;
+#endif
+
+	execmem_params.ranges[EXECMEM_KPROBES].start = VMALLOC_START;
+	execmem_params.ranges[EXECMEM_KPROBES].end = VMALLOC_END;
+
+	execmem_params.ranges[EXECMEM_BPF].start = BPF_JIT_REGION_START;
+	execmem_params.ranges[EXECMEM_BPF].end = BPF_JIT_REGION_END;
 
 	return &execmem_params;
 }
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index 2f08c14a933d..e64f2f3064eb 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -104,16 +104,6 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	return 0;
 }
 
-#ifdef CONFIG_MMU
-void *alloc_insn_page(void)
-{
-	return  __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
-				     GFP_KERNEL, PAGE_KERNEL_READ_EXEC,
-				     VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
-				     __builtin_return_address(0));
-}
-#endif
-
 /* install breakpoint in text */
 void __kprobes arch_arm_kprobe(struct kprobe *p)
 {
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index 7b70ccb7fec3..c8a758f0882b 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -218,19 +218,6 @@ u64 bpf_jit_alloc_exec_limit(void)
 	return BPF_JIT_REGION_SIZE;
 }
 
-void *bpf_jit_alloc_exec(unsigned long size)
-{
-	return __vmalloc_node_range(size, PAGE_SIZE, BPF_JIT_REGION_START,
-				    BPF_JIT_REGION_END, GFP_KERNEL,
-				    PAGE_KERNEL, 0, NUMA_NO_NODE,
-				    __builtin_return_address(0));
-}
-
-void bpf_jit_free_exec(void *addr)
-{
-	return vfree(addr);
-}
-
 void *bpf_arch_text_copy(void *dst, void *src, size_t len)
 {
 	int ret;
-- 
2.39.2


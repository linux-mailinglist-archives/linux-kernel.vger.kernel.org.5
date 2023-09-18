Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44DC7A4291
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240332AbjIRHcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240215AbjIRHbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:31:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF01A19A;
        Mon, 18 Sep 2023 00:31:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68ED7C433C8;
        Mon, 18 Sep 2023 07:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695022263;
        bh=mbiiTE+Ax/Si/BZxcJVEdVXi15nThNmQlUqiyILb0zo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ojfgNgsup07S+iaZErkHdPn6pFXvUxpfd0rqcJ0g/fFjdgDTdp5RCwZChtRwqs+hU
         358zdLhiRZXyw3aIFuKwPq3ciyzug59B+euqQg31hDJF2IYAsE+6D264chrRpy0JCv
         lIJDaEg0ezBhP+IOLDXi95uXUolbh37QjiMgyCp6vToq0/niAQX3TSUJ4+A3chXFuR
         Fz6pQnaNxbhFzVVMJL+/JI6h0Va38Wr9Y8Zzq0rWzkuGOl0+j0c7QpIR3g6g0WJ4vh
         Na6tomyrzTQLlYxetqXYeBzvBjSJ3J7TMO8PQeFVdg4iyOutejtYTgrDjMGzC7l/J1
         0uZomhqve3rWw==
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
Subject: [PATCH v3 05/13] modules, execmem: drop module_alloc
Date:   Mon, 18 Sep 2023 10:29:47 +0300
Message-Id: <20230918072955.2507221-6-rppt@kernel.org>
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

Define default parameters for address range for code allocations using
the current values in module_alloc() and make execmem_text_alloc() use
these defaults when an architecture does not supply its specific
parameters.

With this, execmem_text_alloc() implements memory allocation in a way
compatible with module_alloc() and can be used as a replacement for
module_alloc().

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/execmem.h      |  8 ++++++++
 include/linux/moduleloader.h | 12 ------------
 kernel/module/main.c         |  7 -------
 mm/execmem.c                 | 12 ++++++++----
 4 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/include/linux/execmem.h b/include/linux/execmem.h
index 806ad1a0088d..519bdfdca595 100644
--- a/include/linux/execmem.h
+++ b/include/linux/execmem.h
@@ -4,6 +4,14 @@
 
 #include <linux/types.h>
 
+#if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
+		!defined(CONFIG_KASAN_VMALLOC)
+#include <linux/kasan.h>
+#define MODULE_ALIGN (PAGE_SIZE << KASAN_SHADOW_SCALE_SHIFT)
+#else
+#define MODULE_ALIGN PAGE_SIZE
+#endif
+
 /**
  * enum execmem_type - types of executable memory ranges
  *
diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index a23718aa2f4d..8c81f389117d 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -25,10 +25,6 @@ int module_frob_arch_sections(Elf_Ehdr *hdr,
 /* Additional bytes needed by arch in front of individual sections */
 unsigned int arch_mod_section_prepend(struct module *mod, unsigned int section);
 
-/* Allocator used for allocating struct module, core sections and init
-   sections.  Returns NULL on failure. */
-void *module_alloc(unsigned long size);
-
 /* Determines if the section name is an init section (that is only used during
  * module loading).
  */
@@ -118,12 +114,4 @@ void module_arch_cleanup(struct module *mod);
 /* Any cleanup before freeing mod->module_init */
 void module_arch_freeing_init(struct module *mod);
 
-#if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
-		!defined(CONFIG_KASAN_VMALLOC)
-#include <linux/kasan.h>
-#define MODULE_ALIGN (PAGE_SIZE << KASAN_SHADOW_SCALE_SHIFT)
-#else
-#define MODULE_ALIGN PAGE_SIZE
-#endif
-
 #endif
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 4ec982cc943c..c4146bfcd0a7 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1601,13 +1601,6 @@ static void free_modinfo(struct module *mod)
 	}
 }
 
-void * __weak module_alloc(unsigned long size)
-{
-	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
-			GFP_KERNEL, PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS,
-			NUMA_NO_NODE, __builtin_return_address(0));
-}
-
 bool __weak module_init_section(const char *name)
 {
 	return strstarts(name, ".init");
diff --git a/mm/execmem.c b/mm/execmem.c
index a8c2f44d0133..abcbd07e05ac 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -55,9 +55,6 @@ static void *execmem_alloc(size_t size, struct execmem_range *range)
 
 void *execmem_text_alloc(enum execmem_type type, size_t size)
 {
-	if (!execmem_params.ranges[type].start)
-		return module_alloc(size);
-
 	return execmem_alloc(size, &execmem_params.ranges[type]);
 }
 
@@ -111,8 +108,15 @@ void __init execmem_init(void)
 {
 	struct execmem_params *p = execmem_arch_params();
 
-	if (!p)
+	if (!p) {
+		p = &execmem_params;
+		p->ranges[EXECMEM_DEFAULT].start = VMALLOC_START;
+		p->ranges[EXECMEM_DEFAULT].end = VMALLOC_END;
+		p->ranges[EXECMEM_DEFAULT].pgprot = PAGE_KERNEL_EXEC;
+		p->ranges[EXECMEM_DEFAULT].alignment = 1;
+
 		return;
+	}
 
 	if (!execmem_validate_params(p))
 		return;
-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EB47E8E9A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 07:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjKLGQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 01:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjKLGQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 01:16:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CAC3A8D
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 22:16:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DC5C433CB;
        Sun, 12 Nov 2023 06:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699769776;
        bh=vpjhhhUmj1avFAQY8tW0355cR2hNJ8+HWWoICf4M/q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tbmYH6qvjiwpurPDTM/NhvCyNM0BO9pDMaCHLOgToCuPIYab9D5pj1Pru7s5I5zH3
         3EZpHOYlEz7SPUvEspv5L+ntRZzc7Cu9pkMJ7kLCXZ9h7PQd63b+UeUidrdSN0WSkA
         6dHdTp7ipXNS/ZSQxbnuETUSCx/kEpXc9VvNk5zEb/oy5uSCt/XZXQECJEiy1sa94Z
         4yz6iD4zm0oOVHE+huuWTqa705yDUvTwkqHE/b/egrGTwu28FeR2kvixkaS9B8y2Wp
         v/asfaAmxC6JFNBTJpFBH/S61flYt5GgQ2C0+pM4/xWWLkKohmzBOlpE17LyUP/1MO
         jXud+VjwKISQQ==
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
Subject: [RFC PATCH V2 08/38] riscv: u64ilp32: Adjust vDSO alternative for 64ilp32 abi
Date:   Sun, 12 Nov 2023 01:14:44 -0500
Message-Id: <20231112061514.2306187-9-guoren@kernel.org>
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

The 64ilp32 uses the same ELF32 as 32ilp32 and the 64lp64 uses ELF64, so
separate apply_vdso_alternatives into 64 and 32 versions and serve for
three kinds of vDSO - vdso32, vdso64, vdso64ilp32.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/module.h | 30 ++++++++++++++++++++++
 arch/riscv/kernel/alternative.c | 45 ++++++++++++++++++++++++---------
 2 files changed, 63 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/include/asm/module.h b/arch/riscv/include/asm/module.h
index 0f3baaa6a9a8..9f556435a1a4 100644
--- a/arch/riscv/include/asm/module.h
+++ b/arch/riscv/include/asm/module.h
@@ -127,4 +127,34 @@ static inline const Elf_Shdr *find_section(const Elf_Ehdr *hdr,
 	return NULL;
 }
 
+static inline const Elf64_Shdr *find_section64(const Elf64_Ehdr *hdr,
+					       const Elf64_Shdr *sechdrs,
+					       const char *name)
+{
+	const Elf64_Shdr *s, *se;
+	const char *secstrs = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
+
+	for (s = sechdrs, se = sechdrs + hdr->e_shnum; s < se; s++) {
+		if (strcmp(name, secstrs + s->sh_name) == 0)
+			return s;
+	}
+
+	return NULL;
+}
+
+static inline const Elf32_Shdr *find_section32(const Elf32_Ehdr *hdr,
+					       const Elf32_Shdr *sechdrs,
+					       const char *name)
+{
+	const Elf32_Shdr *s, *se;
+	const char *secstrs = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
+
+	for (s = sechdrs, se = sechdrs + hdr->e_shnum; s < se; s++) {
+		if (strcmp(name, secstrs + s->sh_name) == 0)
+			return s;
+	}
+
+	return NULL;
+}
+
 #endif /* _ASM_RISCV_MODULE_H */
diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
index 73a2d7533806..ab9eb42a5502 100644
--- a/arch/riscv/kernel/alternative.c
+++ b/arch/riscv/kernel/alternative.c
@@ -181,17 +181,40 @@ static void __init_or_module _apply_alternatives(struct alt_entry *begin,
 				stage);
 }
 
-#ifdef CONFIG_MMU
-static void __init apply_vdso_alternatives(void *vdso_start)
+#ifdef CONFIG_VDSO64
+static void __init apply_vdso_alternatives64(void *vdso_start)
 {
-	const Elf_Ehdr *hdr;
-	const Elf_Shdr *shdr;
-	const Elf_Shdr *alt;
+	const Elf64_Ehdr *hdr;
+	const Elf64_Shdr *shdr;
+	const Elf64_Shdr *alt;
 	struct alt_entry *begin, *end;
 
-	hdr = (Elf_Ehdr *)vdso_start;
+	hdr = (Elf64_Ehdr *)vdso_start;
 	shdr = (void *)hdr + hdr->e_shoff;
-	alt = find_section(hdr, shdr, ".alternative");
+	alt = find_section64(hdr, shdr, ".alternative");
+	if (!alt)
+		return;
+
+	begin = (void *)hdr + alt->sh_offset,
+	end = (void *)hdr + alt->sh_offset + alt->sh_size,
+
+	_apply_alternatives((struct alt_entry *)begin,
+			    (struct alt_entry *)end,
+			    RISCV_ALTERNATIVES_BOOT);
+}
+#endif
+
+#if IS_ENABLED(CONFIG_VDSO32) || IS_ENABLED(CONFIG_VDSO64ILP32)
+static void __init apply_vdso_alternatives32(void *vdso_start)
+{
+	const Elf32_Ehdr *hdr;
+	const Elf32_Shdr *shdr;
+	const Elf32_Shdr *alt;
+	struct alt_entry *begin, *end;
+
+	hdr = (Elf32_Ehdr *)vdso_start;
+	shdr = (void *)hdr + hdr->e_shoff;
+	alt = find_section32(hdr, shdr, ".alternative");
 	if (!alt)
 		return;
 
@@ -202,8 +225,6 @@ static void __init apply_vdso_alternatives(void *vdso_start)
 			    (struct alt_entry *)end,
 			    RISCV_ALTERNATIVES_BOOT);
 }
-#else
-static void __init apply_vdso_alternatives(void *vdso_start) { }
 #endif
 
 void __init apply_boot_alternatives(void)
@@ -217,13 +238,13 @@ void __init apply_boot_alternatives(void)
 			    RISCV_ALTERNATIVES_BOOT);
 
 #ifdef CONFIG_VDSO64
-	apply_vdso_alternatives(vdso64_start);
+	apply_vdso_alternatives64(vdso64_start);
 #endif
 #ifdef CONFIG_VDSO32
-	apply_vdso_alternatives(vdso32_start);
+	apply_vdso_alternatives32(vdso32_start);
 #endif
 #ifdef CONFIG_VDSO64ILP32
-	apply_vdso_alternatives(vdso64ilp32_start);
+	apply_vdso_alternatives32(vdso64ilp32_start);
 #endif
 
 }
-- 
2.36.1


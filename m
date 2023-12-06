Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD218075D9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442665AbjLFQy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379719AbjLFQy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:54:56 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CF0D4E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 08:55:02 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-332d5c852a0so993366f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 08:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701881700; x=1702486500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=11Qvm73V/R4oS4z1zzbUqHU36xrwvK0hc2TtJL/D01A=;
        b=Q2xpQM7/SePVQLCLgneWl/RfzS4khoExkdozP89U1ALawV6MKouCxR+CJDN5q7LlEx
         QO2Pxj05+lqDH9mCp2d+In8KAJJ584MMqB+wmG6/qOF25gjORvMXi90tjAxf0IXesu7C
         lkm/DvK66Z0dQxeN5Z7Isbyc9pMY8YqDt5P8JLk1wkdn1awU5Mwwji8K+K28D4emAYUM
         46OSwS1E73VEXf7nreoSV1Q+eIypGpH9IsErV+KOhn+CqcFyKXj6/Hd+jGqH1HNW+FNA
         oW6hL49wGvbtHRhffvcP9vZvwqvKMj+om0cqYC/q0cz3m6ieX19zt7MDM1Qibot5lTQJ
         cPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701881700; x=1702486500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=11Qvm73V/R4oS4z1zzbUqHU36xrwvK0hc2TtJL/D01A=;
        b=kfNCWVL3fjUUiH6un+vz/bnhPubk6H73AiBTCsB+wW/EFeePXU6QTU8oLLgH2hVbQe
         rMib0ry5HVL+lFXKFhI/s+bbCSQHYI+4E7n7bQi7cTrl/ggCctIVehRfQOIIeycpc7wL
         J7Sg4dT9OBfQNzIiQ+XK3QfYwEmrhqT73XDN1g51tOXtJq9GZYiTaItjRa12jzYRWpRn
         KCYcaFQjxQfSuVeGXHhBhRyfamY2HSE12CWqvGwBGwE6/nMkfiWN3ycLev1w3y9Y4wpX
         LeNYfG5pImdUPZ/+v9uFJFgC4OJQ+Z+9zG8cgvpJAfznnLB0RTxZDDYaLTfy8Og6Fyz7
         qZQg==
X-Gm-Message-State: AOJu0YxkFu9UJps53sAR45I+spgT79JICi8Y7hkNKRQlehi1YoL0woTI
        owmQ/tLdvrtOF756YG68q6f02w==
X-Google-Smtp-Source: AGHT+IEWj7IINYNgOfOiEmwYeJkE0Y1KTlaky3I47a/47VFbSS6FDRvec3zWR9HjMHUj9F/PMRO1pA==
X-Received: by 2002:adf:a3cc:0:b0:333:10f6:29c8 with SMTP id m12-20020adfa3cc000000b0033310f629c8mr1093444wrb.20.1701881700471;
        Wed, 06 Dec 2023 08:55:00 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id g9-20020a5d5409000000b0033349de2622sm108599wrv.94.2023.12.06.08.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 08:55:00 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        syzbot+2c2a76232878c44e0eae@syzkaller.appspotmail.com
Subject: [PATCH -fixes] riscv: Check if the code to patch lies in the exit section
Date:   Wed,  6 Dec 2023 17:54:58 +0100
Message-Id: <20231206165458.40610-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise we fall through to vmalloc_to_page() which panics since the
address does not lie in the vmalloc region.

Fixes: 043cb41a85de ("riscv: introduce interfaces to patch kernel code")
Reported-by: syzbot+2c2a76232878c44e0eae@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000ce4a27060b39ed34@google.com/T/
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/sections.h |  1 +
 arch/riscv/kernel/patch.c         | 11 ++++++++++-
 arch/riscv/kernel/vmlinux.lds.S   |  2 ++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/sections.h b/arch/riscv/include/asm/sections.h
index 32336e8a17cb..a393d5035c54 100644
--- a/arch/riscv/include/asm/sections.h
+++ b/arch/riscv/include/asm/sections.h
@@ -13,6 +13,7 @@ extern char _start_kernel[];
 extern char __init_data_begin[], __init_data_end[];
 extern char __init_text_begin[], __init_text_end[];
 extern char __alt_start[], __alt_end[];
+extern char __exittext_begin[], __exittext_end[];
 
 static inline bool is_va_kernel_text(uintptr_t va)
 {
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 13ee7bf589a1..37e87fdcf6a0 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -14,6 +14,7 @@
 #include <asm/fixmap.h>
 #include <asm/ftrace.h>
 #include <asm/patch.h>
+#include <asm/sections.h>
 
 struct patch_insn {
 	void *addr;
@@ -25,6 +26,14 @@ struct patch_insn {
 int riscv_patch_in_stop_machine = false;
 
 #ifdef CONFIG_MMU
+
+static inline bool is_kernel_exittext(uintptr_t addr)
+{
+	return system_state < SYSTEM_RUNNING &&
+		addr >= (uintptr_t)__exittext_begin &&
+		addr < (uintptr_t)__exittext_end;
+}
+
 /*
  * The fix_to_virt(, idx) needs a const value (not a dynamic variable of
  * reg-a0) or BUILD_BUG_ON failed with "idx >= __end_of_fixed_addresses".
@@ -35,7 +44,7 @@ static __always_inline void *patch_map(void *addr, const unsigned int fixmap)
 	uintptr_t uintaddr = (uintptr_t) addr;
 	struct page *page;
 
-	if (core_kernel_text(uintaddr))
+	if (core_kernel_text(uintaddr) || is_kernel_exittext(uintaddr))
 		page = phys_to_page(__pa_symbol(addr));
 	else if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
 		page = vmalloc_to_page(addr);
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 492dd4b8f3d6..002ca58dd998 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -69,10 +69,12 @@ SECTIONS
 		__soc_builtin_dtb_table_end = .;
 	}
 	/* we have to discard exit text and such at runtime, not link time */
+	__exittext_begin = .;
 	.exit.text :
 	{
 		EXIT_TEXT
 	}
+	__exittext_end = .;
 
 	__init_text_end = .;
 	. = ALIGN(SECTION_ALIGN);
-- 
2.39.2


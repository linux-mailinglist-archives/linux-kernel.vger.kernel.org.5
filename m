Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BDE7E67C3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjKIKU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjKIKUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:20:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89C8A19A3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:20:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDDF312FC;
        Thu,  9 Nov 2023 02:21:36 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FC793F703;
        Thu,  9 Nov 2023 02:20:51 -0800 (PST)
From:   Kevin Brodsky <kevin.brodsky@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>
Subject: [PATCH] arm64/syscall: Remove duplicate declaration
Date:   Thu,  9 Nov 2023 10:19:58 +0000
Message-ID: <20231109101958.225593-1-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6ac19f96515e ("arm64: avoid prototype warnings for syscalls")
added missing declarations to various syscall wrapper macros.
It however proved a little too zealous in __SYSCALL_DEFINEx(), as
a declaration for __arm64_sys##name was already present.

This likely wouldn't have happened if declarations were consistently
located, ideally just before the corresponding definition.
Accordingly, this patch removes the old declaration line in
__SYSCALL_DEFINEx(), and moves any other declaration that does not
directly precede the corresponding definition.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/syscall_wrapper.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/syscall_wrapper.h b/arch/arm64/include/asm/syscall_wrapper.h
index 17f687510c48..0d1ec3280f89 100644
--- a/arch/arm64/include/asm/syscall_wrapper.h
+++ b/arch/arm64/include/asm/syscall_wrapper.h
@@ -18,10 +18,10 @@
 #ifdef CONFIG_COMPAT
 
 #define COMPAT_SYSCALL_DEFINEx(x, name, ...)						\
-	asmlinkage long __arm64_compat_sys##name(const struct pt_regs *regs);		\
 	ALLOW_ERROR_INJECTION(__arm64_compat_sys##name, ERRNO);				\
 	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));		\
 	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
+	asmlinkage long __arm64_compat_sys##name(const struct pt_regs *regs);		\
 	asmlinkage long __arm64_compat_sys##name(const struct pt_regs *regs)		\
 	{										\
 		return __se_compat_sys##name(SC_ARM64_REGS_TO_ARGS(x,__VA_ARGS__));	\
@@ -50,7 +50,6 @@
 #endif /* CONFIG_COMPAT */
 
 #define __SYSCALL_DEFINEx(x, name, ...)						\
-	asmlinkage long __arm64_sys##name(const struct pt_regs *regs);		\
 	ALLOW_ERROR_INJECTION(__arm64_sys##name, ERRNO);			\
 	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));		\
 	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
@@ -70,8 +69,8 @@
 
 #define SYSCALL_DEFINE0(sname)							\
 	SYSCALL_METADATA(_##sname, 0);						\
-	asmlinkage long __arm64_sys_##sname(const struct pt_regs *__unused);	\
 	ALLOW_ERROR_INJECTION(__arm64_sys_##sname, ERRNO);			\
+	asmlinkage long __arm64_sys_##sname(const struct pt_regs *__unused);	\
 	asmlinkage long __arm64_sys_##sname(const struct pt_regs *__unused)
 
 #define COND_SYSCALL(name)							\
-- 
2.42.1


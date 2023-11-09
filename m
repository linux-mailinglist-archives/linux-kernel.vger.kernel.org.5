Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305C57E6C35
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 15:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbjKIOMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 09:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjKIOMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 09:12:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C40C2D75
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 06:12:12 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B410512FC;
        Thu,  9 Nov 2023 06:12:56 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 245993F64C;
        Thu,  9 Nov 2023 06:12:11 -0800 (PST)
From:   Kevin Brodsky <kevin.brodsky@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>
Subject: [PATCH v2] arm64/syscall: Remove duplicate declaration
Date:   Thu,  9 Nov 2023 14:11:53 +0000
Message-ID: <20231109141153.250046-1-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6ac19f96515e ("arm64: avoid prototype warnings for syscalls")
added missing declarations to various syscall wrapper macros. It
however proved a little too zealous in __SYSCALL_DEFINEx(), as a
declaration for __arm64_sys##name was already present. A declaration
is required before the call to ALLOW_ERROR_INJECTION(), so keep
the original one and remove the new one.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---

v1..v2:
- Keep the original declarations as-is, as they are required before
  calling ALLOW_ERROR_INJECTION().

 arch/arm64/include/asm/syscall_wrapper.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/include/asm/syscall_wrapper.h b/arch/arm64/include/asm/syscall_wrapper.h
index 17f687510c48..d977713ec0ba 100644
--- a/arch/arm64/include/asm/syscall_wrapper.h
+++ b/arch/arm64/include/asm/syscall_wrapper.h
@@ -54,7 +54,6 @@
 	ALLOW_ERROR_INJECTION(__arm64_sys##name, ERRNO);			\
 	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));		\
 	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
-	asmlinkage long __arm64_sys##name(const struct pt_regs *regs);		\
 	asmlinkage long __arm64_sys##name(const struct pt_regs *regs)		\
 	{									\
 		return __se_sys##name(SC_ARM64_REGS_TO_ARGS(x,__VA_ARGS__));	\
-- 
2.42.1


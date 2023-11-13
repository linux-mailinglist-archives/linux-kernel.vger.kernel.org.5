Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01797E9580
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 04:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbjKMDZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 22:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbjKMDZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 22:25:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEB41719
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 19:25:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B8CC433C7;
        Mon, 13 Nov 2023 03:25:23 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] LoongArch: Add __percpu annotation for __percpu_read()/__percpu_write()
Date:   Mon, 13 Nov 2023 11:25:11 +0800
Message-Id: <20231113032511.860159-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When build kernel with C=1, we get:

arch/loongarch/kernel/process.c:234:46: warning: incorrect type in argument 1 (different address spaces)
arch/loongarch/kernel/process.c:234:46:    expected void *ptr
arch/loongarch/kernel/process.c:234:46:    got unsigned long [noderef] __percpu *
arch/loongarch/kernel/process.c:234:46: warning: incorrect type in argument 1 (different address spaces)
arch/loongarch/kernel/process.c:234:46:    expected void *ptr
arch/loongarch/kernel/process.c:234:46:    got unsigned long [noderef] __percpu *
arch/loongarch/kernel/process.c:234:46: warning: incorrect type in argument 1 (different address spaces)
arch/loongarch/kernel/process.c:234:46:    expected void *ptr
arch/loongarch/kernel/process.c:234:46:    got unsigned long [noderef] __percpu *
arch/loongarch/kernel/process.c:234:46: warning: incorrect type in argument 1 (different address spaces)
arch/loongarch/kernel/process.c:234:46:    expected void *ptr
arch/loongarch/kernel/process.c:234:46:    got unsigned long [noderef] __percpu *

Add __percpu annotation for __percpu_read()/__percpu_write() can avoid
such warnings. __percpu_xchg() and other functions don't need annotation
because their wrapper, i.e. _pcp_protect(), already suppresses warnings.

Also adjust the indentations in this file.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311080409.LlOfTR3m-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202311080840.Vc2kXhfp-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202311081340.3k72KKdg-lkp@intel.com/
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/percpu.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/loongarch/include/asm/percpu.h b/arch/loongarch/include/asm/percpu.h
index ed5da02b1cf6..9b36ac003f89 100644
--- a/arch/loongarch/include/asm/percpu.h
+++ b/arch/loongarch/include/asm/percpu.h
@@ -40,13 +40,13 @@ static __always_inline unsigned long __percpu_##op(void *ptr,		\
 	switch (size) {							\
 	case 4:								\
 		__asm__ __volatile__(					\
-		"am"#asm_op".w"	" %[ret], %[val], %[ptr]	\n"		\
+		"am"#asm_op".w"	" %[ret], %[val], %[ptr]	\n"	\
 		: [ret] "=&r" (ret), [ptr] "+ZB"(*(u32 *)ptr)		\
 		: [val] "r" (val));					\
 		break;							\
 	case 8:								\
 		__asm__ __volatile__(					\
-		"am"#asm_op".d" " %[ret], %[val], %[ptr]	\n"		\
+		"am"#asm_op".d" " %[ret], %[val], %[ptr]	\n"	\
 		: [ret] "=&r" (ret), [ptr] "+ZB"(*(u64 *)ptr)		\
 		: [val] "r" (val));					\
 		break;							\
@@ -63,7 +63,7 @@ PERCPU_OP(and, and, &)
 PERCPU_OP(or, or, |)
 #undef PERCPU_OP
 
-static __always_inline unsigned long __percpu_read(void *ptr, int size)
+static __always_inline unsigned long __percpu_read(void __percpu *ptr, int size)
 {
 	unsigned long ret;
 
@@ -100,7 +100,7 @@ static __always_inline unsigned long __percpu_read(void *ptr, int size)
 	return ret;
 }
 
-static __always_inline void __percpu_write(void *ptr, unsigned long val, int size)
+static __always_inline void __percpu_write(void __percpu *ptr, unsigned long val, int size)
 {
 	switch (size) {
 	case 1:
@@ -132,8 +132,7 @@ static __always_inline void __percpu_write(void *ptr, unsigned long val, int siz
 	}
 }
 
-static __always_inline unsigned long __percpu_xchg(void *ptr, unsigned long val,
-						   int size)
+static __always_inline unsigned long __percpu_xchg(void *ptr, unsigned long val, int size)
 {
 	switch (size) {
 	case 1:
-- 
2.39.3


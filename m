Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A357B0ACE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjI0RGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjI0RGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:06:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B7F92
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 10:06:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1830FC433CA;
        Wed, 27 Sep 2023 17:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695834370;
        bh=+UG/yWZqZo1iV8TUQE3qhdJF0S1Q3YjrzyQjZVd6NL0=;
        h=From:To:Cc:Subject:Date:From;
        b=Qdfg391W2W7NBMk+m/EKVEc4PsWoYHrPd94/b7LiJLUlRCDPTFoJAq+2Ka3b9Blhf
         45CmO9z2n7DEOGLXApOAnZ2gUZ2+8B1zF6dqIUmbkpyTaq5cSvTofUNxgGt5orqHsE
         RcM28LrsljFT1hdyyDuVn9f3G9JEajNh8ZTx5Yadl0IT1wJ209uJa69+R324nBzKgk
         n6u31bLwSv+SrbrlPc9VyCfNcCn3yrololUBn4y58e4Aor0/NosIGwmMlThKmzaOmY
         EW+z8ksqq1DVLgr02f3JuA6c7q6eMTEVVQW5qSVfJZ2fRnf1rYozlWD+DGYX49CS0D
         aVroXOfNICTjw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     patches@armlinux.org.uk
Cc:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: make <linux/uaccess.h> self-contained for ARM
Date:   Thu, 28 Sep 2023 02:06:00 +0900
Message-Id: <20230927170600.286183-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I compiled the following code for ARM, I encountered numerous
errors.

[Test Code]

    #include <linux/compiler.h>
    #include <linux/uaccess.h>

    int foo(int *x, int __user *ptr)
    {
            return get_user(*x, ptr);
    }

To fix the errors, make some asm headers self-contained:

 1. In arch/arm/include/asm/domain.h, include <linux/thread_info.h>
    for current_thread_info().

 2. In arch/arm/include/asm/traps.h, remove unneeded  __init, and
    include <linux/linkage.h> for asmlinkage.

 3. In arch/arm/include/asm/uaccess.h, include <linux/kernel.h> for
    might_fault().

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

KernelVersion: v6.6-rc1


 arch/arm/include/asm/domain.h  | 2 +-
 arch/arm/include/asm/traps.h   | 3 ++-
 arch/arm/include/asm/uaccess.h | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/domain.h b/arch/arm/include/asm/domain.h
index 41536feb4392..d48859fdf32c 100644
--- a/arch/arm/include/asm/domain.h
+++ b/arch/arm/include/asm/domain.h
@@ -8,8 +8,8 @@
 #define __ASM_PROC_DOMAIN_H
 
 #ifndef __ASSEMBLY__
+#include <linux/thread_info.h>
 #include <asm/barrier.h>
-#include <asm/thread_info.h>
 #endif
 
 /*
diff --git a/arch/arm/include/asm/traps.h b/arch/arm/include/asm/traps.h
index 0aaefe3e1700..2621b9fb9b19 100644
--- a/arch/arm/include/asm/traps.h
+++ b/arch/arm/include/asm/traps.h
@@ -2,6 +2,7 @@
 #ifndef _ASMARM_TRAP_H
 #define _ASMARM_TRAP_H
 
+#include <linux/linkage.h>
 #include <linux/list.h>
 
 struct pt_regs;
@@ -28,7 +29,7 @@ static inline int __in_irqentry_text(unsigned long ptr)
 	       ptr < (unsigned long)&__irqentry_text_end;
 }
 
-extern void __init early_trap_init(void *);
+extern void early_trap_init(void *);
 extern void dump_backtrace_entry(unsigned long where, unsigned long from,
 				 unsigned long frame, const char *loglvl);
 extern void ptrace_break(struct pt_regs *regs);
diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index bb5c81823117..6a2cc57f015a 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -8,6 +8,7 @@
 /*
  * User space memory access functions
  */
+#include <linux/kernel.h>
 #include <linux/string.h>
 #include <asm/page.h>
 #include <asm/domain.h>
-- 
2.39.2


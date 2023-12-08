Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4208A80A928
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574441AbjLHQf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574298AbjLHQfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:35:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F169519A9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:35:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144D9C433B6;
        Fri,  8 Dec 2023 16:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702053317;
        bh=l/ccn9TohWmVu0gidxLaFZAXe873u+W72QG48wg65qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KmthFkp9R6S/S5QKzNeYjmgaMpiidbj1m4cc2zhTtKl9OKSy2IzILLGw4PS0qs3VM
         Hh1heFlMbk9aE/p7RBhwLjnswCE20sB/esq/CO5GoY2rktts5wrkXxi6aHYiCfBRq7
         XgjhbwiQXDa+9B2X5cePCKwa6R+ED0TZv6+eghgsMEYO2vhqjU8OtofeTWVZmo0N/u
         RcF5U3Rm/tOZYbODaFJNlgpCv5VWA8Afh+n+MhcgtQiy7TsGZGRJV1CrT1EDsTBqcx
         1yibxRHME3rt9nAgj5bWwwmxecDUzmirP2JGnoaWXn4gfsho0Ws6VszDbfdaPo5/6D
         x8AlUT9JYDW2Q==
From:   Naveen N Rao <naveen@kernel.org>
To:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH 4/9] powerpc/Kconfig: Select FUNCTION_ALIGNMENT_4B
Date:   Fri,  8 Dec 2023 22:00:43 +0530
Message-ID: <21892186ec44abe24df0daf64f577dac0e78783f.1702045299.git.naveen@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702045299.git.naveen@kernel.org>
References: <cover.1702045299.git.naveen@kernel.org>
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

From: Sathvika Vasireddy <sv@linux.ibm.com>

Commit d49a0626216b95 ("arch: Introduce CONFIG_FUNCTION_ALIGNMENT")
introduced a generic function-alignment infrastructure. Move to using
FUNCTION_ALIGNMENT_4B on powerpc, to use the same alignment as that of
the existing _GLOBAL macro.

Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
---
 arch/powerpc/Kconfig               | 1 +
 arch/powerpc/include/asm/linkage.h | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6f105ee4f3cf..318e5c1b7454 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -189,6 +189,7 @@ config PPC
 	select EDAC_ATOMIC_SCRUB
 	select EDAC_SUPPORT
 	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if ARCH_USING_PATCHABLE_FUNCTION_ENTRY
+	select FUNCTION_ALIGNMENT_4B
 	select GENERIC_ATOMIC64			if PPC32
 	select GENERIC_CLOCKEVENTS_BROADCAST	if SMP
 	select GENERIC_CMOS_UPDATE
diff --git a/arch/powerpc/include/asm/linkage.h b/arch/powerpc/include/asm/linkage.h
index b88d1d2cf304..b71b9582e754 100644
--- a/arch/powerpc/include/asm/linkage.h
+++ b/arch/powerpc/include/asm/linkage.h
@@ -4,9 +4,6 @@
 
 #include <asm/types.h>
 
-#define __ALIGN		.align 2
-#define __ALIGN_STR	".align 2"
-
 #ifdef CONFIG_PPC64_ELF_ABI_V1
 #define cond_syscall(x) \
 	asm ("\t.weak " #x "\n\t.set " #x ", sys_ni_syscall\n"		\
-- 
2.43.0


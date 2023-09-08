Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A257E7990A4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245538AbjIHT5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbjIHT5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:57:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97ECA3;
        Fri,  8 Sep 2023 12:57:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC3DC433BB;
        Fri,  8 Sep 2023 19:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201641;
        bh=OalSMVl3XxgEOsrbDSVUgswfFyTVgBefeOsrUsFx/t0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sfA3dD7JCHzaASKHHvd9HKvgZh/eGbVJcwUzLeOXRem3kMVQE+V+4V243Vs629Kg/
         givMJPPCnJUCq+oLxpLOFgdQ4QoIc670ywmzliMpFBHC4PQwyASIFQl5kXzaD7Bxav
         1jjar/7A0/ZKh5XBF40oY210iLk6rhB1fgjHDMlUpGGk4vtIo4wo+8e88OYNXtl63n
         +txY5k3nbXr2apsVFph4HScjzeXlJteaubr0px3Wevar1IK6kx7pVoDrDjKR5Cw7wm
         FEz3KIKnvEmttT0F+FGe9kng/5dZWAdL5lQgyoCLumjaSA2YLZenmL291VtrK9XMwg
         OgEJ3Yk21PUnw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, ira.weiny@intel.com
Subject: [PATCH AUTOSEL 6.4 31/31] x86: bring back rep movsq for user access on CPUs without ERMS
Date:   Fri,  8 Sep 2023 15:32:00 -0400
Message-Id: <20230908193201.3462957-31-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908193201.3462957-1-sashal@kernel.org>
References: <20230908193201.3462957-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mateusz Guzik <mjguzik@gmail.com>

[ Upstream commit ca96b162bfd21a5d55e3cd6099e4ee357a0eeb68 ]

Intel CPUs ship with ERMS for over a decade, but this is not true for
AMD.  In particular one reasonably recent uarch (EPYC 7R13) does not
have it (or at least the bit is inactive when running on the Amazon EC2
cloud -- I found rather conflicting information about AMD CPUs vs the
extension).

Hand-rolled mov loops executing in this case are quite pessimal compared
to rep movsq for bigger sizes.  While the upper limit depends on uarch,
everyone is well south of 1KB AFAICS and sizes bigger than that are
common.

While technically ancient CPUs may be suffering from rep usage, gcc has
been emitting it for years all over kernel code, so I don't think this
is a legitimate concern.

Sample result from read1_processes from will-it-scale (4KB reads/s):

  before:   1507021
  after:    1721828 (+14%)

Note that the cutoff point for rep usage is set to 64 bytes, which is
way too conservative but I'm sticking to what was done in 47ee3f1dd93b
("x86: re-introduce support for ERMS copies for user space accesses").
That is to say *some* copies will now go slower, which is fixable but
beyond the scope of this patch.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/uaccess_64.h |  2 +-
 arch/x86/lib/copy_user_64.S       | 57 +++++++------------------------
 2 files changed, 14 insertions(+), 45 deletions(-)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index 81b826d3b7530..f2c02e4469ccc 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -116,7 +116,7 @@ copy_user_generic(void *to, const void *from, unsigned long len)
 		"2:\n"
 		_ASM_EXTABLE_UA(1b, 2b)
 		:"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
-		: : "memory", "rax", "r8", "r9", "r10", "r11");
+		: : "memory", "rax");
 	clac();
 	return len;
 }
diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 01c5de4c279b8..0a81aafed7f88 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -27,7 +27,7 @@
  * NOTE! The calling convention is very intentionally the same as
  * for 'rep movs', so that we can rewrite the function call with
  * just a plain 'rep movs' on machines that have FSRM.  But to make
- * it simpler for us, we can clobber rsi/rdi and rax/r8-r11 freely.
+ * it simpler for us, we can clobber rsi/rdi and rax freely.
  */
 SYM_FUNC_START(rep_movs_alternative)
 	cmpq $64,%rcx
@@ -68,55 +68,24 @@ SYM_FUNC_START(rep_movs_alternative)
 	_ASM_EXTABLE_UA( 3b, .Lcopy_user_tail)
 
 .Llarge:
-0:	ALTERNATIVE "jmp .Lunrolled", "rep movsb", X86_FEATURE_ERMS
+0:	ALTERNATIVE "jmp .Llarge_movsq", "rep movsb", X86_FEATURE_ERMS
 1:	RET
 
-        _ASM_EXTABLE_UA( 0b, 1b)
+	_ASM_EXTABLE_UA( 0b, 1b)
 
-	.p2align 4
-.Lunrolled:
-10:	movq (%rsi),%r8
-11:	movq 8(%rsi),%r9
-12:	movq 16(%rsi),%r10
-13:	movq 24(%rsi),%r11
-14:	movq %r8,(%rdi)
-15:	movq %r9,8(%rdi)
-16:	movq %r10,16(%rdi)
-17:	movq %r11,24(%rdi)
-20:	movq 32(%rsi),%r8
-21:	movq 40(%rsi),%r9
-22:	movq 48(%rsi),%r10
-23:	movq 56(%rsi),%r11
-24:	movq %r8,32(%rdi)
-25:	movq %r9,40(%rdi)
-26:	movq %r10,48(%rdi)
-27:	movq %r11,56(%rdi)
-	addq $64,%rsi
-	addq $64,%rdi
-	subq $64,%rcx
-	cmpq $64,%rcx
-	jae .Lunrolled
-	cmpl $8,%ecx
-	jae .Lword
+.Llarge_movsq:
+	movq %rcx,%rax
+	shrq $3,%rcx
+	andl $7,%eax
+0:	rep movsq
+	movl %eax,%ecx
 	testl %ecx,%ecx
 	jne .Lcopy_user_tail
 	RET
 
-	_ASM_EXTABLE_UA(10b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(11b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(12b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(13b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(14b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(15b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(16b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(17b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(20b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(21b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(22b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(23b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(24b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(25b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(26b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(27b, .Lcopy_user_tail)
+1:	leaq (%rax,%rcx,8),%rcx
+	jmp .Lcopy_user_tail
+
+	_ASM_EXTABLE_UA( 0b, 1b)
 SYM_FUNC_END(rep_movs_alternative)
 EXPORT_SYMBOL(rep_movs_alternative)
-- 
2.40.1


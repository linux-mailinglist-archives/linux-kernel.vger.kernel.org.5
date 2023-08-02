Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B6C76DA8A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 00:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjHBWTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 18:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjHBWTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 18:19:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA41026BD;
        Wed,  2 Aug 2023 15:19:26 -0700 (PDT)
Date:   Wed, 02 Aug 2023 22:19:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691014765;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=TUJ+OCfmM8+EElq1tAhXEtqcW1KXxkUlMX9/vYnalbI=;
        b=OaP5xCUHJcdgrql9DKTPSk3GHr/eCqS0PH6VVyrm+R8UP+JIyEFeJ+iuN4J4z2J9PBNk9T
        4MePzxPhbs21dMFA+Vk/Ggc7VVYG5VPSzbXLKlnbsdPuCResw9+ai4bl0vyKe3NXRudbIb
        xmKMHGRlqiS8aPhnoRgx+ZuQbajx3PPvcRmuz1dSBpzD5i0j1BvOEtyEc9bhsV99L+wwZP
        NbM1CxljtA+fz9vwxrqPhS5LDlHIndEy6f/R0f70V3Bt/c9oqxxPtVJEmv1y6+ezjKKOHJ
        DB/M3gQmkTl+SOFWfTtsbcK/zHnavK+ISKib/OOwkJIpEfNtteqST94G89e0Tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691014765;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=TUJ+OCfmM8+EElq1tAhXEtqcW1KXxkUlMX9/vYnalbI=;
        b=7UGH8CcV+zOwYMcD3aP3Yign4GQMKMnP2s/FBkTp1Z1q1EXEV6HvBjAyDHmdyujq9L3DDU
        6BgAsw4uBbUjFMAA==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/shstk: Move arch detail comment out of core mm
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169101476425.28540.15036192081259914021.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     87f0df7828899c552bcdde639c045983d5aeeed9
Gitweb:        https://git.kernel.org/tip/87f0df7828899c552bcdde639c045983d5aeeed9
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Thu, 06 Jul 2023 16:32:48 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 02 Aug 2023 15:01:51 -07:00

x86/shstk: Move arch detail comment out of core mm

The comment around VM_SHADOW_STACK in mm.h refers to a lot of x86
specific details that don't belong in a cross arch file. Remove these
out of core mm, and just leave the non-arch details.

Since the comment includes some useful details that would be good to
retain in the source somewhere, put the arch specifics parts in
arch/x86/shstk.c near alloc_shstk(), where memory of this type is
allocated. Include a reference to the existence of the x86 details near
the VM_SHADOW_STACK definition mm.h.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/all/20230706233248.445713-1-rick.p.edgecombe%40intel.com
---
 arch/x86/kernel/shstk.c | 25 +++++++++++++++++++++++++
 include/linux/mm.h      | 32 ++++++--------------------------
 2 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index b26810c..47f5204 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -72,6 +72,31 @@ static int create_rstor_token(unsigned long ssp, unsigned long *token_addr)
 	return 0;
 }
 
+/*
+ * VM_SHADOW_STACK will have a guard page. This helps userspace protect
+ * itself from attacks. The reasoning is as follows:
+ *
+ * The shadow stack pointer(SSP) is moved by CALL, RET, and INCSSPQ. The
+ * INCSSP instruction can increment the shadow stack pointer. It is the
+ * shadow stack analog of an instruction like:
+ *
+ *   addq $0x80, %rsp
+ *
+ * However, there is one important difference between an ADD on %rsp
+ * and INCSSP. In addition to modifying SSP, INCSSP also reads from the
+ * memory of the first and last elements that were "popped". It can be
+ * thought of as acting like this:
+ *
+ * READ_ONCE(ssp);       // read+discard top element on stack
+ * ssp += nr_to_pop * 8; // move the shadow stack
+ * READ_ONCE(ssp-8);     // read+discard last popped stack element
+ *
+ * The maximum distance INCSSP can move the SSP is 2040 bytes, before
+ * it would read the memory. Therefore a single page gap will be enough
+ * to prevent any operation from shifting the SSP to an adjacent stack,
+ * since it would have to land in the gap at least once, causing a
+ * fault.
+ */
 static unsigned long alloc_shstk(unsigned long addr, unsigned long size,
 				 unsigned long token_offset, bool set_res_tok)
 {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 97eddc8..8c0350c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -343,33 +343,13 @@ extern unsigned int kobjsize(const void *objp);
 
 #ifdef CONFIG_X86_USER_SHADOW_STACK
 /*
- * This flag should not be set with VM_SHARED because of lack of support
- * core mm. It will also get a guard page. This helps userspace protect
- * itself from attacks. The reasoning is as follows:
+ * VM_SHADOW_STACK should not be set with VM_SHARED because of lack of
+ * support core mm.
  *
- * The shadow stack pointer(SSP) is moved by CALL, RET, and INCSSPQ. The
- * INCSSP instruction can increment the shadow stack pointer. It is the
- * shadow stack analog of an instruction like:
- *
- *   addq $0x80, %rsp
- *
- * However, there is one important difference between an ADD on %rsp
- * and INCSSP. In addition to modifying SSP, INCSSP also reads from the
- * memory of the first and last elements that were "popped". It can be
- * thought of as acting like this:
- *
- * READ_ONCE(ssp);       // read+discard top element on stack
- * ssp += nr_to_pop * 8; // move the shadow stack
- * READ_ONCE(ssp-8);     // read+discard last popped stack element
- *
- * The maximum distance INCSSP can move the SSP is 2040 bytes, before
- * it would read the memory. Therefore a single page gap will be enough
- * to prevent any operation from shifting the SSP to an adjacent stack,
- * since it would have to land in the gap at least once, causing a
- * fault.
- *
- * Prevent using INCSSP to move the SSP between shadow stacks by
- * having a PAGE_SIZE guard gap.
+ * These VMAs will get a single end guard page. This helps userspace protect
+ * itself from attacks. A single page is enough for current shadow stack archs
+ * (x86). See the comments near alloc_shstk() in arch/x86/kernel/shstk.c
+ * for more details on the guard size.
  */
 # define VM_SHADOW_STACK	VM_HIGH_ARCH_5
 #else

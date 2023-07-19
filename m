Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A13375A26F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjGSWt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjGSWrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:47:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F87C2684;
        Wed, 19 Jul 2023 15:47:39 -0700 (PDT)
Date:   Wed, 19 Jul 2023 22:47:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689806856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ppNPHh3f9E+cmOMsAYNYdl/HFaDsQZr4n0zoMiYqEpg=;
        b=JsP9ptWu5aIynnRVwBf1qOa9MzpdSgopFSblOy5kohNp/4G5I+XoWyIlkkLbXT9Ev4HTRk
        TG30j2RvjEKy8SGQ5UVUhrN6D8LdkBY5Mwcml3i0UxGrjaT6DDmoyzkPZ96entj5SFly8d
        YvP1RvndTm9z8Fm5MGbSoDBYDbGbFeSM439blseMDUhuvwBSWx82CAugox09FQnomvLRRe
        ipxK0abfyiB1yOd+A658Q27PCKFbmAcuKsnmvGlTBJ2hzZjFwY3L3T6ZbwCfDp5ry+TWC8
        cwyantKzoH2Sr92GFaEnxCYWEmB9mfsJVc+fXFCR3qubS88tPTG06r6+hCkfkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689806856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ppNPHh3f9E+cmOMsAYNYdl/HFaDsQZr4n0zoMiYqEpg=;
        b=tLccNWNCEhdiFY6rjeUGOyX10RFkVPie9SMZe8PREP2JYAaC830gEalyt7jtDk5rpWEqkX
        ILmg01mc9d1y3SDw==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/mm: Warn if create Write=0,Dirty=1 with raw prot
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168980685638.28540.14035565704491484302.tip-bot2@tip-bot2>
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

Commit-ID:     ae1f05a617dcbc0a732fbeba0893786cd009536c
Gitweb:        https://git.kernel.org/tip/ae1f05a617dcbc0a732fbeba0893786cd009536c
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:10:44 -07:00
Committer:     Rick Edgecombe <rick.p.edgecombe@intel.com>
CommitterDate: Tue, 11 Jul 2023 14:12:19 -07:00

x86/mm: Warn if create Write=0,Dirty=1 with raw prot

When user shadow stack is in use, Write=0,Dirty=1 is treated by the CPU as
shadow stack memory. So for shadow stack memory this bit combination is
valid, but when Dirty=1,Write=1 (conventionally writable) memory is being
write protected, the kernel has been taught to transition the Dirty=1
bit to SavedDirty=1, to avoid inadvertently creating shadow stack
memory. It does this inside pte_wrprotect() because it knows the PTE is
not intended to be a writable shadow stack entry, it is supposed to be
write protected.

However, when a PTE is created by a raw prot using mk_pte(), mk_pte()
can't know whether to adjust Dirty=1 to SavedDirty=1. It can't
distinguish between the caller intending to create a shadow stack PTE or
needing the SavedDirty shift.

The kernel has been updated to not do this, and so Write=0,Dirty=1
memory should only be created by the pte_mkfoo() helpers. Add a warning
to make sure no new mk_pte() start doing this, like, for example,
set_memory_rox() did.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-19-rick.p.edgecombe%40intel.com
---
 arch/x86/include/asm/pgtable.h |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 9255b5b..61b5244 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1033,7 +1033,14 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
  * (Currently stuck as a macro because of indirect forward reference
  * to linux/mm.h:page_to_nid())
  */
-#define mk_pte(page, pgprot)   pfn_pte(page_to_pfn(page), (pgprot))
+#define mk_pte(page, pgprot)						  \
+({									  \
+	pgprot_t __pgprot = pgprot;					  \
+									  \
+	WARN_ON_ONCE((pgprot_val(__pgprot) & (_PAGE_DIRTY | _PAGE_RW)) == \
+		    _PAGE_DIRTY);					  \
+	pfn_pte(page_to_pfn(page), __pgprot);				  \
+})
 
 static inline int pmd_bad(pmd_t pmd)
 {

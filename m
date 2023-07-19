Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEE175A264
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjGSWs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjGSWru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:47:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9593C2127;
        Wed, 19 Jul 2023 15:47:37 -0700 (PDT)
Date:   Wed, 19 Jul 2023 22:47:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689806855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6RaDc0uxTpDv+FQGSYEtH1QqNCE6dth2JPIYxw7pRKE=;
        b=Jht+gsbTQDV1VCi8uZEMOvuiK5c6n6x9UXgxsGfTLtlBllB+VUElmVc1jqmMBKoWL+NOqG
        Rt3Cv9+9fOv+MGiEw/u4ewkBc/+vocb0tk5zV312yurGxj7axEEQjt7KVuDoEj84/M4usW
        m3TeOo01xMEUszXRM3igkhx7jLjSmLgdrFtrzosSICt/4aYhFMydMu4rHubhpWZ2e3bllM
        5viVMS0UBQFqxGIdUFUtOLQO08WGAMdQ5jPl0eW1rNKNgNWRsCg6fqqru04VJgXqtiZ3Ih
        cWiseo6d4N3XqEGcyxMLea0C4rjjGNfa3Vcc3KUPq/W0E8GvuTUEXxdZ+Jqx1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689806855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6RaDc0uxTpDv+FQGSYEtH1QqNCE6dth2JPIYxw7pRKE=;
        b=HkBiGbWW/TsWnjYg++SaZzsm818kzBfJRCrr/5RHSBWCEvoyI/zUxNvRG7N2pj2GTsShtg
        wqYdvqzoMHEr8/CA==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/mm: Teach pte_mkwrite() about stack memory
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Deepak Gupta <debug@rivosinc.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168980685497.28540.12778915917294389214.tip-bot2@tip-bot2>
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

Commit-ID:     b497e52ddb2ab750b00d8cc78209613558fc503b
Gitweb:        https://git.kernel.org/tip/b497e52ddb2ab750b00d8cc78209613558fc503b
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:10:47 -07:00
Committer:     Rick Edgecombe <rick.p.edgecombe@intel.com>
CommitterDate: Tue, 11 Jul 2023 14:12:19 -07:00

x86/mm: Teach pte_mkwrite() about stack memory

If a VMA has the VM_SHADOW_STACK flag, it is shadow stack memory. So
when it is made writable with pte_mkwrite(), it should create shadow
stack memory, not conventionally writable memory. Now that all the places
where shadow stack memory might be created pass a VMA into pte_mkwrite(),
it can know when it should do this.

So make pte_mkwrite() create shadow stack memory when the VMA has the
VM_SHADOW_STACK flag. Do the same thing for pmd_mkwrite().

This requires referencing VM_SHADOW_STACK in these functions, which are
currently defined in pgtable.h, however mm.h (where VM_SHADOW_STACK is
located) can't be pulled in without causing problems for files that
reference pgtable.h. So also move pte/pmd_mkwrite() into pgtable.c, where
they can safely reference VM_SHADOW_STACK.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: Deepak Gupta <debug@rivosinc.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-22-rick.p.edgecombe%40intel.com
---
 arch/x86/mm/pgtable.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 4bfbe4c..0d66aeb 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -875,6 +875,9 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 
 pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
+	if (vma->vm_flags & VM_SHADOW_STACK)
+		return pte_mkwrite_shstk(pte);
+
 	pte = pte_mkwrite_novma(pte);
 
 	return pte_clear_saveddirty(pte);
@@ -882,6 +885,9 @@ pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 
 pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 {
+	if (vma->vm_flags & VM_SHADOW_STACK)
+		return pmd_mkwrite_shstk(pmd);
+
 	pmd = pmd_mkwrite_novma(pmd);
 
 	return pmd_clear_saveddirty(pmd);

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1333B75A260
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjGSWsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjGSWru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:47:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AD72121;
        Wed, 19 Jul 2023 15:47:36 -0700 (PDT)
Date:   Wed, 19 Jul 2023 22:47:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689806855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Jpao/DukEzvG5d44DsDDaQVQhQWzCfmPyvpHDMkvxBk=;
        b=GLduqw7/r8nzEbh8++4tnTBP5doa7jNePLjFGEF8Dly3lcu3QRbF4f2z+KR4DGRAFXzbh2
        Y/wqKtzZu4tWpmdckCt6cXAXhpvCpMAQDtVZP4c2UwenQxjuPcAGxCOI2OQ2SPdIFt2qMB
        3eSaQwqhArMfuRVZ65P51PL7Vb8/3/uK06VO+HI1PUOfDv5aF4gC1p0xlWU3ocC2+XNbCz
        lcpxyC7Ohnr2jnx98Ayd8bduq6WFsy0fSxoQHB4y8E1R7Oie0oaV0i4otVoLo7YTgDOpdN
        fbtykWS8DuGiy+SPkJt0Xq+Q7Czql/XPjQKyLmu/d7KrB/dODVqCTj7FMdp2Nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689806855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Jpao/DukEzvG5d44DsDDaQVQhQWzCfmPyvpHDMkvxBk=;
        b=2rdEwFwnC9qDv2/Nek2MFhGUI+g5JlzUZptLhQVameKbL/kGf4YGi1qMVaTiwVc3QN6g/X
        bYInpED9W70opiDw==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] mm: Don't allow write GUPs to shadow stack memory
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168980685456.28540.8149705038742119504.tip-bot2@tip-bot2>
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

Commit-ID:     7c8f82db8acb9f0935703c0d96cda552bbf91ff2
Gitweb:        https://git.kernel.org/tip/7c8f82db8acb9f0935703c0d96cda552bbf91ff2
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:10:48 -07:00
Committer:     Rick Edgecombe <rick.p.edgecombe@intel.com>
CommitterDate: Tue, 11 Jul 2023 14:12:47 -07:00

mm: Don't allow write GUPs to shadow stack memory

The x86 Control-flow Enforcement Technology (CET) feature includes a
new type of memory called shadow stack. This shadow stack memory has
some unusual properties, which requires some core mm changes to
function properly.

In userspace, shadow stack memory is writable only in very specific,
controlled ways. However, since userspace can, even in the limited
ways, modify shadow stack contents, the kernel treats it as writable
memory. As a result, without additional work there would remain many
ways for userspace to trigger the kernel to write arbitrary data to
shadow stacks via get_user_pages(, FOLL_WRITE) based operations. To
help userspace protect their shadow stacks, make this a little less
exposed by blocking writable get_user_pages() operations for shadow
stack VMAs.

Still allow FOLL_FORCE to write through shadow stack protections, as it
does for read-only protections. This is required for debugging use
cases.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-23-rick.p.edgecombe%40intel.com
---
 arch/x86/include/asm/pgtable.h | 5 +++++
 mm/gup.c                       | 6 +-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 61b5244..e95cfd3 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1631,6 +1631,11 @@ static inline bool __pte_access_permitted(unsigned long pteval, bool write)
 {
 	unsigned long need_pte_bits = _PAGE_PRESENT|_PAGE_USER;
 
+	/*
+	 * Write=0,Dirty=1 PTEs are shadow stack, which the kernel
+	 * shouldn't generally allow access to, but since they
+	 * are already Write=0, the below logic covers both cases.
+	 */
 	if (write)
 		need_pte_bits |= _PAGE_RW;
 
diff --git a/mm/gup.c b/mm/gup.c
index 76d222c..86ccdb7 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1050,11 +1050,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 		return -EFAULT;
 
 	if (write) {
-		if (!vma_anon &&
-		    !writable_file_mapping_allowed(vma, gup_flags))
-			return -EFAULT;
-
-		if (!(vm_flags & VM_WRITE)) {
+		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
 			if (!(gup_flags & FOLL_FORCE))
 				return -EFAULT;
 			/* hugetlb does not support FOLL_FORCE|FOLL_WRITE. */

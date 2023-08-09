Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93EE776AB6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjHIVG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjHIVG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 17:06:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64E5138;
        Wed,  9 Aug 2023 14:06:56 -0700 (PDT)
Date:   Wed, 09 Aug 2023 21:06:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691615215;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8iC6K4qMca1HxvCjZ+227qIOOBi29M4/B4ry0PMUGMM=;
        b=lGWbP+0kYVNSySa3BRb4DJv8qEN/FE/dh+bZIhuSWyJ/OrljPzjIdOihfEw65n8rTk29iE
        7ZKlJO+9u6bPCcBWtRo+JfiSQr7w7915dNwwhIyS7UDXFMzEYNfR8Qlnju9aCovEM0gd49
        H9ZmcSyH2KHE72/w5EdGOXaQ/0fMP/aHHa32Vlhm4jgZsGA5U7WGMfwDFfTEQ9rkFaeBHO
        loLs/SNY6zn+2/KBzlDHwyezIKpr9kGEwzB7sBHQVH5rrNFUBL0tZlBR9mG0XXhI8P+3PH
        Jb1nqqvAh5rKZqHrCWg614+jhtt4dCKOPgJvoEfBnNvhp3ulEVsHX47fLesQow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691615215;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8iC6K4qMca1HxvCjZ+227qIOOBi29M4/B4ry0PMUGMM=;
        b=8vqZKJqY3mB6hBcbwK9jhkZFRORLgSUeTBeLp3m4kqRrbVSzPtIPZNjFpY9Hx5RhRkDE4O
        BBE3C9EnprNJm4DQ==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm: Fix VDSO and VVAR placement on 5-level
 paging machines
Cc:     Yingcong Wu <yingcong.wu@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        stable@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169161521427.27769.11895332773100602883.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     1b8b1aa90c9c0e825b181b98b8d9e249dc395470
Gitweb:        https://git.kernel.org/tip/1b8b1aa90c9c0e825b181b98b8d9e249dc395470
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Thu, 03 Aug 2023 18:16:09 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 13:38:48 -07:00

x86/mm: Fix VDSO and VVAR placement on 5-level paging machines

Yingcong has noticed that on the 5-level paging machine, VDSO and VVAR
VMAs are placed above the 47-bit border:

8000001a9000-8000001ad000 r--p 00000000 00:00 0                          [vvar]
8000001ad000-8000001af000 r-xp 00000000 00:00 0                          [vdso]

This might confuse users who are not aware of 5-level paging and expect
all userspace addresses to be under the 47-bit border.

So far problem has only been triggered with ASLR disabled, although it
may also occur with ASLR enabled if the layout is randomized in a just
right way.

The problem happens due to custom placement for the VMAs in the VDSO
code: vdso_addr() tries to place them above the stack and checks the
result against TASK_SIZE_MAX, which is wrong. TASK_SIZE_MAX is set to
the 56-bit border on 5-level paging machines. Use DEFAULT_MAP_WINDOW
instead.

Fixes: b569bab78d8d ("x86/mm: Prepare to expose larger address space to userspace")
Reported-by: Yingcong Wu <yingcong.wu@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20230803151609.22141-1-kirill.shutemov%40linux.intel.com
---
 arch/x86/entry/vdso/vma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 11a5c68..7645730 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -299,8 +299,8 @@ static unsigned long vdso_addr(unsigned long start, unsigned len)
 
 	/* Round the lowest possible end address up to a PMD boundary. */
 	end = (start + len + PMD_SIZE - 1) & PMD_MASK;
-	if (end >= TASK_SIZE_MAX)
-		end = TASK_SIZE_MAX;
+	if (end >= DEFAULT_MAP_WINDOW)
+		end = DEFAULT_MAP_WINDOW;
 	end -= len;
 
 	if (end > start) {

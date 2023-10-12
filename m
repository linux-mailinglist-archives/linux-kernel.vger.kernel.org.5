Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F6A7C7773
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442541AbjJLTye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442588AbjJLTy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:54:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066A8DA;
        Thu, 12 Oct 2023 12:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=CSyPT7b+OGrcLFhMzi1tWe4i8irwCIBA39LooloVVJI=; b=rIqwWkkvXo/CE5Euy2SwaFBxhU
        801Ba4eMfLWmgrn1MXv3PKag+tTKsavJbeMJwqNtD7uF35YP3EMCYSXQa1m0wxcVCHRb6ywGJLmWj
        ACsJomCKgV8Jo1WvXVKZtCZIpMF22aqC+M463aa/CpAWBzHZnTGL4e+GnIKf6/8zxbymD43OzHTB1
        Bs/9qFG/TYzl5CppW9Sk912lGrLi7vgfS03lrrxcZNFCHu5l6Q51Fsn9DTibGNc2twZ6IDBCl2f/T
        99WhlqG3f9laCDRDDWz/PkZdMUVCnhUQrt1HfF7AqBk2qVjJyt0bvw5ag39BTRCjlIf9znJLL6vyZ
        bu3cqdzQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qr1lA-001BSa-Fn; Thu, 12 Oct 2023 19:54:16 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-sparc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Erhard Furtner <erhard_f@mailbox.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 2/2] sparc: Allow nesting of lazy MMU mode
Date:   Thu, 12 Oct 2023 20:54:15 +0100
Message-Id: <20231012195415.282357-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231012195415.282357-1-willy@infradead.org>
References: <20231012195415.282357-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As noted in commit 49147beb0ccb ("x86/xen: allow nesting of same lazy
mode"), we can now nest calls to arch_enter_lazy_mmu_mode().  Use ->active
as a counter instead of a flag and only drain the batch when the counter
hits 0.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Fixes: bcc6cc832573 ("mm: add default definition of set_ptes()")
---
 arch/sparc/mm/tlb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index b44d79d778c7..a82c7c32e47d 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -54,16 +54,15 @@ void arch_enter_lazy_mmu_mode(void)
 {
 	struct tlb_batch *tb = this_cpu_ptr(&tlb_batch);
 
-	tb->active = 1;
+	tb->active++;
 }
 
 void arch_leave_lazy_mmu_mode(void)
 {
 	struct tlb_batch *tb = this_cpu_ptr(&tlb_batch);
 
-	if (tb->tlb_nr)
+	if ((--tb->active == 0) && tb->tlb_nr)
 		flush_tlb_pending();
-	tb->active = 0;
 }
 
 static void tlb_batch_add_one(struct mm_struct *mm, unsigned long vaddr,
-- 
2.40.1


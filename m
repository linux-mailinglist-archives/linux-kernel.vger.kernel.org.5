Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FFC7E8475
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346380AbjKJUmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346241AbjKJUmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:42:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F0446BD;
        Fri, 10 Nov 2023 12:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=25QfWharHbMWrIl6caRn0CZ+MZ75oP4Z9qoseEg2zjc=; b=VtlHsuyG81kZTqbBNIglKsUA0j
        NhxzGv8c91tUS6E+YAnLht71Pq8PLu7ZDmoMvu106yZEX5Kl7ViDhN7Qx+Cb+X8hODeZldt8xfMd+
        bT4PCX2OFJrqE0sUJ0OZ3bx78GDIcbAJ2wfvrTPW0psqAXRuZFkr6WADJUBlQuhRYf3P/sRmjM2xx
        nQzc1dQq43nkYvCVN2v6thH/fsFm59/CUZOhiEgN8Rc9AlKRmnwqa1pac1ygpGKR007h2pAVu/7VE
        cxvROJ3Ixoz+pKs7BIRw+5LjUk/0dmGjChbBgW+KE26RME/Nn5uTd0ehSIJ9ltZr47+ZV2c3QZd7C
        Qp9DOl8g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r1YJd-00FUT6-51; Fri, 10 Nov 2023 20:41:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 2/4] mm: Use rwsem assertion macros for mmap_lock
Date:   Fri, 10 Nov 2023 20:41:17 +0000
Message-Id: <20231110204119.3692023-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231110204119.3692023-1-willy@infradead.org>
References: <20231110204119.3692023-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This slightly strengthens our write assertion when lockdep is disabled.
It also downgrades us from BUG_ON to WARN_ON, but I think that's an
improvement.  I don't think dumping the mm_struct was all that valuable;
the call chain is what's important.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mmap_lock.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 8d38dcb6d044..de9dc20b01ba 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -60,16 +60,14 @@ static inline void __mmap_lock_trace_released(struct mm_struct *mm, bool write)
 
 #endif /* CONFIG_TRACING */
 
-static inline void mmap_assert_locked(struct mm_struct *mm)
+static inline void mmap_assert_locked(const struct mm_struct *mm)
 {
-	lockdep_assert_held(&mm->mmap_lock);
-	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
+	rwsem_assert_held(&mm->mmap_lock);
 }
 
-static inline void mmap_assert_write_locked(struct mm_struct *mm)
+static inline void mmap_assert_write_locked(const struct mm_struct *mm)
 {
-	lockdep_assert_held_write(&mm->mmap_lock);
-	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
+	rwsem_assert_held_write(&mm->mmap_lock);
 }
 
 #ifdef CONFIG_PER_VMA_LOCK
-- 
2.42.0


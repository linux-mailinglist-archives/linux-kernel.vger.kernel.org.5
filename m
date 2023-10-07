Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303D57BC9D2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 22:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344183AbjJGUg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 16:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344207AbjJGUgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 16:36:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE1F93;
        Sat,  7 Oct 2023 13:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TkvZj289LjVT0INkRek2vP8VRKU8xKxNyMII+enlEWg=; b=Cr3o8RWM58gE0W4E+dSE8SE0UL
        Xdcas8AZH3bSf8486FYpIVyUco+VLPvf8wArWBxyCMYcnkQZ5EHF6gBsxnToFtBVVVJGVweSpnVXG
        pVd5zoHUthMI/p+Fw5DlYC8zihzCaba7WMrYWvlsg35gA9HJoxVD5QlfNdxIbV6B49ZS27saqgbkn
        m0pDKlI9KhEULZMOZCA2a44zVKUNvfOAi/6aiqRxOCvy+CLRBqDu5K+/CSPv/tCHzTULgIAgcedI+
        8Oc/wngAVrGkFfEWscWUjCALfTLekMn69t9FAP5LxXoUB+utuJ1/nJjrk2DNbLHtZQDB8SnVbkP0O
        RMOIsMmw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qpE1Y-005mLC-LZ; Sat, 07 Oct 2023 20:35:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 2/5] mm: Use rwsem assertion macros for mmap_lock
Date:   Sat,  7 Oct 2023 21:35:40 +0100
Message-Id: <20231007203543.1377452-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231007203543.1377452-1-willy@infradead.org>
References: <20231007203543.1377452-1-willy@infradead.org>
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
2.40.1


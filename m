Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5735F797AA1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245441AbjIGRro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245369AbjIGRrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:47:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61BCBD;
        Thu,  7 Sep 2023 10:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VXFBeiZYZLxdE1EgCNB8C70Cr3AOFx9IwJaa1llihbg=; b=DV83kF/eITv9Kv5OQQmtmcXh4s
        aLB2PI2hxlu4An2NjCFMYLMGM0Yuq/dEbT1Zmb9aJ4Xc9KSmRjqtBtstT/W86jThMfVSYimGMHEBG
        RpTPu//7Bm/ZI/jY6/+Mdekr4QY8VSy2YQChZKQFh3JEyNgS06MTdLvu4t4UQY09KSLfv7PsS6NoW
        Ksxmeb8/rMLRtMuq8/2lhgreBwJdoa1fxIrLHb51vg+QFQj2yu2nqRD025IPMcZM31nfpA53D+F8V
        A+5xrl872htBCCIDaIg+jApOm9GX39pCayQ6NfVTrWvrExjy2cfEd/jc5XIW3Rrih2yROq4N02YA9
        LNCPCoDA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qeJ5w-00CUFM-0r; Thu, 07 Sep 2023 17:47:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: [PATCH 2/5] mm: Use rwsem_is_write_locked in mmap_assert_write_locked
Date:   Thu,  7 Sep 2023 18:47:02 +0100
Message-Id: <20230907174705.2976191-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230907174705.2976191-1-willy@infradead.org>
References: <20230907174705.2976191-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This slightly strengthens our checks when lockdep is disabled.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mmap_lock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 8d38dcb6d044..0258b06668e8 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -69,7 +69,7 @@ static inline void mmap_assert_locked(struct mm_struct *mm)
 static inline void mmap_assert_write_locked(struct mm_struct *mm)
 {
 	lockdep_assert_held_write(&mm->mmap_lock);
-	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
+	VM_BUG_ON_MM(!rwsem_is_write_locked(&mm->mmap_lock), mm);
 }
 
 #ifdef CONFIG_PER_VMA_LOCK
-- 
2.40.1


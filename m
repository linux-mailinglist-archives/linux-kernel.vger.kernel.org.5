Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865127EF4C6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjKQOvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjKQOvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:51:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9D693;
        Fri, 17 Nov 2023 06:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=JrgaNSZkbdttPU8m7IV9E3SqR4RsniiNUF24kh9JfO8=; b=j0pCGrSveYKYRXtt4HIE3G3IaJ
        /XXSDQT1KRDKsvIp0aEw1OPQ3r6ItpfPvYmp9t5iO2Dt1LT3Nm+QMU4PLIh2lNQ/Whkvl2XHXKcg/
        NUmkcSyCUy2Pw1gzXv5O0ETHuP1cxAfVP4uISEcYEggWj4OEXXBdm4BVxFum5Nq1HfBFmaZQAVFUs
        hwq+cjIJVhokWwYI+yme5U4DfMhLpSRVRm1vIS0Jjg3qGTkiUhTYpYJQ6ge1tExmFzieL1U4DfYdx
        yDJC32wJJnGckiV08EUX7cyJrxzf+PZirjLBGP/VtznM+WnX/sAgooLYKkDbVDax43ZtDkrlNG2qB
        q7D+hQNg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r40C7-009ypx-OE; Fri, 17 Nov 2023 14:51:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v4 1/4] locking: Add rwsem_assert_held() and rwsem_assert_held_write()
Date:   Fri, 17 Nov 2023 14:51:39 +0000
Message-Id: <20231117145142.2378800-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231117145142.2378800-1-willy@infradead.org>
References: <20231117145142.2378800-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modelled after lockdep_assert_held() and lockdep_assert_held_write(),
but are always active, even when lockdep is disabled.  Of course, they
don't test that _this_ thread is the owner, but it's sufficient to catch
many bugs and doesn't incur the same performance penalty as lockdep.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/rwbase_rt.h |  9 ++++++--
 include/linux/rwsem.h     | 46 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/include/linux/rwbase_rt.h b/include/linux/rwbase_rt.h
index 1d264dd08625..29c4e4f243e4 100644
--- a/include/linux/rwbase_rt.h
+++ b/include/linux/rwbase_rt.h
@@ -26,12 +26,17 @@ struct rwbase_rt {
 	} while (0)
 
 
-static __always_inline bool rw_base_is_locked(struct rwbase_rt *rwb)
+static __always_inline bool rw_base_is_locked(const struct rwbase_rt *rwb)
 {
 	return atomic_read(&rwb->readers) != READER_BIAS;
 }
 
-static __always_inline bool rw_base_is_contended(struct rwbase_rt *rwb)
+static inline void rw_base_assert_held_write(const struct rwbase_rt *rwb)
+{
+	WARN_ON(atomic_read(&rwb->readers) != WRITER_BIAS);
+}
+
+static __always_inline bool rw_base_is_contended(const struct rwbase_rt *rwb)
 {
 	return atomic_read(&rwb->readers) > 0;
 }
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 1dd530ce8b45..e032b9644af5 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -66,14 +66,24 @@ struct rw_semaphore {
 #endif
 };
 
-/* In all implementations count != 0 means locked */
+#define RWSEM_UNLOCKED_VALUE		0UL
+#define RWSEM_WRITER_LOCKED		(1UL << 0)
+#define __RWSEM_COUNT_INIT(name)	.count = ATOMIC_LONG_INIT(RWSEM_UNLOCKED_VALUE)
+
 static inline int rwsem_is_locked(struct rw_semaphore *sem)
 {
-	return atomic_long_read(&sem->count) != 0;
+	return atomic_long_read(&sem->count) != RWSEM_UNLOCKED_VALUE;
 }
 
-#define RWSEM_UNLOCKED_VALUE		0L
-#define __RWSEM_COUNT_INIT(name)	.count = ATOMIC_LONG_INIT(RWSEM_UNLOCKED_VALUE)
+static inline void rwsem_assert_held_nolockdep(const struct rw_semaphore *sem)
+{
+	WARN_ON(atomic_long_read(&sem->count) == RWSEM_UNLOCKED_VALUE);
+}
+
+static inline void rwsem_assert_held_write_nolockdep(const struct rw_semaphore *sem)
+{
+	WARN_ON(!(atomic_long_read(&sem->count) & RWSEM_WRITER_LOCKED));
+}
 
 /* Common initializer macros and functions */
 
@@ -152,11 +162,21 @@ do {								\
 	__init_rwsem((sem), #sem, &__key);			\
 } while (0)
 
-static __always_inline int rwsem_is_locked(struct rw_semaphore *sem)
+static __always_inline int rwsem_is_locked(const struct rw_semaphore *sem)
 {
 	return rw_base_is_locked(&sem->rwbase);
 }
 
+static inline void rwsem_assert_held_nolockdep(const struct rw_semaphore *sem)
+{
+	WARN_ON(!rwsem_is_locked(sem));
+}
+
+static inline void rwsem_assert_held_write_nolockdep(const struct rw_semaphore *sem)
+{
+	rw_base_assert_held_write(sem);
+}
+
 static __always_inline int rwsem_is_contended(struct rw_semaphore *sem)
 {
 	return rw_base_is_contended(&sem->rwbase);
@@ -169,6 +189,22 @@ static __always_inline int rwsem_is_contended(struct rw_semaphore *sem)
  * the RT specific variant.
  */
 
+static inline void rwsem_assert_held(const struct rw_semaphore *sem)
+{
+	if (IS_ENABLED(CONFIG_LOCKDEP))
+		lockdep_assert_held(sem);
+	else
+		rwsem_assert_held_nolockdep(sem);
+}
+
+static inline void rwsem_assert_held_write(const struct rw_semaphore *sem)
+{
+	if (IS_ENABLED(CONFIG_LOCKDEP))
+		lockdep_assert_held_write(sem);
+	else
+		rwsem_assert_held_write_nolockdep(sem);
+}
+
 /*
  * lock for reading
  */
-- 
2.42.0


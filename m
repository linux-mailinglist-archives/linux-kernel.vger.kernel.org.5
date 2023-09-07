Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9187B797AC0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245399AbjIGRsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245527AbjIGRru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:47:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D261FF3;
        Thu,  7 Sep 2023 10:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=LLFJT9lhOndsodIHfPQ9LEtDlXX6YGclPNMO2t1USgU=; b=jAKEfKshiWNUs4KA27DrmnJak0
        fotEfuCnFgJxrpNUy54FTDDByW/E9sBz1SE2zakIlZJhp1hvXQ/JrczFhZlH5vBtzyTCrBEViEZ1r
        rD2XlLJb/lmeXQvvhgAR1iFsykO9s7L/WtUzp4faEt4pLZWRXY68YIibxqDRTv/VmZzG6Z/HQjVcK
        WuDOyAggJnPFYDxeVSPWQmtmGsGIvkM67ia+qMuyl1Axj3bfOOoVGq16Elsg7Un3O2gVO45V950KH
        Cs5NbUja00oSR1Ep8FiYLK7eeJGKRtDPUrjGr35KP12gtU4KJaIFuyWbCHsCgPd1jB3NrkeDddkYO
        lp9gc8kQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qeJ5v-00CUFJ-Uv; Thu, 07 Sep 2023 17:47:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: [PATCH 1/5] locking: Add rwsem_is_write_locked()
Date:   Thu,  7 Sep 2023 18:47:01 +0100
Message-Id: <20230907174705.2976191-2-willy@infradead.org>
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

Several places want to know whether the lock is held by a writer, instead
of just whether it's held.  We can implement this for both normal and
rt rwsems.  RWSEM_WRITER_LOCKED is declared in rwsem.c and exposing
it outside that file might tempt other people to use it, so just use
a comment to note that's what the 1 means, and help anybody find it if
they're looking to change the implementation.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/rwbase_rt.h |  5 +++++
 include/linux/rwsem.h     | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/rwbase_rt.h b/include/linux/rwbase_rt.h
index 1d264dd08625..3c25b14edc05 100644
--- a/include/linux/rwbase_rt.h
+++ b/include/linux/rwbase_rt.h
@@ -31,6 +31,11 @@ static __always_inline bool rw_base_is_locked(struct rwbase_rt *rwb)
 	return atomic_read(&rwb->readers) != READER_BIAS;
 }
 
+static __always_inline bool rw_base_is_write_locked(struct rwbase_rt *rwb)
+{
+	return atomic_read(&rwb->readers) == WRITER_BIAS;
+}
+
 static __always_inline bool rw_base_is_contended(struct rwbase_rt *rwb)
 {
 	return atomic_read(&rwb->readers) > 0;
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 1dd530ce8b45..0f78b8d2e653 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -72,6 +72,11 @@ static inline int rwsem_is_locked(struct rw_semaphore *sem)
 	return atomic_long_read(&sem->count) != 0;
 }
 
+static inline int rwsem_is_write_locked(struct rw_semaphore *sem)
+{
+	return atomic_long_read(&sem->count) & 1 /* RWSEM_WRITER_LOCKED */;
+}
+
 #define RWSEM_UNLOCKED_VALUE		0L
 #define __RWSEM_COUNT_INIT(name)	.count = ATOMIC_LONG_INIT(RWSEM_UNLOCKED_VALUE)
 
@@ -157,6 +162,11 @@ static __always_inline int rwsem_is_locked(struct rw_semaphore *sem)
 	return rw_base_is_locked(&sem->rwbase);
 }
 
+static __always_inline int rwsem_is_write_locked(struct rw_semaphore *sem)
+{
+	return rw_base_is_write_locked(&sem->rwbase);
+}
+
 static __always_inline int rwsem_is_contended(struct rw_semaphore *sem)
 {
 	return rw_base_is_contended(&sem->rwbase);
-- 
2.40.1


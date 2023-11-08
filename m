Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A9D7E5903
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbjKHObV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjKHOax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:30:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4282121
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699453792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=X+mW6S3E9PxzlJ59KYM6a9lo9aW4LQzFCn0v6EM+0/M=;
        b=SohCgCHzOd+FtyLMSTrKLN90hXDhSqbg+OiBe+Xpdc8yipNNv0O3HuNys3qA1eArbcq8NB
        MUq+PLlqzHMM1z5FUc19bxjZ2oF4hQFu2cn3CO2CPcoKrlRR78+SIqi1EBHK4XpSJbKFiy
        4Gzzg36nlZrfAXkQ1uJTjSXAbxm3sy4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-Rd2hbUbZN7WUv2LuyFooUA-1; Wed,
 08 Nov 2023 09:29:49 -0500
X-MC-Unique: Rd2hbUbZN7WUv2LuyFooUA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A90D3C108D8;
        Wed,  8 Nov 2023 14:29:49 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A90722166B26;
        Wed,  8 Nov 2023 14:29:48 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] locking/rwsem: Clarify that RWSEM_READER_OWNED is just a hint
Date:   Wed,  8 Nov 2023 09:29:36 -0500
Message-Id: <20231108142936.831960-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clarify in the comments that the RWSEM_READER_OWNED bit in the owner
field is just a hint, not an authoritative state of the rwsem.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 2340b6d90ec6..c6d17aee4209 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -35,7 +35,7 @@
 /*
  * The least significant 2 bits of the owner value has the following
  * meanings when set.
- *  - Bit 0: RWSEM_READER_OWNED - The rwsem is owned by readers
+ *  - Bit 0: RWSEM_READER_OWNED - rwsem may be owned by readers (just a hint)
  *  - Bit 1: RWSEM_NONSPINNABLE - Cannot spin on a reader-owned lock
  *
  * When the rwsem is reader-owned and a spinning writer has timed out,
@@ -1002,8 +1002,8 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 
 	/*
 	 * To prevent a constant stream of readers from starving a sleeping
-	 * waiter, don't attempt optimistic lock stealing if the lock is
-	 * currently owned by readers.
+	 * writer, don't attempt optimistic lock stealing if the lock is
+	 * very likely owned by readers.
 	 */
 	if ((atomic_long_read(&sem->owner) & RWSEM_READER_OWNED) &&
 	    (rcnt > 1) && !(count & RWSEM_WRITER_LOCKED))
-- 
2.39.3


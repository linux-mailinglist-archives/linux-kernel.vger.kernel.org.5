Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B738B756B58
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjGQSKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjGQSKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:10:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E53E4C;
        Mon, 17 Jul 2023 11:10:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCA20611D6;
        Mon, 17 Jul 2023 18:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B81C433C7;
        Mon, 17 Jul 2023 18:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617408;
        bh=Tn6tTasSlGqo3gwhYaxuUliXOXbDqye5oZ+0i/Onq8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h5HjUxes+ELBhNY0CMUKHpmZtNKWy0IYcEVAdrokfmWslGHMxtdKgqIOcb/q2lRFg
         2hx9yHERoORe95PQPCbtvkbQUEAOWxIPjv5tTlO2aW0hwiAxYRei9UCe/ke+jGVX7O
         nLQvqQyBxCxngOTfdOLkwDbhstXvuAB+kfpptmonqe2184Y7OuxDSv3FVDmCiPJGPN
         56NPOIHyq/POMJtcuSmNP6ylywiHDqo+1GhWIYMrNFYuBLKc23OromzT2quoyHl9A3
         lOKWBvNm2om4OUmfWcyjaH6yG/d/zZeZ2+QhQGYX2QL2Yt7TFPrhD0KpLQwGkgUw0O
         hZpt4Y9bVzubQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D2181CE04CD; Mon, 17 Jul 2023 11:10:07 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Waiman Long <longman@redhat.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/3] refscale: Fix uninitalized use of wait_queue_head_t
Date:   Mon, 17 Jul 2023 11:10:05 -0700
Message-Id: <20230717181006.1097957-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2c4aea8b-6f82-45ab-988e-a6bb19129808@paulmck-laptop>
References: <2c4aea8b-6f82-45ab-988e-a6bb19129808@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Waiman Long <longman@redhat.com>

Running the refscale test occasionally crashes the kernel with the
following error:

[ 8569.952896] BUG: unable to handle page fault for address: ffffffffffffffe8
[ 8569.952900] #PF: supervisor read access in kernel mode
[ 8569.952902] #PF: error_code(0x0000) - not-present page
[ 8569.952904] PGD c4b048067 P4D c4b049067 PUD c4b04b067 PMD 0
[ 8569.952910] Oops: 0000 [#1] PREEMPT_RT SMP NOPTI
[ 8569.952916] Hardware name: Dell Inc. PowerEdge R750/0WMWCR, BIOS 1.2.4 05/28/2021
[ 8569.952917] RIP: 0010:prepare_to_wait_event+0x101/0x190
  :
[ 8569.952940] Call Trace:
[ 8569.952941]  <TASK>
[ 8569.952944]  ref_scale_reader+0x380/0x4a0 [refscale]
[ 8569.952959]  kthread+0x10e/0x130
[ 8569.952966]  ret_from_fork+0x1f/0x30
[ 8569.952973]  </TASK>

The likely cause is that init_waitqueue_head() is called after the call to
the torture_create_kthread() function that creates the ref_scale_reader
kthread.  Although this init_waitqueue_head() call will very likely
complete before this kthread is created and starts running, it is
possible that the calling kthread will be delayed between the calls to
torture_create_kthread() and init_waitqueue_head().  In this case, the
new kthread will use the waitqueue head before it is properly initialized,
which is not good for the kernel's health and well-being.

The above crash happened here:

	static inline void __add_wait_queue(...)
	{
		:
		if (!(wq->flags & WQ_FLAG_PRIORITY)) <=== Crash here

The offset of flags from list_head entry in wait_queue_entry is
-0x18. If reader_tasks[i].wq.head.next is NULL as allocated reader_task
structure is zero initialized, the instruction will try to access address
0xffffffffffffffe8, which is exactly the fault address listed above.

This commit therefore invokes init_waitqueue_head() before creating
the kthread.

Fixes: 653ed64b01dc ("refperf: Add a test to measure performance of read-side synchronization")
Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 1970ce5f22d4..71d138573856 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -1107,12 +1107,11 @@ ref_scale_init(void)
 	VERBOSE_SCALEOUT("Starting %d reader threads", nreaders);
 
 	for (i = 0; i < nreaders; i++) {
+		init_waitqueue_head(&reader_tasks[i].wq);
 		firsterr = torture_create_kthread(ref_scale_reader, (void *)i,
 						  reader_tasks[i].task);
 		if (torture_init_error(firsterr))
 			goto unwind;
-
-		init_waitqueue_head(&(reader_tasks[i].wq));
 	}
 
 	// Main Task
-- 
2.40.1


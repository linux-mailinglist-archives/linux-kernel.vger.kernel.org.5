Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1C37D53C7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343588AbjJXOUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbjJXOT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:19:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8243B6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698157151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FzoE+t/xa/RBIqwiGU6BCs2knHD6IlCAWWR1/udDPMk=;
        b=NFjNA2znSaaNjKQPiEvpoJPhSaMuhAJDLz4EU/fOijLG7StTKY/xnMBSryel7SsKCyKim4
        HFxRDuOlWQNmBzbbpUFpNCYZ+Z52MYj52O8HjRrxkZlIBrxJ8uBQ+xkVUScbIMyykCWvil
        iRzoJXxOgN3uZTO3yXc/Y7ckoOcx3is=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-MkTUii1tPdefPQcswqZvkw-1; Tue, 24 Oct 2023 10:19:06 -0400
X-MC-Unique: MkTUii1tPdefPQcswqZvkw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4109C101A53B;
        Tue, 24 Oct 2023 14:19:05 +0000 (UTC)
Received: from llong.com (unknown [10.22.10.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E7C3492BFB;
        Tue, 24 Oct 2023 14:19:02 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Xia Fukun <xiafukun@huawei.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2] cgroup/cpuset: Change nr_deadline_tasks to an atomic_t value
Date:   Tue, 24 Oct 2023 10:18:34 -0400
Message-Id: <20231024141834.4073262-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nr_deadline_tasks field in cpuset structure was introduced by
commit 6c24849f5515 ("sched/cpuset: Keep track of SCHED_DEADLINE task
in cpusets"). Unlike nr_migrate_dl_tasks which is only modified under
cpuset_mutex, nr_deadline_tasks can be updated under two different
locks - cpuset_mutex in most cases or css_set_lock in cgroup_exit(). As
a result, data races can happen leading to incorrect nr_deadline_tasks
value.

Since it is not practical to somehow take cpuset_mutex in cgroup_exit(),
the easy way out to avoid this possible race condition is by making
nr_deadline_tasks an atomic_t value.

Fixes: 6c24849f5515 ("sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets")
Reported-by: Xia Fukun <xiafukun@huawei.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 58ec88efa4f8..3f3da468f058 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -174,7 +174,7 @@ struct cpuset {
 	 * number of SCHED_DEADLINE tasks attached to this cpuset, so that we
 	 * know when to rebuild associated root domain bandwidth information.
 	 */
-	int nr_deadline_tasks;
+	atomic_t nr_deadline_tasks;
 	int nr_migrate_dl_tasks;
 	u64 sum_migrate_dl_bw;
 
@@ -234,14 +234,14 @@ void inc_dl_tasks_cs(struct task_struct *p)
 {
 	struct cpuset *cs = task_cs(p);
 
-	cs->nr_deadline_tasks++;
+	atomic_inc(&cs->nr_deadline_tasks);
 }
 
 void dec_dl_tasks_cs(struct task_struct *p)
 {
 	struct cpuset *cs = task_cs(p);
 
-	cs->nr_deadline_tasks--;
+	atomic_dec(&cs->nr_deadline_tasks);
 }
 
 /* bits in struct cpuset flags field */
@@ -1071,7 +1071,7 @@ static void dl_update_tasks_root_domain(struct cpuset *cs)
 	struct css_task_iter it;
 	struct task_struct *task;
 
-	if (cs->nr_deadline_tasks == 0)
+	if (atomic_read(&cs->nr_deadline_tasks) == 0)
 		return;
 
 	css_task_iter_start(&cs->css, 0, &it);
@@ -2721,8 +2721,8 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	cs->old_mems_allowed = cpuset_attach_nodemask_to;
 
 	if (cs->nr_migrate_dl_tasks) {
-		cs->nr_deadline_tasks += cs->nr_migrate_dl_tasks;
-		oldcs->nr_deadline_tasks -= cs->nr_migrate_dl_tasks;
+		atomic_add(cs->nr_migrate_dl_tasks, &cs->nr_deadline_tasks);
+		atomic_sub(cs->nr_migrate_dl_tasks, &oldcs->nr_deadline_tasks);
 		reset_migrate_dl_data(cs);
 	}
 
-- 
2.39.3


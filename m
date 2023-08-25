Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE078788D29
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 18:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343979AbjHYQVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 12:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344004AbjHYQVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 12:21:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80111991
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 09:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692980444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=k+LON5n1Edxrfcmnk444h4+WmPGNpJEbekR11bu5AwM=;
        b=QdCXm1cjge0862CxOmRBFiMQzNBlj2ecS68mxPPAox7/MRyMhQZOc6bu8w2lU1YPiPGl1P
        2AQwk83+c5EiBHimkkk11Z19WwZcw3mHNPBiYUfex8/7KU57Db3E+AF9WUgfBaesD4XWVg
        2sk7iMuNlskhWtnABA4yEYKOCsPP/eU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-G5NOwX-QNNOTttWRdYHZcA-1; Fri, 25 Aug 2023 12:20:41 -0400
X-MC-Unique: G5NOwX-QNNOTttWRdYHZcA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92345802E5A;
        Fri, 25 Aug 2023 16:20:40 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 85C8740C2079;
        Fri, 25 Aug 2023 16:20:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 25 Aug 2023 18:19:54 +0200 (CEST)
Date:   Fri, 25 Aug 2023 18:19:51 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yonghong Song <yhs@fb.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kui-Feng Lee <kuifeng@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] bpf: task_group_seq_get_next: kill next_task
Message-ID: <20230825161951.GA16878@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825161842.GA16750@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It only adds the unnecessary confusion and compicates the "retry" code.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/bpf/task_iter.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 2264870ae3fc..f51f476ec679 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -35,7 +35,7 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
 						   u32 *tid,
 						   bool skip_if_dup_files)
 {
-	struct task_struct *task, *next_task;
+	struct task_struct *task;
 	struct pid *pid;
 	u32 saved_tid;
 
@@ -68,10 +68,10 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
 		return NULL;
 
 retry:
-	next_task = next_thread(task);
+	task = next_thread(task);
 
 	saved_tid = *tid;
-	*tid = __task_pid_nr_ns(next_task, PIDTYPE_PID, common->ns);
+	*tid = __task_pid_nr_ns(task, PIDTYPE_PID, common->ns);
 	if (!*tid || *tid == common->pid) {
 		/* Run out of tasks of a process.  The tasks of a
 		 * thread_group are linked as circular linked list.
@@ -82,13 +82,11 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
 
 	common->pid_visiting = *tid;
 
-	if (skip_if_dup_files && next_task->files == next_task->group_leader->files) {
-		task = next_task;
+	if (skip_if_dup_files && task->files == task->group_leader->files)
 		goto retry;
-	}
 
-	get_task_struct(next_task);
-	return next_task;
+	get_task_struct(task);
+	return task;
 }
 
 static struct task_struct *task_seq_get_next(struct bpf_iter_seq_task_common *common,
-- 
2.25.1.362.g51ebf55


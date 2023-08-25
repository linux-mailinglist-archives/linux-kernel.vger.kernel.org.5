Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBACA788D2C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 18:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344000AbjHYQV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 12:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344022AbjHYQVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 12:21:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47576212B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 09:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692980453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=YQBzsA/Z+wipgrDrsnQY+IF6MUsXkrkm4AfJgFKQYa8=;
        b=IE0pT17OSh0O2TS20Y3yvITR+LZ7JYzGaMfylrqQgq0FZ2EEtLS1tWM0k+2otNwXNow/Zi
        gwwpE7Ht1DNN78RFPEX1gNuuhwAJlpTHr3e/jO39zjK20+bJvn4sv3ZBqTRMvvtjCnmFkn
        xAUCDCfo78FO66ZSW6E9XZQfy8mQAbU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-89Uwb9boOTuNfZZ-1GzX0A-1; Fri, 25 Aug 2023 12:20:49 -0400
X-MC-Unique: 89Uwb9boOTuNfZZ-1GzX0A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7FBA811731;
        Fri, 25 Aug 2023 16:20:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 75A642166B27;
        Fri, 25 Aug 2023 16:20:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 25 Aug 2023 18:20:02 +0200 (CEST)
Date:   Fri, 25 Aug 2023 18:19:59 +0200
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
Subject: [PATCH 6/6] bpf: task_group_seq_get_next: use __next_thread() rather
 than next_thread()
Message-ID: <20230825161959.GA16893@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825161842.GA16750@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lockless use of next_thread() should be avoided, task_group_seq_get_next()
is the last user, it too can return the group leader twice if it races with
mt-thread exec which changes the group->leader's pid.

Change the main loop to use __next_thread(), kill "next_tid == common->pid"
check.

__next_thread() can't loop forever, so we can also change this code to retry
if next_tid == 0.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/bpf/task_iter.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 7473068ed313..8c847d91cdd9 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -68,15 +68,13 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
 		return NULL;
 
 retry:
-	task = next_thread(task);
+	task = __next_thread(task);
+	if (!task)
+		return NULL;
 
 	next_tid = __task_pid_nr_ns(task, PIDTYPE_PID, common->ns);
-	if (!next_tid || next_tid == common->pid) {
-		/* Run out of tasks of a process.  The tasks of a
-		 * thread_group are linked as circular linked list.
-		 */
-		return NULL;
-	}
+	if (!next_tid)
+		goto retry;
 
 	if (skip_if_dup_files && task->files == task->group_leader->files)
 		goto retry;
-- 
2.25.1.362.g51ebf55


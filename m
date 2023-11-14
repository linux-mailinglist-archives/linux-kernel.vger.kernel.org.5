Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFD67EB4F0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjKNQdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjKNQdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:33:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D33112
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699979627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=BkORamFmgjQm3rT3wXmKJVf5l2MYL+TWgwU+R0JxK1c=;
        b=O9xJJH+cmHlfqT7imG4tOUTDYcg16yAZc2RMofJvynu1mumE6/NYEyh1g3gXCbQ+VgmD9d
        U3wNJUEs8TJhSDiFp5NatW0alpEMY3tugI8n8wZUQhBbmby2AML8mDxofV/aq+xEkjCWVs
        YrbkSI3nT6LY9JdGEHUvZ7PEVtD0QqM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-yLGSOGLEP8ui6el_IihhxQ-1; Tue, 14 Nov 2023 11:33:41 -0500
X-MC-Unique: yLGSOGLEP8ui6el_IihhxQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49EE5811E8F;
        Tue, 14 Nov 2023 16:33:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.253])
        by smtp.corp.redhat.com (Postfix) with SMTP id CA84B5028;
        Tue, 14 Nov 2023 16:33:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 14 Nov 2023 17:32:36 +0100 (CET)
Date:   Tue, 14 Nov 2023 17:32:34 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>
Cc:     Chuyi Zhou <zhouchuyi@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kui-Feng Lee <kuifeng@fb.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH 1/3] bpf: task_group_seq_get_next: use __next_thread() rather
 than next_thread()
Message-ID: <20231114163234.GA890@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114163211.GA874@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lockless use of next_thread() should be avoided, kernel/bpf/task_iter.c
is the last user and the usage is wrong.

task_group_seq_get_next() can return the group leader twice if it races
with mt-thread exec which changes the group->leader's pid.

Change the main loop to use __next_thread(), kill "next_tid == common->pid"
check.

__next_thread() can't loop forever, we can also change this code to retry
if next_tid == 0.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/bpf/task_iter.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 26082b97894d..51ae15e2b290 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -70,15 +70,13 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
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


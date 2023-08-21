Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F36782CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbjHUPKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjHUPKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:10:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365E4102
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 08:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692630600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=9YOqEsz0E9i9rWLFPxwqu5HEnoteHVcXSEYvs1ICBUo=;
        b=HwLdqOl3fMjNOM+v1Qq4Agz0cfB/1KG/PCjt5dLzIwdj+6dsEKhooPSxHJ/wIOYvkc6gqI
        Ig8BhiUNrUMQlNPqDkIh7kPfjnIAIuvadRVZeENrpKwcGrXb6S2K9FjV9FB42ZSiR48ASR
        q/pCAhjOVUbuaFWzXl8d55iApbnYq3I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-F2Ba5-b2OiGty_I1OAzrqw-1; Mon, 21 Aug 2023 11:09:57 -0400
X-MC-Unique: F2Ba5-b2OiGty_I1OAzrqw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E50808DC66D;
        Mon, 21 Aug 2023 15:09:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.99])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2C9A11121314;
        Mon, 21 Aug 2023 15:09:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 21 Aug 2023 17:09:11 +0200 (CEST)
Date:   Mon, 21 Aug 2023 17:09:09 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Yonghong Song <yhs@fb.com>, Kui-Feng Lee <kuifeng@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: task_group_seq_get_next: cleanup the usage of
 next_thread()
Message-ID: <20230821150909.GA2431@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. find_pid_ns() + get_pid_task() under rcu_read_lock() guarantees that we
   can safely iterate the task->thread_group list. Even if this task exits
   right after get_pid_task() (or goto retry) and pid_alive() returns 0.

   Kill the unnecessary pid_alive() check.

2. next_thread() simply can't return NULL, kill the bogus "if (!next_task)"
   check.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/bpf/task_iter.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index c4ab9d6cdbe9..4d1125108014 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -75,15 +75,8 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
 		return NULL;
 
 retry:
-	if (!pid_alive(task)) {
-		put_task_struct(task);
-		return NULL;
-	}
-
 	next_task = next_thread(task);
 	put_task_struct(task);
-	if (!next_task)
-		return NULL;
 
 	saved_tid = *tid;
 	*tid = __task_pid_nr_ns(next_task, PIDTYPE_PID, common->ns);
-- 
2.25.1.362.g51ebf55



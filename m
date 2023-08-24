Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A617871AB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241679AbjHXOeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241769AbjHXOdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:33:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DACD193
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692887576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/9R4uLDmVq3SZUrV7oyvoIl0ePP/hBf7OCHweYTv794=;
        b=NL7BcJIduPJ3Hk3Xy7GJYlvVye9bOSIsiVZ+hZAwTf6u9DvUs3jvFXrFeFesibaXMi8Dsn
        NwwU/pNY/I3dgufuYVKaYKn97NF80TqrSjgcDcJnwudHLwyz2OKiuE9Tn2VLmUa3el80W3
        nrJ4UdsEDywJJxwSsYeTfbuUH64HAh8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-cVgN4S5PN1CUhvLzwSybrw-1; Thu, 24 Aug 2023 10:32:53 -0400
X-MC-Unique: cVgN4S5PN1CUhvLzwSybrw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41A9128237C3;
        Thu, 24 Aug 2023 14:32:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.43])
        by smtp.corp.redhat.com (Postfix) with SMTP id C76994A9005;
        Thu, 24 Aug 2023 14:32:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 24 Aug 2023 16:32:03 +0200 (CEST)
Date:   Thu, 24 Aug 2023 16:32:01 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        peterz@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] change next_thread() to use __next_thread() ?:
 group_leader
Message-ID: <20230824143201.GB31222@redhat.com>
References: <20230824143112.GA31208@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824143112.GA31208@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This relies on fact that group leader is always the 1st entry in the
signal->thread_head list.

With or without this change, if the lockless next_thread(last_thread)
races with exec it can return the old or the new leader.

We are almost ready to kill task->thread_group, after this change its
only user is thread_group_empty().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/sched/signal.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 7fb34b8cda54..cffc882d367f 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -726,10 +726,9 @@ static inline struct task_struct *__next_thread(struct task_struct *p)
 					thread_node);
 }
 
-static inline struct task_struct *next_thread(const struct task_struct *p)
+static inline struct task_struct *next_thread(struct task_struct *p)
 {
-	return list_entry_rcu(p->thread_group.next,
-			      struct task_struct, thread_group);
+	return __next_thread(p) ?: p->group_leader;
 }
 
 static inline int thread_group_empty(struct task_struct *p)
-- 
2.25.1.362.g51ebf55



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B305D799B7D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 23:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344617AbjIIVvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 17:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjIIVvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 17:51:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C8DBB
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 14:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694296246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=4bqk3sy1JqMjNVjTXQjD5qqF9f5tEbVtTAhKhydo4QY=;
        b=UDa6ORmX0FMZjzZkpCT02fEKP5Jn50FMwM+hqNguFAVERb8jG4zPZxVin+fRBos28FXist
        atRQxGdmt51lLWYDB79GHbQKsngXVtnX9yJiobUhV2zXzlYB6HXTeR20kum9qUVV1z888y
        Dj9H1z1nPTzK8eDEaQlkEGSmXKSccFM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-9qaHlmjhNA6b78bPDA1fwg-1; Sat, 09 Sep 2023 17:50:45 -0400
X-MC-Unique: 9qaHlmjhNA6b78bPDA1fwg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC16C3C0D184;
        Sat,  9 Sep 2023 21:50:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id CA3684060E1;
        Sat,  9 Sep 2023 21:50:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat,  9 Sep 2023 23:49:53 +0200 (CEST)
Date:   Sat, 9 Sep 2023 23:49:51 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] taskstats: fill_stats_for_tgid: use for_each_thread()
Message-ID: <20230909214951.GA24274@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do/while_each_thread should be avoided when possible.

Plus I _think_ this change allows to avoid lock_task_sighand() but I am not
sure, I forgot everything about taskstats. In any case, this code does not
look right in that the same thread can be accounted twice: taskstats_exit()
can account the exiting thread in signal->stats and drop ->siglock but this
thread is still on the thread-group list, so lock_task_sighand() can't help.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/taskstats.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index 8ce3fa0c19e2..4354ea231fab 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -233,9 +233,8 @@ static int fill_stats_for_tgid(pid_t tgid, struct taskstats *stats)
 	else
 		memset(stats, 0, sizeof(*stats));
 
-	tsk = first;
 	start_time = ktime_get_ns();
-	do {
+	for_each_thread(first, tsk) {
 		if (tsk->exit_state)
 			continue;
 		/*
@@ -258,7 +257,7 @@ static int fill_stats_for_tgid(pid_t tgid, struct taskstats *stats)
 
 		stats->nvcsw += tsk->nvcsw;
 		stats->nivcsw += tsk->nivcsw;
-	} while_each_thread(first, tsk);
+	}
 
 	unlock_task_sighand(first, &flags);
 	rc = 0;
-- 
2.25.1.362.g51ebf55



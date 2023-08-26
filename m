Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17BC789638
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 13:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjHZLQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 07:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjHZLPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 07:15:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B20C9
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 04:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693048497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=ZWSA7LNRGMd+LCc4C4ZGAbRaQSffcVVlJMIjRGpVAo8=;
        b=DOZ4+bCxYa6+PQ2DBBqPIJ0jcH7C6c1/Rv87s1bcqEaHnL64JWoamy1AAOsCNsk/1f05XJ
        loCJF43jUgGZL4Ne5XXioEiyHp66d6jmHgGUo0ipRjMuR7fE5+0rykbQyIs0WdykULA/Z+
        Y6XFC19mCHlc/G1qHJYiJzbWdiLKWHY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-7Q4oD473OjGBVp-T20Mg1A-1; Sat, 26 Aug 2023 07:14:55 -0400
X-MC-Unique: 7Q4oD473OjGBVp-T20Mg1A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00765185A78B;
        Sat, 26 Aug 2023 11:14:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id B948BC15BAD;
        Sat, 26 Aug 2023 11:14:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat, 26 Aug 2023 13:14:08 +0200 (CEST)
Date:   Sat, 26 Aug 2023 13:14:06 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] change thread_group_empty() to use
 task_struct->thread_node
Message-ID: <20230826111406.GA23238@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826111200.GA22982@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It could use list_is_singular() but this way it is cheaper. Plus the
thread_group_leader() check makes it clear that thread_group_empty()
can only return true if p is a group leader. This was not immediately
obvious before this patch.

task_struct->thread_group no longer has users, it can die.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/sched/signal.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index cffc882d367f..d7fa3ca2fa53 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -733,7 +733,8 @@ static inline struct task_struct *next_thread(struct task_struct *p)
 
 static inline int thread_group_empty(struct task_struct *p)
 {
-	return list_empty(&p->thread_group);
+	return thread_group_leader(p) &&
+	       list_is_last(&p->thread_node, &p->signal->thread_head);
 }
 
 #define delay_group_leader(p) \
-- 
2.25.1.362.g51ebf55


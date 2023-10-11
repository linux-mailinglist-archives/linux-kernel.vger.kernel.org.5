Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943507C47F3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 04:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344867AbjJKCuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 22:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344822AbjJKCuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 22:50:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632AF8E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 19:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696992558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LKaaWjcSib4OYci1/rf1zY/JSkdOEw69OTsSHXb56OQ=;
        b=SBbgmEGvQsnewnssLlN8AKGlI0lHsRKcRqQv9bw7FXsBTSiwaDBmDCURUH/Qkg0IupVHqu
        QMmzeYOqE2gACRpR+G3MU6HxbxMGVmwvFes260E3Bnp4jfeh05+qEu3y5Uj5LXKN0P10FL
        zjAHjaRurPUZsvx3eWuBOjJChEKSCaw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-yZz7x6TqN9CQ3sL-S9fUZA-1; Tue, 10 Oct 2023 22:49:15 -0400
X-MC-Unique: yZz7x6TqN9CQ3sL-S9fUZA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B98263C0F662;
        Wed, 11 Oct 2023 02:49:14 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 731BB10EE859;
        Wed, 11 Oct 2023 02:49:14 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH] workqueue: Override implicit ordered attribute in workqueue_apply_unbound_cpumask()
Date:   Tue, 10 Oct 2023 22:48:42 -0400
Message-Id: <20231011024842.3348767-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1
to be ordered") enabled implicit ordered attribute to be added to
WQ_UNBOUND workqueues with max_active of 1. This prevented the changing
of attributes to these workqueues leading to fix commit 0a94efb5acbb
("workqueue: implicit ordered attribute should be overridable").

However, workqueue_apply_unbound_cpumask() was not updated at that time.
So sysfs changes to wq_unbound_cpumask has no effect on WQ_UNBOUND
workqueues with implicit ordered attribute. Since not all WQ_UNBOUND
workqueues are visible on sysfs, we are not able to make all the
necessary cpumask changes even if we iterates all the workqueue cpumasks
in sysfs and changing them one by one.

Fix this problem by applying the corresponding change made
to apply_workqueue_attrs_locked() in the fix commit to
workqueue_apply_unbound_cpumask().

Fixes: 5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/workqueue.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index d141bd8eb2b7..19d403aa41b0 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5785,9 +5785,13 @@ static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
 	list_for_each_entry(wq, &workqueues, list) {
 		if (!(wq->flags & WQ_UNBOUND))
 			continue;
+
 		/* creating multiple pwqs breaks ordering guarantee */
-		if (wq->flags & __WQ_ORDERED)
-			continue;
+		if (!list_empty(&wq->pwqs)) {
+			if (wq->flags & __WQ_ORDERED_EXPLICIT)
+				continue;
+			wq->flags &= ~__WQ_ORDERED;
+		}
 
 		ctx = apply_wqattrs_prepare(wq, wq->unbound_attrs, unbound_cpumask);
 		if (IS_ERR(ctx)) {
-- 
2.39.3


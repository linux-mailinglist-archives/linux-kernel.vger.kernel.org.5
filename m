Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA947E3093
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 00:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbjKFXGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 18:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjKFXG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 18:06:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183EFD73;
        Mon,  6 Nov 2023 15:06:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4EBC433C7;
        Mon,  6 Nov 2023 23:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699311985;
        bh=SiI4uaAjuD4l6FmaRcPvJBaMOLIqONI4+TQPlJbFjtY=;
        h=From:To:Cc:Subject:Date:From;
        b=S560loz0v0dG4a1zBkaxlZsJFpWLvujD3yRmH1Uc4o8UUZhO1WqoHBuTTfiBGw/ZY
         pnx34+4DQdwro+oXSjmC4yesxdtGly3d5APMc6UQmVqjsGawJTp6OnVNqZFFi2upFV
         Rgs0soHgOoQ7818ZX+yMAgKzXH+WJj/YtdVSkN1nc6iyYjV3gRX7SgCXez2TsqB/Gx
         Z6X2NEUmC54v7sLDl5BbGo9CxzA8/xWlGk1Zw82MR5nNyzGWGDmPhfOyr1eddHVLi1
         PTfn7qbHnrWwHBIBXkjwsjRnP9ZcH7fEkjIReMgG5Lwuf3pfW8J7ickT5+C9uNisbk
         D8ajwxoLZc2OA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org
Subject: [PATCH AUTOSEL 6.6 1/5] locking/ww_mutex/test: Fix potential workqueue corruption
Date:   Mon,  6 Nov 2023 18:06:07 -0500
Message-ID: <20231106230622.3734225-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Stultz <jstultz@google.com>

[ Upstream commit bccdd808902f8c677317cec47c306e42b93b849e ]

In some cases running with the test-ww_mutex code, I was seeing
odd behavior where sometimes it seemed flush_workqueue was
returning before all the work threads were finished.

Often this would cause strange crashes as the mutexes would be
freed while they were being used.

Looking at the code, there is a lifetime problem as the
controlling thread that spawns the work allocates the
"struct stress" structures that are passed to the workqueue
threads. Then when the workqueue threads are finished,
they free the stress struct that was passed to them.

Unfortunately the workqueue work_struct node is in the stress
struct. Which means the work_struct is freed before the work
thread returns and while flush_workqueue is waiting.

It seems like a better idea to have the controlling thread
both allocate and free the stress structures, so that we can
be sure we don't corrupt the workqueue by freeing the structure
prematurely.

So this patch reworks the test to do so, and with this change
I no longer see the early flush_workqueue returns.

Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230922043616.19282-3-jstultz@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/test-ww_mutex.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 93cca6e698600..7c5a8f05497f2 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -466,7 +466,6 @@ static void stress_inorder_work(struct work_struct *work)
 	} while (!time_after(jiffies, stress->timeout));
 
 	kfree(order);
-	kfree(stress);
 }
 
 struct reorder_lock {
@@ -531,7 +530,6 @@ static void stress_reorder_work(struct work_struct *work)
 	list_for_each_entry_safe(ll, ln, &locks, link)
 		kfree(ll);
 	kfree(order);
-	kfree(stress);
 }
 
 static void stress_one_work(struct work_struct *work)
@@ -552,8 +550,6 @@ static void stress_one_work(struct work_struct *work)
 			break;
 		}
 	} while (!time_after(jiffies, stress->timeout));
-
-	kfree(stress);
 }
 
 #define STRESS_INORDER BIT(0)
@@ -564,15 +560,24 @@ static void stress_one_work(struct work_struct *work)
 static int stress(int nlocks, int nthreads, unsigned int flags)
 {
 	struct ww_mutex *locks;
-	int n;
+	struct stress *stress_array;
+	int n, count;
 
 	locks = kmalloc_array(nlocks, sizeof(*locks), GFP_KERNEL);
 	if (!locks)
 		return -ENOMEM;
 
+	stress_array = kmalloc_array(nthreads, sizeof(*stress_array),
+				     GFP_KERNEL);
+	if (!stress_array) {
+		kfree(locks);
+		return -ENOMEM;
+	}
+
 	for (n = 0; n < nlocks; n++)
 		ww_mutex_init(&locks[n], &ww_class);
 
+	count = 0;
 	for (n = 0; nthreads; n++) {
 		struct stress *stress;
 		void (*fn)(struct work_struct *work);
@@ -596,9 +601,7 @@ static int stress(int nlocks, int nthreads, unsigned int flags)
 		if (!fn)
 			continue;
 
-		stress = kmalloc(sizeof(*stress), GFP_KERNEL);
-		if (!stress)
-			break;
+		stress = &stress_array[count++];
 
 		INIT_WORK(&stress->work, fn);
 		stress->locks = locks;
@@ -613,6 +616,7 @@ static int stress(int nlocks, int nthreads, unsigned int flags)
 
 	for (n = 0; n < nlocks; n++)
 		ww_mutex_destroy(&locks[n]);
+	kfree(stress_array);
 	kfree(locks);
 
 	return 0;
-- 
2.42.0


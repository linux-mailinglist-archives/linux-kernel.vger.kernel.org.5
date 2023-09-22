Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1F67AAC56
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjIVIMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbjIVILq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:11:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA46BE4B;
        Fri, 22 Sep 2023 01:11:39 -0700 (PDT)
Date:   Fri, 22 Sep 2023 08:11:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695370298;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FZqsvjjlEWZGBL4cgJ2JxgAJVbdahw8bEqqnuOXhUxc=;
        b=tb+Qqq9JnLV863K0PuaWNgk7/nrLIQ4fTVxh8YzJOTAKznP4a+nfPHWz43NGLlnaCUhrjW
        zgsoyiSBlVDmKgJXmtYlOr5P/OdVDAfJYtmh5v+ng9lf5NqnDYcp4to79yloGraKqczZkg
        dMYLirHQn6cnDnrtqE6yI917N+7+lRnHljfCyFhu3OaLzap19r0MbO7XaHo7HkJT4L5v+p
        KJKSZ6AAJcMh3W2V3+JsmfgmcfO/YmUXdx6sCS3Vbjh0nXHJR0lWJ25Wt7aew95Lh1qcBP
        5WI8YcDBqGikRvlUao3iwgyT7KqLmkpGe4cBTlzeBfEixcNoHiGwK0zcsIpGSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695370298;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FZqsvjjlEWZGBL4cgJ2JxgAJVbdahw8bEqqnuOXhUxc=;
        b=hSUvho8pyGAJcA9ZiZns7v977eVto5De55HjK5ate/H+iZQ5khb/xso39TEdNZ4EGtkFq1
        02EGbC28jJfgz4DQ==
From:   "tip-bot2 for John Stultz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/ww_mutex/test: Fix potential workqueue corruption
Cc:     John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230922043616.19282-3-jstultz@google.com>
References: <20230922043616.19282-3-jstultz@google.com>
MIME-Version: 1.0
Message-ID: <169537029753.27769.15529645927257680234.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     bccdd808902f8c677317cec47c306e42b93b849e
Gitweb:        https://git.kernel.org/tip/bccdd808902f8c677317cec47c306e42b93b849e
Author:        John Stultz <jstultz@google.com>
AuthorDate:    Fri, 22 Sep 2023 04:36:00 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Sep 2023 09:43:40 +02:00

locking/ww_mutex/test: Fix potential workqueue corruption

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
---
 kernel/locking/test-ww_mutex.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 9bceba6..358d661 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -479,7 +479,6 @@ retry:
 	} while (!time_after(jiffies, stress->timeout));
 
 	kfree(order);
-	kfree(stress);
 }
 
 struct reorder_lock {
@@ -544,7 +543,6 @@ out:
 	list_for_each_entry_safe(ll, ln, &locks, link)
 		kfree(ll);
 	kfree(order);
-	kfree(stress);
 }
 
 static void stress_one_work(struct work_struct *work)
@@ -565,8 +563,6 @@ static void stress_one_work(struct work_struct *work)
 			break;
 		}
 	} while (!time_after(jiffies, stress->timeout));
-
-	kfree(stress);
 }
 
 #define STRESS_INORDER BIT(0)
@@ -577,15 +573,24 @@ static void stress_one_work(struct work_struct *work)
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
@@ -609,9 +614,7 @@ static int stress(int nlocks, int nthreads, unsigned int flags)
 		if (!fn)
 			continue;
 
-		stress = kmalloc(sizeof(*stress), GFP_KERNEL);
-		if (!stress)
-			break;
+		stress = &stress_array[count++];
 
 		INIT_WORK(&stress->work, fn);
 		stress->locks = locks;
@@ -626,6 +629,7 @@ static int stress(int nlocks, int nthreads, unsigned int flags)
 
 	for (n = 0; n < nlocks; n++)
 		ww_mutex_destroy(&locks[n]);
+	kfree(stress_array);
 	kfree(locks);
 
 	return 0;

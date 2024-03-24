Return-Path: <linux-kernel+bounces-112892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C77887F89
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B462812DB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A8C4C3DE;
	Sun, 24 Mar 2024 22:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJLP1LCD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F20482EE;
	Sun, 24 Mar 2024 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319703; cv=none; b=Zm6HlFtw6B5LB6tAbHHJgQws7xZLxfWtfCYv8/UdmpC0c7auyMUKHy8xJTCeWBOcLndPksIBH/WVSibTGiMG9wRkvWtO5ykVzsMAT2WaSkVrpSawVfYErAj36HazHIp/FgVGmyrEBRI168IPK/yy1pQUbXJGHC5Fn8iD2agtwZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319703; c=relaxed/simple;
	bh=l9ny8GqDQj32iNYYIqnbkFSzH/g8eVE5gNxj0kXzuP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJU6+EZgVL0QXzQvmiKCoBumf3A7sJqEvY/be+dj9di//Woqgy/7FA85aQS6G89e90oyGLFkhvRencVImrqw5QeoVAChURz/5+f9VmSpN9NU+w/b/P67rtAWkpqCgQhLb7PnxcjmZnWidQE1eKyqUJsxFtOG0fiYJoBMbnq5ERE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJLP1LCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FF3C43141;
	Sun, 24 Mar 2024 22:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319702;
	bh=l9ny8GqDQj32iNYYIqnbkFSzH/g8eVE5gNxj0kXzuP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SJLP1LCDjQP7y7uc9trefJRox+5Gv3503nkVtvmd0FqfuyTwU18BQJMErWFWWqc7e
	 o/Hw8cEG6CqI6l6qCwvI2kw98oGbUq+m3OK/xKemd6Fn1Pf7w6o6mRSLn6FQX2LszT
	 XrGtPA1bVTugQhFfZDXcdCGNcXu+z5BowdqDJM7x/QZb6dW6G6tYNlv5JDv1JpnX9J
	 B1etjlCocOifxGxR4xGROmxFLEw0jYmOJAG85Gww30pukKw9PIrN/rf3xqmRLyEWQG
	 98liLEqmerQQxOg26RQjV6VT5YZGI+lbUg6yo8Fr2dvxxida96/BttfgtuUzCMwB7h
	 TVMt4UAZXWCEA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 005/715] workqueue: Replace pwq_activate_inactive_work() with [__]pwq_activate_work()
Date: Sun, 24 Mar 2024 18:23:04 -0400
Message-ID: <20240324223455.1342824-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 4c6380305d21e36581b451f7337a36c93b64e050 ]

To prepare for unbound nr_active handling improvements, move work activation
part of pwq_activate_inactive_work() into __pwq_activate_work() and add
pwq_activate_work() which tests WORK_STRUCT_INACTIVE and updates nr_active.

pwq_activate_first_inactive() and try_to_grab_pending() are updated to use
pwq_activate_work(). The latter conversion is functionally identical. For
the former, this conversion adds an unnecessary WORK_STRUCT_INACTIVE
testing. This is temporary and will be removed by the next patch.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
Stable-dep-of: 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/workqueue.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 6d0f64b5918ba..7e1b0238158ea 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1461,16 +1461,36 @@ static bool pwq_is_empty(struct pool_workqueue *pwq)
 	return !pwq->nr_active && list_empty(&pwq->inactive_works);
 }
 
-static void pwq_activate_inactive_work(struct work_struct *work)
+static void __pwq_activate_work(struct pool_workqueue *pwq,
+				struct work_struct *work)
 {
-	struct pool_workqueue *pwq = get_work_pwq(work);
-
 	trace_workqueue_activate_work(work);
 	if (list_empty(&pwq->pool->worklist))
 		pwq->pool->watchdog_ts = jiffies;
 	move_linked_works(work, &pwq->pool->worklist, NULL);
 	__clear_bit(WORK_STRUCT_INACTIVE_BIT, work_data_bits(work));
+}
+
+/**
+ * pwq_activate_work - Activate a work item if inactive
+ * @pwq: pool_workqueue @work belongs to
+ * @work: work item to activate
+ *
+ * Returns %true if activated. %false if already active.
+ */
+static bool pwq_activate_work(struct pool_workqueue *pwq,
+			      struct work_struct *work)
+{
+	struct worker_pool *pool = pwq->pool;
+
+	lockdep_assert_held(&pool->lock);
+
+	if (!(*work_data_bits(work) & WORK_STRUCT_INACTIVE))
+		return false;
+
 	pwq->nr_active++;
+	__pwq_activate_work(pwq, work);
+	return true;
 }
 
 static void pwq_activate_first_inactive(struct pool_workqueue *pwq)
@@ -1478,7 +1498,7 @@ static void pwq_activate_first_inactive(struct pool_workqueue *pwq)
 	struct work_struct *work = list_first_entry(&pwq->inactive_works,
 						    struct work_struct, entry);
 
-	pwq_activate_inactive_work(work);
+	pwq_activate_work(pwq, work);
 }
 
 /**
@@ -1616,8 +1636,7 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
 		 * management later on and cause stall.  Make sure the work
 		 * item is activated before grabbing.
 		 */
-		if (*work_data_bits(work) & WORK_STRUCT_INACTIVE)
-			pwq_activate_inactive_work(work);
+		pwq_activate_work(pwq, work);
 
 		list_del_init(&work->entry);
 		pwq_dec_nr_in_flight(pwq, *work_data_bits(work));
-- 
2.43.0



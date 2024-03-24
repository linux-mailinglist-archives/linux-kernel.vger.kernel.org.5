Return-Path: <linux-kernel+bounces-115322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3D1889AC5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39511F346E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BCA1DF0FE;
	Mon, 25 Mar 2024 02:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNPzw0ed"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3300180C16;
	Sun, 24 Mar 2024 22:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320525; cv=none; b=Z9btAb2z3I5k9yAzt0Yp0b19DzoxxnCEcBbEH96+298k7nlDdya6kqLx4eGkDCjtwt98Anc0qyIwlXPmSAiDGsm1keyvzqftC/bSFIDAgJbgzMIzniUBkjxO+ENXDv9I/jMGzNNI4FuDcFEqcui5jsZwEAgWDt9/zlngZgQJkn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320525; c=relaxed/simple;
	bh=+mlHzEBUPNqfokPIaT4uJRapE/C8RmPnz2gA32qU8Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTeVjaohntESE1ZKp0fmCdwNNXQdR7LLOcuCtp7neQFXqLlXVtc9HQqAJMJirJRaZCgYjHytwC1f0O2gMCwJXEqwb4EM85ybOzLFhjqeiWrdJqjuSb9/7B3PMUEWkBM+ApUrBTlTb9305rvHCZjRuuGY4LCvQvj4fa3gpCxiEso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNPzw0ed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0BDC433C7;
	Sun, 24 Mar 2024 22:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320524;
	bh=+mlHzEBUPNqfokPIaT4uJRapE/C8RmPnz2gA32qU8Nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aNPzw0edclHUb4Xfmdi6PHKGZsQJGk3CFOqGJibEFGj5g2G8ysO9DA7LXaH84k6r2
	 RFIFll6hSTrODr2F1gTBCfhtdpBz96gnIJ6ywXaAqtQGDQZXYpoZWWlrHyZ8KSnGEC
	 lpgGT+9VLcH/mzC+XyKnBrsrmvZ6HGzuOLg/DOLrrRGVj9lmNHnEcjh6aINGfNiIna
	 Ma0UDo+sTesZfGC670dr+1xwcfWdZoxAE3hZv6X4JzAp0yUsaHXwBkoBhoopqkL4Wz
	 HqZnOxQj7MFNDQ0Jbbe3pHBrdvcAzQNya9rq0ZplzVq2uzT1dDxol1wii/ZtJM+BLQ
	 EJkaf+USxI8qw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 085/713] workqueue: Replace pwq_activate_inactive_work() with [__]pwq_activate_work()
Date: Sun, 24 Mar 2024 18:36:51 -0400
Message-ID: <20240324224720.1345309-86-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 4674b45620e74..861d8c7d6449a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1455,16 +1455,36 @@ static bool pwq_is_empty(struct pool_workqueue *pwq)
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
@@ -1472,7 +1492,7 @@ static void pwq_activate_first_inactive(struct pool_workqueue *pwq)
 	struct work_struct *work = list_first_entry(&pwq->inactive_works,
 						    struct work_struct, entry);
 
-	pwq_activate_inactive_work(work);
+	pwq_activate_work(pwq, work);
 }
 
 /**
@@ -1610,8 +1630,7 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
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



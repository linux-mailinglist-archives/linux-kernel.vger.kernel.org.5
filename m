Return-Path: <linux-kernel+bounces-115327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AD3889AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3081F34671
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FD11E063B;
	Mon, 25 Mar 2024 02:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4TUPGvB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E66780C17;
	Sun, 24 Mar 2024 22:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320523; cv=none; b=Y9/eFbiy9D8dU52pSb/mSx9FtsUgakQnk3anixWgyOrjPpItqInZhQOYZ1BFcB43VzhG5hKhMHQIFR7iwhYvULWGaKLlBg0Yi06LxUqFWH94v3QxmIJKEql5l9hJlemhtQOD1nGVw6pJ7OExTzTik9Wu7BI8FLZCzTsvjTQWxds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320523; c=relaxed/simple;
	bh=wd8GCL5M6ALkdfhbttLGKAwfW7ned3dpLEr+dadbP78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdRY2vyaITJs2csABPyKFJMyKgco+Gx1desbW0hqiuK4u8vCPDsA89RjXpb83iuEaIRO2VnQNGdVeybBtJsUyGowJNMlkimqPE6z/8rVQQj3avUcZXIzk51o5uz4YjgZ3HQotpNbSkoYLXZwt2rlCvfNcJY007J+aRA1TZt6aJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4TUPGvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD3CC43399;
	Sun, 24 Mar 2024 22:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320523;
	bh=wd8GCL5M6ALkdfhbttLGKAwfW7ned3dpLEr+dadbP78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U4TUPGvBaVXMtPsQBi2Xd1ga2XgxmvcmPo/9Ob8el6HWmN+8XIiCRqXnJzB7rXc9H
	 HrErB/tJ/B6BkbXUR9Ll+m5Racvp6QsqAH7UB5qjC2gbJqQoB1E625iQ5n2YY1bYnt
	 JYBnbTxVhedsxp8JhRTlcwTTQx3iiugW9T2cCDOgSJBsTEKkFJKcUZ9b+TxlH8/xEL
	 qeETyHw9ybaHZ/1rQOMPbEsn/SFM1nJit/suOpvZMSDR4cvoRIslmSGhIXqe84fsv9
	 2CeicI5XTbWMZcm4jY/lExumCADjg3Dz9a7Ja7kedR7riUa2MrVoobtxJv75j2o8D7
	 F8xYHspIt3hAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 084/713] workqueue: Factor out pwq_is_empty()
Date: Sun, 24 Mar 2024 18:36:50 -0400
Message-ID: <20240324224720.1345309-85-sashal@kernel.org>
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

[ Upstream commit afa87ce85379e2d93863fce595afdb5771a84004 ]

"!pwq->nr_active && list_empty(&pwq->inactive_works)" test is repeated
multiple times. Let's factor it out into pwq_is_empty().

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
Stable-dep-of: 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/workqueue.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index f67eb40203ffc..4674b45620e74 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1450,6 +1450,11 @@ static void put_pwq_unlocked(struct pool_workqueue *pwq)
 	}
 }
 
+static bool pwq_is_empty(struct pool_workqueue *pwq)
+{
+	return !pwq->nr_active && list_empty(&pwq->inactive_works);
+}
+
 static void pwq_activate_inactive_work(struct work_struct *work)
 {
 	struct pool_workqueue *pwq = get_work_pwq(work);
@@ -3319,7 +3324,7 @@ void drain_workqueue(struct workqueue_struct *wq)
 		bool drained;
 
 		raw_spin_lock_irq(&pwq->pool->lock);
-		drained = !pwq->nr_active && list_empty(&pwq->inactive_works);
+		drained = pwq_is_empty(pwq);
 		raw_spin_unlock_irq(&pwq->pool->lock);
 
 		if (drained)
@@ -4779,7 +4784,7 @@ static bool pwq_busy(struct pool_workqueue *pwq)
 
 	if ((pwq != pwq->wq->dfl_pwq) && (pwq->refcnt > 1))
 		return true;
-	if (pwq->nr_active || !list_empty(&pwq->inactive_works))
+	if (!pwq_is_empty(pwq))
 		return true;
 
 	return false;
@@ -5217,7 +5222,7 @@ void show_one_workqueue(struct workqueue_struct *wq)
 	unsigned long flags;
 
 	for_each_pwq(pwq, wq) {
-		if (pwq->nr_active || !list_empty(&pwq->inactive_works)) {
+		if (!pwq_is_empty(pwq)) {
 			idle = false;
 			break;
 		}
@@ -5229,7 +5234,7 @@ void show_one_workqueue(struct workqueue_struct *wq)
 
 	for_each_pwq(pwq, wq) {
 		raw_spin_lock_irqsave(&pwq->pool->lock, flags);
-		if (pwq->nr_active || !list_empty(&pwq->inactive_works)) {
+		if (!pwq_is_empty(pwq)) {
 			/*
 			 * Defer printing to avoid deadlocks in console
 			 * drivers that queue work while holding locks
-- 
2.43.0



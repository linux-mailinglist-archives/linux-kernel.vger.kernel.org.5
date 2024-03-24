Return-Path: <linux-kernel+bounces-115604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE9188967E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E0C7B343E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E06253974;
	Mon, 25 Mar 2024 02:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHBUdMnr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4540C14F13B;
	Sun, 24 Mar 2024 23:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321349; cv=none; b=GZOmDMtXI8qT/FtpJ1BjaOx89pM5aTnqkz2uXyFMD+jsN5aXlqejCzw/JJttJeo2W0ARhzyQGajS8DTDKMoub6lNB1iQYwhYRhGvYZwtX9li8oDTCtNE+E+dKxbg6LwV09nPeTrb5UceEFGrrOTonIpvQE1XP63b0U/ssSOZDAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321349; c=relaxed/simple;
	bh=nX02O78A6Qiaz42VVWFCjsQTRlEgLaaJFDu/xHs+waA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mmbvMoF8Zmhrdr0sxyUTnoWC3icjEuj6c95N74YOVCqO4iBVEbjKS81iXbQ3OWA6BfZfad5cBFxIxokIdmQKXYC53DvCHgQPKdWgP6MP299AdHcFJNSrg1v1Crv2nEFawJ82Kr+/z8IO1LXQPlFY91SWoqQhtqd7NpiAJcxbMqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHBUdMnr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32921C43390;
	Sun, 24 Mar 2024 23:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321348;
	bh=nX02O78A6Qiaz42VVWFCjsQTRlEgLaaJFDu/xHs+waA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aHBUdMnrZHirndjVhzUaLX2wh4G3W4pVJLkFj/qqnUDgHWf6MwjD22hg5CrmX1/vW
	 0w+9P3yZGR2Y+U9/1Kjg5j+6HwM9NdDzej0dGmDHD82N3mnEnoU71CC3CiHIaDyomF
	 3glgQGVHWqe/8bwYg08rVUcsB3QBUx/0zx5Mg1U/Uk49nqgAdJHl2szKpmBVRVMUK2
	 N6QJJLsSe0XWrqX1aQfmtTLDdb9gueGVMzHmzU57jNZ/V6iwQv5dxD8ymxsFrQw6WY
	 U/9DsCKXO2vh6LsCYtlwxC9Sxifnyc+kQzSyCVX62HmVb+lPW4RK3N/vBYGe8nyuUc
	 vPbyYJryAv3LQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 073/638] workqueue: Make wq_adjust_max_active() round-robin pwqs while activating
Date: Sun, 24 Mar 2024 18:51:50 -0400
Message-ID: <20240324230116.1348576-74-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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

[ Upstream commit c5404d4e6df6faba1007544b5f4e62c7c14416dd ]

wq_adjust_max_active() needs to activate work items after max_active is
increased. Previously, it did that by visiting each pwq once activating all
that could be activated. While this makes sense with per-pwq nr_active,
nr_active will be shared across multiple pwqs for unbound wqs. Then, we'd
want to round-robin through pwqs to be fairer.

In preparation, this patch makes wq_adjust_max_active() round-robin pwqs
while activating. While the activation ordering changes, this shouldn't
cause user-noticeable behavior changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
Stable-dep-of: 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/workqueue.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 51dc508ac35b5..76559b63ee1fc 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4710,7 +4710,7 @@ static int init_rescuer(struct workqueue_struct *wq)
  */
 static void wq_adjust_max_active(struct workqueue_struct *wq)
 {
-	struct pool_workqueue *pwq;
+	bool activated;
 
 	lockdep_assert_held(&wq->mutex);
 
@@ -4730,19 +4730,26 @@ static void wq_adjust_max_active(struct workqueue_struct *wq)
 	 */
 	WRITE_ONCE(wq->max_active, wq->saved_max_active);
 
-	for_each_pwq(pwq, wq) {
-		unsigned long flags;
-
-		/* this function can be called during early boot w/ irq disabled */
-		raw_spin_lock_irqsave(&pwq->pool->lock, flags);
-
-		while (pwq_activate_first_inactive(pwq))
-			;
+	/*
+	 * Round-robin through pwq's activating the first inactive work item
+	 * until max_active is filled.
+	 */
+	do {
+		struct pool_workqueue *pwq;
 
-		kick_pool(pwq->pool);
+		activated = false;
+		for_each_pwq(pwq, wq) {
+			unsigned long flags;
 
-		raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
-	}
+			/* can be called during early boot w/ irq disabled */
+			raw_spin_lock_irqsave(&pwq->pool->lock, flags);
+			if (pwq_activate_first_inactive(pwq)) {
+				activated = true;
+				kick_pool(pwq->pool);
+			}
+			raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
+		}
+	} while (activated);
 }
 
 __printf(1, 4)
-- 
2.43.0



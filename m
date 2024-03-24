Return-Path: <linux-kernel+bounces-112894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F28F4887F8E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3002F1C2092F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECB74EB3F;
	Sun, 24 Mar 2024 22:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pg+dLDYb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D5C4D9E3;
	Sun, 24 Mar 2024 22:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319705; cv=none; b=msHSRqlohzZ24PQ10anM6Lukahf/4GCAbT+IosT736BluMBeVMsna4igb23wjqlKGjV5VTCQzBvI4oDRkHQKbPXuh9I8EoRz19XrKWDM12MGOO9qN7jVSWn/6E+cTirf1bgxS11ZD162vHVRj+DRkLsPddTzFfrXmSAxTQbkf0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319705; c=relaxed/simple;
	bh=VNKgCdf+8XLDqyA5oqNOYsgu4Nyq48Fer9bqXElncUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVuyZ5tPjxVZ0iUydL0WxGfTBejyDBVkUOcW6Tk6U19PLSvNDMRTZ9zEdGllMeUmWd35K1mvgBxSKnQF6Clc7tWnos5N+CP8A2bdHo91ZDUR6fQu+rEjhEQKaO/WSCE2+fNVJKxOhGlZpU4MPAcIsm1csZqASdZ1sOHsRgZmK5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pg+dLDYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1E6C43390;
	Sun, 24 Mar 2024 22:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319704;
	bh=VNKgCdf+8XLDqyA5oqNOYsgu4Nyq48Fer9bqXElncUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pg+dLDYbWAMz1BG5G6M8A4hcMF2vvphlJJ2x3atYexdIf2bHBEgYuCf24XsVKfIwJ
	 rWPcUW2tFuH3QJ4Yaoc6Xqa27z4VugpPkPYqqxJlzbC4bZLzsIrEY8SGrwKpEmDDV+
	 OrYh1DEsgFutwnSjAqOwqvE5Dt2tioPTOLDBCxVfRjexN5R32j/mmc6sXBIjGInJ2S
	 Azad9ySTFD73hqo+diEO0fGPQ2Kk+2oatsKrhchPxMjFLZZI7mblKcCmfriHX9B212
	 ndjcpTfmpjYt2y3tzKtUZvwaTZzS7np3Rzl2BxqwNbN+B9WZkd1Wnc0NNxCXvJ1D+c
	 AWWrkGeWm1RrA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 007/715] workqueue: Make wq_adjust_max_active() round-robin pwqs while activating
Date: Sun, 24 Mar 2024 18:23:06 -0400
Message-ID: <20240324223455.1342824-8-sashal@kernel.org>
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
index 80733046ee012..1659cd4a36c62 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4703,7 +4703,7 @@ static int init_rescuer(struct workqueue_struct *wq)
  */
 static void wq_adjust_max_active(struct workqueue_struct *wq)
 {
-	struct pool_workqueue *pwq;
+	bool activated;
 
 	lockdep_assert_held(&wq->mutex);
 
@@ -4723,19 +4723,26 @@ static void wq_adjust_max_active(struct workqueue_struct *wq)
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



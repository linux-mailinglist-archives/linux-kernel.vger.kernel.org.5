Return-Path: <linux-kernel+bounces-115601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EB388A1A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE420B244E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE6125287D;
	Mon, 25 Mar 2024 02:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z76051WE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469EE14F122;
	Sun, 24 Mar 2024 23:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321346; cv=none; b=e10xPxXBbUwTnEg05C7BdgqyNvPJRbUUme85HfYDp5F+/Oz3Fr0GaIXUB+RwNj83/dlE7Lcjis9QRwJsZEC+reTXV+qUn3TUG2O/QxvSgS5SUa3weItRkC0oMrLwht5KSb/G9xGGcCf6eXvRkKaGXsQUtM2seiNcNY0Cl8nfSb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321346; c=relaxed/simple;
	bh=SceaZmCpQTkY+KSCgdHN+OVnB1Mmup/sCz2d/q4qxb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4nKMaHl2ZaTspqbFe9wXR4jVP1M+2P1hg0Tpn9K29PZ2vBxKJ99SheQW/NWm5GaHAWgcvanEaaSFfDdV/jvNxPPJTVrnCX3+rdctQEcusmTG6Xf/MHSsfFBfh785kco6US0MROXREngyaUVJxWDv3aXFZGjOM9JJ4X9nb8VWjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z76051WE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871D3C43390;
	Sun, 24 Mar 2024 23:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321346;
	bh=SceaZmCpQTkY+KSCgdHN+OVnB1Mmup/sCz2d/q4qxb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z76051WESXsqAp1J1XjsiYNoQEY1fGhGEksE6LU4a+j2rNa/5B5T30DThhWadBOCV
	 YmXgudLiihaQCCCnFr7D/A90ZJrXyKajqsGDYNYw8eTkL7mWy9ZWnxW/oQYW2DaSc8
	 pyQuw1tXtDQ4LkJw5UcObv/OBYRlqszCxw/tRCYU9ccOrz5Ftm21p4897Jt6GOEsSy
	 b/yGLPx3VWnD/ot8mM4rjxSEQ9mj7rxkvksWNLNaqbDp12km8S9ucdidu2dBqCzrfw
	 xS9zdpzl5MVoDi4tG4LBKg+2RArFop4WYV7f8hNky9vkG5MvpPtb0c9ItEEXq8/6p/
	 F0Hyqx6P16upQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 070/638] workqueue: Factor out pwq_is_empty()
Date: Sun, 24 Mar 2024 18:51:47 -0400
Message-ID: <20240324230116.1348576-71-sashal@kernel.org>
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
index 3aa48ba8c7175..3eb0408133ada 100644
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



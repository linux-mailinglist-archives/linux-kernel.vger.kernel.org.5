Return-Path: <linux-kernel+bounces-112891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DA9887F87
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C1E1F211E2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA38487B6;
	Sun, 24 Mar 2024 22:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6ZLrgWK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801034204E;
	Sun, 24 Mar 2024 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319702; cv=none; b=MG9M7Ulql3YJJga8pomMKYczIGo/WS9x5Aq6OzZl16CCDDaRe8J4V3TnRLFE4mOlm/g3Ij4VXZeU5r/bBwebIdCCf5deSwABIfXdikT1F5oBMmi8dQdGBT6FijOBeF0UtgPpS5ABzf4tg8hiRdrba66SoJaN/WX02idCDbyf4Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319702; c=relaxed/simple;
	bh=UOA95C2nRZx1WdV76grdqxOWS8HjHR6ci7gp4nbAr+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WdgnDTYYZmcyjYnq6hCIdFa67vmj5MgQNfzH3AyHHsAsqke4tvUY1YfRqYPlOH5iwgWo7cp5V60I2GnTijLUUZyPflkv0Ub22CeZRYFEiqolu65KTxhIlC0CbQTdi9asLuOvOpQswPQe3AjJ84mOX5EKw39e8eXQqyDOKIRtmrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6ZLrgWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4104BC43394;
	Sun, 24 Mar 2024 22:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319701;
	bh=UOA95C2nRZx1WdV76grdqxOWS8HjHR6ci7gp4nbAr+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a6ZLrgWKJSyPRl2Z08vqLh+Tx0Ao4rswDx1gwKCY3pzwwgNZ+KRLYu+WnxkPTYe6l
	 vLP0CjeGqSkKwt7teCHDgk9PlkpIFkvUgtUKwgju/xMCIw+p3/X02GhDmfIasAoS/U
	 /vvljTDBf9M71qIJb6adz0gOsyA/ch6FQ2Dg1Y4xuSpFOy4sWj53BHbwo4ayjWJBiw
	 SA61wEuWfN3csp7opfVMbpGWqliuBaDN40orqwUzJLeaUdMI1INmRBlwWafiHw3ila
	 fnxNS3X8h2Z5ELpmtu5yQNGJ1XHZbS6LGVL4Fd+0chc2k+DBzGSkxdveNTERcXYDyP
	 oNb7iFGwZQnVA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 004/715] workqueue: Factor out pwq_is_empty()
Date: Sun, 24 Mar 2024 18:23:03 -0400
Message-ID: <20240324223455.1342824-5-sashal@kernel.org>
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
index 8ee754dd319da..6d0f64b5918ba 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1456,6 +1456,11 @@ static void put_pwq_unlocked(struct pool_workqueue *pwq)
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
@@ -3325,7 +3330,7 @@ void drain_workqueue(struct workqueue_struct *wq)
 		bool drained;
 
 		raw_spin_lock_irq(&pwq->pool->lock);
-		drained = !pwq->nr_active && list_empty(&pwq->inactive_works);
+		drained = pwq_is_empty(pwq);
 		raw_spin_unlock_irq(&pwq->pool->lock);
 
 		if (drained)
@@ -4772,7 +4777,7 @@ static bool pwq_busy(struct pool_workqueue *pwq)
 
 	if ((pwq != pwq->wq->dfl_pwq) && (pwq->refcnt > 1))
 		return true;
-	if (pwq->nr_active || !list_empty(&pwq->inactive_works))
+	if (!pwq_is_empty(pwq))
 		return true;
 
 	return false;
@@ -5210,7 +5215,7 @@ void show_one_workqueue(struct workqueue_struct *wq)
 	unsigned long flags;
 
 	for_each_pwq(pwq, wq) {
-		if (pwq->nr_active || !list_empty(&pwq->inactive_works)) {
+		if (!pwq_is_empty(pwq)) {
 			idle = false;
 			break;
 		}
@@ -5222,7 +5227,7 @@ void show_one_workqueue(struct workqueue_struct *wq)
 
 	for_each_pwq(pwq, wq) {
 		raw_spin_lock_irqsave(&pwq->pool->lock, flags);
-		if (pwq->nr_active || !list_empty(&pwq->inactive_works)) {
+		if (!pwq_is_empty(pwq)) {
 			/*
 			 * Defer printing to avoid deadlocks in console
 			 * drivers that queue work while holding locks
-- 
2.43.0



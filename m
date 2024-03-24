Return-Path: <linux-kernel+bounces-115328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0519B889AC1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5811F3455E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E121DF10F;
	Mon, 25 Mar 2024 02:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYqEGVS/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0231CE99B;
	Sun, 24 Mar 2024 22:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320527; cv=none; b=Hqozh9vETmpRcAVxgzjc/wtuYf35gSe7O/V95L447eRaK8gKzpysA5YNlLhlbvxJ+UUYE69zLMAqfP4zdF3gCU1qR7yF7zZyx8cgDX/2OpJcBJ0ZQhj3kBuEi755MaTLsxhmE6EbkfNCuA3FRdwyHugZPapQeIF5d/d2iLTYUgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320527; c=relaxed/simple;
	bh=MMQ1PVr+DULjkb6hUdVFC51M9t05DhNVZVRYlp2BvVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GT8avEoLH7y4i1gUKBT8kGlRmdJO4lKhVAEj8N6mJee0Wzv02kL6nFAC/J/cGxdFt+czVbuUU/a06rL6Zjjy4MySwLIws/jOnnpRXaIcLnQy47TfDurUV5Ao/QlGFMS8bUnyHsKSAVPWrlN3+nU+/dP1yi3bLcMSDMeKV10Jtww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYqEGVS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39232C433A6;
	Sun, 24 Mar 2024 22:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320525;
	bh=MMQ1PVr+DULjkb6hUdVFC51M9t05DhNVZVRYlp2BvVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KYqEGVS/F89y0xNHFtiIo5Hd0lgC3MIru8XJ1xCNIJ4wqNpUZZEaQPdOy78XcyrxT
	 6vzCFRaDMTXto4h/z+dub+cEidNwciFRRwswnjqSh292NtcgnbzyNyWiOerzE0wsAB
	 5JBwV/VOepQp3lxIUerycykZdq3yxx5jaNKGs6/FAaViLV2hwn1GksqXlIhwcIJ9l+
	 uDemwdV3KksXoagbJoVFnCPa+fmSmfPQjjBib/iBQXstIv/LXsTMsiciFYey7r2OQ1
	 zs2h22tE7ncCn075TOlJind6F8U3sn+onHKZuYZE5HVizbyRL5IQXvjA6YPWV6ku7/
	 U4yg0ZE6VrIbw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 087/713] workqueue: Make wq_adjust_max_active() round-robin pwqs while activating
Date: Sun, 24 Mar 2024 18:36:53 -0400
Message-ID: <20240324224720.1345309-88-sashal@kernel.org>
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
index 78b4f4e3e41dd..059f122563def 100644
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



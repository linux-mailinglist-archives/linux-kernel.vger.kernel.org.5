Return-Path: <linux-kernel+bounces-53857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 610E184A75D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEA41288DB7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01947E76F;
	Mon,  5 Feb 2024 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UzUQ9UjJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4067CF18
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162401; cv=none; b=dJKdlx72Q85YeRbKCT7xp/1xPzF+fbP/Zn1PAV9o0I/PInFra+7zmsMNMAHBB9bY+zB8sbSzlq3jAtx3Sp3M4EswjCVBR1BEiuGvEbYxoPYJ4nMeAN3JYchae834PMZT7O92KtLwmWJtOh6O56c0mBGlKrMEKbLXSFgqDjMGrXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162401; c=relaxed/simple;
	bh=UBgB7wxdCAt+ad7SnQ4VhV8QrVhO4q6rF8Sg0R0cabs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CSnGwhaJ9OpFeUs5+R8/FCOYSzYD6QTLz+GL1xnFaWYD19kyQTWLpsSc9oL4N3WleW3IWzCt3cZQD3sEwChX7QrtGqKrYJUCz6hBATDAhUElIeNrn+9wgBtcZwdDdPIDCXqj17HiOSsNTpU6IBI43Vhkh7OTreb0AHLFV7XEswY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UzUQ9UjJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707162398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tvk5P0YwhhGGdf9RGAqGeLDJl3BLaezVv7toWoOGyh0=;
	b=UzUQ9UjJp/jRWZ1FFUih7Koif3FLob+rN6wAGXWblm1rU4JPbnt3HaKE11XEsk+PlfjdFO
	1JMpQVFOUs68imuQfpyNeD8W0VZqwftDZ4kGYtk10SUyF7YtnUanlTQf3f0MbNteQDKjJG
	4Ak9fFX4gK/XgH9FEVyAYBp5RXZwoKk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-gnYI3oETNTqqcyFngXnrCg-1; Mon, 05 Feb 2024 14:46:36 -0500
X-MC-Unique: gnYI3oETNTqqcyFngXnrCg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A5FA85A58C;
	Mon,  5 Feb 2024 19:46:36 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.212])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 055931C060AF;
	Mon,  5 Feb 2024 19:46:35 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Alex Gladkov <agladkov@redhat.com>,
	Phil Auld <pauld@redhat.com>,
	Costa Shulyupin <cshulyup@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-wq v3 2/4] workqueue: Thaw frozen pwq in workqueue_apply_unbound_cpumask()
Date: Mon,  5 Feb 2024 14:46:00 -0500
Message-Id: <20240205194602.871505-3-longman@redhat.com>
In-Reply-To: <20240205194602.871505-1-longman@redhat.com>
References: <20240205194602.871505-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

workqueue_apply_unbound_cpumask() cannot proceed with an ordered
workqueue if its dfl_pwq is still frozen. Just do a sleep wait for
it to be thawed may not work in some cases if pwq_release_workfn() is
somehow prevented from being called due to resources (e.g. wq_pool_mutex)
that are held by its caller.

To break the logjam, we have to actively check if the frozen dfl_pwq
is ready to be thawed and call thaw_pwq() directly if so.

Signed-off-by: Waiman Long <longman@redhat.com>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/workqueue.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9b107e8a2c15..f453f339f74a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6541,6 +6541,33 @@ void thaw_workqueues(void)
 }
 #endif /* CONFIG_FREEZER */
 
+/*
+ * Check the given ordered workqueue to see if its non-default pwq's have
+ * zero reference count and if so thaw the frozen default pwq.
+ *
+ * Return:
+ * %true if dfl_pwq has been thawed or %false otherwise.
+ */
+static bool ordered_workqueue_ref_check(struct workqueue_struct *wq)
+{
+	struct pool_workqueue *dfl_pwq = rcu_access_pointer(wq->dfl_pwq);
+	struct pool_workqueue *pwq;
+	int refs = 0;
+
+	if (!READ_ONCE(dfl_pwq->frozen))
+		return true;
+	mutex_lock(&wq->mutex);
+	for_each_pwq(pwq, wq) {
+		if (pwq == dfl_pwq)
+			continue;
+		refs += pwq->refcnt;
+	}
+	if (!refs)
+		thaw_pwq(dfl_pwq);
+	mutex_unlock(&wq->mutex);
+	return !refs;
+}
+
 static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
 {
 	LIST_HEAD(ctxs);
@@ -6566,12 +6593,12 @@ static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
 			dfl_pwq = rcu_access_pointer(wq->dfl_pwq);
 			if (!(wq->flags & __WQ_ORDERED_EXPLICIT)) {
 				wq->flags &= ~__WQ_ORDERED;
-			} else if (dfl_pwq && dfl_pwq->frozen) {
+			} else if (dfl_pwq && !ordered_workqueue_ref_check(wq)) {
 				int i;
 
 				for (i = 0; i < 10; i++) {
 					msleep(10);
-					if (!dfl_pwq->frozen)
+					if (ordered_workqueue_ref_check(wq))
 						break;
 				}
 				if (WARN_ON_ONCE(dfl_pwq->frozen))
-- 
2.39.3



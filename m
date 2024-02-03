Return-Path: <linux-kernel+bounces-51160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76879848733
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 083D3B250E7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676075FBA8;
	Sat,  3 Feb 2024 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBhH4ipD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7E85F579
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706975048; cv=none; b=HJGCmgRph4acVTXAwgtwYsvYVTiZLofZmg+iQTC0sCVCtDTlFOL7dfPTssuRz0HJYgcrvYL3VF8zth7PXlXRYUB50XY0YnZpvUrc6kaorUW5UDUL1/0EhN9CGMXrOsiQcPW61f8EUf9ivM2w3WJUujUHjmePeVsk6VOgXTAynfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706975048; c=relaxed/simple;
	bh=1jnXP20A8FTVhBfK5XMoOFBXtkTqsoRl3cBJhPND+Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bR/2f25UTt7qPHKoL/J+aq2Wx/rQhbrjtbXmvELpV2tBLE4F24V4hgynW8IeoapKS41ss1TVujBP+RJsmj5lRD7VBD6WeRQ/pdVW58iA8qPGLKmWhmRxqFTN9R0m5xk7b8kuaW5xel2NoKHrG6qU9cyG3TQNih8thhwKd1KIOpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aBhH4ipD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706975045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z37S38Ac+FZG32K3ttyGhIlDZkrUn25fgqCMfEdj2WY=;
	b=aBhH4ipDEgoo8UXOSW7WmbWhPq9zVUBr1RB1JReM0I2qHV25bosFShNDkM++oHn+LNqiLO
	b3egrFqb1OMWR4oeWq18EgYNa42rGuuURj5vddWafBBPgCEwIU8smI9Y7AA7AKF88HdkyK
	X758m2z5hPhBi+/wM5dmaGOf4vjkvBc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-KRPLBrgKMu6TrTKsDj8DEA-1; Sat, 03 Feb 2024 10:44:00 -0500
X-MC-Unique: KRPLBrgKMu6TrTKsDj8DEA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 537488432A0;
	Sat,  3 Feb 2024 15:44:00 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D413D492BC6;
	Sat,  3 Feb 2024 15:43:59 +0000 (UTC)
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
Subject: [PATCH-wq v2 3/5] workqueue: Thaw frozen pwq in workqueue_apply_unbound_cpumask()
Date: Sat,  3 Feb 2024 10:43:32 -0500
Message-Id: <20240203154334.791910-4-longman@redhat.com>
In-Reply-To: <20240203154334.791910-1-longman@redhat.com>
References: <20240203154334.791910-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

workqueue_apply_unbound_cpumask() cannot proceed with an ordered
workqueue if its dfl_pwq is still frozen. Just do a sleep wait for
it to be thawed may not work in some cases if pwq_release_workfn() is
somehow prevented from being called due to resources (e.g. wq_pool_mutex)
that are held by its caller.

To break the logjam, we have to actively check if the frozen dfl_pwq
is ready to be thawed and call thaw_pwq() directly if so.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/workqueue.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index f089e532758a..ee934c2c6ea8 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6354,6 +6354,32 @@ void thaw_workqueues(void)
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
+	int refs = 0;
+	struct pool_workqueue *pwq;
+
+	if (!READ_ONCE(wq->dfl_pwq->frozen))
+		return true;
+	mutex_lock(&wq->mutex);
+	for_each_pwq(pwq, wq) {
+		if (pwq == wq->dfl_pwq)
+			continue;
+		refs += pwq->refcnt;
+	}
+	if (!refs)
+		thaw_pwq(wq->dfl_pwq);
+	mutex_unlock(&wq->mutex);
+	return !refs;
+}
+
 static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
 {
 	LIST_HEAD(ctxs);
@@ -6378,12 +6404,12 @@ static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
 
 			if (!(wq->flags & __WQ_ORDERED_EXPLICIT)) {
 				wq->flags &= ~__WQ_ORDERED;
-			} else if (pwq && pwq->frozen) {
+			} else if (pwq && !ordered_workqueue_ref_check(wq)) {
 				int i;
 
 				for (i = 0; i < 10; i++) {
 					msleep(10);
-					if (!pwq->frozen)
+					if (ordered_workqueue_ref_check(wq))
 						break;
 				}
 				if (WARN_ON_ONCE(pwq->frozen))
-- 
2.39.3



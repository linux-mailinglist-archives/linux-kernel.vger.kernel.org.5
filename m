Return-Path: <linux-kernel+bounces-1572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D879815041
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913001C210E7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E69241858;
	Fri, 15 Dec 2023 19:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRAndKgn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FC041846
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702669201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WFP0NBWdlK/4b4bX2lTxF+woaIssSpF1Py2WecMr6iY=;
	b=eRAndKgnm9EurHwdtU6BTuAO1KrKhimI9k8lB8nKIZ0/TJ/mh9KAvcdUMAZoSgpES2j5aO
	jMvJRTR0zBTnZi0u1iPeDvmAnE4MwZqkaXTqoVZFU5cW+H293QXperY4xBwbL+98KJsOxC
	vqKFGvZud3vdptiFLaqWD1fjgs3SpuE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-OyaqeuD8PveHvdbbB1pNkA-1; Fri, 15 Dec 2023 14:39:56 -0500
X-MC-Unique: OyaqeuD8PveHvdbbB1pNkA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85ABB8353E2;
	Fri, 15 Dec 2023 19:39:56 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.16.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 553FB3C25;
	Fri, 15 Dec 2023 19:39:56 +0000 (UTC)
From: Audra Mitchell <audra@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: raquini@redhat.com,
	tj@kernel.org,
	jiangshanlai@gmail.com
Subject: [PATCH] workqueue.c: Change workqueue to accept variable length name
Date: Fri, 15 Dec 2023 14:39:54 -0500
Message-ID: <20231215193954.1785069-1-audra@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Currently we limit the size of the workqueue name to 24 characters due to
commit ecf6881ff349 ("workqueue: make workqueue->name[] fixed len")
As device names increase in size a static size for the workqueue name no
longer satisfies the size requirement, leading to truncated workqueue
names as we append the device name to the workqueue name. Truncation of
the workqueue names can cause issues when debugging as each is unique to
the associated device. Bring back the flexibility of a variable length
workqueue name to prevent truncation.

Signed-off-by: Audra Mitchell <audra@redhat.com>
---
 kernel/workqueue.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 2989b57e154a..6e9e332d1cf4 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -107,8 +107,6 @@ enum {
 	 */
 	RESCUER_NICE_LEVEL	= MIN_NICE,
 	HIGHPRI_NICE_LEVEL	= MIN_NICE,
-
-	WQ_NAME_LEN		= 24,
 };
 
 /*
@@ -311,7 +309,7 @@ struct workqueue_struct {
 	struct lock_class_key	key;
 	struct lockdep_map	lockdep_map;
 #endif
-	char			name[WQ_NAME_LEN]; /* I: workqueue name */
+	char			*name; /* I: workqueue name */
 
 	/*
 	 * Destruction of workqueue_struct is RCU protected to allow walking
@@ -3929,6 +3927,7 @@ static void rcu_free_wq(struct rcu_head *rcu)
 	wq_free_lockdep(wq);
 	free_percpu(wq->cpu_pwq);
 	free_workqueue_attrs(wq->unbound_attrs);
+	kfree(wq->name);
 	kfree(wq);
 }
 
@@ -4670,9 +4669,10 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 					 unsigned int flags,
 					 int max_active, ...)
 {
-	va_list args;
+	va_list args, args_copy;
 	struct workqueue_struct *wq;
 	struct pool_workqueue *pwq;
+	size_t namelen;
 
 	/*
 	 * Unbound && max_active == 1 used to imply ordered, which is no longer
@@ -4699,8 +4699,16 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	}
 
 	va_start(args, max_active);
-	vsnprintf(wq->name, sizeof(wq->name), fmt, args);
+	va_copy(args_copy, args);
+	namelen = vsnprintf(NULL, 0, fmt, args) + 1;
+	namelen = (namelen < PAGE_SIZE) ? namelen : PAGE_SIZE;
 	va_end(args);
+	wq->name = kzalloc(namelen, GFP_KERNEL);
+	if (!wq->name)
+		goto err_free_wq;
+
+	vsnprintf(wq->name, namelen, fmt, args_copy);
+	va_end(args_copy);
 
 	max_active = max_active ?: WQ_DFL_ACTIVE;
 	max_active = wq_clamp_max_active(max_active, flags, wq->name);
@@ -4746,6 +4754,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	return wq;
 
 err_unreg_lockdep:
+	kfree(wq->name);
 	wq_unregister_lockdep(wq);
 	wq_free_lockdep(wq);
 err_free_wq:
@@ -5038,7 +5047,7 @@ EXPORT_SYMBOL_GPL(set_worker_desc);
 void print_worker_info(const char *log_lvl, struct task_struct *task)
 {
 	work_func_t *fn = NULL;
-	char name[WQ_NAME_LEN] = { };
+	char *name;
 	char desc[WORKER_DESC_LEN] = { };
 	struct pool_workqueue *pwq = NULL;
 	struct workqueue_struct *wq = NULL;
@@ -5060,7 +5069,7 @@ void print_worker_info(const char *log_lvl, struct task_struct *task)
 	copy_from_kernel_nofault(&fn, &worker->current_func, sizeof(fn));
 	copy_from_kernel_nofault(&pwq, &worker->current_pwq, sizeof(pwq));
 	copy_from_kernel_nofault(&wq, &pwq->wq, sizeof(wq));
-	copy_from_kernel_nofault(name, wq->name, sizeof(name) - 1);
+	copy_from_kernel_nofault(&name, &wq->name, sizeof(wq->name));
 	copy_from_kernel_nofault(desc, worker->desc, sizeof(desc) - 1);
 
 	if (fn || name[0] || desc[0]) {
-- 
2.43.0



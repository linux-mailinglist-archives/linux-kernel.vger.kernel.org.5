Return-Path: <linux-kernel+bounces-59498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A270F84F802
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603AA282D7E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93746D1A1;
	Fri,  9 Feb 2024 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MoSmMzOk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A90F4D112
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707490747; cv=none; b=Xt0ylXhRO71AhGPvF6KmtSEzO41CA7916G500MDgXN/RF95C55hkfhR+Ve3WxzTFQY8dsrHgM7HkbbM5I1x8cxju/XXbUCw29Ds4CAhD7Y0y70D3UP1hwoU1L7p6MmKfmoWAtUkSTG3mYx7Jr9hz028MAZaCJNd9J4eRA0N9OrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707490747; c=relaxed/simple;
	bh=nwshd7swGuSMRtAuLH/JMEgmP/BeZTkB2Y6ZbhwBQL8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l9TK41lQZUlbBDA8z39S88e/ZqXMUzC/b+Oup7u4a2fWYPfPPtN2Ew8DktY2h3CKzDlGV1lte1R5E6bCujdf1gJHjaM8rm+ELC9kF4kbpMPGpRUjAGRXABr6FR+TjJ5lPfjZ3NuKvdPY5ewHpuZptr8usadisnZRke0SB5yUHH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MoSmMzOk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707490744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e8OyeWUTOX2hlvrd/mpZRRlBQxFqRED3bHw4tpIxF14=;
	b=MoSmMzOkgRIvLeP7icOV0I1OmLnQ5bX/Xu/AyLBua+OCDv3jpVGiAj70FpGqUUyU4UNEGa
	6YFwvCtSljF4ZPp4alqzUs+W0kAG26LPKZ0idsjf2byaJxypozunXnZxxWU/AKzcxKvuCZ
	fPFpdkYExxT3m1UsiK+XgTRhVm8Xknc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-OcAPx5DHMPWAjEIy7NJULA-1; Fri,
 09 Feb 2024 09:59:02 -0500
X-MC-Unique: OcAPx5DHMPWAjEIy7NJULA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE29838062B7;
	Fri,  9 Feb 2024 14:59:01 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.112])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8AB1D2026D06;
	Fri,  9 Feb 2024 14:59:01 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] workqueue: Fix kernel-doc comment of unplug_oldest_pwq()
Date: Fri,  9 Feb 2024 09:58:50 -0500
Message-Id: <20240209145850.1157304-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

It turns out that it is not a good idea to put an ASCII diagram in the
kernel-doc comment of unplug_oldest_pwq() as the tool puts out warnings
about its format and will likely render it illegible anyway. Break the
ASCII diagram out into its own comment block inside the function to
avoid this problem.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/workqueue.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index cd2c6edc5c66..f622f535bc00 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1790,25 +1790,29 @@ static bool pwq_activate_first_inactive(struct pool_workqueue *pwq, bool fill)
  * unplug_oldest_pwq - restart an oldest plugged pool_workqueue
  * @wq: workqueue_struct to be restarted
  *
- * pwq's are linked into wq->pwqs with the oldest first. For ordered
- * workqueues, only the oldest pwq is unplugged, the others are plugged to
- * suspend execution until the oldest one is drained. When this happens, the
- * next oldest one (first plugged pwq in iteration) will be unplugged to
- * restart work item execution to ensure proper work item ordering.
- *
- *    dfl_pwq --------------+     [P] - plugged
- *                          |
- *                          v
- *    pwqs -> A -> B [P] -> C [P] (newest)
- *            |    |        |
- *            1    3        5
- *            |    |        |
- *            2    4        6
+ * This function should only be called for ordered workqueues where only the
+ * oldest pwq is unplugged, the others are plugged to suspend execution until
+ * the oldest one is drained and removed. When this happens, the next oldest
+ * one will be unplugged to restart work item execution to ensure proper work
+ * item ordering. Note that pwq's are linked into wq->pwqs with the oldest
+ * first, so the first one in the list is the oldest.
  */
 static void unplug_oldest_pwq(struct workqueue_struct *wq)
 {
 	struct pool_workqueue *pwq;
 
+	/*
+	 * Layout of an ordered workqueue during a wq_unbound_cpumask update:
+	 *
+	 *    dfl_pwq --------------+     [P] - plugged
+	 *                          |
+	 *                          v
+	 *    pwqs -> A -> B [P] -> C [P] (newest)
+	 *            |    |        |
+	 *            1    3        5
+	 *            |    |        |
+	 *            2    4        6
+	 */
 	lockdep_assert_held(&wq->mutex);
 
 	/* Caller should make sure that pwqs isn't empty before calling */
-- 
2.39.3



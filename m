Return-Path: <linux-kernel+bounces-58331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB25884E4C0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8018E28385A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC41381AC6;
	Thu,  8 Feb 2024 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CKrepQkQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1597EF14
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408636; cv=none; b=ozQy4NZ/Oi82xhcd9FRJle3NbobPXiugqEnA7BmGXlOAPv6lWTtAPlg3cRV1r+r0Q0ayk1zO7BOfIsyrWHiC8ey8Sl1L/g5+rIZQgvJba3CF5GP2X+OCnNa/A5/kchuTzwBFPAAIXYt/Xkgrr/1rZHNElHfgz5OYyrCVSBoVXmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408636; c=relaxed/simple;
	bh=+t7pmKjtDdwuTE5+NchSpHdkWOnMrrwVoYXVY+E/eCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FEPxQ1TNb8nz27pf6TtEwYJKwWKfk+Af3LFSR48p3x+QMNFjWTX3ZKfk4HKlcRGksJLhitN6E29BlmdC+K0elmGI2x5kn5U1uQqAcbG3A+/HFp6mYRf2IKLwfU5mKXF4sDTdiYRyaV4Pf+3J/ofE+IX/w94w+SS+EO/iJZz4yIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CKrepQkQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707408633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r7dYKKpjSbNzyLMoqiBagtQ1UbDE2BU0ecOQOmIBJIo=;
	b=CKrepQkQqiGrjIPT4vGsLn0fXZNlaPgKwW3BGV0pihhQ1ae3/rvUZ4t5UVK1h0oRMDrbRD
	tk+jln6IS9jC0SO++g+OgO3LkeOnrG3p60ROEav6iaoWx6CBeJYWf8pRe+sZNCvfy91OU1
	JBT1+Z3K41bT9R3mjYNZiqvanZX1DWg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-rzlhX5SBM5mWrxnbKQl8iQ-1; Thu,
 08 Feb 2024 11:10:27 -0500
X-MC-Unique: rzlhX5SBM5mWrxnbKQl8iQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FD8D381645B;
	Thu,  8 Feb 2024 16:10:27 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 19877492BC6;
	Thu,  8 Feb 2024 16:10:27 +0000 (UTC)
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
Subject: [PATCH wq/for-6.9 v5 4/4] workqueue: Bind unbound workqueue rescuer to wq_unbound_cpumask
Date: Thu,  8 Feb 2024 11:10:14 -0500
Message-Id: <20240208161014.1084943-5-longman@redhat.com>
In-Reply-To: <20240208161014.1084943-1-longman@redhat.com>
References: <20240208161014.1084943-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Commit 85f0ab43f9de ("kernel/workqueue: Bind rescuer to unbound
cpumask for WQ_UNBOUND") modified init_rescuer() to bind rescuer of
an unbound workqueue to the cpumask in wq->unbound_attrs. However
unbound_attrs->cpumask's of all workqueues are initialized to
cpu_possible_mask and will only be changed if it has the WQ_SYSFS flag
to expose a cpumask sysfs file to be written by users. So this patch
doesn't achieve what it is intended to do.

If an unbound workqueue is created after wq_unbound_cpumask is modified
and there is no more unbound cpumask update after that, the unbound
rescuer will be bound to all CPUs unless the workqueue is created
with the WQ_SYSFS flag and a user explicitly modified its cpumask
sysfs file.  Fix this problem by binding directly to wq_unbound_cpumask
in init_rescuer().

Fixes: 85f0ab43f9de ("kernel/workqueue: Bind rescuer to unbound cpumask for WQ_UNBOUND")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 8df27c496b63..ca53e1144f0a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5302,7 +5302,7 @@ static int init_rescuer(struct workqueue_struct *wq)
 
 	wq->rescuer = rescuer;
 	if (wq->flags & WQ_UNBOUND)
-		kthread_bind_mask(rescuer->task, wq->unbound_attrs->cpumask);
+		kthread_bind_mask(rescuer->task, wq_unbound_cpumask);
 	else
 		kthread_bind_mask(rescuer->task, cpu_possible_mask);
 	wake_up_process(rescuer->task);
-- 
2.39.3



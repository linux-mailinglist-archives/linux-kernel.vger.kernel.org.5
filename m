Return-Path: <linux-kernel+bounces-51159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF16848732
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1C21F22128
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106135FB8F;
	Sat,  3 Feb 2024 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7LUy/uz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D4B5F844
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706975048; cv=none; b=Ai7Tqx5SSkJ2WN03IoaYN9XSzLpk3658wE3WYNyxXjxh064O/OExTS+04IZQpBSBPOVwyhEYEDS4e+2HIVNTVuIITMcD0HtKHMj52S6ysDddI9hifg2CI8+U/H5D+kzKYDuM/Tx1H1iX3QE1mMr0/oSPlrgLKC+5ybjbBKIaxFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706975048; c=relaxed/simple;
	bh=i6TPdcvT1TQK+CKu+xNdsdflEhMuYXP1v6ppPXqzfUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NCoSI1LTkJ9Ij7HiX8XBlnghvFl47onquJbOSgcDmNh6DoN4/MwINVE9C7s/+pp2ysx2P6x+X2vY6uhg2UE9rrUUsKyJHBDpR5cS9OJDPwXFknea3igj+ku67sTN6K3YXPIFxWmqWaFUrsiWYpuu0pPEAGhPHsuzCLlDE+kB7N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X7LUy/uz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706975045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZE5SuTiC1eU6caXAnwVyMAj7DO/jK06d00aD2gGGC9Y=;
	b=X7LUy/uzVH5EXH2n/t6My/QPxHBhhzeFjPesyb1BeDWyZYucG8QvuZbXhkanu9NxnO2ITA
	R6Js1uhp6Cw+e8iw4hTp3SDnZ+cexYHPcDXJvsi7bjUcqGwJeK9AjvX9FmIgwGb6J/obev
	VTJRJg1DBcXNS5Gmk0goxFKqbe0UuKw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-kpxT-kJSPYyD4ihjCqYHlA-1; Sat, 03 Feb 2024 10:44:01 -0500
X-MC-Unique: kpxT-kJSPYyD4ihjCqYHlA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69864185A781;
	Sat,  3 Feb 2024 15:44:01 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EB934492BC6;
	Sat,  3 Feb 2024 15:44:00 +0000 (UTC)
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
Subject: [PATCH-wq v2 5/5] workqueue: Bind unbound workqueue rescuer to wq_unbound_cpumask
Date: Sat,  3 Feb 2024 10:43:34 -0500
Message-Id: <20240203154334.791910-6-longman@redhat.com>
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
with the WQ_SYSFS flag and an user explicitly modified its cpumask
sysfs file.  Fix this problem by binding directly to wq_unbound_cpumask
in init_rescuer().

Fixes: 85f0ab43f9de ("kernel/workqueue: Bind rescuer to unbound cpumask for WQ_UNBOUND")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 172f7299aa71..1e022899c13c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5149,7 +5149,7 @@ static int init_rescuer(struct workqueue_struct *wq)
 
 	wq->rescuer = rescuer;
 	if (wq->flags & WQ_UNBOUND)
-		kthread_bind_mask(rescuer->task, wq->unbound_attrs->cpumask);
+		kthread_bind_mask(rescuer->task, wq_unbound_cpumask);
 	else
 		kthread_bind_mask(rescuer->task, cpu_possible_mask);
 	wake_up_process(rescuer->task);
-- 
2.39.3



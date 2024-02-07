Return-Path: <linux-kernel+bounces-55793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8240784C1D3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25530B258E4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73CB15E97;
	Wed,  7 Feb 2024 01:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G35drRw8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5393012E78
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 01:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707268778; cv=none; b=F7Vvwkquh7LJU7AHsQy9jjJ4fkZe3mbH3u73yRYHpU3lV3J1asu98D7dLzpqRwzzytE20Bpb+WoQFeMzXvP05ERHpptBSj+viv1V8I7SZMlFPCnIeNnQl/R5rL/lOCGRHHkxsXAA+s5OJAQOl6Z84xat3CmAiKogX9GCKb040yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707268778; c=relaxed/simple;
	bh=J65o7hPKuyaZeWfHkvaapxx63RY6RSdtfljnA5r1ZuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pDLTbo5nu+zpvsI2w3NorwBYMPXc6BuNTSPitw4kUN7aqe+2J2uqFWtVigpt202O8hAiu6LrgKKb5Fil2HvPpgH8fUflt+v6eH5xW+etnGoVaMNO16pR5xdNJYS1DkLCRmdx3opWtzDUfKkIfv5YE242k4ymlluxlR3ustNM53U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G35drRw8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707268776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rs0fe4YlOD0l4N4FR/S8D6TW5/0PHTLNKLmnFNrs1i4=;
	b=G35drRw8u9IcnIz6OglUMA+4Q/SdN6crsh9QQgA8fhKf/I5P81zfA6mFj5i6+c7AP5HKha
	5KenPJ7Ugp3q6XL9bwhSTCfZ2qo1PKeS/zkFwn6hNraqdfoqRw6sl2UjPpgaOaQFhZVdCd
	WNDFUf1nM1/w9LCwANjh+k2hVX03ORg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-6g3ZwjHbPjGY7P-phbz64w-1; Tue,
 06 Feb 2024 20:19:34 -0500
X-MC-Unique: 6g3ZwjHbPjGY7P-phbz64w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57EB93C1E9C5;
	Wed,  7 Feb 2024 01:19:34 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D93F040C106C;
	Wed,  7 Feb 2024 01:19:33 +0000 (UTC)
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
Subject: [PATCH wq/for-6.9 v4 4/4] workqueue: Bind unbound workqueue rescuer to wq_unbound_cpumask
Date: Tue,  6 Feb 2024 20:19:11 -0500
Message-Id: <20240207011911.975608-5-longman@redhat.com>
In-Reply-To: <20240207011911.975608-1-longman@redhat.com>
References: <20240207011911.975608-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

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
index 3044ad6f9496..81800cc2ee28 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5332,7 +5332,7 @@ static int init_rescuer(struct workqueue_struct *wq)
 
 	wq->rescuer = rescuer;
 	if (wq->flags & WQ_UNBOUND)
-		kthread_bind_mask(rescuer->task, wq->unbound_attrs->cpumask);
+		kthread_bind_mask(rescuer->task, wq_unbound_cpumask);
 	else
 		kthread_bind_mask(rescuer->task, cpu_possible_mask);
 	wake_up_process(rescuer->task);
-- 
2.39.3



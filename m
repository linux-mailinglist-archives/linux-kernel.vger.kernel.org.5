Return-Path: <linux-kernel+bounces-53858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BC884A75E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B583B28C0FC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADE07E78B;
	Mon,  5 Feb 2024 19:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NA0p9ykt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBD57E57D
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162402; cv=none; b=TBxKrwp2UOVOd4bzRs0MydtjHYzvpp2oO9dZN66ewSb14u6Th15qENwET5whd+fgteyjTuTsHzo9i9P+hmwi/k8AgW3XJaGORWRZeUVDF5POoHz2h6D8H3jypTc+g03rpwgfrxJrHCEAbx+rCaMEyhZAv7hXTY6v9OT4IejFgoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162402; c=relaxed/simple;
	bh=vO8HGkvtn6jz0wtvFkjiJ9lBXoPwD9WE/SfztzX7xQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p1mVovRGlARd1WtqrrrGxgHZ6uXydrE56qQRea0pMtqbky/4h6nQWqPC78O3hZzMvmYvL9gVfjqSJXBjb6SObYNxfxMyFQxRArUsNCOW6QwQZdeZ3V6lvmFtE5ER09edKmNWJ3M195DdVOPX/HIRDOpzTZsgf4hl5v8DlDL4rYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NA0p9ykt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707162399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rbQHwYA7ykmolC0A4lTROkm5bxARusbIFHiZqSIfIjU=;
	b=NA0p9yktrk3mGQv45D1kuRcPMLTYOIsjsUEdC6f5b+QOBxUvP2F9AMt3PNfDlr1cp5iKpS
	3ULSwxi3rexljLd+/0No7RNduN+L6RE1SlYXe6QsY6OmJFY4n6Pz5wkDuNpFJDJuB8Gnb4
	j1I4FZlf5jdQ0g4dkUUO0PQ4XZRTE0I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-kVMk7NwuMUSN5LxNo7eC6w-1; Mon, 05 Feb 2024 14:46:37 -0500
X-MC-Unique: kVMk7NwuMUSN5LxNo7eC6w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8EF9785A597;
	Mon,  5 Feb 2024 19:46:37 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.212])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 19E3E1C060B3;
	Mon,  5 Feb 2024 19:46:37 +0000 (UTC)
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
Subject: [PATCH-wq v3 4/4] workqueue: Bind unbound workqueue rescuer to wq_unbound_cpumask
Date: Mon,  5 Feb 2024 14:46:02 -0500
Message-Id: <20240205194602.871505-5-longman@redhat.com>
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
Tested-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index bbd4269d2729..6077d5d663c3 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5300,7 +5300,7 @@ static int init_rescuer(struct workqueue_struct *wq)
 
 	wq->rescuer = rescuer;
 	if (wq->flags & WQ_UNBOUND)
-		kthread_bind_mask(rescuer->task, wq->unbound_attrs->cpumask);
+		kthread_bind_mask(rescuer->task, wq_unbound_cpumask);
 	else
 		kthread_bind_mask(rescuer->task, cpu_possible_mask);
 	wake_up_process(rescuer->task);
-- 
2.39.3



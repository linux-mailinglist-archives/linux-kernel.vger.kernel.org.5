Return-Path: <linux-kernel+bounces-58329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBBA84E4BC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5DA28A5C5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215517E79A;
	Thu,  8 Feb 2024 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TrQWBEtM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7E57D411
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408633; cv=none; b=IqA6a9hOMmoDzpk2KQycR0TYXORIneZGlrz42s0KVrdVjrPqcbTqPGX+Ygdtwp/nA2SYpX8QIt/UuKyCnSSaM9JpwYS1Z3v9Htt7E/OS41Vsujo/TlZ1iw4+TcfAhIE+LztXCp189P2oHQg60HIRovFkvwNB4ekBx7HZFD2vnE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408633; c=relaxed/simple;
	bh=3oS9kSqj13klcEDeru35Hnr/W1vfC6t+2kJTHNu3Y/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fXlKCI4HSqbA4lLbe0dGeRcc8Mo4904PrTcdNHSebjy50aHBxd08gE14XEQwQuICswEHTjifqj5eBm3jcYJNl3iH3knz7eg/hEc1GfuUsqDZQEi99hEquySRYW7oLkuClxDiK4k0JBbsBb7mmtNd5bqxyzLLsyoSOeUNVp9gUTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TrQWBEtM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707408630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UVT04WTuQZOL2MdMj2b0Oo6Y1zY5WCBFIOr5ePYEIio=;
	b=TrQWBEtMFeBNjuuQnY4gzlnOKCXZcmvoHkBsDTwKnEY85bP8h2Pi7vDjDzvGIJvtIbXWzF
	P838tbL1oim3QJkfO0BnzGM/negEdk5BbbiJ9tDoPM2pWeIFiHZXEzatfMrjmPXzXjimqU
	pIeZCduXjLhkB/Y2pgL7cIy+NYyIRY8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-46iU4v4GPkOENz-AOr_wng-1; Thu, 08 Feb 2024 11:10:27 -0500
X-MC-Unique: 46iU4v4GPkOENz-AOr_wng-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09CA485A5A8;
	Thu,  8 Feb 2024 16:10:27 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 88FD2492BC6;
	Thu,  8 Feb 2024 16:10:26 +0000 (UTC)
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
Subject: [PATCH wq/for-6.9 v5 3/4] kernel/workqueue: Let rescuers follow unbound wq cpumask changes
Date: Thu,  8 Feb 2024 11:10:13 -0500
Message-Id: <20240208161014.1084943-4-longman@redhat.com>
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

From: Juri Lelli <juri.lelli@redhat.com>

When workqueue cpumask changes are committed the associated rescuer (if
one exists) affinity is not touched and this might be a problem down the
line for isolated setups.

Make sure rescuers affinity is updated every time a workqueue cpumask
changes, so that rescuers can't break isolation.

 [longman: set_cpus_allowed_ptr() will block until the designated task
  is enqueued on an allowed CPU, no wake_up_process() needed. Also use
  the unbound_effective_cpumask() helper as suggested by Tejun.]

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/workqueue.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index e261acf258b8..8df27c496b63 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5054,6 +5054,11 @@ static void apply_wqattrs_commit(struct apply_wqattrs_ctx *ctx)
 	/* update node_nr_active->max */
 	wq_update_node_max_active(ctx->wq, -1);
 
+	/* rescuer needs to respect wq cpumask changes */
+	if (ctx->wq->rescuer)
+		set_cpus_allowed_ptr(ctx->wq->rescuer->task,
+				     unbound_effective_cpumask(ctx->wq));
+
 	mutex_unlock(&ctx->wq->mutex);
 }
 
-- 
2.39.3



Return-Path: <linux-kernel+bounces-53861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B22584A761
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A7128D193
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917D67F475;
	Mon,  5 Feb 2024 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHUUy+oJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620DC7E59B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162402; cv=none; b=Od2Q6AD/jsbh0OVZpx2Tc8Rn+cygnYgq/dq2CJD8uvaPGk+ZgdUA9mUrBoXrVaWGkgoWxiFXti2DNQfLMXL7jEtRGwfKjTSA5JjSUNV4zEKGvXDefYbv0R6ugmBgB93ygrKeX0v6tXFOCzmBPKVSEwdfjhvNbBO4qMU9+q+P3Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162402; c=relaxed/simple;
	bh=dD7RzPOu/yZs0SQ7pUw18W4NFsgZFjiCRghDj6nC4Pk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZHyQXIoexvJzzEXyhzFlNV9K6e6L6r1Ald4eZ9Fue8oa51zWBMCWtnw4eexKX32xhOw+jQX3MECywiisK92tT2Js7ZheabnstwDMzRDlKjA6XqY+7dO9+i3HRrUq/tQss+ZUZhP9PaGfO08m2f50mCRiFqw6dFXmGumCJ5Whd7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GHUUy+oJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707162400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8fhJVNF3lWvjfwTgTO/+j3df6cdCJ3ZEvdWETu+5JAU=;
	b=GHUUy+oJzpVvJkdtmEBhVKo5K9wTZ/vyOJcyg/7qM7cxZspnmrUgVbJVnaFmJBe/Z3wsA/
	yd+NXfwydhTOE45pqCRRKx2gEpAXPtZd9UtmGy5t4IvlWGVJFNN+QBPtKp9uKo7X4gPIWG
	YhFOLxBx9MHndm916dnJNPkCETiWwkI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-9WDAA6SHPl2JC0toqD9PkQ-1; Mon,
 05 Feb 2024 14:46:37 -0500
X-MC-Unique: 9WDAA6SHPl2JC0toqD9PkQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 096A5380451D;
	Mon,  5 Feb 2024 19:46:37 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.212])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 884B51C060AF;
	Mon,  5 Feb 2024 19:46:36 +0000 (UTC)
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
Subject: [PATCH-wq v3 3/4] kernel/workqueue: Let rescuers follow unbound wq cpumask changes
Date: Mon,  5 Feb 2024 14:46:01 -0500
Message-Id: <20240205194602.871505-4-longman@redhat.com>
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
Tested-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/workqueue.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index f453f339f74a..bbd4269d2729 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5049,6 +5049,11 @@ static void apply_wqattrs_commit(struct apply_wqattrs_ctx *ctx)
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



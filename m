Return-Path: <linux-kernel+bounces-51158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6976D848731
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D6E284F2E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E575F878;
	Sat,  3 Feb 2024 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjzxMAgk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7BD5F55E
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706975048; cv=none; b=dIWxxy10rmkNKE6BnZhuXTsoaXcrK5IXvfe3YHkD1PLH2DnJl3vxoLLjUBF0V2KRSDC7VOVBU99UpFcK8qGpukEPlGfm4pZzPgqqsMybot9UpESJpm8IKuChDNaU1W8lDGybBNqti4rM+e79Nmddl/EfxPjlJmxwdSJShp9Ffmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706975048; c=relaxed/simple;
	bh=h5QmlYtfNPJkR43xmQK8MmClp8+0FgNrfjWDooIF2m0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hI6Z0gZLxAieT32sIs6vOW6QMeYZKBAf/2/822iMShMCtTuvv1sJTNaC8PwTOkPL9S0YYbbIZBLaO83wmglGgzEQb0DJbW295MJHL6Icq6gVLaA4IyDINRcLunF38W93jlDCbhuilykEAxKnRHnP1KufvBaQQGnuXWs7jzITRG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjzxMAgk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706975045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X2395hdNLA+e2lfzBFwx2gFoDSFHPhjOE9LGsAepU2M=;
	b=WjzxMAgkj36pZ35fZ6xBRi93t2HvO53jHTZVM6VOjM+EAtUwjRCKhiyB6IVNpn3pIpgZ5w
	pQs1pVx8nJoU3rfC/fwWD8U4q6DifCDJ//hrVme7ZEeT3ps4KWTcBpnsmrI4WQd6Auevly
	6b+aSadqgxXqOcnIAzwT5t3ka5bvgBo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-LSgab-vdNNS5dJajugvDTA-1; Sat, 03 Feb 2024 10:44:01 -0500
X-MC-Unique: LSgab-vdNNS5dJajugvDTA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC44E10651AF;
	Sat,  3 Feb 2024 15:44:00 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 64ECB492BC6;
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
Subject: [PATCH-wq v2 4/5] kernel/workqueue: Let rescuers follow unbound wq cpumask changes
Date: Sat,  3 Feb 2024 10:43:33 -0500
Message-Id: <20240203154334.791910-5-longman@redhat.com>
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
index ee934c2c6ea8..172f7299aa71 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4905,6 +4905,11 @@ static void apply_wqattrs_commit(struct apply_wqattrs_ctx *ctx)
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



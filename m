Return-Path: <linux-kernel+bounces-55795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6528E84C1D5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B212EB25844
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6C0D535;
	Wed,  7 Feb 2024 01:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a93f2x24"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6FC1B95B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 01:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707268781; cv=none; b=Zl8jq+/FQlow4HZs9HnzJUB+AyU+KD56VTNRMAaORcLAgTGpjcTj0YShtCy1J5GG10anVy9WpVD/AW9czQ15z9BrLocjee5h/8VaviUpyBbUQj7UnlPOQl5k4QixBloxvaMYdqPSdWJNpnbXhqjgNCC7BP+EFY9ca/LLA7Lr1RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707268781; c=relaxed/simple;
	bh=FS+l524qoBFbVz1FfbcQ2i0NBRG/MdSdZhRbd/PgfWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lUtMiVrZ42epUvre2g9XleIRHVB4GaxHEUsBbBx05I63fH1FcITtFrVPRHV2CsdscNo2Bcpr8C/RlWgxBH3HRSL0TkVzVB2OSZ6fcusahHtFU070s7gqiW7svmZOQCRXlWWabANbL3gFP87pPc0oGbPudfoWRKuAPkwmMMdSmT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a93f2x24; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707268779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vJQWPdqy08UQ8K2twJy9pwfGNKDdokiadGdxmJITQUM=;
	b=a93f2x24Sw81Gh/wSK/QjTOtDKgf1UrWDsRaaZZD7tz+ncEKYuvejZEyuR33mHlZyPte2C
	TiqXb9yOFYPaU1HYCt2ahTeeS/gZiN6qWJyi96cxblXCfWK//P/9/VaOSPnJE3y6JACigH
	XipJez7eKOk3U/Gz15ceoyHAFAKjdso=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-3g99GikHP0uEyRJ_BmBzXA-1; Tue,
 06 Feb 2024 20:19:34 -0500
X-MC-Unique: 3g99GikHP0uEyRJ_BmBzXA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA4311C04B4C;
	Wed,  7 Feb 2024 01:19:33 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4E18640D1B60;
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
Subject: [PATCH wq/for-6.9 v4 3/4] kernel/workqueue: Let rescuers follow unbound wq cpumask changes
Date: Tue,  6 Feb 2024 20:19:10 -0500
Message-Id: <20240207011911.975608-4-longman@redhat.com>
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
index 49fe082fe328..3044ad6f9496 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5084,6 +5084,11 @@ static void apply_wqattrs_commit(struct apply_wqattrs_ctx *ctx)
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



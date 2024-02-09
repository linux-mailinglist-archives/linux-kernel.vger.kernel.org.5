Return-Path: <linux-kernel+bounces-59700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3250A84FAAD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326F11C281C1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341D580C02;
	Fri,  9 Feb 2024 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O24YBxP6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1197276414
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498448; cv=none; b=XTGn3ywKc7yPG416cgC4YtBf0NzzOJr/xenzAR673E+TN7SZ2Yf+UCJpuQLb6vDOo6RKisEr+lDmvsd9kmLrhi3HOKy1SVsXCWN0tmi7i/BOn7mOS2p2txO/Jd/nXsgXAE+LQH5VyT/La/jJVFbxo9MafBmoc6SkyKhDZOUiaiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498448; c=relaxed/simple;
	bh=lXj0p83miCCs1eZl068ESAgPJXD6oMzDd+cA3SQSAZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HBgdH2iXPyToyKwTozq5E2MsJnTZcb/fKxbZ9ArOExWXWeK5ZXOH/YKAuWtQ+NEz7b5Gc4nf4sZAY/GXcvvxAWPmg21++lxHMtG3wTYgeSinz5Ri/SoFt6fuQXyBbLcN3GbRE+7kCQI/E4GSPbChacujMUTYKQVs/e7nmqwsbCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O24YBxP6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707498446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=inghrfI9q8SDCIbQ6QauyZqdtpQq5fNv91h6apsRIK8=;
	b=O24YBxP6sTbKZJYmiIgT6umes38e4l92+9D2kARqgsKZQ4WhFLiFVvK2i41dlpSlHdKFsl
	9MnJIXBsnS1vNWcviD4wZ4I9LhoiBwdG1OlkjZvvMokaxLOPjPVU1boECidjR/tLDrV/df
	JeOxT9wPpNHd31gXrjKsW2R2G1x6dnQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-R2s17w-7NhGuSLaZ_skc6Q-1; Fri,
 09 Feb 2024 12:07:20 -0500
X-MC-Unique: R2s17w-7NhGuSLaZ_skc6Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08BFF1C05AEE;
	Fri,  9 Feb 2024 17:07:19 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.112])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B119C2026D06;
	Fri,  9 Feb 2024 17:07:18 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2] workqueue: Fix kernel-doc comment of unplug_oldest_pwq()
Date: Fri,  9 Feb 2024 12:06:11 -0500
Message-Id: <20240209170611.1166299-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Fix the kernel-doc comment of the unplug_oldest_pwq() function to enable
proper processing and formatting of the embedded ASCII diagram.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/workqueue.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index cd2c6edc5c66..ddcdeb7b9f26 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1787,14 +1787,12 @@ static bool pwq_activate_first_inactive(struct pool_workqueue *pwq, bool fill)
 }
 
 /**
- * unplug_oldest_pwq - restart an oldest plugged pool_workqueue
- * @wq: workqueue_struct to be restarted
+ * unplug_oldest_pwq - unplug the oldest pool_workqueue
+ * @wq: workqueue_struct where its oldest pwq is to be unplugged
  *
- * pwq's are linked into wq->pwqs with the oldest first. For ordered
- * workqueues, only the oldest pwq is unplugged, the others are plugged to
- * suspend execution until the oldest one is drained. When this happens, the
- * next oldest one (first plugged pwq in iteration) will be unplugged to
- * restart work item execution to ensure proper work item ordering.
+ * This function should only be called for ordered workqueues where only the
+ * oldest pwq is unplugged, the others are plugged to suspend execution to
+ * ensure proper work item ordering::
  *
  *    dfl_pwq --------------+     [P] - plugged
  *                          |
@@ -1804,6 +1802,11 @@ static bool pwq_activate_first_inactive(struct pool_workqueue *pwq, bool fill)
  *            1    3        5
  *            |    |        |
  *            2    4        6
+ *
+ * When the oldest pwq is drained and removed, this function should be called
+ * to unplug the next oldest one to start its work item execution. Note that
+ * pwq's are linked into wq->pwqs with the oldest first, so the first one in
+ * the list is the oldest.
  */
 static void unplug_oldest_pwq(struct workqueue_struct *wq)
 {
-- 
2.39.3



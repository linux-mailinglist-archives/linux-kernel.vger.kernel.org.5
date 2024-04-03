Return-Path: <linux-kernel+bounces-130408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3318977B0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23451F22C96
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC751534F2;
	Wed,  3 Apr 2024 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCna67lP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9427F152E07
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167231; cv=none; b=K5YvDCKMR9A4R0G2l4jRL2QTaYXxv2NH3+2sK//rIgGvI6FcxynaXpQ8U1/4aVyaZMkF8wqjgeq0vXGv0s45/zohAG2fLpU/IJeE06t8cVlhLQAZxe7BuJ+vUEg1uZoE3svPFcxViZzZ8T9fVHbEHSRpWF5q9Yt+/nN1yVKYpzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167231; c=relaxed/simple;
	bh=ESa69bYpC8ijbm9tNxC6w6CKWUsMZjRn0lH9e8ZPGiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LAb/9pEB/6HN8bp2Rq2LGAiMy2E47w2UqHcVQRx8fdqtMSjUt+n4BkL70wEZjXf1grGTusUKkiXt8gKEw+w17C/QILj44eFYyxJQviWkSdY3HF7nrSiWkxrCNeBnIVDDkeP4aacA38QEp/owQ+Umf1BjXMY75V7+Pw0t2KyzUF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gCna67lP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712167228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NOWzWds8cVKHQdlc47r4G0/HKNJbns4J1HuoS3oJPb0=;
	b=gCna67lPAH03volTn4GnBj/XGNP89gBzAgmzo+OjKbxHuawuF8dvG5PdjGVPvy/T7gVce7
	slNIDuG9amH5BONPRqs9yPHORrjAeTDm0LaNnhYo0F/bQfqWQEs63wom3vwCjYm/Q7Pynb
	J4lltnmTDNof+wr5mfRhWfSeVjkWiPQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-TrN30FAFMYOnb6-VNGny2Q-1; Wed, 03 Apr 2024 14:00:25 -0400
X-MC-Unique: TrN30FAFMYOnb6-VNGny2Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86597101A535;
	Wed,  3 Apr 2024 18:00:23 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.9.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 69BE71121313;
	Wed,  3 Apr 2024 18:00:23 +0000 (UTC)
From: Audra Mitchell <audra@redhat.com>
To: corbet@lwn.net
Cc: tj@kernel.org,
	jiangshanlai@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raquini@redhat.com,
	rdunlap@infradead.org,
	aros@gmx.com
Subject: [PATCH] Documentation/core-api: Update events_freezable_power references.
Date: Wed,  3 Apr 2024 14:00:22 -0400
Message-ID: <20240403180022.16248-1-audra@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Due to commit 8318d6a6362f ("workqueue: Shorten
events_freezable_power_efficient name") we now have some stale
references in the workqeueue documentation, so updating those
references accordingly.

Signed-off-by: Audra Mitchell <audra@redhat.com>
---
 Documentation/core-api/workqueue.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index ed73c612174d..bcc370c876be 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -671,7 +671,7 @@ configuration, worker pools and how workqueues map to the pools: ::
   events_unbound           unbound  9  9 10 10  8
   events_freezable         percpu   0  2  4  6
   events_power_efficient   percpu   0  2  4  6
-  events_freezable_power_  percpu   0  2  4  6
+  events_freezable_pwr_ef  percpu   0  2  4  6
   rcu_gp                   percpu   0  2  4  6
   rcu_par_gp               percpu   0  2  4  6
   slub_flushwq             percpu   0  2  4  6
@@ -694,7 +694,7 @@ Use tools/workqueue/wq_monitor.py to monitor workqueue operations: ::
   events_unbound              38306     0      0.1       -       7       -       -
   events_freezable                0     0      0.0       0       0       -       -
   events_power_efficient      29598     0      0.2       0       0       -       -
-  events_freezable_power_        10     0      0.0       0       0       -       -
+  events_freezable_pwr_ef        10     0      0.0       0       0       -       -
   sock_diag_events                0     0      0.0       0       0       -       -
 
                               total  infl  CPUtime  CPUhog CMW/RPR  mayday rescued
@@ -704,7 +704,7 @@ Use tools/workqueue/wq_monitor.py to monitor workqueue operations: ::
   events_unbound              38322     0      0.1       -       7       -       -
   events_freezable                0     0      0.0       0       0       -       -
   events_power_efficient      29603     0      0.2       0       0       -       -
-  events_freezable_power_        10     0      0.0       0       0       -       -
+  events_freezable_pwr_ef        10     0      0.0       0       0       -       -
   sock_diag_events                0     0      0.0       0       0       -       -
 
   ...
-- 
2.44.0



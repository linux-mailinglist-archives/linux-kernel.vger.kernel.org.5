Return-Path: <linux-kernel+bounces-149008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120E48A8A68
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FF03B24FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D015172BBC;
	Wed, 17 Apr 2024 17:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpKJo7vG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03013171099
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 17:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376166; cv=none; b=pYCbmUMPhq5BiViZVcrBu3RlWdSS54Lpdipm88ftpHlVfikLSkDPTx1QOxYysgz9TFciBDkHNmmudOZaFVyhKhovDzn6xKJ/Ojqd2APu4CF5jKMntP1JCJ2cTCjhf1YNd+ge72BNjPUTL8L54ppOJ2beOonaShbYELAUSznwah8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376166; c=relaxed/simple;
	bh=FYolpYZ25eTFYqMkR6yEsWu9xJyTtvfoFSQkRdJikcI=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=pQ3OnaAniuWLo0JdXZ3S2BjzVn/cHz9Kaq6gaX5Vtqy1FOBztCaEP1zv0XsBPSs739IofTpD/yxbf7+4dkAMvYJAW75glkYld2k1+po1vwWvK523r0lECM5BXSmeqIASpiYpWQDfIh+Ymkz5hXXSjqXZdlQ7Sj2cQkwzYalWJ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MpKJo7vG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713376163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=lRV892maf5KBkoWbV+bN/G5QeBDW5WP72bhpiy5MQpk=;
	b=MpKJo7vGh3pUtHLcX5pUHZ1uKJtwzTjlu338dA8DRTn5K5+Sr7yroDKV8cn5K9Yyb9AbqO
	M/S8el4WarsYtFPcdzPC2nIaGcerXdY4CpeY1RwgwZU+vYyyNsYo6Xt65b+7oNEljrDpHK
	9zUZSBM/i40rIXx4PUbv/exGk2xWhjQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-cUS9pHqbO16ngFt4bsFguQ-1; Wed, 17 Apr 2024 13:49:18 -0400
X-MC-Unique: cUS9pHqbO16ngFt4bsFguQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1482A18A8261;
	Wed, 17 Apr 2024 17:49:18 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C25C8400EAE;
	Wed, 17 Apr 2024 17:49:17 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id A6DF630C2BF7; Wed, 17 Apr 2024 17:49:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id A30823FD7A;
	Wed, 17 Apr 2024 19:49:17 +0200 (CEST)
Date: Wed, 17 Apr 2024 19:49:17 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Mike Snitzer <msnitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
    Damien Le Moal <dlemoal@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
    Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
    Waiman Long <longman@redhat.com>
cc: Guangwu Zhang <guazhang@redhat.com>, dm-devel@lists.linux.dev, 
    linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] completion: move blk_wait_io to
 kernel/sched/completion.c
Message-ID: <31b118f3-bc8d-b18b-c4b9-e57d74a73f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

The block layer has a function blk_wait_io - it works like
wait_for_completion_io, except that it doesn't warn if the wait takes too
long. This commit renames the function to wait_for_completion_long_io and
moves it to kernel/sched/completion.c so that other kernel subsystems can
use it. It will be needed by the dm-io subsystem.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 block/bio.c                |    2 +-
 block/blk-mq.c             |    2 +-
 block/blk.h                |   12 ------------
 include/linux/completion.h |    1 +
 kernel/sched/completion.c  |   20 ++++++++++++++++++++
 5 files changed, 23 insertions(+), 14 deletions(-)

Index: linux-2.6/block/blk.h
===================================================================
--- linux-2.6.orig/block/blk.h	2024-04-17 19:41:14.000000000 +0200
+++ linux-2.6/block/blk.h	2024-04-17 19:41:14.000000000 +0200
@@ -72,18 +72,6 @@ static inline int bio_queue_enter(struct
 	return __bio_queue_enter(q, bio);
 }
 
-static inline void blk_wait_io(struct completion *done)
-{
-	/* Prevent hang_check timer from firing at us during very long I/O */
-	unsigned long timeout = sysctl_hung_task_timeout_secs * HZ / 2;
-
-	if (timeout)
-		while (!wait_for_completion_io_timeout(done, timeout))
-			;
-	else
-		wait_for_completion_io(done);
-}
-
 #define BIO_INLINE_VECS 4
 struct bio_vec *bvec_alloc(mempool_t *pool, unsigned short *nr_vecs,
 		gfp_t gfp_mask);
Index: linux-2.6/include/linux/completion.h
===================================================================
--- linux-2.6.orig/include/linux/completion.h	2024-04-17 19:41:14.000000000 +0200
+++ linux-2.6/include/linux/completion.h	2024-04-17 19:41:14.000000000 +0200
@@ -112,6 +112,7 @@ extern long wait_for_completion_interrup
 	struct completion *x, unsigned long timeout);
 extern long wait_for_completion_killable_timeout(
 	struct completion *x, unsigned long timeout);
+extern void wait_for_completion_long_io(struct completion *x);
 extern bool try_wait_for_completion(struct completion *x);
 extern bool completion_done(struct completion *x);
 
Index: linux-2.6/block/bio.c
===================================================================
--- linux-2.6.orig/block/bio.c	2024-04-17 19:41:14.000000000 +0200
+++ linux-2.6/block/bio.c	2024-04-17 19:41:14.000000000 +0200
@@ -1378,7 +1378,7 @@ int submit_bio_wait(struct bio *bio)
 	bio->bi_end_io = submit_bio_wait_endio;
 	bio->bi_opf |= REQ_SYNC;
 	submit_bio(bio);
-	blk_wait_io(&done);
+	wait_for_completion_long_io(&done);
 
 	return blk_status_to_errno(bio->bi_status);
 }
Index: linux-2.6/block/blk-mq.c
===================================================================
--- linux-2.6.orig/block/blk-mq.c	2024-04-17 19:41:14.000000000 +0200
+++ linux-2.6/block/blk-mq.c	2024-04-17 19:41:14.000000000 +0200
@@ -1407,7 +1407,7 @@ blk_status_t blk_execute_rq(struct reque
 	if (blk_rq_is_poll(rq))
 		blk_rq_poll_completion(rq, &wait.done);
 	else
-		blk_wait_io(&wait.done);
+		wait_for_completion_long_io(&wait.done);
 
 	return wait.ret;
 }
Index: linux-2.6/kernel/sched/completion.c
===================================================================
--- linux-2.6.orig/kernel/sched/completion.c	2024-04-17 19:41:14.000000000 +0200
+++ linux-2.6/kernel/sched/completion.c	2024-04-17 19:41:14.000000000 +0200
@@ -290,6 +290,26 @@ wait_for_completion_killable_timeout(str
 EXPORT_SYMBOL(wait_for_completion_killable_timeout);
 
 /**
+ * wait_for_completion_long_io - waits for completion of a task
+ * @x:  holds the state of this particular completion
+ *
+ * This is like wait_for_completion_io, but it doesn't warn if the wait takes
+ * too long.
+ */
+void wait_for_completion_long_io(struct completion *x)
+{
+	/* Prevent hang_check timer from firing at us during very long I/O */
+	unsigned long timeout = sysctl_hung_task_timeout_secs * HZ / 2;
+
+	if (timeout)
+		while (!wait_for_completion_io_timeout(x, timeout))
+			;
+	else
+		wait_for_completion_io(x);
+}
+EXPORT_SYMBOL(wait_for_completion_long_io);
+
+/**
  *	try_wait_for_completion - try to decrement a completion without blocking
  *	@x:	completion structure
  *



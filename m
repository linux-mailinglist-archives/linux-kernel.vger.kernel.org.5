Return-Path: <linux-kernel+bounces-148935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2713B8A895B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89800B22017
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C650A16FF55;
	Wed, 17 Apr 2024 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUGv+PvK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC43146A73
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372768; cv=none; b=EyJsus2eHiUuB+jg774ZjaAGk3LiOemjdhonJcY7sYB6WvIEhJtVZ1wGpi7jWBiMeMRLGrbkT+3KVEdqDCXRe5OYHznSI0kmNw84d+8J72kXalPXLC8jZGypEzVKgYbOD2pMK1p7Jew/lkWYk2MYvRvjLwmipbR7ysDxM+R7kKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372768; c=relaxed/simple;
	bh=B2fMwR3FShAzjynlmBht9WceiKyd0W2VOuCtbPlpPiQ=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=KgT0Zruyg71a3uc8jvJ0Nl+APlr64fqsCpAVJHI2UnjHs59Eon3XVc150q7yB4T1OnnjbTHbRrZsPn3WUhy/bWc/s3DABtoQklbuaHyh3dDhOtcFv2wlzpEQG662JaKCmGPWhcEhL45ap3PsidK+RGMK2NuYFRDx3EcPs5yuMR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SUGv+PvK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713372765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=SjplzZoluTIe1o36u1uDOUnzCJidPg6EwC9CMT0pgh8=;
	b=SUGv+PvKHNUZUSdVnOPwA7IilH3Ox0SLd43is3NMUzks81XwiuDZM6M6E/ANRAoMNPAVp1
	ZKcvrQHwM8FtNz/lx5rZySAfEto2/GyD6yiu7r+3gOCAw557nCh+fuaudMeL48qOqNk3QQ
	KZdaljg5WGSR3pI7u6e3uY5wZalC/IE=
Received: from mimecast-mx02.redhat.com (66.187.233.88 [66.187.233.88]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-9WehWUvfMnCmwsDXpk2nxQ-1; Wed,
 17 Apr 2024 12:51:40 -0400
X-MC-Unique: 9WehWUvfMnCmwsDXpk2nxQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C89A834FB3;
	Wed, 17 Apr 2024 16:51:39 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E59EC1C0F133;
	Wed, 17 Apr 2024 16:51:38 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id D051330BFED5; Wed, 17 Apr 2024 16:51:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id CF4973FB54;
	Wed, 17 Apr 2024 18:51:38 +0200 (CEST)
Date: Wed, 17 Apr 2024 18:51:38 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Mike Snitzer <msnitzer@redhat.com>, Damien Le Moal <dlemoal@kernel.org>, 
    Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>, 
    Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
    Waiman Long <longman@redhat.com>
cc: Guangwu Zhang <guazhang@redhat.com>, dm-devel@lists.linux.dev, 
    linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] dm-io: don't warn if flush takes too long time
Message-ID: <65c83995-1db-87ff-17df-20c43c1b74d7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

There was reported hang warning when using dm-integrity on the top of loop
device on XFS on a rotational disk. The warning was triggered because
flush on the loop device was too slow.

There's no easy way to reduce the latency, so I made a patch that shuts
the warning up.

There's already a function blk_wait_io that avoids the hung task warning.
This commit moves this function from block/blk.h to
kernel/sched/completion.c, renames it to wait_for_completion_long_io
(because it is not dependent on the block layer at all) and uses it in
dm-io instead of wait_for_completion_io.

[ 1352.586981] INFO: task kworker/1:2:14820 blocked for more than 120 seconds.
[ 1352.593951] Not tainted 4.18.0-552.el8_10.x86_64 #1
[ 1352.599358] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1352.607202] Call Trace:
[ 1352.609670] __schedule+0x2d1/0x870
[ 1352.613173] ? update_load_avg+0x7e/0x710
[ 1352.617193] ? update_load_avg+0x7e/0x710
[ 1352.621214] schedule+0x55/0xf0
[ 1352.624371] schedule_timeout+0x281/0x320
[ 1352.628393] ? __schedule+0x2d9/0x870
[ 1352.632065] io_schedule_timeout+0x19/0x40
[ 1352.636176] wait_for_completion_io+0x96/0x100
[ 1352.640639] sync_io+0xcc/0x120 [dm_mod]
[ 1352.644592] dm_io+0x209/0x230 [dm_mod]
[ 1352.648436] ? bit_wait_timeout+0xa0/0xa0
[ 1352.652461] ? vm_next_page+0x20/0x20 [dm_mod]
[ 1352.656924] ? km_get_page+0x60/0x60 [dm_mod]
[ 1352.661298] dm_bufio_issue_flush+0xa0/0xd0 [dm_bufio]
[ 1352.666448] dm_bufio_write_dirty_buffers+0x1a0/0x1e0 [dm_bufio]
[ 1352.672462] dm_integrity_flush_buffers+0x32/0x140 [dm_integrity]
[ 1352.678567] ? lock_timer_base+0x67/0x90
[ 1352.682505] ? __timer_delete.part.36+0x5c/0x90
[ 1352.687050] integrity_commit+0x31a/0x330 [dm_integrity]
[ 1352.692368] ? __switch_to+0x10c/0x430
[ 1352.696131] process_one_work+0x1d3/0x390
[ 1352.700152] ? process_one_work+0x390/0x390
[ 1352.704348] worker_thread+0x30/0x390
[ 1352.708019] ? process_one_work+0x390/0x390
[ 1352.712214] kthread+0x134/0x150
[ 1352.715459] ? set_kthread_struct+0x50/0x50
[ 1352.719659] ret_from_fork+0x1f/0x40 

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 block/bio.c                |    2 +-
 block/blk-mq.c             |    2 +-
 block/blk.h                |   12 ------------
 drivers/md/dm-io.c         |    2 +-
 include/linux/completion.h |    1 +
 kernel/sched/completion.c  |   20 ++++++++++++++++++++
 6 files changed, 24 insertions(+), 15 deletions(-)

Index: linux-2.6/block/blk.h
===================================================================
--- linux-2.6.orig/block/blk.h	2024-04-17 18:41:50.000000000 +0200
+++ linux-2.6/block/blk.h	2024-04-17 18:41:50.000000000 +0200
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
Index: linux-2.6/drivers/md/dm-io.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-io.c	2024-04-17 18:41:50.000000000 +0200
+++ linux-2.6/drivers/md/dm-io.c	2024-04-17 18:41:50.000000000 +0200
@@ -450,7 +450,7 @@ static int sync_io(struct dm_io_client *
 
 	dispatch_io(opf, num_regions, where, dp, io, 1, ioprio);
 
-	wait_for_completion_io(&sio.wait);
+	wait_for_completion_long_io(&sio.wait);
 
 	if (error_bits)
 		*error_bits = sio.error_bits;
Index: linux-2.6/include/linux/completion.h
===================================================================
--- linux-2.6.orig/include/linux/completion.h	2024-04-17 18:41:50.000000000 +0200
+++ linux-2.6/include/linux/completion.h	2024-04-17 18:49:07.000000000 +0200
@@ -112,6 +112,7 @@ extern long wait_for_completion_interrup
 	struct completion *x, unsigned long timeout);
 extern long wait_for_completion_killable_timeout(
 	struct completion *x, unsigned long timeout);
+extern void wait_for_completion_long_io(struct completion *x);
 extern bool try_wait_for_completion(struct completion *x);
 extern bool completion_done(struct completion *x);
 
Index: linux-2.6/block/bio.c
===================================================================
--- linux-2.6.orig/block/bio.c	2024-04-17 18:41:50.000000000 +0200
+++ linux-2.6/block/bio.c	2024-04-17 18:41:50.000000000 +0200
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
--- linux-2.6.orig/block/blk-mq.c	2024-04-17 18:41:50.000000000 +0200
+++ linux-2.6/block/blk-mq.c	2024-04-17 18:41:50.000000000 +0200
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
--- linux-2.6.orig/kernel/sched/completion.c	2024-04-17 18:41:50.000000000 +0200
+++ linux-2.6/kernel/sched/completion.c	2024-04-17 18:41:50.000000000 +0200
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



Return-Path: <linux-kernel+bounces-149012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 539678A8A74
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B531C2329F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4591146D74;
	Wed, 17 Apr 2024 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="di7Cy8Om"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0012171099
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376275; cv=none; b=B9rxT4iXE44daX1mhYuw4979K0DFTxC3vPdPBz0/2jQB1F9Z1jo4qGEjNr0Hbda39B90H/SwMqxkmivWhpEhuXxAW6IEaFEmkXHMhfpgavuG49MyZixlUL9w0urISy99ebqJtpKsvpTFtEAlSeVUj1NN0faYZrbhRLBF3x1vGXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376275; c=relaxed/simple;
	bh=mEWPo64/cqVvVE5N5PI7TzK6kqyhCqwo5a2U4Vz8R1I=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=QMGqaOH2yBIXjdezBdZzE2llUBTI75pAenAPDFbqwbpon1547P4m3uaNTKXxp4YO4KHX8W3yrABQ2CcScSfzbIJQ0KDwwuVynO4yGMgbTF+0l/cXqxmCdMnDWpoQ1I2Uk1C1m8vBddjHqNPM9k5SFW3adDD3m+Ripcb6f6LMZdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=di7Cy8Om; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713376272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=kujO86Jl3C4sFlf0wfnUMZttB5N1ylWd1xY1DJNRkI0=;
	b=di7Cy8OmUyQkfuX03qUwsX1ZL1hY9x0kMZEqbSDNMvpM3aWIL5HDoOZZYEKdY78O9OGcgo
	CUmNNTIsqz8WCQ4+U1gHnvIwkhedO+OBrFmTHgCZz56ZLB9SMFvdiN4z1mEfVTsd6+Y3rX
	GrVP34+oBmROH8CZiJDVsNqnNaPNZd8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-2KCdiRelO4OyUP-a8xoxTA-1; Wed, 17 Apr 2024 13:51:09 -0400
X-MC-Unique: 2KCdiRelO4OyUP-a8xoxTA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC621812C55;
	Wed, 17 Apr 2024 17:51:08 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B7CC35430;
	Wed, 17 Apr 2024 17:51:08 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 751F330C2BF7; Wed, 17 Apr 2024 17:51:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 7190E3FD7A;
	Wed, 17 Apr 2024 19:51:08 +0200 (CEST)
Date: Wed, 17 Apr 2024 19:51:08 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Mike Snitzer <msnitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
    Damien Le Moal <dlemoal@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
    Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
    Waiman Long <longman@redhat.com>
cc: Guangwu Zhang <guazhang@redhat.com>, dm-devel@lists.linux.dev, 
    linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dm-io: don't warn if flush takes too long time
Message-ID: <a9bb519d-77de-4e3-a37-e8207bf2938a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

There was reported hang warning when using dm-integrity on the top of loop
device on XFS on a rotational disk. The warning was triggered because
flush on the loop device was too slow.

There's no easy way to reduce the latency, so I made a commit that shuts
the warning up.

This commit replaces wait_for_completion_io with
wait_for_completion_long_io, so that the warning is avoided.

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
 drivers/md/dm-io.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/md/dm-io.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-io.c	2024-04-17 19:43:07.000000000 +0200
+++ linux-2.6/drivers/md/dm-io.c	2024-04-17 19:43:07.000000000 +0200
@@ -450,7 +450,7 @@ static int sync_io(struct dm_io_client *
 
 	dispatch_io(opf, num_regions, where, dp, io, 1, ioprio);
 
-	wait_for_completion_io(&sio.wait);
+	wait_for_completion_long_io(&sio.wait);
 
 	if (error_bits)
 		*error_bits = sio.error_bits;



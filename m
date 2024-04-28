Return-Path: <linux-kernel+bounces-161254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA0C8B49A3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 06:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A5291F215EC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 04:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFE74436;
	Sun, 28 Apr 2024 04:53:12 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B8E28F1;
	Sun, 28 Apr 2024 04:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714279991; cv=none; b=dSRMvK1Q5HfZbEgWf2kRriqEj+9a6fKKmcyYHvr6jPY+l0M9xh9qs2Jo+2YnAHdYsRW352yDY0G8YydlZTB8ni7DbexTgMy90ocwX9kQgwPJC68e6cN8oidFWvRc1n41Aji80A3mWLgKdsts930SDJyOeBnenCohxmgT3qcpld8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714279991; c=relaxed/simple;
	bh=G4YP2/ZWQwZU2XzsNw7jXNrEDs7fUDza/7rfo9ENXWI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L/wKD+TjfF7/bkBkCNjFXkRTKy7ruLH++wLMCTZIrt2GPWTj81nNUyiPcpwzRfxqEwC8oJZ8YwKgFVcOuHAnvxdCXG8h7XVblfAAoqYVlkvG6rSzbjztocxH800pKHDSllizHC5aLnfXbq/jXGtzmk0CJMqnu0onbMJBzztXSw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from h3cspam02-ex.h3c.com (localhost [127.0.0.2] (may be forged))
	by h3cspam02-ex.h3c.com with ESMTP id 43S3jaSg028991;
	Sun, 28 Apr 2024 11:45:36 +0800 (GMT-8)
	(envelope-from xi.fengfei@h3c.com)
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 43S3iaGj025312;
	Sun, 28 Apr 2024 11:44:37 +0800 (GMT-8)
	(envelope-from xi.fengfei@h3c.com)
Received: from DAG6EX01-IMDC.srv.huawei-3com.com (unknown [10.62.14.10])
	by mail.maildlp.com (Postfix) with ESMTP id A2F8522E8727;
	Sun, 28 Apr 2024 11:47:11 +0800 (CST)
Received: from localhost.localdomain (10.99.206.12) by
 DAG6EX01-IMDC.srv.huawei-3com.com (10.62.14.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Sun, 28 Apr 2024 11:44:38 +0800
From: Fengfei Xi <xi.fengfei@h3c.com>
To: <sandeen@sandeen.net>
CC: <darrick.wong@oracle.com>, <linux-kernel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <tian.xianting@h3c.com>,
        <xi.fengfei@h3c.com>
Subject: Re: [PATCH] xfs: fix system crash caused by null bp->b_pages
Date: Sun, 28 Apr 2024 11:44:36 +0800
Message-ID: <20240428034436.42237-1-xi.fengfei@h3c.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <63d75865-84c6-0f76-81a2-058f4cad1d84@sandeen.net>
References: <63d75865-84c6-0f76-81a2-058f4cad1d84@sandeen.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG6EX01-IMDC.srv.huawei-3com.com (10.62.14.10)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 43S3jaSg028991

>On 12/24/20 3:51 AM, Fengfei Xi wrote:
>> We have encountered the following problems several times:
>>     1、A raid slot or hardware problem causes block device loss.
>>     2、Continue to issue IO requests to the problematic block device.
>>     3、The system possibly crash after a few hours.

>What kernel is this on?

>> dmesg log as below:
>> [15205901.268313] blk_partition_remap: fail for partition 1

>I think this message has been gone since kernel v4.16...

>If you're testing this on an old kernel, can you reproduce it on a
>current kernel?

>> [15205901.319309] blk_partition_remap: fail for partition 1
>> [15205901.319341] blk_partition_remap: fail for partition 1
>> [15205901.319873] sysctl (3998546): drop_caches: 3

>What performed the drop_caches immediately before the BUG?  Does
>the BUG happen without drop_caches?

>> [15205901.371379] BUG: unable to handle kernel NULL pointer dereference at

>was something lost here?  "dereference at" ... what?

>> [15205901.372602] IP: xfs_buf_offset+0x32/0x60 [xfs]
>> [15205901.373605] PGD 0 P4D 0
>> [15205901.374690] Oops: 0000 [#1] SMP
>> [15205901.375629] Modules linked in:
>> [15205901.382445] CPU: 6 PID: 18545 Comm: xfsaild/sdh1 Kdump: loaded Tainted: G
>> [15205901.384728] Hardware name:
>> [15205901.385830] task: ffff885216939e80 task.stack: ffffb28ba9b38000
>> [15205901.386974] RIP: 0010:xfs_buf_offset+0x32/0x60 [xfs]
>> [15205901.388044] RSP: 0018:ffffb28ba9b3bc68 EFLAGS: 00010246
>> [15205901.389021] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000000000b
>> [15205901.390016] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88627bebf000
>> [15205901.391075] RBP: ffffb28ba9b3bc98 R08: ffff88627bebf000 R09: 00000001802a000d
>> [15205901.392031] R10: ffff88521f3a0240 R11: ffff88627bebf000 R12: ffff88521041e000
>> [15205901.392950] R13: 0000000000000020 R14: ffff88627bebf000 R15: 0000000000000000
>> [15205901.393858] FS:  0000000000000000(0000) GS:ffff88521f380000(0000) knlGS:0000000000000000
>> [15205901.394774] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [15205901.395756] CR2: 0000000000000000 CR3: 000000099bc09001 CR4: 00000000007606e0
>> [15205901.396904] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [15205901.397869] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [15205901.398836] PKRU: 55555554
>> [15205901.400111] Call Trace:
>> [15205901.401058]  ? xfs_inode_buf_verify+0x8e/0xf0 [xfs]
>> [15205901.402069]  ? xfs_buf_delwri_submit_buffers+0x16d/0x2b0 [xfs]
>> [15205901.403060]  xfs_inode_buf_write_verify+0x10/0x20 [xfs]
>> [15205901.404017]  _xfs_buf_ioapply+0x88/0x410 [xfs]
>> [15205901.404990]  ? xfs_buf_delwri_submit_buffers+0x16d/0x2b0 [xfs]
>> [15205901.405929]  xfs_buf_submit+0x63/0x200 [xfs]
>> [15205901.406801]  xfs_buf_delwri_submit_buffers+0x16d/0x2b0 [xfs]
>> [15205901.407675]  ? xfs_buf_delwri_submit_nowait+0x10/0x20 [xfs]
>> [15205901.408540]  ? xfs_inode_item_push+0xb7/0x190 [xfs]
>> [15205901.409395]  xfs_buf_delwri_submit_nowait+0x10/0x20 [xfs]
>> [15205901.410249]  xfsaild+0x29a/0x780 [xfs]
>> [15205901.411121]  kthread+0x109/0x140
>> [15205901.411981]  ? xfs_trans_ail_cursor_first+0x90/0x90 [xfs]
>> [15205901.412785]  ? kthread_park+0x60/0x60
>> [15205901.413578]  ret_from_fork+0x2a/0x40
>> 
>> The "obvious" cause is that the bp->b_pages was NULL in function
>> xfs_buf_offset. Analyzing vmcore, we found that b_pages=NULL but
>> b_page_count=16, so b_pages is set to NULL for some reason.

>this can happen, for example _xfs_buf_get_pages sets the count, but may
>fail the allocation, and leave the count set while the pointer is NULL.
>> 
>> crash> struct xfs_buf ffff88627bebf000 | less
>>     ...
>>   b_pages = 0x0,
>>   b_page_array = {0x0, 0x0},
>>   b_maps = 0xffff88627bebf118,
>>   __b_map = {
>>     bm_bn = 512,
>>     bm_len = 128
>>   },
>>   b_map_count = 1,
>>   b_io_length = 128,
>>   b_pin_count = {
>>     counter = 0
>>   },
>>   b_io_remaining = {
>>     counter = 1
>>   },
>>   b_page_count = 16,
>>   b_offset = 0,
>>   b_error = 0,
>>     ...
>> 
>> To avoid system crash, we can add the check of 'bp->b_pages' to
>> xfs_inode_buf_verify(). If b_pages == NULL, we mark the buffer
>> as -EFSCORRUPTED and the IO will not dispatched.
>> 
>> Signed-off-by: Fengfei Xi <xi.fengfei@h3c.com>
>> Reviewed-by: Xianting Tian <tian.xianting@h3c.com>
>> ---
>>  fs/xfs/libxfs/xfs_inode_buf.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>> 
>> diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
>> index c667c63f2..5a485c51f 100644
>> --- a/fs/xfs/libxfs/xfs_inode_buf.c
>> +++ b/fs/xfs/libxfs/xfs_inode_buf.c
>> @@ -45,6 +45,17 @@ xfs_inode_buf_verify(
>>  	int		i;
>>  	int		ni;
>>  
>> +	/*
>> +	 * Don't crash and mark buffer EFSCORRUPTED when b_pages is NULL
>> +	 */
>> +	if (!bp->b_pages) {
>> +		xfs_buf_ioerror(bp, -EFSCORRUPTED);
>> +		xfs_alert(mp,
>> +			"xfs_buf(%p) b_pages corruption detected at %pS\n",
>> +			bp, __return_address);
>> +		return;
>> +	}

>This seems fairly ad hoc.

>I think we need a better idea of how we got here; why should inode buffers
>be uniquely impacted (or defensively protected?)  Can you reproduce this
>using virtual devices so the test can be scripted?

Hi, we have confirmed through the systemtap instrumentation of ioerror that 
the issue is related to the cleanup logic for xfs_log_item->li_flags in the 
xfs_buf_resubmit_failed_buffers function. 

As described in commit d43aaf1685aa471f0593685c9f54d53e3af3cf3f: 
if we clear the log item failed state before queuing the buffer for IO 
we can release all active references to the buffer and free it, 
leading to use after free problems in xfs_buf_delwri_queue.

If we trigger dropcache between xfs_clear_li_failed and xfs_buf_delwri_queue,
as no one holds the xfs_buf, the xfs_buf is released.

Currently, after incorporating the modifications, the issue has not reoccurred.

--
Thanks, 

Fengfei.Xi


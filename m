Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15D47A34C0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 10:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbjIQI5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 04:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbjIQI46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 04:56:58 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAAE185;
        Sun, 17 Sep 2023 01:56:51 -0700 (PDT)
Received: from [192.168.1.122] (ip5b41a963.dynamic.kabel-deutschland.de [91.65.169.99])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3DBCA61E5FE01;
        Sun, 17 Sep 2023 10:55:45 +0200 (CEST)
Message-ID: <f79867f5-befb-0d7d-0c01-a42caa5d1466@molgen.mpg.de>
Date:   Sun, 17 Sep 2023 10:55:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: md_raid: mdX_raid6 looping after sync_action "check" to "idle"
 transition
From:   Donald Buczek <buczek@molgen.mpg.de>
To:     Dragan Stancevic <dragan@stancevic.com>,
        Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org
Cc:     guoqing.jiang@linux.dev, it+raid@molgen.mpg.de,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        msmith626@gmail.com, "yangerkun@huawei.com" <yangerkun@huawei.com>
References: <CAPhsuW6R11y6vETeZ4vmFGmV6DRrj2gwhp1-Nm+csvtHb2nQYg@mail.gmail.com>
 <20230822211627.1389410-1-dragan@stancevic.com>
 <ab757e2b-3ff0-33d9-d30c-61669b738664@huaweicloud.com>
 <2061b123-6332-1456-e7c3-b713752527fb@stancevic.com>
 <07d5c7c2-c444-8747-ed6d-ca24231decd8@huaweicloud.com>
 <cf765117-7270-1b98-7e82-82a1ca1daa2a@stancevic.com>
 <0d79d1f9-00e8-93be-3c7c-244030521cd7@huaweicloud.com>
 <ff996ffb-cba5-cc9b-2740-49ba4a1869b5@huaweicloud.com>
 <07ef7b78-66d4-d3de-4e25-8a889b902e14@stancevic.com>
 <63c63d93-30fc-0175-0033-846b93fe9eff@molgen.mpg.de>
 <de7f6fba-c6e0-7549-199e-36548b68a862@stancevic.com>
 <d48c6c4a-9b0e-20bc-7d40-2a88aa37524a@molgen.mpg.de>
Content-Language: en-US
In-Reply-To: <d48c6c4a-9b0e-20bc-7d40-2a88aa37524a@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/23 08:03, Donald Buczek wrote:
> On 9/13/23 16:16, Dragan Stancevic wrote:
>> Hi Donald-
>> [...]
>> Here is a list of changes for 6.1:
>>
>> e5e9b9cb71a0 md: factor out a helper to wake up md_thread directly
>> f71209b1f21c md: enhance checking in md_check_recovery()
>> 753260ed0b46 md: wake up 'resync_wait' at last in md_reap_sync_thread()
>> 130443d60b1b md: refactor idle/frozen_sync_thread() to fix deadlock
>> 6f56f0c4f124 md: add a mutex to synchronize idle and frozen in action_store()
>> 64e5e09afc14 md: refactor action_store() for 'idle' and 'frozen'
>> a865b96c513b Revert "md: unlock mddev before reap sync_thread in action_store"
> 
> Thanks!
> 
> I've put these patches on v6.1.52. I've started a script which transitions the three md-devices of a very active backup server through idle->check->idle every 6 minutes a few ours ago.  It went through ~400 iterations till now. No lock-ups so far.

Oh dear, looks like the deadlock problem is _not_fixed with these patches.

We've had a lockup again after ~3 days of operation. Again, the `echo idle > $sys/md/sync_action` is hanging:

# # /proc/70554/task/70554: mdcheck.safe : /bin/bash /usr/bin/mdcheck.safe --continue --duration 06:00
# cat /proc/70554/task/70554/stack

[<0>] action_store+0x17f/0x390
[<0>] md_attr_store+0x83/0xf0
[<0>] kernfs_fop_write_iter+0x117/0x1b0
[<0>] vfs_write+0x2ce/0x400
[<0>] ksys_write+0x5f/0xe0
[<0>] do_syscall_64+0x43/0x90
[<0>] entry_SYSCALL_64_after_hwframe+0x64/0xce

And everything else going to that specific raid (md0) is dead, too. No task is busy looping.

So as it looks now, we cant go from 5.15.X to 6.1.X as we would like to do. These patches don't fix the problem and our own patch no longer works with 6.1. Unfortunately, this happened on a production system which I need to reboot and is not available for further analysis. We'd need to reproduce the problem on a dedicated machine to really work on it.

Here's some more possibly interesting procfs output and some examples of tasks.

/sys/devices/virtual/block/md0/inflight : 0 3936

#/proc/mdstat

Personalities : [linear] [raid0] [raid1] [raid6] [raid5] [raid4] [multipath]
md1 : active raid6 sdae[0] sdad[15] sdac[14] sdab[13] sdaa[12] sdz[11] sdy[10] sdx[9] sdw[8] sdv[7] sdu[6] sdt[5] sds[4] sdah[3] sdag[2] sdaf[1]
       109394518016 blocks super 1.2 level 6, 512k chunk, algorithm 2 [16/16] [UUUUUUUUUUUUUUUU]
       bitmap: 0/59 pages [0KB], 65536KB chunk

md0 : active raid6 sdc[0] sdr[17] sdq[16] sdp[13] sdo[12] sdn[11] sdm[10] sdl[9] sdk[8] sdj[7] sdi[6] sdh[5] sdg[4] sdf[3] sde[2] sdd[1]
       109394518016 blocks super 1.2 level 6, 512k chunk, algorithm 2 [16/16] [UUUUUUUUUUUUUUUU]
       [===>.................]  check = 15.9% (1242830396/7813894144) finish=14788.4min speed=7405K/sec
       bitmap: 53/59 pages [212KB], 65536KB chunk

unused devices: <none>

# # /proc/66024/task/66024: md0_resync :
# cat /proc/66024/task/66024/stack

[<0>] raid5_get_active_stripe+0x20f/0x4d0
[<0>] raid5_sync_request+0x38b/0x3b0
[<0>] md_do_sync.cold+0x40c/0x985
[<0>] md_thread+0xb1/0x160
[<0>] kthread+0xe7/0x110
[<0>] ret_from_fork+0x22/0x30

# # /proc/939/task/939: md0_raid6 :
# cat /proc/939/task/939/stack

[<0>] md_thread+0x12d/0x160
[<0>] kthread+0xe7/0x110
[<0>] ret_from_fork+0x22/0x30

# # /proc/1228/task/1228: xfsaild/md0 :
# cat /proc/1228/task/1228/stack

[<0>] raid5_get_active_stripe+0x20f/0x4d0
[<0>] raid5_make_request+0x24c/0x1170
[<0>] md_handle_request+0x131/0x220
[<0>] __submit_bio+0x89/0x130
[<0>] submit_bio_noacct_nocheck+0x160/0x360
[<0>] _xfs_buf_ioapply+0x26c/0x420
[<0>] __xfs_buf_submit+0x64/0x1d0
[<0>] xfs_buf_delwri_submit_buffers+0xc5/0x1e0
[<0>] xfsaild+0x2a0/0x880
[<0>] kthread+0xe7/0x110
[<0>] ret_from_fork+0x22/0x30

# # /proc/49747/task/49747: kworker/24:2+xfs-inodegc/md0 :
# cat /proc/49747/task/49747/stack

[<0>] xfs_buf_lock+0x35/0xf0
[<0>] xfs_buf_find_lock+0x45/0xf0
[<0>] xfs_buf_get_map+0x17d/0xa60
[<0>] xfs_buf_read_map+0x52/0x280
[<0>] xfs_trans_read_buf_map+0x115/0x350
[<0>] xfs_btree_read_buf_block.constprop.0+0x9a/0xd0
[<0>] xfs_btree_lookup_get_block+0x97/0x170
[<0>] xfs_btree_lookup+0xc4/0x4a0
[<0>] xfs_difree_finobt+0x62/0x250
[<0>] xfs_difree+0x130/0x1c0
[<0>] xfs_ifree+0x86/0x510
[<0>] xfs_inactive_ifree.isra.0+0xa2/0x1c0
[<0>] xfs_inactive+0xf8/0x170
[<0>] xfs_inodegc_worker+0x90/0x140
[<0>] process_one_work+0x1c7/0x3c0
[<0>] worker_thread+0x4d/0x3c0
[<0>] kthread+0xe7/0x110
[<0>] ret_from_fork+0x22/0x30

# # /proc/49844/task/49844: kworker/30:3+xfs-sync/md0 :
# cat /proc/49844/task/49844/stack

[<0>] __flush_workqueue+0x10e/0x390
[<0>] xlog_cil_push_now.isra.0+0x25/0x90
[<0>] xlog_cil_force_seq+0x7c/0x240
[<0>] xfs_log_force+0x83/0x240
[<0>] xfs_log_worker+0x3b/0xd0
[<0>] process_one_work+0x1c7/0x3c0
[<0>] worker_thread+0x4d/0x3c0
[<0>] kthread+0xe7/0x110
[<0>] ret_from_fork+0x22/0x30


# # /proc/52646/task/52646: kworker/u263:2+xfs-cil/md0 :
# cat /proc/52646/task/52646/stack

[<0>] raid5_get_active_stripe+0x20f/0x4d0
[<0>] raid5_make_request+0x24c/0x1170
[<0>] md_handle_request+0x131/0x220
[<0>] __submit_bio+0x89/0x130
[<0>] submit_bio_noacct_nocheck+0x160/0x360
[<0>] xlog_state_release_iclog+0xf6/0x1d0
[<0>] xlog_write_get_more_iclog_space+0x79/0xf0
[<0>] xlog_write+0x334/0x3b0
[<0>] xlog_cil_push_work+0x501/0x740
[<0>] process_one_work+0x1c7/0x3c0
[<0>] worker_thread+0x4d/0x3c0
[<0>] kthread+0xe7/0x110
[<0>] ret_from_fork+0x22/0x30

# # /proc/52753/task/52753: rm : rm -rf /project/pbackup_gone/data/C8029/home_Cyang/home_Cyang:202306011248:C3019.BEING_DELETED
# cat /proc/52753/task/52753/stack

[<0>] xfs_buf_lock+0x35/0xf0
[<0>] xfs_buf_find_lock+0x45/0xf0
[<0>] xfs_buf_get_map+0x17d/0xa60
[<0>] xfs_buf_read_map+0x52/0x280
[<0>] xfs_trans_read_buf_map+0x115/0x350
[<0>] xfs_read_agi+0x98/0x140
[<0>] xfs_iunlink+0x63/0x1f0
[<0>] xfs_remove+0x280/0x3a0
[<0>] xfs_vn_unlink+0x53/0xa0
[<0>] vfs_rmdir.part.0+0x5e/0x1e0
[<0>] do_rmdir+0x15c/0x1c0
[<0>] __x64_sys_unlinkat+0x4b/0x60
[<0>] do_syscall_64+0x43/0x90
[<0>] entry_SYSCALL_64_after_hwframe+0x64/0xce

Best
   Donald

-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433

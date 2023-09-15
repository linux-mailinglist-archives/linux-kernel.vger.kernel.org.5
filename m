Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F437A1BCF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbjIOKLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbjIOKLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:11:41 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E34D83
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:11:35 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rn8zH1wtpzVl07;
        Fri, 15 Sep 2023 18:08:43 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 15 Sep 2023 18:11:33 +0800
Subject: Re: [PATCH] mm: vmscan: fix NULL pointer dereference in
 can_reclaim_anon_pages
To:     Sachin Sant <sachinp@linux.ibm.com>
References: <20230908093103.2620512-1-liushixin2@huawei.com>
 <DD531436-22EE-4353-9944-6A3A87F27BC7@linux.ibm.com>
CC:     Michael Ellerman <michaele@au1.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <aaf18620-8951-86a1-0cb3-f8174134b661@huawei.com>
Date:   Fri, 15 Sep 2023 18:11:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <DD531436-22EE-4353-9944-6A3A87F27BC7@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/8 20:56, Sachin Sant wrote:
>
>> On 08-Sep-2023, at 3:01 PM, Liu Shixin <liushixin2@huawei.com> wrote:
>>
>> The variable sc is NULL pointer in can_reclaim_anon_pages() when called
>> from zone_reclaimable_pages(). Check it before setting swapcache_only.
>>
>> Reported-by: Sachin Sant <sachinp@linux.ibm.com>
>> Link: https://lore.kernel.org/linux-mm/F00144DE-2A3F-4463-8203-45E0D57E313E@linux.ibm.com/T/
>> Fixes: 92039ae85e8d("mm: vmscan: try to reclaim swapcache pages if no swap space")
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>> ---
>> mm/vmscan.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
> Thanks for the fix. With this patch applied although I no longer run into
> the reported crash the test program doesn’t complete. I have observed
> hung task timeouts while running the program.
>
> # ./min_free_kbytes
> tst_test.c:1547: TINFO: Timeout per run is disabled
> mem.c:648: TINFO: set overcommit_memory to 2
> mem.c:648: TINFO: set min_free_kbytes to 31116
> memfree is 58822592 kB before eatup mem
> [  490.838676] __vm_enough_memory: pid: 10431, comm: min_free_kbytes, not enough memory for the allocation
> memfree is 25224000 kB after eatup mem
> mem.c:648: TINFO: set min_free_kbytes to 62232
> memfree is 58794048 kB before eatup mem
> [  493.789210] __vm_enough_memory: pid: 10807, comm: min_free_kbytes, not enough memory for the allocation
> memfree is 25239232 kB after eatup mem
> mem.c:648: TINFO: set min_free_kbytes to 1211553
> memfree is 58777344 kB before eatup mem
> [  496.736678] __vm_enough_memory: pid: 10943, comm: min_free_kbytes, not enough memory for the allocation
> memfree is 25145600 kB after eatup mem
> mem.c:648: TINFO: set overcommit_memory to 0
> mem.c:648: TINFO: set min_free_kbytes to 31116
> memfree is 58684864 kB before eatup mem
> [  736.065807] INFO: task kworker/u260:0:178 blocked for more than 122 seconds.
> [  736.065833]       Tainted: G            E      6.5.0-next-20230907-dirty #16
> [  736.065837] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  736.065842] task:kworker/u260:0  state:D stack:0     pid:178   ppid:2      flags:0x00000000
> [  736.065852] Workqueue: writeback wb_workfn (flush-8:0)
> [  736.065864] Call Trace:
> [  736.065867] [c0000000080e32a0] [c0000000080e3500] 0xc0000000080e3500 (unreliable)
> [  736.065875] [c0000000080e3450] [c00000000001fc9c] __switch_to+0x13c/0x220
> [  736.065884] [c0000000080e34b0] [c000000000fec5b0] __schedule+0x260/0x7c0
> [  736.065891] [c0000000080e3580] [c000000000fecb84] schedule+0x74/0x150
> [  736.065897] [c0000000080e35f0] [c000000000fecce4] io_schedule+0x54/0x80
> [  736.065902] [c0000000080e3620] [c0000000007fb1fc] rq_qos_wait+0xfc/0x1e0
> [  736.065910] [c0000000080e36d0] [c0000000008278a4] wbt_wait+0xd4/0x170
> [  736.065916] [c0000000080e3730] [c0000000007fab64] __rq_qos_throttle+0x54/0x80
> [  736.065922] [c0000000080e3760] [c0000000007df0dc] blk_mq_get_new_requests+0xfc/0x270
> [  736.065931] [c0000000080e37f0] [c0000000007e4e6c] blk_mq_submit_bio+0x37c/0x580
> [  736.065937] [c0000000080e3850] [c0000000007cd830] __submit_bio+0x30/0x250
> [  736.065944] [c0000000080e3880] [c0000000007ce110] submit_bio_noacct_nocheck+0x140/0x260
> [  736.065951] [c0000000080e38f0] [c000000000675a0c] iomap_submit_ioend+0x8c/0xf0
> [  736.065959] [c0000000080e3930] [c00800000154fc20] xfs_vm_writepages+0xc8/0x140 [xfs]
> [  736.066063] [c0000000080e39e0] [c0000000004768d0] do_writepages+0xc0/0x290
> [  736.066070] [c0000000080e3a60] [c00000000061553c] __writeback_single_inode+0x6c/0x500
> [  736.066076] [c0000000080e3ab0] [c0000000006160cc] writeback_sb_inodes+0x2dc/0x6d0
> [  736.066081] [c0000000080e3bd0] [c000000000616544] __writeback_inodes_wb+0x84/0x1a0
> [  736.066087] [c0000000080e3c40] [c0000000006169bc] wb_writeback+0x35c/0x4b0
> [  736.066092] [c0000000080e3d00] [c000000000618274] wb_workfn+0x3a4/0x6f0
> [  736.066097] [c0000000080e3e50] [c00000000018d4ec] process_one_work+0x1ec/0x4a0
> [  736.066105] [c0000000080e3ef0] [c00000000018db5c] worker_thread+0x3bc/0x590
> [  736.066112] [c0000000080e3f90] [c00000000019c2e8] kthread+0x138/0x140
> [  736.066118] [c0000000080e3fe0] [c00000000000df98] start_kernel_thread+0x14/0x18
>
> The system seems to lockup(atleast appears that way)  after few minutes. I cannot ssh to
> the system. Killing the test program doesn’t appear to help. 
> I have attached the console output.
>
> There still seems to be some issue with the patch.
I sent a new version to replace patch 92039ae85e8d("mm: vmscan: try to reclaim swapcache pages if no swap space")
Could you replace it with new version and test again?

https://lore.kernel.org/linux-mm/20230915083417.3190512-1-liushixin2@huawei.com/

thanks,
>
> - Sachin
>


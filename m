Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FC27E6B73
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbjKINs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbjKINsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:48:08 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AAC30D3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 05:48:03 -0800 (PST)
Received: from kwepemm000020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SR39D27d5zmXCt;
        Thu,  9 Nov 2023 21:44:48 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm000020.china.huawei.com (7.193.23.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 9 Nov 2023 21:47:24 +0800
Message-ID: <9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com>
Date:   Thu, 9 Nov 2023 21:47:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>,
        <lstoakes@gmail.com>, <hughd@google.com>, <david@redhat.com>,
        <fengwei.yin@intel.com>, <vbabka@suse.cz>, <peterz@infradead.org>,
        <mgorman@suse.de>, <mingo@redhat.com>, <riel@redhat.com>,
        <ying.huang@intel.com>, <hannes@cmpxchg.org>,
        Nanyong Sun <sunnanyong@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
From:   "zhangpeng (AS)" <zhangpeng362@huawei.com>
Subject: [Question]: major faults are still triggered after mlockall when numa
 balancing
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.160]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000020.china.huawei.com (7.193.23.93)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

There is a performance issue that has been bothering us recently.
This problem can reproduce in the latest mainline version (Linux 6.6).

We use mlockall(MCL_CURRENT | MCL_FUTURE) in the user mode process
to avoid performance problems caused by major fault.

There is a stage in numa fault which will set pte as 0 in do_numa_page() :
ptep_modify_prot_start() will clear the vmf->pte, until
ptep_modify_prot_commit() assign a value to the vmf->pte.

For the data segment of the user-mode program, the global variable area
is a private mapping. After the pagecache is loaded, the private
anonymous page is generated after the COW is triggered. Mlockall can
lock COW pages (anonymous pages), but the original file pages cannot
be locked and may be reclaimed. If the global variable (private anon page)
is accessed when vmf->pte is zero which is concurrently set by numa fault,
a file page fault will be triggered.

At this time, the original private file page may have been reclaimed.
If the page cache is not available at this time, a major fault will be
triggered and the file will be read, causing additional overhead.

Our problem scenario is as follows:

task 1                      task 2
------                      ------
/* scan global variables */
do_numa_page()
   spin_lock(vmf->ptl)
   ptep_modify_prot_start()
   /* set vmf->pte as null */
                             /* Access global variables */
                             handle_pte_fault()
                               /* no pte lock */
                               do_pte_missing()
                                 do_fault()
                                   do_read_fault()
   ptep_modify_prot_commit()
   /* ptep update done */
   pte_unmap_unlock(vmf->pte, vmf->ptl)
                                     do_fault_around()
                                     __do_fault()
                                       filemap_fault()
                                         /* page cache is not available
                                         and a major fault is triggered */
                                         do_sync_mmap_readahead()
                                         /* page_not_uptodate and goto
                                         out_retry. */

Is there any way to avoid such a major fault?

-- 
Best Regards,
Peng


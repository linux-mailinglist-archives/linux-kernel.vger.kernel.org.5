Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E8378389C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 05:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjHVDls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 23:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjHVDlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 23:41:46 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DBC186
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 20:41:44 -0700 (PDT)
Received: from kwepemm600017.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RVFV70Mh0z1L9S1;
        Tue, 22 Aug 2023 11:40:15 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 22 Aug 2023 11:41:42 +0800
Message-ID: <0bbbb7d8-699b-30ac-9657-840112c41a78@huawei.com>
Date:   Tue, 22 Aug 2023 11:41:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] mm: memory-failure: use rcu lock instead of
 tasklist_lock when collect_procs()
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        <wangkefeng.wang@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20230821091312.2034844-1-tongtiangen@huawei.com>
 <ZOOt6S+I9ywyNQjP@casper.infradead.org>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <ZOOt6S+I9ywyNQjP@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/22 2:33, Matthew Wilcox 写道:
> On Mon, Aug 21, 2023 at 05:13:12PM +0800, Tong Tiangen wrote:
>> We found a softlock issue in our test, analyzed the logs, and found that
>> the relevant CPU call trace as follows:
>>
>> CPU0:
>>    _do_fork
>>      -> copy_process()
>>        -> write_lock_irq(&tasklist_lock)  //Disable irq,waiting for
>>        					 //tasklist_lock
>>
>> CPU1:
>>    wp_page_copy()
>>      ->pte_offset_map_lock()
>>        -> spin_lock(&page->ptl);        //Hold page->ptl
>>      -> ptep_clear_flush()
>>        -> flush_tlb_others() ...
>>          -> smp_call_function_many()
>>            -> arch_send_call_function_ipi_mask()
>>              -> csd_lock_wait()         //Waiting for other CPUs respond
>> 	                               //IPI
>>
>> CPU2:
>>    collect_procs_anon()
>>      -> read_lock(&tasklist_lock)       //Hold tasklist_lock
>>        ->for_each_process(tsk)
>>          -> page_mapped_in_vma()
>>            -> page_vma_mapped_walk()
>> 	    -> map_pte()
>>                ->spin_lock(&page->ptl)  //Waiting for page->ptl
>>
>> We can see that CPU1 waiting for CPU0 respond IPI，CPU0 waiting for CPU2
>> unlock tasklist_lock, CPU2 waiting for CPU1 unlock page->ptl. As a result,
>> softlockup is triggered.
>>
>> For collect_procs_anon(), we will not modify the tasklist, but only perform
>> read traversal. Therefore, we can use rcu lock instead of spin lock
>> tasklist_lock, from this, we can break the softlock chain above.
> 
> The only thing that's giving me pause is that there's no discussion
> about why this is safe.  "We're not modifying it" isn't really enough
> to justify going from read_lock() to rcu_read_lock().  When you take a
> normal read_lock(), writers are not permitted and so you see an atomic
> snapshot of the list.  With rcu_read_lock() you can see inconsistencies.

Hi Matthew:

When rcu_read_lock() is used, the task list can be modified during the 
iteration, but cannot be seen during iteration. After the iteration is 
complete, the task list can be updated in the RCU mechanism. Therefore, 
the task list used by iteration can also be considered as a snapshot.

> For example, if new tasks can be added to the tasklist, they may not
> be seen by an iteration.  Is this OK?  

The newly added tasks does not access the HWPoison page, because the 
HWPoison page has been isolated from the 
buddy(memory_failure()->take_page_off_buddy()). Therefore, it is safe to 
see the newly added task during the iteration and not be seen by iteration.

Tasks may be removed from the
> tasklist after they have been seen by the iteration.  Is this OK?

Task be seen during iteration are deleted from the task list after 
iteration, it's task_struct is not released because reference counting 
is added in __add_to_kill(). Therefore, the subsequent processing of 
kill_procs() is not affected (sending signals to the task deleted from 
task list). so i think it's safe too.

> 
> As I understand the list RCU code, it guarantees that all tasks which
> were on the list before rcu_read_lock() and remain on the list after
> rcu_read_unlock() will be seen by a list iteration, while tasks which
> are added or removed during that time may or may not be seen.

As described above, i understand that the write update is not visible 
during the RCU read.

Thanks,
Tong.

> 
> .

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E95780839
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359056AbjHRJ0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359102AbjHRJ0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:26:42 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D724430E6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:26:38 -0700 (PDT)
Received: from kwepemm600017.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RRxL12CVNz1GDvv;
        Fri, 18 Aug 2023 17:25:13 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 18 Aug 2023 17:26:35 +0800
Message-ID: <4b91e2c7-cd54-d5e9-472e-6ece369b0651@huawei.com>
Date:   Fri, 18 Aug 2023 17:26:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RFC PATCH -next] mm: fix softlockup by replacing tasklist_lock
 with RCU in for_each_process()
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
References: <20230815130154.1100779-1-tongtiangen@huawei.com>
 <20230817053630.GA461822@ik1-406-35019.vs.sakura.ne.jp>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <20230817053630.GA461822@ik1-406-35019.vs.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/17 13:36, Naoya Horiguchi 写道:
> On Tue, Aug 15, 2023 at 09:01:54PM +0800, Tong Tiangen wrote:
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
>>
>> The same logic can also be applied to:
>>   - collect_procs_file()
>>   - collect_procs_fsdax()
>>   - collect_procs_ksm()
>>   - find_early_kill_thread()
>>
>> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> 
> Hello Tiangen, thank you for finding the issue.
> mm/filemap.c mentions tasklist_lock in the comment about locking order,
> 
>    * ->i_mmap_rwsem
>    *   ->tasklist_lock            (memory_failure, collect_procs_ao)
> 
> so you can update this together?
> Otherwise looks good to me.
> 
> Thanks,
> Naoya Horiguchi

Thank you for your reply. Since tasklist_lock is no longer used in 
collect_procs_xxx(), Should I delete these two comments in mm/filemap.c?

Thanks,
Tong.

> 
>> ---
>>   mm/ksm.c            |  4 ++--
>>   mm/memory-failure.c | 36 ++++++++++++++++++++++--------------
>>   2 files changed, 24 insertions(+), 16 deletions(-)
>>
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index 6b7b8928fb96..dcbc0c7f68e7 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -2919,7 +2919,7 @@ void collect_procs_ksm(struct page *page, struct list_head *to_kill,
>>   		struct anon_vma *av = rmap_item->anon_vma;
>>   
>>   		anon_vma_lock_read(av);
>> -		read_lock(&tasklist_lock);
>> +		rcu_read_lock();
>>   		for_each_process(tsk) {
>>   			struct anon_vma_chain *vmac;
>>   			unsigned long addr;
>> @@ -2938,7 +2938,7 @@ void collect_procs_ksm(struct page *page, struct list_head *to_kill,
>>   				}
>>   			}
>>   		}
>> -		read_unlock(&tasklist_lock);
>> +		rcu_read_unlock();
>>   		anon_vma_unlock_read(av);
>>   	}
>>   }
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 7b01fffe7a79..6a02706043f4 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -546,24 +546,32 @@ static void kill_procs(struct list_head *to_kill, int forcekill, bool fail,
>>    * Find a dedicated thread which is supposed to handle SIGBUS(BUS_MCEERR_AO)
>>    * on behalf of the thread group. Return task_struct of the (first found)
>>    * dedicated thread if found, and return NULL otherwise.
>> - *
>> - * We already hold read_lock(&tasklist_lock) in the caller, so we don't
>> - * have to call rcu_read_lock/unlock() in this function.
>>    */
>>   static struct task_struct *find_early_kill_thread(struct task_struct *tsk)
>>   {
>>   	struct task_struct *t;
>> +	bool find = false;
>>   
>> +	rcu_read_lock();
>>   	for_each_thread(tsk, t) {
>>   		if (t->flags & PF_MCE_PROCESS) {
>> -			if (t->flags & PF_MCE_EARLY)
>> -				return t;
>> +			if (t->flags & PF_MCE_EARLY) {
>> +				find = true;
>> +				break;
>> +			}
>>   		} else {
>> -			if (sysctl_memory_failure_early_kill)
>> -				return t;
>> +			if (sysctl_memory_failure_early_kill) {
>> +				find = true;
>> +				break;
>> +			}
>>   		}
>>   	}
>> -	return NULL;
>> +	rcu_read_unlock();
>> +
>> +	if (!find)
>> +		t = NULL;
>> +
>> +	return t;
>>   }
>>   
>>   /*
>> @@ -609,7 +617,7 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
>>   		return;
>>   
>>   	pgoff = page_to_pgoff(page);
>> -	read_lock(&tasklist_lock);
>> +	rcu_read_lock();
>>   	for_each_process(tsk) {
>>   		struct anon_vma_chain *vmac;
>>   		struct task_struct *t = task_early_kill(tsk, force_early);
>> @@ -626,7 +634,7 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
>>   			add_to_kill_anon_file(t, page, vma, to_kill);
>>   		}
>>   	}
>> -	read_unlock(&tasklist_lock);
>> +	rcu_read_unlock();
>>   	anon_vma_unlock_read(av);
>>   }
>>   
>> @@ -642,7 +650,7 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
>>   	pgoff_t pgoff;
>>   
>>   	i_mmap_lock_read(mapping);
>> -	read_lock(&tasklist_lock);
>> +	rcu_read_lock();
>>   	pgoff = page_to_pgoff(page);
>>   	for_each_process(tsk) {
>>   		struct task_struct *t = task_early_kill(tsk, force_early);
>> @@ -662,7 +670,7 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
>>   				add_to_kill_anon_file(t, page, vma, to_kill);
>>   		}
>>   	}
>> -	read_unlock(&tasklist_lock);
>> +	rcu_read_unlock();
>>   	i_mmap_unlock_read(mapping);
>>   }
>>   
>> @@ -685,7 +693,7 @@ static void collect_procs_fsdax(struct page *page,
>>   	struct task_struct *tsk;
>>   
>>   	i_mmap_lock_read(mapping);
>> -	read_lock(&tasklist_lock);
>> +	rcu_read_lock();
>>   	for_each_process(tsk) {
>>   		struct task_struct *t = task_early_kill(tsk, true);
>>   
>> @@ -696,7 +704,7 @@ static void collect_procs_fsdax(struct page *page,
>>   				add_to_kill_fsdax(t, page, vma, to_kill, pgoff);
>>   		}
>>   	}
>> -	read_unlock(&tasklist_lock);
>> +	rcu_read_unlock();
>>   	i_mmap_unlock_read(mapping);
>>   }
>>   #endif /* CONFIG_FS_DAX */
>> -- 
>> 2.25.1
>>
>>
>>
> .

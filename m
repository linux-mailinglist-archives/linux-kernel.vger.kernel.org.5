Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013C77823C5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 08:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbjHUGfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 02:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjHUGfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 02:35:37 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D10A7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 23:35:35 -0700 (PDT)
Received: from kwepemm600017.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RTjMK3mXqzLp90;
        Mon, 21 Aug 2023 14:32:29 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 21 Aug 2023 14:35:31 +0800
Message-ID: <132f7a1a-3219-bdac-5ca4-ad5a54b09616@huawei.com>
Date:   Mon, 21 Aug 2023 14:35:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] mm: memory-failure: use rcu lock instead of tasklist_lock
 when collect_procs()
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        <wangkefeng.wang@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20230821022534.1381092-1-tongtiangen@huawei.com>
 <ZOLpbwwk4esztLaO@casper.infradead.org>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <ZOLpbwwk4esztLaO@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/21 12:34, Matthew Wilcox 写道:
> On Mon, Aug 21, 2023 at 10:25:34AM +0800, Tong Tiangen wrote:
>> +++ b/mm/memory-failure.c
>> @@ -546,24 +546,26 @@ static void kill_procs(struct list_head *to_kill, int forcekill, bool fail,
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
>>   
>> +	rcu_read_lock();
>>   	for_each_thread(tsk, t) {
>>   		if (t->flags & PF_MCE_PROCESS) {
>>   			if (t->flags & PF_MCE_EARLY)
>> -				return t;
>> +				goto found;
>>   		} else {
>>   			if (sysctl_memory_failure_early_kill)
>> -				return t;
>> +				goto found;
>>   		}
>>   	}
>> -	return NULL;
>> +
>> +	t = NULL;
>> +found:
>> +	rcu_read_unlock();
>> +	return t;
>>   }
> 
> I don't understand why you need to modify find_early_kill_thread() at
> all.  It's still true that the caller holds _a_ lock protecting it; the
> comment needs to be updated to reflect that it might be the RCU lock
> or the tasklist_lock (or did you change all callers?), but there's no
> need for this function to take the RCU lock itself, afaics?
> 
> .

I've checked that all the paths that call find_early_kill_thread() 
already hold the rcu lock, and there's really no need to hold the rcu 
lock here.
In the next patch version, here only the comments are modified.

Thanks,
Tong.


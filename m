Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7838C770D4F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 04:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjHECaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 22:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHECaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 22:30:17 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B5B4EDC;
        Fri,  4 Aug 2023 19:30:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RHml63lQVz4f3nKM;
        Sat,  5 Aug 2023 10:30:10 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgBH_rEvtM1krxhcPg--.25609S3;
        Sat, 05 Aug 2023 10:30:10 +0800 (CST)
Subject: Re: [PATCH v6 0/5] rcu: Dump memory object info if callback function
 is invalid
To:     paulmck@kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhen Lei <thunder.leizhen@huawei.com>
References: <20230804091136.1177-1-thunder.leizhen@huaweicloud.com>
 <7af1d3d8-2d51-40a8-8021-0141e4bf1a0e@paulmck-laptop>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <fad9df02-e57a-9a6c-84d8-e7c7b09cb021@huaweicloud.com>
Date:   Sat, 5 Aug 2023 10:30:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7af1d3d8-2d51-40a8-8021-0141e4bf1a0e@paulmck-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgBH_rEvtM1krxhcPg--.25609S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1DKF4UWFyfCw15tFyxKrg_yoW5XF17p3
        sxWasxKrn8Xry7Cr1fZr1xCry5ta1fKFsxKFnxZwn5u3WUZr9ayr95Ar4xWa4UGFWxKF1j
        y3WYyF1qkr15ArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UZ18PUUUUU=
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/5 1:31, Paul E. McKenney wrote:
> On Fri, Aug 04, 2023 at 05:11:30PM +0800, thunder.leizhen@huaweicloud.com wrote:
>> From: Zhen Lei <thunder.leizhen@huawei.com>
>>
>> v5 --> v6:
>> 1. Use print_hex_dump() to dump the memory of slab object.
>> 2. Add a new dump prefix DUMP_PREFIX_ADDRESS_LOW16
>> 3. Minimize the output width of the offset
>>
>> v4 --> v5:
>> 1. Add Reviewed-by Acked-by for patch 1/3
>> 2. Add patch 3/3:
>>    mm: Dump the memory of slab object in kmem_dump_obj()
>>
>> v3 --> v4:
>> 1. Remove kmem_valid_obj() and convert kmem_dump_obj() to work the same way
>>    as vmalloc_dump_obj().
>> 2. In kernel/rcu/rcu.h
>> -#include <linux/mm.h>
>> +#include <linux/slab.h>
>>
>> v2 --> v3:
>> 1. I made statistics about the source of 'rhp'. kmem_valid_obj() accounts for
>>    more than 97.5%, and vmalloc accounts for less than 1%. So change call
>>    mem_dump_obj() to call kmem_dump_obj() can meet debugging requirements and
>>    avoid the potential deadlock risk of vmalloc_dump_obj().
>> -		mem_dump_obj(rhp);
>> +		if (kmem_valid_obj(rhp))
>> +			kmem_dump_obj(rhp);
>>
>>    The discussion about vmap_area_lock deadlock in v2:
>>    https://lkml.org/lkml/2022/11/11/493
>>
>> 2. Provide static inline empty functions for kmem_valid_obj() and kmem_dump_obj()
>>    when CONFIG_PRINTK=n.
>>
>> v1 --> v2:
>> 1. Remove condition "(unsigned long)rhp->func & 0x3", it have problems on x86.
>> 2. Paul E. McKenney helped me update the commit message, thanks.
> 
> I would be happy to take the patch that Matthew and Vlastimil are happy
> with, and also the one against RCU.  But unless you tell me otherwise,
> I will assume that you would prefer me to wait until the entire series
> is ready.  The best way to tell me otherwise is of course to resend just
> those two patches in their own series.  ;-)

Yes, I also feel this snowball rolling bigger and bigger. Let me resend the two
RCU-related patches that we've discussed OK.

> 
> 							Thanx, Paul
> 
>> Zhen Lei (5):
>>   hexdump: add a new dump prefix DUMP_PREFIX_ADDRESS_LOW16
>>   hexdump: minimize the output width of the offset
>>   mm: Remove kmem_valid_obj()
>>   mm: Dump the memory of slab object in kmem_dump_obj()
>>   rcu: Dump memory object info if callback function is invalid
>>
>>  include/linux/printk.h |  1 +
>>  include/linux/slab.h   |  5 ++--
>>  kernel/rcu/rcu.h       |  7 +++++
>>  kernel/rcu/srcutiny.c  |  1 +
>>  kernel/rcu/srcutree.c  |  1 +
>>  kernel/rcu/tasks.h     |  1 +
>>  kernel/rcu/tiny.c      |  1 +
>>  kernel/rcu/tree.c      |  1 +
>>  lib/hexdump.c          | 17 +++++++++--
>>  mm/slab_common.c       | 68 ++++++++++++++++++++++--------------------
>>  mm/util.c              |  4 +--
>>  11 files changed, 67 insertions(+), 40 deletions(-)
>>
>> -- 
>> 2.34.1
>>
> .
> 

-- 
Regards,
  Zhen Lei


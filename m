Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC0476F714
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 03:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjHDBof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 21:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjHDBod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 21:44:33 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F4B1BD;
        Thu,  3 Aug 2023 18:44:31 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RH7mr06kfz4f3jqs;
        Fri,  4 Aug 2023 09:44:28 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgD3X7P6V8xk6Z0MPg--.4994S3;
        Fri, 04 Aug 2023 09:44:28 +0800 (CST)
Subject: Re: [PATCH v5 3/3] mm: Dump the memory of slab object in
 kmem_dump_obj()
To:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>
References: <20230803101754.1149-1-thunder.leizhen@huaweicloud.com>
 <20230803101754.1149-4-thunder.leizhen@huaweicloud.com>
 <8a08b7aa-ce1f-4b3d-abb5-cf3191474725@suse.cz>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <5d625946-28f1-f532-dd58-af18263a8bea@huaweicloud.com>
Date:   Fri, 4 Aug 2023 09:44:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <8a08b7aa-ce1f-4b3d-abb5-cf3191474725@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgD3X7P6V8xk6Z0MPg--.4994S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZw13Kw4fJrWUZF1UGr45ZFb_yoW5WF4kpr
        98Gr1UKrZ7ArnrCrn7X3WDJFnxJ3ykCF1kA3yav3W2vryDXr48uFyktF97uFyrAF1Sq39F
        yr4qqF9I934UJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/3 18:34, Vlastimil Babka wrote:
> On 8/3/23 12:17, thunder.leizhen@huaweicloud.com wrote:
>> From: Zhen Lei <thunder.leizhen@huawei.com>
>>
>> The contents of the slab object may contain some magic words and other
>> useful information that may be helpful in locating problems such as
>> memory corruption and use-after-free.
>>
>> To avoid print flooding, dump up to "16 * sizeof(int) = 64" bytes
>> centered on argument 'ojbect'.
>>
>> For example:
>> slab kmalloc-64 start ffff4043802d8b40 pointer offset 24 size 64
>> [8b40]: 12345678 00000000 8092d000 ffff8000
>> [8b50]: 00101000 00000000 8199ee00 ffff4043
>> [8b60]: 00000000 00000000 00000000 00000100
>> [8b70]: 00000000 9abcdef0 a8744de4 ffffc7fe
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  mm/slab_common.c | 30 +++++++++++++++++++++++++++---
>>  1 file changed, 27 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index ee6ed6dd7ba9fa5..0232de9a3b29cf5 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -553,7 +553,7 @@ static void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *
>>  bool kmem_dump_obj(void *object)
>>  {
>>  	char *cp = IS_ENABLED(CONFIG_MMU) ? "" : "/vmalloc";
>> -	int i;
>> +	int i, object_size = 0;
>>  	struct slab *slab;
>>  	unsigned long ptroffset;
>>  	struct kmem_obj_info kp = { };
>> @@ -580,12 +580,36 @@ bool kmem_dump_obj(void *object)
>>  		ptroffset = ((char *)object - (char *)kp.kp_objp) - kp.kp_data_offset;
>>  		pr_cont(" pointer offset %lu", ptroffset);
>>  	}
>> -	if (kp.kp_slab_cache && kp.kp_slab_cache->object_size)
>> -		pr_cont(" size %u", kp.kp_slab_cache->object_size);
>> +	if (kp.kp_slab_cache && kp.kp_slab_cache->object_size) {
>> +		object_size = kp.kp_slab_cache->object_size;
>> +		pr_cont(" size %u", object_size);
>> +	}
>>  	if (kp.kp_ret)
>>  		pr_cont(" allocated at %pS\n", kp.kp_ret);
>>  	else
>>  		pr_cont("\n");
>> +
>> +	/* Dump a small piece of memory centered on 'object' */
>> +	if (kp.kp_objp && object_size) {
>> +		int *p = object, n = 16;
>> +
>> +		p += n / 2;
>> +		if ((void *)p > kp.kp_objp + object_size)
>> +			p = kp.kp_objp + object_size;
>> +
>> +		p -= n;
>> +		if ((void *)p < kp.kp_objp)
>> +			p = kp.kp_objp;
>> +
>> +		n = min_t(int, object_size / sizeof(int), n);
>> +		for (i = 0; i < n; i++, p++) {
>> +			if (i % 4 == 0)
>> +				pr_info("[%04lx]:", 0xffff & (unsigned long)p);
>> +			pr_cont(" %08x", *p);
>> +		}
>> +		pr_cont("\n");
> 
> There's a print_hex_dump() for this, see how it's used from e.g. __dump_page().

Thank you very much. The code has suddenly been a lot simpler.

However, print_hex_dump() can be further enhanced, I will add a patch, let's
discuss it together.

> 
> 
>> +	}
>> +
>>  	for (i = 0; i < ARRAY_SIZE(kp.kp_stack); i++) {
>>  		if (!kp.kp_stack[i])
>>  			break;
> 
> .
> 

-- 
Regards,
  Zhen Lei


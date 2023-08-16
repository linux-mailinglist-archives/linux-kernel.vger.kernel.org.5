Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E76B77DD17
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243254AbjHPJPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243284AbjHPJP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:15:27 -0400
Received: from out-1.mta0.migadu.com (out-1.mta0.migadu.com [91.218.175.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A55173F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:15:25 -0700 (PDT)
Message-ID: <9091fa43-1c38-58f4-b23d-7705fc647293@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692177324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7hzRwpdWY8QIffBbn0D1YNeGrZzAgPJoF3wC1s2tY6M=;
        b=XQBooO+R0LjluBdeAtLEQNXIFeBN6MY67jQWB2CEMoSSKsz6vpgkY7xN3PgdYHvND952wE
        zbN7gPLjguh29PjLy9NxSKmPOg6mpSL4T4Lb/CHidSINUwBe4GZclVHq6q37qptqGvi60P
        oZky3NRnyqPGtUHfvHfoJCW9oQhl8x0=
Date:   Wed, 16 Aug 2023 17:15:14 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] null_blk: fix poll request timeout handling
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     axboe@kernel.dk, kch@nvidia.com, damien.lemoal@opensource.wdc.com,
        bvanassche@acm.org, nj.shetty@samsung.com, kbusch@kernel.org,
        zhouchengming@bytedance.com, akinobu.mita@gmail.com,
        shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230815060443.660263-1-chengming.zhou@linux.dev>
 <23383.1692087575@warthog.procyon.org.uk>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <23383.1692087575@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/15 16:19, David Howells wrote:
> chengming.zhou@linux.dev wrote:
> 
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> When doing io_uring benchmark on /dev/nullb0, it's easy to crash the
>> kernel if poll requests timeout triggered, as reported by David. [1]
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000008
>> Workqueue: kblockd blk_mq_timeout_work
>> RIP: 0010:null_timeout_rq+0x4e/0x91
>> Call Trace:
>>  ? __die_body+0x1a/0x5c
>>  ? page_fault_oops+0x6f/0x9c
>>  ? kernelmode_fixup_or_oops+0xc6/0xd6
>>  ? __bad_area_nosemaphore+0x44/0x1eb
>>  ? exc_page_fault+0xe2/0xf4
>>  ? asm_exc_page_fault+0x22/0x30
>>  ? null_timeout_rq+0x4e/0x91
>>  blk_mq_handle_expired+0x31/0x4b
>>  bt_iter+0x68/0x84
>>  ? bt_tags_iter+0x81/0x81
>>  __sbitmap_for_each_set.constprop.0+0xb0/0xf2
>>  ? __blk_mq_complete_request_remote+0xf/0xf
>>  bt_for_each+0x46/0x64
>>  ? __blk_mq_complete_request_remote+0xf/0xf
>>  ? percpu_ref_get_many+0xc/0x2a
>>  blk_mq_queue_tag_busy_iter+0x14d/0x18e
>>  blk_mq_timeout_work+0x95/0x127
>>  process_one_work+0x185/0x263
>>  worker_thread+0x1b5/0x227
>>  ? rescuer_thread+0x287/0x287
>>  kthread+0xfa/0x102
>>  ? kthread_complete_and_exit+0x1b/0x1b
>>  ret_from_fork+0x22/0x30
>>
>> This is indeed a race problem between null_timeout_rq() and null_poll().
>>
>> null_poll()				null_timeout_rq()
>>   spin_lock(&nq->poll_lock)
>>   list_splice_init(&nq->poll_list, &list)
>>   spin_unlock(&nq->poll_lock)
>>
>>   while (!list_empty(&list))
>>     req = list_first_entry()
>>     list_del_init()
>>     ...
>>     blk_mq_add_to_batch()
>>     // req->rq_next = NULL
>> 					spin_lock(&nq->poll_lock)
>>
>> 					// rq->queuelist->next == NULL
>> 					list_del_init(&rq->queuelist)
>>
>> 					spin_unlock(&nq->poll_lock)
>>
>> What's worse is that we don't call blk_mq_complete_request_remote()
>> before blk_mq_add_to_batch(), so these completed requests have wrong
>> rq->state == MQ_RQ_IN_FLIGHT. We can easily check this using bpftrace:
>>
>> ```
>> bpftrace -e 'kretfunc:null_blk:null_poll {
>>   $iob=(struct io_comp_batch *)args->iob;
>>   @[$iob->req_list->state]=count();
>> }'
>>
>> @[1]: 51708
>> ```
>>
>> Fix these problems by setting requests state to MQ_RQ_COMPLETE under
>> nq->poll_lock protection, in which null_timeout_rq() can safely detect
>> this race and early return.
>>
>> [1] https://lore.kernel.org/all/3893581.1691785261@warthog.procyon.org.uk/
>>
>> Fixes: 0a593fbbc245 ("null_blk: poll queue support")
>> Reported-by: David Howells <dhowells@redhat.com>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Okay, the oops no longer seems to happen, so on that basis:
> 
> Tested-by: David Howells <dhowells@redhat.com>
> 

Yes, this patch just fixes the kernel oops when request timeout happened.

> 
> However, running:
> 
> 	./fio/t/io_uring -n4 /dev/nullb0
> 
> and then interrupting it with ctrl-C after a while dumps a whole load of
> messages into the dmesg log (excerpt attached).  It seems wrong that the user
> should be able to generate a dump like this just by interrupting - but I guess
> as it's null_blk it probably doesn't matter.

I can reproduce it, maybe an issue in io_uring. Although io_uring will reap
all pending requests when task exit, it seems that it will block for some
seconds before doing reap, so timeout happen. I'm not sure, just some guess ;-)

Thanks.

> 
> David
> ---
> null_blk: rq 00000000bb2d3264 timed out
> timeout error, dev nullb0, sector 328372624 op 0x0:(READ) flags 0xe00000 phys_seg 1 prio class 2
> null_blk: rq 00000000abcc1075 timed out
> timeout error, dev nullb0, sector 378610072 op 0x0:(READ) flags 0xe00000 phys_seg 1 prio class 2
> null_blk: rq 00000000d4bdc71f timed out
> timeout error, dev nullb0, sector 185005312 op 0x0:(READ) flags 0xe00000 phys_seg 1 prio class 2
> null_blk: rq 00000000f4ffddee timed out
> timeout error, dev nullb0, sector 206118608 op 0x0:(READ) flags 0xe00000 phys_seg 1 prio class 2
> null_blk: rq 000000001e68b709 timed out
> timeout error, dev nullb0, sector 310381160 op 0x0:(READ) flags 0xe00000 phys_seg 1 prio class 2
> null_blk: rq 00000000bfeafe97 timed out
> timeout error, dev nullb0, sector 52036480 op 0x0:(READ) flags 0xe00000 phys_seg 1 prio class 2
> null_blk: rq 00000000aa67d21c timed out
> timeout error, dev nullb0, sector 22746448 op 0x0:(READ) flags 0xe00000 phys_seg 1 prio class 2
> null_blk: rq 00000000faec1291 timed out
> timeout error, dev nullb0, sector 391201440 op 0x0:(READ) flags 0xe00000 phys_seg 1 prio class 2
> null_blk: rq 00000000c634428c timed out
> timeout error, dev nullb0, sector 237216136 op 0x0:(READ) flags 0xe00000 phys_seg 1 prio class 2
> null_blk: rq 0000000077f91a5d timed out
> timeout error, dev nullb0, sector 453778912 op 0x0:(READ) flags 0xe00000 phys_seg 1 prio class 2
> null_blk: rq 000000003076467c timed out
> null_blk: rq 000000009c172678 timed out
> null_blk: rq 000000002df50b48 timed out
> null_blk: rq 00000000e4c66900 timed out
> null_blk: rq 0000000082606e31 timed out
> null_blk: rq 00000000fe21ffdc timed out
> null_blk: rq 000000005e5c5173 timed out
> null_blk: rq 00000000b0a0d20c timed out
> null_blk: rq 000000008c729e47 timed out
> null_blk: rq 00000000970f75a0 timed out
> null_blk: rq 000000002ad3c45a timed out
> 

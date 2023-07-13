Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9438B75179D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbjGMElY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjGMElV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:41:21 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A39211E;
        Wed, 12 Jul 2023 21:41:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VnFWGm4_1689223270;
Received: from 30.97.48.217(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VnFWGm4_1689223270)
          by smtp.aliyun-inc.com;
          Thu, 13 Jul 2023 12:41:11 +0800
Message-ID: <f124e041-6a82-2069-975c-4f393e5c4137@linux.alibaba.com>
Date:   Thu, 13 Jul 2023 12:41:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when
 !CONFIG_DEBUG_LOCK_ALLOC
To:     paulmck@kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Sandeep Dhavale <dhavale@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org,
        Will Shiu <Will.Shiu@mediatek.com>, kernel-team@android.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230711233816.2187577-1-dhavale@google.com>
 <CAEXW_YQvpiFEaaNoS=Msgi17mU3kZD+q8bNBaHYasMArG9aPig@mail.gmail.com>
 <CAB=BE-Rm0ycTZXj=wHW_FBCCKbswG+dh3L+o1+CUW=Pg_oWnyw@mail.gmail.com>
 <20230713003201.GA469376@google.com>
 <161f1615-3d85-cf47-d2d5-695adf1ca7d4@linux.alibaba.com>
 <0d9e7b4d-6477-47a6-b3d2-2c9d9b64903d@paulmck-laptop>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <0d9e7b4d-6477-47a6-b3d2-2c9d9b64903d@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/13 12:27, Paul E. McKenney wrote:
> On Thu, Jul 13, 2023 at 10:02:17AM +0800, Gao Xiang wrote:
>>
>>
>> On 2023/7/13 08:32, Joel Fernandes wrote:
>>> On Wed, Jul 12, 2023 at 02:20:56PM -0700, Sandeep Dhavale wrote:
>>> [..]
>>>>> As such this patch looks correct to me, one thing I noticed is that
>>>>> you can check rcu_is_watching() like the lockdep-enabled code does.
>>>>> That will tell you also if a reader-section is possible because in
>>>>> extended-quiescent-states, RCU readers should be non-existent or
>>>>> that's a bug.
>>>>>
>>>> Please correct me if I am wrong, reading from the comment in
>>>> kernel/rcu/update.c rcu_read_lock_held_common()
>>>> ..
>>>>     * The reason for this is that RCU ignores CPUs that are
>>>>    * in such a section, considering these as in extended quiescent state,
>>>>    * so such a CPU is effectively never in an RCU read-side critical section
>>>>    * regardless of what RCU primitives it invokes.
>>>>
>>>> It seems rcu will treat this as lock not held rather than a fact that
>>>> lock is not held. Is my understanding correct?
>>>
>>> If RCU treats it as a lock not held, that is a fact for RCU ;-). Maybe you
>>> mean it is not a fact for erofs?
>>
>> I'm not sure if I get what you mean, EROFS doesn't take any RCU read lock
>> here:
> 
> The key point is that we need lockdep to report errors when
> rcu_read_lock(), rcu_dereference(), and friends are used when RCU is
> not watching.  We also need lockdep to report an error when someone
> uses rcu_dereference() when RCU is not watching, but also forgets the
> rcu_read_lock().
> 
> And this is the job of rcu_read_lock_held(), which is one reason why
> that rcu_is_watching() is needed.
> 
>> z_erofs_decompressqueue_endio() is actually a "bio->bi_end_io", previously
>> which can be called under two scenarios:
>>
>>   1) under softirq context, which is actually part of device I/O compleltion;
>>
>>   2) under threaded context, like what dm-verity or likewise calls.
>>
>> But EROFS needs to decompress in a threaded context anyway, so we trigger
>> a workqueue to resolve the case 1).
>>
>> Recently, someone reported there could be some case 3) [I think it was
>> introduced recently but I have no time to dig into it]:
>>
>>   case 3: under RCU read lock context, which is shown by this:
>> https://lore.kernel.org/r/4a8254eb-ac39-1e19-3d82-417d3a7b9f94@linux.alibaba.com/T/#u
>>
>>   and such RCU read lock is taken in __blk_mq_run_dispatch_ops().
>>
>> But as the commit shown, we only need to trigger a workqueue for case 1)
>> and 3) due to performance reasons.
> 
> Just out of curiosity, exactly how much is it costing to trigger the
> workqueue?

There are lots of performance issues here and even a plumber
topic last year to show that, see:

[1] https://lore.kernel.org/r/20230519001709.2563-1-tj@kernel.org
[2] https://lore.kernel.org/r/CAHk-=wgE9kORADrDJ4nEsHHLirqPCZ1tGaEPAZejHdZ03qCOGg@mail.gmail.com
[3] https://lore.kernel.org/r/CAB=BE-SBtO6vcoyLNA9F-9VaN5R0t3o_Zn+FW8GbO6wyUqFneQ@mail.gmail.com
[4] https://lpc.events/event/16/contributions/1338/
and more.

I'm not sure if it's necessary to look info all of that,
andSandeep knows more than I am (the scheduling issue
becomes vital on some aarch64 platform.)

Thanks,
Gao Xiang

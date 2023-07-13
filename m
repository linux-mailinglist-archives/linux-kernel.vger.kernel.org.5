Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2201375160C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 04:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbjGMCKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 22:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjGMCKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 22:10:38 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5334512D;
        Wed, 12 Jul 2023 19:10:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VnEugHV_1689214232;
Received: from 30.97.48.217(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VnEugHV_1689214232)
          by smtp.aliyun-inc.com;
          Thu, 13 Jul 2023 10:10:33 +0800
Message-ID: <a6d65874-1280-bf16-06ce-2062d913dbca@linux.alibaba.com>
Date:   Thu, 13 Jul 2023 10:10:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when
 !CONFIG_DEBUG_LOCK_ALLOC
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Joel Fernandes <joel@joelfernandes.org>,
        Sandeep Dhavale <dhavale@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
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
In-Reply-To: <161f1615-3d85-cf47-d2d5-695adf1ca7d4@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/13 10:02, Gao Xiang wrote:
> 
> 
> On 2023/7/13 08:32, Joel Fernandes wrote:
>> On Wed, Jul 12, 2023 at 02:20:56PM -0700, Sandeep Dhavale wrote:
>> [..]
>>>> As such this patch looks correct to me, one thing I noticed is that
>>>> you can check rcu_is_watching() like the lockdep-enabled code does.
>>>> That will tell you also if a reader-section is possible because in
>>>> extended-quiescent-states, RCU readers should be non-existent or
>>>> that's a bug.
>>>>
>>> Please correct me if I am wrong, reading from the comment in
>>> kernel/rcu/update.c rcu_read_lock_held_common()
>>> ..
>>>    * The reason for this is that RCU ignores CPUs that are
>>>   * in such a section, considering these as in extended quiescent state,
>>>   * so such a CPU is effectively never in an RCU read-side critical section
>>>   * regardless of what RCU primitives it invokes.
>>>
>>> It seems rcu will treat this as lock not held rather than a fact that
>>> lock is not held. Is my understanding correct?
>>
>> If RCU treats it as a lock not held, that is a fact for RCU ;-). Maybe you
>> mean it is not a fact for erofs?
> 
> I'm not sure if I get what you mean, EROFS doesn't take any RCU read lock
> here:
> 
> z_erofs_decompressqueue_endio() is actually a "bio->bi_end_io", previously
> which can be called under two scenarios:
> 
>   1) under softirq context, which is actually part of device I/O compleltion;
> 
>   2) under threaded context, like what dm-verity or likewise calls.
> 
> But EROFS needs to decompress in a threaded context anyway, so we trigger
> a workqueue to resolve the case 1).
> 
> 
> Recently, someone reported there could be some case 3) [I think it was
> introduced recently but I have no time to dig into it]:
> 
>   case 3: under RCU read lock context, which is shown by this:
> https://lore.kernel.org/r/4a8254eb-ac39-1e19-3d82-417d3a7b9f94@linux.alibaba.com/T/#u

Sorry about the incorrect link (I really don't know who initally reported
this and on which device):

https://lore.kernel.org/linux-erofs/161f1615-3d85-cf47-d2d5-695adf1ca7d4@linux.alibaba.com/T/#t

> 
>   and such RCU read lock is taken in __blk_mq_run_dispatch_ops().
> 
> But as the commit shown, we only need to trigger a workqueue for case 1)
> and 3) due to performance reasons.
> 
> Hopefully I show it more clear.
> 
> Thanks,
> Gao Xiang

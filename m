Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2FF752FD9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbjGNDRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbjGNDRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:17:07 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A76230F4;
        Thu, 13 Jul 2023 20:17:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VnK7oAI_1689304613;
Received: from 172.20.10.3(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VnK7oAI_1689304613)
          by smtp.aliyun-inc.com;
          Fri, 14 Jul 2023 11:16:56 +0800
Message-ID: <058e7ee9-0380-eb1b-d9a8-b184cba6ed53@linux.alibaba.com>
Date:   Fri, 14 Jul 2023 11:16:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when
 !CONFIG_DEBUG_LOCK_ALLOC
To:     paulmck@kernel.org, Sandeep Dhavale <dhavale@google.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
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
        linux-mediatek@lists.infradead.org,
        Joel Fernandes <joel@joelfernandes.org>
References: <20230713003201.GA469376@google.com>
 <161f1615-3d85-cf47-d2d5-695adf1ca7d4@linux.alibaba.com>
 <0d9e7b4d-6477-47a6-b3d2-2c9d9b64903d@paulmck-laptop>
 <f124e041-6a82-2069-975c-4f393e5c4137@linux.alibaba.com>
 <87292a44-cc02-4d95-940e-e4e31d0bc6f2@paulmck-laptop>
 <f1c60dcb-e32f-7b7e-bf0d-5dec999e9299@linux.alibaba.com>
 <CAEXW_YSODXRfgkR0D2G-x=0uZdsqvF3kZL+LL3DcRX-5CULJ1Q@mail.gmail.com>
 <894a3b64-a369-7bc6-c8a8-0910843cc587@linux.alibaba.com>
 <CAEXW_YSM1yik4yWTgZoxCS9RM6TbsL26VCVCH=41+uMA8chfAQ@mail.gmail.com>
 <58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmck-laptop>
 <7d433fac-a62d-4e81-b8e5-57cf5f2d1d55@paulmck-laptop>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <7d433fac-a62d-4e81-b8e5-57cf5f2d1d55@paulmck-laptop>
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



On 2023/7/14 10:16, Paul E. McKenney wrote:
> On Thu, Jul 13, 2023 at 09:33:35AM -0700, Paul E. McKenney wrote:
>> On Thu, Jul 13, 2023 at 11:33:24AM -0400, Joel Fernandes wrote:

...

>>>
>>> >From what Sandeep described, the code path is in an RCU reader. My
>>> question is more, why doesn't it use SRCU instead since it clearly
>>> does so if BLK_MQ_F_BLOCKING. What are the tradeoffs? IMHO, a deeper
>>> dive needs to be made into that before concluding that the fix is to
>>> use rcu_read_lock_any_held().
>>
>> How can this be solved?
>>
>> 1.	Always use a workqueue.  Simple, but is said to have performance
>> 	issues.
>>
>> 2.	Pass a flag in that indicates whether or not the caller is in an
>> 	RCU read-side critical section.  Conceptually simple, but might
>> 	or might not be reasonable to actually implement in the code as
>> 	it exists now.	(You tell me!)
>>
>> 3.	Create a function in z_erofs that gives you a decent
>> 	approximation, maybe something like the following.
>>
>> 4.	Other ideas here.
> 
> 5.	#3 plus make the corresponding Kconfig option select
> 	PREEMPT_COUNT, assuming that any users needing compression in
> 	non-preemptible kernels are OK with PREEMPT_COUNT being set.
> 	(Some users of non-preemptible kernels object strenuously
> 	to the added overhead from CONFIG_PREEMPT_COUNT=y.)

I'm not sure if it's a good idea, we need to work on
CONFIG_PREEMPT_COUNT=n (why not?), we could just always trigger a
workqueue for this.

Anyway, before we proceed, I also think it'd be better to get some
performance numbers first for this (e.g. with dm-verity) and record
the numbers in the commit message to justify this.  Otherwise, I guess
the same question will be raised again and again.

Thanks,
Gao Xiang

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DE378BCD5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 04:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbjH2Cab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 22:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbjH2C36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:29:58 -0400
Received: from out-247.mta0.migadu.com (out-247.mta0.migadu.com [91.218.175.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C10A1AB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 19:29:46 -0700 (PDT)
Message-ID: <51cf9db1-4487-4229-4d43-e91268e52125@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693276184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vqm46DklsiPUqsKNsKfG5jvEXJZjbfT+kn5o07p+jO8=;
        b=ntSApUDajpkhf2XFpWimfICfDSvwa2v7ONZP3cQTInzr+Ov3cIJ10LQRgPxr0EM5L2iEbH
        1+zsP+Uhv4GJ4Bt5HJBqEnszpK2uUA0zxa9c/YzQmHisOhXV+WULPtI4F61UP3XeTzLuch
        IaJNr+W8puq3gE3foxkt3pnkBujsrDw=
Date:   Tue, 29 Aug 2023 10:29:17 +0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH v2 0/3] Move usages of struct __call_single_data to
 call_single_data_t
Content-Language: en-US
To:     =?UTF-8?Q?Leonardo_Br=c3=a1s?= <leobras@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230520052957.798486-1-leobras@redhat.com>
 <CAJ6HWG6dK_-5jjoGJadOXqE=9c0Np-85r9-ymtAt241XrdwW=w@mail.gmail.com>
 <b84ad9aa200457b1cbd5c55a7d860e685f068d7a.camel@redhat.com>
 <1cd98cb37dcf621520e52ac7a15513aab5749534.camel@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <1cd98cb37dcf621520e52ac7a15513aab5749534.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/29 08:55, Leonardo Brás wrote:
> On Tue, 2023-07-04 at 04:22 -0300, Leonardo Brás wrote:
>> On Tue, 2023-06-13 at 00:51 -0300, Leonardo Bras Soares Passos wrote:
>>> Friendly ping
>>>
>>> On Sat, May 20, 2023 at 2:30 AM Leonardo Bras <leobras@redhat.com> wrote:
>>>>
>>>> Changes since RFCv1:
>>>> - request->csd moved to the middle of the struct, without size impact
>>>> - type change happens in a different patch (thanks Jens Axboe!)
>>>> - Improved the third patch to also update the .h file.
>>>>
>>>> Leonardo Bras (3):
>>>>   blk-mq: Move csd inside struct request so it's 32-byte aligned
>>>>   blk-mq: Change request->csd type to call_single_data_t
>>>>   smp: Change signatures to use call_single_data_t
>>>>
>>>>  include/linux/blk-mq.h | 10 +++++-----
>>>>  include/linux/smp.h    |  2 +-
>>>>  kernel/smp.c           |  4 ++--
>>>>  kernel/up.c            |  2 +-
>>>>  4 files changed, 9 insertions(+), 9 deletions(-)
>>>>
>>>> --
>>>> 2.40.1
>>>>
>>
>> Hello Jens,
>>
>> I still want your feedback on this series :)
>>
>> I think I addressed every issue of RFCv1, but if you have any other feedback,
>> please let me know.
>>
>> Thanks!
>> Leo
> 
> Hello Jens Axboe,
> 
> Please provide feedback on this series!
> 
> Are you ok with those changes?
> What's your opinion on them? 
> 
> Thanks!
> Leo
> 

Hello,

FYI, there is no csd in struct request anymore in block/for-next branch,
which is deleted by this commit:

commit 660e802c76c89e871c29cd3174c07c8d23e39c35
Author: Chengming Zhou <zhouchengming@bytedance.com>
Date:   Mon Jul 17 12:00:55 2023 +0800

    blk-mq: use percpu csd to remote complete instead of per-rq csd

    If request need to be completed remotely, we insert it into percpu llist,
    and smp_call_function_single_async() if llist is empty previously.

    We don't need to use per-rq csd, percpu csd is enough. And the size of
    struct request is decreased by 24 bytes.

    This way is cleaner, and looks correct, given block softirq is guaranteed
    to be scheduled to consume the list if one new request is added to this
    percpu list, either smp_call_function_single_async() returns -EBUSY or 0.

    Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
    Reviewed-by: Ming Lei <ming.lei@redhat.com>
    Reviewed-by: Christoph Hellwig <hch@lst.de>
    Link: https://lore.kernel.org/r/20230717040058.3993930-2-chengming.zhou@linux.dev
    Signed-off-by: Jens Axboe <axboe@kernel.dk>


Return-Path: <linux-kernel+bounces-58924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F6984EEAD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 02:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60EFA1F26548
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 01:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F191C20;
	Fri,  9 Feb 2024 01:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwNkCvof"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746CD15D4;
	Fri,  9 Feb 2024 01:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707443924; cv=none; b=NWpJaLzMi/P0pDc5V4UOB0lJmCnIOyPiYd42eWuTXQIVWCkv7fV4PxaIzY5OCdfwE/ZJmWCLw8OTtZHdv5xkqa5f7tjmyQrGkyh51bJq2yUvR14Kl23m8zPnOUv2qPABByukgZQxK025er0snoqFVhUFisvFYiiih94DfKlMy8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707443924; c=relaxed/simple;
	bh=fhyg5jBDizytO6x3hZXyQa4pHMLhM/GRB9tg0/a7aZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MCP+9xTxjmMNvxRvENPrzVz4kTNdaU7tBNiXoSJEHfQRsvoSXPvd6dbveSXQGkkJ7vVNpp2Co7OpbNIbcX17NPQgXEbkow7NalB5Nr7CP2cKMHLrUIk1Jjz/QhzGDkm173DeNtiDmIkH6A1rIq4rj8nxgrnvfZ69UF45F6zShjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwNkCvof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1481DC433C7;
	Fri,  9 Feb 2024 01:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707443924;
	bh=fhyg5jBDizytO6x3hZXyQa4pHMLhM/GRB9tg0/a7aZE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mwNkCvofzO6gMxI2qcdtN8md9csh2uCkP/J0eHFdHTB4dLVWyLHZ3aiYlQJM/jduZ
	 +hryoxuATnyhBUk/vVVCkwJsVtM5o+K9SeXc33ObfsubUvnxZGA2bWHr0aA19uBPfV
	 dYl5ozEtRoRfx35lUC9EOh99D57uk/k+w660bE0O3dHEJWEzQIIPW7k+dBY8OmSRqT
	 IxriGWy0bd3IYLrE88cJMjkUjyHYbKtv0kBhyirD62VatmfDIu9cZzSivIO0mAdgwY
	 7aXkwrwgw9SvkzG5X7IKVcJa1psfjfaF4noxrt1HDpWD+q39x5noI7hsS3invtHjuE
	 hvgT7gF8VQPPg==
Message-ID: <e4078b85-5675-4fdb-a01f-7112342ec501@kernel.org>
Date: Fri, 9 Feb 2024 10:58:40 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] block: introducing a bias over deadline's fifo_time
Content-Language: en-US
To: Zhaoyang Huang <huangzhaoyang@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Yu Zhao <yuzhao@google.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 steve.kang@unisoc.com
References: <20240208093136.178797-1-zhaoyang.huang@unisoc.com>
 <20240208093136.178797-3-zhaoyang.huang@unisoc.com>
 <ca00ff75-e98d-4652-9c52-94b2e876901e@kernel.dk>
 <CAGWkznH6Y8u7PsoHWid0uQ+ceRK_qzSn6=eWn4dvDhK+DzSXzg@mail.gmail.com>
 <da41bac4-015f-4df0-b8cc-6c8b2f468e12@kernel.dk>
 <CAGWkznGnyPXM_DyyUxxZFoW=3K0B3Nh8sRZ8Lnsvm7WfES_fmA@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAGWkznGnyPXM_DyyUxxZFoW=3K0B3Nh8sRZ8Lnsvm7WfES_fmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/9/24 09:28, Zhaoyang Huang wrote:
> On Fri, Feb 9, 2024 at 8:11 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 2/8/24 5:02 PM, Zhaoyang Huang wrote:
>>> On Fri, Feb 9, 2024 at 1:49?AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> On 2/8/24 2:31 AM, zhaoyang.huang wrote:
>>>>> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
>>>>> index f958e79277b8..43c08c3d6f18 100644
>>>>> --- a/block/mq-deadline.c
>>>>> +++ b/block/mq-deadline.c
>>>>> @@ -15,6 +15,7 @@
>>>>>  #include <linux/compiler.h>
>>>>>  #include <linux/rbtree.h>
>>>>>  #include <linux/sbitmap.h>
>>>>> +#include "../kernel/sched/sched.h"
>>>>>
>>>>>  #include <trace/events/block.h>
>>>>>
>>>>> @@ -802,6 +803,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>>>>>       u8 ioprio_class = IOPRIO_PRIO_CLASS(ioprio);
>>>>>       struct dd_per_prio *per_prio;
>>>>>       enum dd_prio prio;
>>>>> +     int fifo_expire;
>>>>>
>>>>>       lockdep_assert_held(&dd->lock);
>>>>>
>>>>> @@ -840,7 +842,9 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>>>>>               /*
>>>>>                * set expire time and add to fifo list
>>>>>                */
>>>>> -             rq->fifo_time = jiffies + dd->fifo_expire[data_dir];
>>>>> +             fifo_expire = task_is_realtime(current) ? dd->fifo_expire[data_dir] :
>>>>> +                     CFS_PROPORTION(current, dd->fifo_expire[data_dir]);
>>>>> +             rq->fifo_time = jiffies + fifo_expire;
>>>>>               insert_before = &per_prio->fifo_list[data_dir];
>>>>>  #ifdef CONFIG_BLK_DEV_ZONED
>>>>>               /*
>>>>
>>>> Hard pass on this blatant layering violation. Just like the priority
>>>> changes, this utterly fails to understand how things are properly
>>>> designed.
>>> IMHO, I don't think this is a layering violation. bio_set_ioprio is
>>> the one which introduces the scheduler thing into the block layer,
>>> this commit just wants to do a little improvement based on that. This
>>> commit helps CFS task save some IO time when preempted by RT heavily.
>>
>> Listen, both this and the previous content ioprio thing show a glaring
>> misunderstanding of how to design these kinds of things. You have no
>> grasp of what the different layers do, or how they interact. I'm not
>> sure how to put this kindly, but it's really an awful idea to hardcore
>> some CFS helper into the IO scheduler. The fact that you had to fiddle
>> around with headers to make it work was the first warning sign, and the
>> fact that you didn't stop at that point to consider how it could be
>> properly done makes it even worse.
>>
>> You need to stop sending kernel patches until you understand basic
>> software design. Neither of these patches are going anywhere until this
>> happens. There's been plenty of feedback to telling you that, but you
>> seem to just ignore it and plow on ahead. Stop.
> Ok, thanks for pointing this out, I will follow your advice. But I
> have to say that '[PATCHv9 1/1] block: introduce content activity
> based ioprio' really solved layering violation things. I would like to
> humbly ask for your kindly patient to have a look, as it is really
> helpful.

If properly designed, that patch would *not* be a block layer API/function and
so does not need review by block layer folks/Jens as it would simply set an IO
prio for a BIO issued by an FS. So that patch needs to be accepted by FS
people, for the FS you are interested in.


-- 
Damien Le Moal
Western Digital Research



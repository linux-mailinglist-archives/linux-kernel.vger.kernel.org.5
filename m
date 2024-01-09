Return-Path: <linux-kernel+bounces-21057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F57C828929
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC9F1F24998
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4115439FE8;
	Tue,  9 Jan 2024 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ai/7ZLiQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B279D38DC1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704814810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3u9frew4AnXnPrgkhRned9H0OvInDmYOObkWxIBfig=;
	b=Ai/7ZLiQ2r4IeHFTjylc/NoriwsgMmEDoKASSSj9XwqtLM5iwaSShWKyp4YZsqdRyvJWb9
	EsuWGegA8DoYWaK4kgU1fdtKeFxQD8DSn6/6WAwNn1/7GBpSc3AygzUEedidCCzOLTrKzU
	bzbZi0/c3chm1BYZK8YVkb6FmIuVBB0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-UzIOES_hN9Wt6QwKTVHf5A-1; Tue,
 09 Jan 2024 10:40:05 -0500
X-MC-Unique: UzIOES_hN9Wt6QwKTVHf5A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BFCAC29ABA1E;
	Tue,  9 Jan 2024 15:40:04 +0000 (UTC)
Received: from [10.22.9.97] (unknown [10.22.9.97])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8C41B3C2E;
	Tue,  9 Jan 2024 15:40:03 +0000 (UTC)
Message-ID: <83981bdc-08e5-435b-bf09-c00c90a80870@redhat.com>
Date: Tue, 9 Jan 2024 10:40:03 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] lockdep: Add missing graph_unlock in check_prev_add
Content-Language: en-US
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, peterz@infradead.org,
 mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com,
 zhiguo.niu@unisoc.com, ke.wang@unisoc.com, linux-kernel@vger.kernel.org
References: <20240105060456.15331-1-xuewen.yan@unisoc.com>
 <a8023072-0900-4be9-bb34-02850276404b@redhat.com>
 <CAB8ipk_hcbYbZhoV0ZCDH0smQPTz98CQH7wP=PjJS6kcxavpVg@mail.gmail.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CAB8ipk_hcbYbZhoV0ZCDH0smQPTz98CQH7wP=PjJS6kcxavpVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 1/9/24 00:11, Xuewen Yan wrote:
> Hi Waiman
>
>
> On Tue, Jan 9, 2024 at 11:51 AM Waiman Long <longman@redhat.com> wrote:
>> On 1/5/24 01:04, Xuewen Yan wrote:
>>> The check_prev_add() is held graph_lock, and it should unlock
>>> the graph_lock before return 0.
>>> But there is one condition where it will return 0 without unlock,
>>> that is:
>>>
>>> /* <prev> is not found in <next>::locks_before */
>>>        return 0;
>>>
>>> So add graph_unlock before return 0.
>>>
>>> Fixes: 3454a36d6a39 ("lockdep: Introduce lock_list::dep")
>>> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>>> ---
>>> Change in V2:
>>> -move the graph_unlock to check_prev_add from validate_chain(Boqun)
>>> -Add fix tag
>>> ---
>>> ---
>>>    kernel/locking/lockdep.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
>>> index 151bd3de5936..c8602a251bec 100644
>>> --- a/kernel/locking/lockdep.c
>>> +++ b/kernel/locking/lockdep.c
>>> @@ -3178,6 +3178,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
>>>                        }
>>>
>>>                        /* <prev> is not found in <next>::locks_before */
>>> +                     graph_unlock();
>>>                        return 0;
>>>                }
>>>        }
>> There are multiple places in check_prev_add() that will return 0. It
>> will be odd to have just one of them has a graph_unlock(). It makes the
>> code hard to understand. You should insert graph_unlock() in a place
>> that matches the other places where graph_unlock() will be called. My
>> suggestion is as follows:
>>
>> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
>> index 151bd3de5936..d9f2df36332c 100644
>> --- a/kernel/locking/lockdep.c
>> +++ b/kernel/locking/lockdep.c
>> @@ -3252,7 +3252,7 @@ check_prevs_add(struct task_struct *curr, struct
>> held_loc>
>>                   if (hlock->check) {
>>                           int ret = check_prev_add(curr, hlock, next,
>> distance, &>
>>                           if (!ret)
>> -                               return 0;
>> +                               goto out_bug;
>>
>>                           /*
>>                            * Stop after the first non-trylock entry,
>>
> As you say, there are multiple places in check_prev_add() that will
> return 0, and some cases had unlocked the lock, if all goto the
> out_bug, would it cause double unlock?
> Maybe as follows?
> ---
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 151bd3de5936..8b665ba90ad0 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -3178,7 +3178,7 @@ check_prev_add(struct task_struct *curr, struct
> held_lock *prev,
>                          }
>
>                          /* <prev> is not found in <next>::locks_before */
> -                       return 0;
> +                       goto list_err;
>                  }
>          }
>
> @@ -3215,6 +3215,11 @@ check_prev_add(struct task_struct *curr, struct
> held_lock *prev,
>                  return 0;
>
>          return 2;
> +
> +list_err:
> +       /* still get graph_lock, unlock it before return*/
> +       graph_unlock();
> +       return 0;
>   }

I see. the graph_unlock() is called before any error message is printed. 
I understand the reason why this is done this way, but it does make it 
easy to re-introduce this kind of error when the lockdep code is 
changed. We need a better system to track the state of the graph_lock 
and do an unlock if necessary.

Cheers,
Longman



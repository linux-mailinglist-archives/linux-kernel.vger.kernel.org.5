Return-Path: <linux-kernel+bounces-43897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C267D841A8B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6D6287363
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C673374F6;
	Tue, 30 Jan 2024 03:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gix5fG0S"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822C1374CC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706585473; cv=none; b=EZJzhQWFDzufFBrMxMoIrm733E3Na34OpcABwK/PgXyrw6OglPMG9L2ulC3qcXErMakdc1j9+6ku4kY8LjjrQndSdPxGaLHbIkLNWTIMurC070IZh4Vf1ALCvS6Efu0O02LhZQscm6iyDLeVPi1PKPwGDqxR/Lis3SO08JiyzAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706585473; c=relaxed/simple;
	bh=CjXew1XjwllxZhcvtK/I/l+8onMDBJRNwzQUXEZOby0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LU5/4xT9bRBSWzVM1GTwyUxccqvFSFmr7dxEy7YjQRyW/Dea258VRl1mC3yPo9EOq86Qb16+EpDvU6Vdnbq4b/vvc1NWo29j9dkNTLz/Mpu3Hr0obmZ5jDLlUOj/fs6ihezsh4s1OUkjv0vBnbMJnw0tl7XsNPJn3NaiF1jN/ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gix5fG0S; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6de28744a46so688989b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706585470; x=1707190270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RD6hTXlMSyJ3iWEtJweqxifSu9jRBJgphTtX1Fvzr68=;
        b=gix5fG0SFCUe2r9pwr6AMg+l3EiYbn0x0s4P75tEE/8kCet42XfbiESFc8g+X+QR3k
         N1lspOqXG7ks+cOUfk88S+C1Sqe+9N7QTQ7fIgjVDMMqAdhjSVzdZIbETgNtXyGOy9lx
         3efWR1x+CmiEPi0J+CsV+qXS8vapqz1KI+1cdQRpso9Th3XDUkf07mBUU+ZIzOW3GaB1
         DppHr1XYq6zrjWlaodlNBBPW8FcdhMFmaWf7N6BmqwBFQ9T7vsg+9nJnojg70LKVR5ob
         xhGPORPZSKNDwbrrSFLUqgEWF9Bkvo5JcQc6HJmSMiOTJhBtvH0IBJtRoglUSrFR0/jV
         t9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706585470; x=1707190270;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RD6hTXlMSyJ3iWEtJweqxifSu9jRBJgphTtX1Fvzr68=;
        b=rxmNxQZ5GoD+703CoD8jTCfpvLqI3s/uT0fpKmBkTxAkaEF5aq4hQcjR3WAYDp4JAw
         WRC90R/cM8A2VmuGaKuNUS4LQ9kh4BrmlVtt1/Mb7vginCQ6lsflACHiff7AFPcv7JxG
         ex4BP1ed/z+WmGRUIHvOUvlzUpSdeyu3WEa2IwE9rDmHJsoz21W8uTUdjRgtaNpP/3C7
         REv46IBnTnEZnL0DxMDi6kt/ewFRRB1UxeERlpNmYhZn4PvJVGeTf9XSq6HndnFn+LU8
         +LTaRXXHYp3O9wYT4SJo5FYOjgDHSKJMX028wr34B6PvoZ1wuKaWqaJwZFhUGLJ+8mrm
         OnkA==
X-Gm-Message-State: AOJu0YzQt0/6YbFL5JuXlOp1pvrrJ6uUD78ESilxUg32xaZxpeWeuZc2
	DpqWYZxJqkJmh8JhHBKUChKIReiFBehY7sa5AFVUTy5XasHUWvFWvlix4PdOYOA=
X-Google-Smtp-Source: AGHT+IHJmPuERhTK5o2Nq2jM7SYhLb3zkXP+HLMEJlqpfVkhvjIwq1UPqfASkuCuKKfgnYlGPV/2sA==
X-Received: by 2002:a05:6a20:3ba6:b0:19c:61d5:beab with SMTP id b38-20020a056a203ba600b0019c61d5beabmr3654918pzh.39.1706585470314;
        Mon, 29 Jan 2024 19:31:10 -0800 (PST)
Received: from [10.4.207.234] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id iz19-20020a170902ef9300b001d8cf16d890sm3334197plb.16.2024.01.29.19.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 19:31:10 -0800 (PST)
Message-ID: <30e949b5-9455-4053-93ef-1ca0ceb10c3f@bytedance.com>
Date: Tue, 30 Jan 2024 11:31:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mm/zswap: fix race between lru writeback and
 swapoff
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chriscli@google.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240126-zswap-writeback-race-v2-0-b10479847099@bytedance.com>
 <20240126-zswap-writeback-race-v2-2-b10479847099@bytedance.com>
 <ZbhBNkayw1hNlkpL@google.com>
 <527bd543-97a5-4262-be73-6a5d21c2f896@bytedance.com>
 <20240130031727.GA780575@cmpxchg.org>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240130031727.GA780575@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/1/30 11:17, Johannes Weiner wrote:
> On Tue, Jan 30, 2024 at 10:30:20AM +0800, Chengming Zhou wrote:
>> On 2024/1/30 08:22, Yosry Ahmed wrote:
>>> On Sun, Jan 28, 2024 at 01:28:50PM +0000, Chengming Zhou wrote:
>>>> @@ -860,40 +839,47 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
>>>>  {
>>>>  	struct zswap_entry *entry = container_of(item, struct zswap_entry, lru);
>>>>  	bool *encountered_page_in_swapcache = (bool *)arg;
>>>> -	struct zswap_tree *tree;
>>>> -	pgoff_t swpoffset;
>>>> +	swp_entry_t swpentry;
>>>>  	enum lru_status ret = LRU_REMOVED_RETRY;
>>>>  	int writeback_result;
>>>>  
>>>> +	/*
>>>> +	 * Rotate the entry to the tail before unlocking the LRU,
>>>> +	 * so that in case of an invalidation race concurrent
>>>> +	 * reclaimers don't waste their time on it.
>>>> +	 *
>>>> +	 * If writeback succeeds, or failure is due to the entry
>>>> +	 * being invalidated by the swap subsystem, the invalidation
>>>> +	 * will unlink and free it.
>>>> +	 *
>>>> +	 * Temporary failures, where the same entry should be tried
>>>> +	 * again immediately, almost never happen for this shrinker.
>>>> +	 * We don't do any trylocking; -ENOMEM comes closest,
>>>> +	 * but that's extremely rare and doesn't happen spuriously
>>>> +	 * either. Don't bother distinguishing this case.
>>>> +	 *
>>>> +	 * But since they do exist in theory, the entry cannot just
>>>> +	 * be unlinked, or we could leak it. Hence, rotate.
>>>
>>> The entry cannot be unlinked because we cannot get a ref on it without
>>> holding the tree lock, and we cannot deref the tree before we acquire a
>>> swap cache ref in zswap_writeback_entry() -- or if
>>> zswap_writeback_entry() fails. This should be called out explicitly
>>> somewhere. Perhaps we can describe this whole deref dance with added
>>> docs to shrink_memcg_cb().
>>
>> Maybe we should add some comments before or after zswap_writeback_entry()?
>> Or do you have some suggestions? I'm not good at this. :)
> 
> I agree with the suggestion of a central point to document this.
> 
> How about something like this:
> 
> /*
>  * As soon as we drop the LRU lock, the entry can be freed by
>  * a concurrent invalidation. This means the following:
>  *
>  * 1. We extract the swp_entry_t to the stack, allowing
>  *    zswap_writeback_entry() to pin the swap entry and
>  *    then validate the zwap entry against that swap entry's
>  *    tree using pointer value comparison. Only when that
>  *    is successful can the entry be dereferenced.
>  *
>  * 2. Usually, objects are taken off the LRU for reclaim. In
>  *    this case this isn't possible, because if reclaim fails
>  *    for whatever reason, we have no means of knowing if the
>  *    entry is alive to put it back on the LRU.
>  *
>  *    So rotate it before dropping the lock. If the entry is
>  *    written back or invalidated, the free path will unlink
>  *    it. For failures, rotation is the right thing as well.
>  *
>  *    Temporary failures, where the same entry should be tried
>  *    again immediately, almost never happen for this shrinker.
>  *    We don't do any trylocking; -ENOMEM comes closest,
>  *    but that's extremely rare and doesn't happen spuriously
>  *    either. Don't bother distinguishing this case.
>  */
> 

Thanks! I think this document is great enough.

>>> We could also use a comment in zswap_writeback_entry() (or above it) to
>>> state that we only deref the tree *after* we get the swapcache ref.
>>
>> I just notice there are some comments in zswap_writeback_entry(), should
>> we add more comments here?
>>
>> 	/*
>> 	 * folio is locked, and the swapcache is now secured against
>> 	 * concurrent swapping to and from the slot. Verify that the
>> 	 * swap entry hasn't been invalidated and recycled behind our
>> 	 * backs (our zswap_entry reference doesn't prevent that), to
>> 	 * avoid overwriting a new swap folio with old compressed data.
>> 	 */
> 
> The bit in () is now stale, since we're not even holding a ref ;)

Right.

> 
> Otherwise, a brief note that entry can not be dereferenced until
> validation would be helpful in zswap_writeback_entry(). The core of

Ok.

> the scheme I'd probably describe in shrink_memcg_cb(), though.
> 
> Can I ask a favor, though?
> 
> For non-critical updates to this patch, can you please make them
> follow-up changes? I just sent out 20 cleanup patches on top of this
> patch which would be super painful and error prone to rebase. I'd like
> to avoid that if at all possible.

Ok, so these comments changes should be changed on top of your cleanup series
and sent as a follow-up patch.

Thanks.



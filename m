Return-Path: <linux-kernel+bounces-64937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0B98544E1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA522837F4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD9F11CA9;
	Wed, 14 Feb 2024 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qqAG8HYO"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544AA1173D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902316; cv=none; b=FlDDw3FJBuIK064YV88i2aEiexai7yLsqjnO4vY+0r8htyqv6EGoXfmOtIrwdCZ3mHQK11b6MGoNr6lKyZPd3GNyAJxGW/sI3li5PGtK5dNQrg/zoQWoW+GnPynrwDOZ0NsXeaFOp/NpyvYhz0Alsvp7LqU1V+ZcTnm6MuQyY8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902316; c=relaxed/simple;
	bh=cKXHw0q9O9WWl5ATS803qkoiSpycJA1nSgUVJR4E9mE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rivOwPuqRHl3LZcZhqhEsHnT/Fk2i4J4p8gKHJK+vibPDqxy2JoMJW0msQ515te51tDvK4a8sqiH9C4jFOxi8GWIqwR0PkMVdy8p46/lsxVjwHMR4Ad4p/PHVOnsvuGApCdeWByS4izuZZPDQ1I0IbqqzOyyJlSZrrXvlI7UILY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qqAG8HYO; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8123c4be-d696-4e9e-884f-aa12f6099ddb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707902309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZXNf1eaZwAP1QgbwSl8cYxTPoxlUmBtCQWVKIvjUxc=;
	b=qqAG8HYOUOy4RLm4Prej9qUYtE3O0ivc3/5+pwaaRgfdRe97TVW1ePltlSF9cWJp89oWeo
	qQ8qdc734NOXoVX3jdETm8NM+tlh6iuhDZ7oCbSVprwZGUGgTgeA5pvEuZtaMl2WBGW/DZ
	rGCLWATf3VkoXu46CBLk1BOgzOUYPwA=
Date: Wed, 14 Feb 2024 17:18:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 1/1] mm/swap: queue reclaimable folio to local rotate
 batch when !folio_test_lru()
Content-Language: en-US
To: Yu Zhao <yuzhao@google.com>
Cc: willy@infradead.org, hannes@cmpxchg.org, yosryahmed@google.com,
 nphamcs@gmail.com, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>
References: <20240209115950.3885183-1-chengming.zhou@linux.dev>
 <20240209115950.3885183-2-chengming.zhou@linux.dev>
 <CAOUHufbg6zbqQaw1CPRWKpOv3NR=mi1xb31hG3WFMoZhj406Tw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAOUHufbg6zbqQaw1CPRWKpOv3NR=mi1xb31hG3WFMoZhj406Tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/14 15:13, Yu Zhao wrote:
> On Fri, Feb 9, 2024 at 6:00 AM <chengming.zhou@linux.dev> wrote:
>>
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> All LRU move interfaces have a problem that it has no effect if the
>> folio is isolated from LRU (in cpu batch or isolated by shrinker).
>> Since it can't move/change folio LRU status when it's isolated, mostly
>> just clear the folio flag and do nothing in this case.
>>
>> In our case, a written back and reclaimable folio won't be rotated to
>> the tail of inactive list, since it's still in cpu lru_add batch. It
>> may cause the delayed reclaim of this folio and evict other folios.
>>
>> This patch changes to queue the reclaimable folio to cpu rotate batch
>> even when !folio_test_lru(), hoping it will likely be handled after
>> the lru_add batch which will put folio on the LRU list first, so
>> will be rotated to the tail successfully when handle rotate batch.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> I don't think the analysis is correct. IIRC, writeback from non
> reclaim paths doesn't require isolation and the reclaim path doesn't
> use struct folio_batch lru_add.

Ah, my bad, I forgot to mention the important context in the message:

This is not from the normal reclaim context, it's from zswap writeback
reclaim context, which will first set PG_reclaim flag, then submit the
async writeback io.

If the writeback io complete fast enough, folio_rotate_reclaimable()
will be called before that folio put on LRU list (it still in the local
lru_add batch, so it's somewhat like isolated too)

> 
> Did you see any performance improvements with this patch? In general,
> this kind of patches should have performance numbers to show it really
> helps (not just in theory).

Right, there are some improvements, the numbers are put in cover letter.
But this solution is not good enough, just RFC for discussion. :)

                           mm-unstable-hot   zswap-lru-reclaim
real                       63.34             62.72            
user                       1063.20           1060.30          
sys                        272.04            256.14           
workingset_refault_anon    2103297.00        1788155.80       
workingset_refault_file    28638.20          39249.40         
workingset_activate_anon   746134.00         695435.40        
workingset_activate_file   4344.60           4255.80          
workingset_restore_anon    653163.80         605315.60        
workingset_restore_file    1079.00           883.00           
workingset_nodereclaim     0.00              0.00             
pgscan                     12971305.60       12730331.20      
pgscan_kswapd              0.00              0.00             
pgscan_direct              12971305.60       12730331.20      
pgscan_khugepaged          0.00              0.00           

> 
> My guess is that you are hitting this problem [1].
> 
> [1] https://lore.kernel.org/linux-mm/20221116013808.3995280-1-yuzhao@google.com/

Right, I just see it, it's the same problem. The only difference is that
in your case the folio is isolated by shrinker, in my case, the folio is
in cpu lru_add batch. Anyway, the result is the same, that folio can't be
rotated successfully when writeback complete.

Thanks.


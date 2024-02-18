Return-Path: <linux-kernel+bounces-70159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3F1859428
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 03:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5B728302C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 02:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBB515C9;
	Sun, 18 Feb 2024 02:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rIOGwIXJ"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD7737E
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 02:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708224436; cv=none; b=l4i4c8UdfAhoQ+OMSyXtxjfpPEZBGlzsx1ii93EuyG6yKWZ+5BjhLY0iK9tTX/OPPVFeOna1DQuweFSQLDrxqcHHAMXnyGnviTwWPrkLYiC4EejJQArik7LC78ywj7UUguzdW82EKAP80jVuNlRPoRmCo6PAU1uLPYJHaUBuJnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708224436; c=relaxed/simple;
	bh=OrbAfymDz1H8lagFBGbTRz0gfBSJVxXWsJAPxxEpnLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O8ulTOED/BCAi3xsxh6bia9n7PrW1ThITRr9zwvlqo2GZnLB0EdayoqYdAgSvkzwipsTKYWe1MO0wL/GD1g1ODmv3apsMoLr8qqBrh3qvzyvf6gn1zPNyHcUsf8IR9IpmXU5uPDuf7BQUV5+HA4MFlGSf1Kh4ERWrZEQEq9ynbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rIOGwIXJ; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <56710a26-2cf4-4116-8181-4fa1ce084008@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708224432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7QXfOY0s0er1gZrkY/W4CgNq8aUNS6EDhavdkRc5tvU=;
	b=rIOGwIXJkN5pwF6MUP/wnDMMPhiNI0iZnA3rc0H+eIB4Qq5cMQHFT8aRnSpP5ytl7zGirH
	J/YEJFhpIbPJpP3RiBtRGGm/yibX4D/xK/0HexCC7/seA4TelbXmAbTL/T0QDqkXl1/tU7
	maLQQizeE1xX+aJT/BNrDiFM6PCbd3g=
Date: Sun, 18 Feb 2024 10:46:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 1/1] mm/swap: queue reclaimable folio to local rotate
 batch when !folio_test_lru()
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>
Cc: willy@infradead.org, hannes@cmpxchg.org, nphamcs@gmail.com,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Chengming Zhou <zhouchengming@bytedance.com>
References: <20240209115950.3885183-1-chengming.zhou@linux.dev>
 <20240209115950.3885183-2-chengming.zhou@linux.dev>
 <CAJD7tkZcL6=dYCHv4XvQhRXgszcevGmsZfeg12jXpzLyy4YH1g@mail.gmail.com>
 <3f7490bb-a36e-46aa-b070-7e6e92853073@linux.dev>
 <Zc0Ndi58Y8r4_Voj@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <Zc0Ndi58Y8r4_Voj@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/15 02:59, Yosry Ahmed wrote:
> On Wed, Feb 14, 2024 at 05:54:56PM +0800, Chengming Zhou wrote:
>> On 2024/2/13 16:49, Yosry Ahmed wrote:
>>> On Fri, Feb 9, 2024 at 4:00 AM <chengming.zhou@linux.dev> wrote:
>>>>
>>>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>>>
>>>> All LRU move interfaces have a problem that it has no effect if the
>>>> folio is isolated from LRU (in cpu batch or isolated by shrinker).
>>>> Since it can't move/change folio LRU status when it's isolated, mostly
>>>> just clear the folio flag and do nothing in this case.
>>>>
>>>> In our case, a written back and reclaimable folio won't be rotated to
>>>> the tail of inactive list, since it's still in cpu lru_add batch. It
>>>> may cause the delayed reclaim of this folio and evict other folios.
>>>>
>>>> This patch changes to queue the reclaimable folio to cpu rotate batch
>>>> even when !folio_test_lru(), hoping it will likely be handled after
>>>> the lru_add batch which will put folio on the LRU list first, so
>>>> will be rotated to the tail successfully when handle rotate batch.
>>>
>>> It seems to me that it is totally up to chance whether the lru_add
>>> batch is handled first, especially that there may be problems if it
>>> isn't.
>>
>> You're right, I just don't know better solution :)
>>
>>>
>>>>
>>>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>>>> ---
>>>>  mm/swap.c | 5 +++--
>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/mm/swap.c b/mm/swap.c
>>>> index cd8f0150ba3a..d304731e47cf 100644
>>>> --- a/mm/swap.c
>>>> +++ b/mm/swap.c
>>>> @@ -236,7 +236,8 @@ static void folio_batch_add_and_move(struct folio_batch *fbatch,
>>>>
>>>>  static void lru_move_tail_fn(struct lruvec *lruvec, struct folio *folio)
>>>>  {
>>>> -       if (!folio_test_unevictable(folio)) {
>>>> +       if (!folio_test_locked(folio) && !folio_test_dirty(folio) &&
>>>> +           !folio_test_unevictable(folio) && !folio_test_active(folio)) {
>>>
>>> What are these conditions based on? I assume we want to check if the
>>> folio is locked because we no longer check that it is on the LRUs, so
>>> we want to check that no one else is operating on it, but I am not
>>> sure that's enough.
>>
>> These conditions are used for checking whether the folio should be reclaimed/rotated
>> at this point. Like we shouldn't reclaim it if it has been dirtied or actived.
> 
> This should be explained somewhere, a comment or in the commit message.
>  
>> lru_move_tail_fn() will only be called after we isolate this folio successfully
>> in folio_batch_move_lru(), so if other path has isolated this folio (cpu batch
>> or reclaim shrinker), this function will not be called.
> 
> Interesting, why are we checking if the folio is locked here then?

I think it means the folio is using by others, and reclaim needs to lock the folio.
Not very sure.

> 
>>
>>>
>>>>                 lruvec_del_folio(lruvec, folio);
>>>>                 folio_clear_active(folio);
>>>>                 lruvec_add_folio_tail(lruvec, folio);
>>>> @@ -254,7 +255,7 @@ static void lru_move_tail_fn(struct lruvec *lruvec, struct folio *folio)
>>>>  void folio_rotate_reclaimable(struct folio *folio)
>>>>  {
>>>>         if (!folio_test_locked(folio) && !folio_test_dirty(folio) &&
>>>> -           !folio_test_unevictable(folio) && folio_test_lru(folio)) {
>>>> +           !folio_test_unevictable(folio) && !folio_test_active(folio)) {
>>>
>>> I am not sure it is safe to continue with a folio that is not on the
>>> LRUs. It could be isolated for other purposes, and we end up adding it
>>> to an LRU nonetheless. Also, folio_batch_move_lru() will do
>>
>> This shouldn't happen since lru_move_tail_fn() will only be called if
>> folio_test_clear_lru() successfully in folio_batch_move_lru().
> 
> I see, so this is where we hope lru_add batch gets handled first. I need
> to think about this some more, let's also see what others like Yu say.

Right.



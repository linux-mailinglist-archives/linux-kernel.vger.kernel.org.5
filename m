Return-Path: <linux-kernel+bounces-84410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B10DB86A670
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C227AB2240D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B631DFDE;
	Wed, 28 Feb 2024 02:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="THc50Ii4"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D401DDD5
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 02:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709086640; cv=none; b=Ndah7WNch/S3boCyWh10U7RdMJxD7VJhY8O9MLMMSFJnIfDnBttoNi4uyYH41MePqgnV9nzKwxmBImMTy6r9HFaUvZXO19xyHEN5IfdQe/rtLqZ1yv99FYcY++CvxQt7aOaA1zgOKZnxpEF5RH5OcwyM90eMNcfdSTuRLRDTnVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709086640; c=relaxed/simple;
	bh=uNhrJRNRsgPai4bqJiTa1qH96jrhz8tds9TebSfLmdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OuGkRXS1O4lhh5K+6H4VT5paz4rTGgNkEU/UwKGZ3JqD1asNfhCi2ojQ6OjJ6RapgQruRg9fYQ6BeiLiGp3Sov97TldgCToBuzsqTWtq0nJuL9UKRAqmbh9e13IuGVDNPsx7+dmOReg7tf1rVALYMmazwzDcyTz2kyZlbEr8A4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=THc50Ii4; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d7611a8f-c266-4545-b0d9-a5e6ef3abf0e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709086636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ic7ZEF6fNvJnl0rUWJu3yuWTnO+lxbv0p/6gX1wuoYU=;
	b=THc50Ii4eNRMF6sen2/5KpQKcrkkcQYGdj+Hu9Bce5nQaqb6q1FAFMpnifomS3ameWp9Y1
	8F1nT93q66cmUZAeS6ApkNQdQwWXMgNBxIz3E7O3l6ELgMVxjU78QZWh/WtVeJ444izKcp
	KEnhQ81K2MVCipdddH6dpCZa9y2yRvM=
Date: Wed, 28 Feb 2024 10:17:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/zsmalloc: don't need to save tag bit in handle
Content-Language: en-US
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: minchan@kernel.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
 nphamcs@gmail.com, yosryahmed@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>
References: <20240227030045.3443702-1-chengming.zhou@linux.dev>
 <20240227075209.GA11972@google.com>
 <b54646e3-44bd-4937-a2dd-4b88ca7ab672@linux.dev>
 <20240228015437.GB11972@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240228015437.GB11972@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/28 09:54, Sergey Senozhatsky wrote:
> On (24/02/27 16:16), Chengming Zhou wrote:
>> On 2024/2/27 15:52, Sergey Senozhatsky wrote:
>>> On (24/02/27 03:00), chengming.zhou@linux.dev wrote:
>>>>
>>>> We only need to save the position (pfn + obj_idx) in the handle, don't
>>>> need to save tag bit in handle. So one more bit can be used as obj_idx.
>>>
>>> [..]
>>>
>>>> mm/zsmalloc: don't need to save tag bit in handle
>>>
>>> Does this mean "don't need to reserve LSB for tag"?
>> The head of object still need to reverve LSB, to save (handle | OBJ_ALLOCATED_TAG),
>> only the handle doesn't need to reserve LSB, which save (pfn | obj_idx).
> 
> Correct.
> 
>>> We still save allocated tag in the handle, that's what
>>>
>>> 	handle |= OBJ_ALLOCATED_TAG;
>>
>> Yes, this result will be saved in the head of each allocated object.
> 
> Right, that's what I was talking about.
> 
>>>> Actually, the tag bit is only useful in zspage's memory space, to tell
>>>> if an object is allocated or not.
>>>
>>> I'm not completely sure if I follow this sentence.
>>
>> What I mean is that only the head of each allocated object need to reverve LSB,
>> which is used to check if allocated or not.
>>
>> handle address -> handle (pfn + obj_idx) -> object: (handle | tag), real_object start
>>
>> I'm not sure if this makes it clearer?
> 
> Yes, thanks. I think separating handle and object header in the commit
> message will be helpful.

Right, I will improve the commit message and send v2.

Thanks!


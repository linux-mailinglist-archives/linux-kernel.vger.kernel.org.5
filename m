Return-Path: <linux-kernel+bounces-41215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE7A83ED81
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF15F284174
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAE928DD1;
	Sat, 27 Jan 2024 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xY+sW1vP"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C82428DA7
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706366066; cv=none; b=uuvHa/DIhH5nE3eK2fmIFjIvaF1Zce2VbAmPp/0cZGs7y+oQIfYKu8EqIFWgAcxaz9IBSgWSKZFCMJpyf9vlxcbxuKRmp5OvPjB5fcNyyTUUM36P+eoACj2JYC+0+KDO7hpQITa4dI2NaFPnpLhRSpPm5TXiopOen+JkdSfNPqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706366066; c=relaxed/simple;
	bh=a/yHEe/OKt09wRGJmHtE8WgIN+jHmTFBcgA8R/Ha908=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsF1fNhsFXgzl5f15sNoXQpSbumtA2VRzLNziZv5+gJjyEr0y4RoiMWxwU7OujKUbygR9cdlpDET5ECYamjAb092B97gwUE2RmdZJvwRQyVFy0sqvLqAl3OJtBTloFXM0sMhIM5a+1yB39iFHb4r7229M8pcTSfKKSRzJeg9r4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xY+sW1vP; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <76b9e52a-9b51-4e4d-93ca-24a5aa3c4dca@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706366061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ldE+n6NcSlOlUyv98rKcvvVoi59JjH0e26apZ4K5NdE=;
	b=xY+sW1vPLcqLgZzsSoXg8dr0ISiJPof/FCC8QysRWw3p2SZ2FqEMBVnNdRQZ9uhPfrYkLN
	bTI5kZuDGgbj7am2ufVQM1q/+E8Tuw8VtHKFgSOnm9NV8tuIM1+r9gAGtMPju0098LkrQa
	ARO9fbq9kW1T3PTP33iWofiLIhPC5bU=
Date: Sat, 27 Jan 2024 22:33:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] mm/zswap: don't return LRU_SKIP if we have dropped
 lru lock
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: yosryahmed@google.com, nphamcs@gmail.com, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Chengming Zhou <zhouchengming@bytedance.com>
References: <20240126083015.3557006-1-chengming.zhou@linux.dev>
 <20240126142800.GF1567330@cmpxchg.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240126142800.GF1567330@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/1/26 22:28, Johannes Weiner wrote:
> On Fri, Jan 26, 2024 at 08:30:14AM +0000, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> LRU_SKIP can only be returned if we don't ever dropped lru lock, or
>> we need to return LRU_RETRY to restart from the head of lru list.
> 
> Good catch. Can you mention the possible consequences in the log?
> 
> "Otherwise, the iteration might continue from a cursor position that
> was freed while the locks were dropped."?

Good, will do.

> 
>> Actually we may need to introduce another LRU_STOP to really terminate
>> the ongoing shrinking scan process, when we encounter a warm page
>> already in the swap cache. The current list_lru implementation
>> doesn't have this function to early break from __list_lru_walk_one.
>>
>> Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks.


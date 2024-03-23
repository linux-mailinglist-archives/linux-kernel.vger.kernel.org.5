Return-Path: <linux-kernel+bounces-112191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A2D8876BA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 03:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2856B283C81
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 02:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7005315A4;
	Sat, 23 Mar 2024 02:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SHczEdYL"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E22B372
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 02:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711162221; cv=none; b=TY4080p1uf/fbgV8nJ16yeSSo7uwh9IlEhUXyRQlell5DrXdUy7RPrfxqtcVCdBipgZRFOzHFZ5CCpJXyd8J+BfY58IkAU27x9ZnHE0vRf4r+50VJ6sOYugRPVte0rbT1jskBeziRqPJ8mOI39Qn7NocVwY+NaszcqLRTJmGw+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711162221; c=relaxed/simple;
	bh=CjqDCAtM8QdnSKe+aR6L9osj5SM3qFKSVUuHvvLOz1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tvctBQDhPRokDtXXdzr+IyAK1ZYm9C/Ci/VNUxtBs+npGM6Bj6OYnzv8FHAumjDDB7Z4iXXe+nASVqptc96xWpwYmdKkiGwdWnUaCyl5Ru5ma5wtIywhhRLviXEf2lSFCSwot9NmSnTLcQYh3QbnJA9AWwLTQYZYmyTuW9G0dWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SHczEdYL; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <91c0a5aa-86b0-4dd3-884f-39a47c1ed6b8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711162216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jo1kf1K5kDD2UFW1uYSmrg6RxPS+DXRGfZXC9+hP/j4=;
	b=SHczEdYLYtVOHZSUtcy3mvfO7UD2g8kqTObI6e6o3mJOuRo5jP9fmQYj1fcUIl/8eFW/cf
	vGlg8CqVNN69TSQySUWuBGFbNB7XwiWXBU8BL5+Q/AhaFlERQK5RoLJCUQFRVX+yb2FWsf
	ETWOZbxsCeRle5PYTI/hmf4KLx4jsQI=
Date: Sat, 23 Mar 2024 10:49:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH] mm: add folio in swapcache if swapin from zswap
To: Yosry Ahmed <yosryahmed@google.com>
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Zhongkun He <hezhongkun.hzk@bytedance.com>
References: <20240322163939.17846-1-chengming.zhou@linux.dev>
 <CAJD7tkYuYEsKFvjKKRxOx3fCekA03jPpOpmV7T20q=9K=Jb2bA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAJD7tkYuYEsKFvjKKRxOx3fCekA03jPpOpmV7T20q=9K=Jb2bA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/3/23 03:37, Yosry Ahmed wrote:
> On Fri, Mar 22, 2024 at 9:40 AM <chengming.zhou@linux.dev> wrote:
>>
>> From: Chengming Zhou <chengming.zhou@linux.dev>
>>
>> There is a report of data corruption caused by double swapin, which is
>> only possible in the skip swapcache path on SWP_SYNCHRONOUS_IO backends.
>>
>> The root cause is that zswap is not like other "normal" swap backends,
>> it won't keep the copy of data after the first time of swapin. So if
>> the folio in the first time of swapin can't be installed in the pagetable
>> successfully and we just free it directly. Then in the second time of
>> swapin, we can't find anything in zswap and read wrong data from swapfile,
>> so this data corruption problem happened.
>>
>> We can fix it by always adding the folio into swapcache if we know the
>> pinned swap entry can be found in zswap, so it won't get freed even though
>> it can't be installed successfully in the first time of swapin.
> 
> A concurrent faulting thread could have already checked the swapcache
> before we add the folio to it, right? In this case, that thread will
> go ahead and call swap_read_folio() anyway.

Right, but it has to lock the folio to proceed.

> 
> Also, I suspect the zswap lookup might hurt performance. Would it be
> better to add the folio back to zswap upon failure? This should be
> detectable by checking if the folio is dirty as I mentioned in the bug
> report thread.

Yes, may hurt performance. As for adding back upon failure, the problem
is that adding may fail too... and I don't know how to handle that.

Anyway, I think the fix of Johannes is much better, we should take that way.

Thanks.


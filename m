Return-Path: <linux-kernel+bounces-132974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29339899CB7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE331F23D84
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B044716C85B;
	Fri,  5 Apr 2024 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DmERWGHS"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F75D16D4D1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712319412; cv=none; b=eQSlVc3l8LxMdLZaLhtqG9Ot1E0Qxj1shI+9osE/n/a/YweIYjPLkqdai4BqKsYIetvnlAebu21eaeIFObxLNuDN0ZxvQdkzm8iB5yvgjKzWZhLLuls+EZCHfyhrFnM4XgWkRPW36jpaVeM1I3K8kTQHCEo4cKVGi7PL/AtAYb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712319412; c=relaxed/simple;
	bh=zSLP3ufHDXUhqUSGulLXWxavP4OznAxZNVLs2OwXYqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLg0JG9GzsoryMj5ZLH8fsxoWFvzupZU35g9OJXGQvRlWiJc9ANKOWSWxWXR30aabFxQCuCWPfvRkMg8zV/F0GZTmWPmI5sz2+JxGckFqc4iX/bdR+z4Cau80K6GaGPPZm9l7J1Rq3MkcXEcB5ReW6VJjFn4IJ6sTT34dbEBi54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DmERWGHS; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712319396; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kAKE1FWTl1PVjjzYCcGKY7AAJE4W0w3oCG32pxeXa8w=;
	b=DmERWGHSTGcAVq2YVQ4QdlhpHfh2lkO9J0zvncY9s/EZR6jj3zoU/7RzMQCGyXjiinZrtklRMqM5ZF7K457VPBtKkD3oI3DtWT1LF3nIjVQDbBdq/KsNhOVlicXb52SPV2w9QR0QUmd9i9UcrPNS9JMykzxY9nFOPTE1QcCv+j0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W3wqza-_1712319395;
Received: from 30.15.228.201(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W3wqza-_1712319395)
          by smtp.aliyun-inc.com;
          Fri, 05 Apr 2024 20:16:36 +0800
Message-ID: <721ca866-0c80-496b-a823-ccdbb1f488d4@linux.alibaba.com>
Date: Fri, 5 Apr 2024 20:16:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: page_alloc: use the correct THP order for THP PCP
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, mgorman@techsingularity.net, vbabka@suse.cz,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <a25c9e14cd03907d5978b60546a69e6aa3fc2a7d.1712151833.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4xvXT6Qy1JgP2khH0DKvTGhjsrexsSj8ddieM_XXn8bng@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAGsJ_4xvXT6Qy1JgP2khH0DKvTGhjsrexsSj8ddieM_XXn8bng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/4/5 12:53, Barry Song wrote:
> On Thu, Apr 4, 2024 at 2:47 AM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>> Commit 44042b449872 ("mm/page_alloc: allow high-order pages to be stored
>> on the per-cpu lists") extends the PCP allocator to store THP pages, and
>> it determines whether to cache THP pags in PCP by comparing with pageblock_order.
>> But the pageblock_order is not always equal to THP order, it might also
>> be MAX_PAGE_ORDER, which could prevent PCP from caching THP pages.
>>
>> Therefore, using HPAGE_PMD_ORDER instead to determine the need for caching
>> THP for PCP can fix this issue
>>
>> Fixes: 44042b449872 ("mm/page_alloc: allow high-order pages to be stored on the per-cpu lists")
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> LGTM,
> Reviewed-by: Barry Song <baohua@kernel.org>
> 
> In the context of using mTHP, perhaps there arises a need for PCP
> allocation for frequently
> requested mTHP orders. These orders typically exceed PAGE_ALLOC_COSTLY_ORDER
> but are smaller than HPAGE_PMD_ORDER.

Yes, I have also considered this, but haven't found some time to do more 
investigation and run some benchmarks.:) May be we can create a new 
thread to talk about this first.


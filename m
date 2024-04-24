Return-Path: <linux-kernel+bounces-156250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D69B8B0031
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3086C1F2212B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B947013D619;
	Wed, 24 Apr 2024 03:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ALyi8zv6"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD9114389F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 03:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930556; cv=none; b=up7+l26KRcSGCSskA7OVFITazMfKk3pkkTYcCI9RR9rJ1v7R5bUssEbW+R0w9Z2Ck0fw1q9sRQJya04mDvFdYGnweSjVG0TA/Z5GwQT6xXlimY8YpqRKDFkKQSnTofjs/aEtImEgHIF9S0yvrA2cq8U1Kn6ARqZ3SMMwdD4FCAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930556; c=relaxed/simple;
	bh=MC5b24qmRWGMif1/e9SVwA1RDF2UvmCagUxnkyjCM9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QGru8mDlt3GIhWeDUZoz0Wijg9avViV02yYjd8w6prxnfMTUCL8JFZoLQUowFqNPrFMYkzyvXr96Ca2NbsQLRs0L8ry8TJEMHRxbTXLXskGHdTJHp3ffYYUh160DXtv0zH7OH8d4/6hseXP/cRRZlswyBQWHrvVINPrBlCJ0Fls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ALyi8zv6; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713930551; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ZvxFBpP6Srhkt4fBNm1R3664oVz/K43/BSO9nAVF7Rw=;
	b=ALyi8zv6WGpL6MiZ04cRVHjzMGNBFWOOJe+BO6EgRHWPan0PkPGD3TaXgNAjA9eVI3ttrf7puZGu9WlX1ifRtdCIw9cY8gewlz0NdyskaMhh7g/hcmkzGB/nWV0rVFqzmyWFkdfDvVhj9JYy7V8X/bEZi5TjiVrltZr8GNyBaMI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W5AlpPx_1713930506;
Received: from 30.97.56.58(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W5AlpPx_1713930506)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 11:49:09 +0800
Message-ID: <ec9d8eb8-a390-40ad-94a1-e65863cb9e76@linux.alibaba.com>
Date: Wed, 24 Apr 2024 11:49:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/5] mm: shmem: add anonymous share mTHP counters
To: Lance Yang <ioworker0@gmail.com>
Cc: 21cnbao@gmail.com, akpm@linux-foundation.org, david@redhat.com,
 hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ryan.roberts@arm.com, shy828301@gmail.com, wangkefeng.wang@huawei.com,
 willy@infradead.org, ying.huang@intel.com, ziy@nvidia.com
References: <CAGsJ_4xu4iL5pv7T1chyzGC2Vp9q1GwOp3wxb=bYMW-T-pj4dA@mail.gmail.com>
 <20240423094502.4080-1-ioworker0@gmail.com>
 <CAK1f24nS9mJ4xU+Z7uzNZxAAgAoqx4-z_v888eRqs98cFb3cpg@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAK1f24nS9mJ4xU+Z7uzNZxAAgAoqx4-z_v888eRqs98cFb3cpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/4/23 19:22, Lance Yang wrote:
> On Tue, Apr 23, 2024 at 5:46 PM Lance Yang <ioworker0@gmail.com> wrote:
>>
>> On 2024/4/23 09:17, Barry Song wrote:
>> [...]
>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>> index 26b6fa98d8ac..67b9c1acad31 100644
>>>> --- a/include/linux/huge_mm.h
>>>> +++ b/include/linux/huge_mm.h
>>>> @@ -270,6 +270,8 @@ enum mthp_stat_item {
>>>>           MTHP_STAT_ANON_SWPOUT,
>>>>           MTHP_STAT_ANON_SWPOUT_FALLBACK,
>>>>           MTHP_STAT_ANON_SWPIN_REFAULT,
>>>> +       MTHP_STAT_SHMEM_ANON_ALLOC,
>>>> +       MTHP_STAT_SHMEM_ANON_ALLOC_FALLBACK,
> 
> Seems like you forgot to add the FILE_FALLBACK_CHARGE counter
> in this patch :)
> 
> IIUC, you've excluded the THP_FILE_FALLBACK_CHARGE counter
> for PTE-mapped mTHP that size < PMD in patch3.

Yes, will add in next version.


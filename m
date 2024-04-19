Return-Path: <linux-kernel+bounces-150936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D033B8AA6E1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 04:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 803AA1F217FF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5E84A3E;
	Fri, 19 Apr 2024 02:19:03 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9093A15BB
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 02:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713493142; cv=none; b=ff0DHZHgNeaI84ulDyRsFDVf/2TH8QtNUBgRZf+fgfh0ZDoQD87e79abDE69TzXHaYlDpIprUVjAmtq0rRaQ59F8eowMYm+KlegB2R0OItNLRBHgszTWdoqRFjVty4BjUa9THdIphcPA8PiqMZ3SY+X31Mv4vZ1y/giZjCFk2pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713493142; c=relaxed/simple;
	bh=Kw4J7cCMZF0zsSyFSO8IizbZzmfPw9W9XDnU3vd2Sp4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DzQLNo5lUab84JllK2op+E1CIXcnvfiVWoZYk/ipU+Je9Ebhh2K5NCivHeh4eyub5UJBdesIEI6aqhC+3JGfgW7AB3ulygwZpMw9TIZU3DQeArNX/HRE3Q13yfPSc2Yi6dtT4vPcv4ZDgEgeVPb9d/nIsabhr2F414uZQ2JqItQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VLHrg1XRVz1wrQT;
	Fri, 19 Apr 2024 09:59:31 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 74ABA14035F;
	Fri, 19 Apr 2024 10:00:30 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 10:00:29 +0800
Subject: Re: [PATCH 1/2] mm/hugetlb: fix DEBUG_LOCKS_WARN_ON(1) when
 dissolve_free_hugetlb_folio()
To: Oscar Salvador <osalvador@suse.de>
CC: <akpm@linux-foundation.org>, <muchun.song@linux.dev>, <david@redhat.com>,
	<vbabka@suse.cz>, <willy@infradead.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240418022000.3524229-1-linmiaohe@huawei.com>
 <20240418022000.3524229-2-linmiaohe@huawei.com>
 <ZiCb_r8O24p8qHIz@localhost.localdomain>
 <a852eb0c-f64e-f1d7-d685-a4e81a6416c6@huawei.com>
 <ZiEU83kaHP7AG25z@localhost.localdomain>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <32c97464-fcc2-18a2-5b72-8602cffa895a@huawei.com>
Date: Fri, 19 Apr 2024 10:00:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZiEU83kaHP7AG25z@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/4/18 20:41, Oscar Salvador wrote:
> On Thu, Apr 18, 2024 at 04:00:42PM +0800, Miaohe Lin wrote:
>> On 2024/4/18 12:05, Oscar Salvador wrote:
>>> On Thu, Apr 18, 2024 at 10:19:59AM +0800, Miaohe Lin wrote:
>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>> index 26ab9dfc7d63..1da9a14a5513 100644
>>>> --- a/mm/hugetlb.c
>>>> +++ b/mm/hugetlb.c
>>>> @@ -1788,7 +1788,8 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
>>>>  		destroy_compound_gigantic_folio(folio, huge_page_order(h));
>>>>  		free_gigantic_folio(folio, huge_page_order(h));
>>>>  	} else {
>>>> -		INIT_LIST_HEAD(&folio->_deferred_list);
>>>> +		if (!folio_test_hugetlb(folio))
>>>> +			INIT_LIST_HEAD(&folio->_deferred_list);
>>>
>>> Ok, it took me a bit to figure this out.
>>>
>>> So we basically init __deferred_list when we know that
>>> folio_put will not end up calling free_huge_folio
>>> because a previous call to remove_hugetlb_folio has already cleared the
>>> bit.
>>>
>>> Maybe Matthew thought that any folio ending here would not end up in
>>> free_huge_folio (which is the one fiddling subpool).
>>>
>>> I mean, fix looks good because if hugetlb flag is cleared,
>>> destroy_large_folio will go straight to free_the_page, but the
>>> whole thing is a bit subtle.
>>
>> AFAICS, this is the most straightforward way to fix the issue. Do you have any suggestions
>> on how to fix this in a more graceful way?
> 
> Not from the top of my head.
> Anyway, I have been thinking for a while that this code needs some love,
> so I will check how this can be untangled.

That would be really nice. Thanks Oscar.
.

> 
> 



Return-Path: <linux-kernel+bounces-149688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DB98A948A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3911C21C89
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8875579DC5;
	Thu, 18 Apr 2024 08:00:51 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D5678B49
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713427251; cv=none; b=qoIfk/CRIN9EKBUsudvA81W3k7Og37fDgrlcW9fGE/ivGwiy0XIky2KGFC9y1rGClRpb6+QAKaJv/5Xev4lKWvwUaseNzcwDyuvVkN4NFguOlmo1TFDo2NL5L18yWb2zIZm6NxHi+5NbR+IUhp0dNaUK7hCpqTanb4qHOquRLE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713427251; c=relaxed/simple;
	bh=VQF2Ei3awZBGH1coNeifKni7R8CulQ0uaVhSG8NwWLI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=O3eJUf7XNnIG2CefFvyArVy1qvtUNVI6uwT5rQI1IQeJ3obFGWOoKL7YjF3trVw/iocpf5Ao/cjAsvaHRpHblW/z8JBm3cYHf/2LjnEyw+Ky+oCPy56ufYQfixEaLDxi9tyYVMVXioHQasL2bDx1EBlsHW7PnWNE7pt5PAOYZT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VKqs72Pnqz1xtxL;
	Thu, 18 Apr 2024 15:58:19 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C6011A016C;
	Thu, 18 Apr 2024 16:00:43 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 16:00:43 +0800
Subject: Re: [PATCH 1/2] mm/hugetlb: fix DEBUG_LOCKS_WARN_ON(1) when
 dissolve_free_hugetlb_folio()
To: Oscar Salvador <osalvador@suse.de>
CC: <akpm@linux-foundation.org>, <muchun.song@linux.dev>, <david@redhat.com>,
	<vbabka@suse.cz>, <willy@infradead.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240418022000.3524229-1-linmiaohe@huawei.com>
 <20240418022000.3524229-2-linmiaohe@huawei.com>
 <ZiCb_r8O24p8qHIz@localhost.localdomain>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <a852eb0c-f64e-f1d7-d685-a4e81a6416c6@huawei.com>
Date: Thu, 18 Apr 2024 16:00:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZiCb_r8O24p8qHIz@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/4/18 12:05, Oscar Salvador wrote:
> On Thu, Apr 18, 2024 at 10:19:59AM +0800, Miaohe Lin wrote:
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 26ab9dfc7d63..1da9a14a5513 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1788,7 +1788,8 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
>>  		destroy_compound_gigantic_folio(folio, huge_page_order(h));
>>  		free_gigantic_folio(folio, huge_page_order(h));
>>  	} else {
>> -		INIT_LIST_HEAD(&folio->_deferred_list);
>> +		if (!folio_test_hugetlb(folio))
>> +			INIT_LIST_HEAD(&folio->_deferred_list);
> 
> Ok, it took me a bit to figure this out.
> 
> So we basically init __deferred_list when we know that
> folio_put will not end up calling free_huge_folio
> because a previous call to remove_hugetlb_folio has already cleared the
> bit.
> 
> Maybe Matthew thought that any folio ending here would not end up in
> free_huge_folio (which is the one fiddling subpool).
> 
> I mean, fix looks good because if hugetlb flag is cleared,
> destroy_large_folio will go straight to free_the_page, but the
> whole thing is a bit subtle.

AFAICS, this is the most straightforward way to fix the issue. Do you have any suggestions
on how to fix this in a more graceful way?

> 
> And if we decide to go with this, I think we are going to need a comment
> in there explaining what is going on like "only init _deferred_list if
> free_huge_folio cannot be call".

Yes, this comment will help.
Thanks.
.

> 
> 



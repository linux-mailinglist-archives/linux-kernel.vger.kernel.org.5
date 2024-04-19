Return-Path: <linux-kernel+bounces-151214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 430888AAB30
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F53C1C21319
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E681874BEC;
	Fri, 19 Apr 2024 09:07:24 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E324F7350E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713517644; cv=none; b=Sn5si78VoVJDBMZKliI0VO8qe9SEsOCyd028e3zyu8vU+k2vt4abj1spnN4b1+/tgvIopxeu74lMPeiEtwnyeddhqXiKpgb3lvUFxLUj2jwLdyXxMLInnwloEENa6qJo0EIcxZlcnoeYiR2EMbW8X47iGRNrls9SMIThiaegWQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713517644; c=relaxed/simple;
	bh=CfnZg8r/QZUEzgHHXpfTKLfEuUrj3HYN6sGnFATCDh0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NEoyw2cVdspCf7uIQaSJ3b5xLHo7BZerRzQPswiikzFkBUODoeywAEVN6gxDsQqJgV3UiipQTtPTzz4CGBVq1cgEYhMSM8pfs3pJ9ELUNr4uppELIoPh90O9rPM3Y1pxNhTzhTmXJxXpCI+KVEgWKJP+WpmyOfQi8fgzCga4ZLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VLTGr4Clqz1hwlS;
	Fri, 19 Apr 2024 17:04:20 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 30D651A0188;
	Fri, 19 Apr 2024 17:07:20 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 17:07:19 +0800
Subject: Re: [PATCH 2/2] mm/hugetlb: fix unable to handle page fault for
 address dead000000000108
To: Andrew Morton <akpm@linux-foundation.org>
CC: <muchun.song@linux.dev>, <david@redhat.com>, <vbabka@suse.cz>,
	<willy@infradead.org>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20240418022000.3524229-1-linmiaohe@huawei.com>
 <20240418022000.3524229-3-linmiaohe@huawei.com>
 <20240418133817.afb65c8dcd11cfea7c686d25@linux-foundation.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d2cd0601-46ef-a42c-a870-f0ab6bdb1a80@huawei.com>
Date: Fri, 19 Apr 2024 17:07:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240418133817.afb65c8dcd11cfea7c686d25@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/4/19 4:38, Andrew Morton wrote:
> On Thu, 18 Apr 2024 10:20:00 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> Below panic occurs when I did memory failure test:
>>
>> BUG: unable to handle page fault for address: dead000000000108
>>
>> ...
>>
>> The root cause is that list_del() is used to remove folio from list when
>> dissolve_free_hugetlb_folio(). But list_move() might be used to reenqueue
>> hugetlb folio when free_huge_folio() leading to above panic. Fix this
>> issue by using list_del_init() to remove folio.
>>
>> ...
>>
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1642,7 +1642,7 @@ static void __remove_hugetlb_folio(struct hstate *h, struct folio *folio,
>>  	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>>  		return;
>>  
>> -	list_del(&folio->lru);
>> +	list_del_init(&folio->lru);
>>  
>>  	if (folio_test_hugetlb_freed(folio)) {
>>  		h->free_huge_pages--;
> 
> We should cc:stable and find a Fixes:.  This appears to predate
> 6eb4e88a6d27022ea8aff424d47a0a5dfc9fcb34, after which I got lost.

I think this series can be dropped because this didn't fix the root cause.
Please see my v2 patch for details. So this Fixes tag isn't needed anymore.
Thanks.
.

> .
> 



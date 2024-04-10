Return-Path: <linux-kernel+bounces-138154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBD389ED63
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A33284AC3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6B513D607;
	Wed, 10 Apr 2024 08:16:16 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A53101C5;
	Wed, 10 Apr 2024 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712736976; cv=none; b=eJQ8cHxoNcZMfVFY2bUM1gucXK91Rfa2Txb4xM4v1AcxQts42j2PBuorwaGz1gXqWSiA6kRXfcFSx32WThHmcTtc8XILUskyya0wySl205ppCcwOv2qycWGFVzSK4N6EbYKTsDHazWS3+caaHCPwSgalmEfgltdeL+b/wAZK/UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712736976; c=relaxed/simple;
	bh=+BMKLZOsQbr0VOgMzU++BDRC6fIbczsfsXJLxYo5OFw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eS54BDt3UArSQ9IjaZntkon6PI0EqH6CkHF5YvYnLfFPVfHRlJJgsdbL+1avDXBUpDEWaWGu7e3u2hdCbQeQ5mQVYgwjOMO7lQxF90RBmeZlUxD0HBiGTQZHN+DrmP05BwtTSAjXnsHz8x9ckzckVnQPTTV0a3oekEdmJGbEK1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VDwYq151qzWmjq;
	Wed, 10 Apr 2024 16:13:03 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 3EE1C14044F;
	Wed, 10 Apr 2024 16:16:11 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 16:16:10 +0800
Subject: Re: [PATCH] mm,swapops: Update check in is_pfn_swap_entry for
 hwpoison entries
To: Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>
CC: Andrew Morton <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, David Hildenbrand <david@redhat.com>,
	<stable@vger.kernel.org>, Tony Luck <tony.luck@intel.com>, Naoya Horiguchi
	<naoya.horiguchi@nec.com>
References: <20240407130537.16977-1-osalvador@suse.de>
 <ZhKmAecilbb2oSD9@localhost.localdomain> <ZhLx3fwzQNPDbBei@x1n>
 <ZhMCvynFUDr-8DpX@localhost.localdomain>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <5b730a9c-440d-6527-a761-e15c9670af83@huawei.com>
Date: Wed, 10 Apr 2024 16:16:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZhMCvynFUDr-8DpX@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/4/8 4:31, Oscar Salvador wrote:
>> Totally unexpected, as this commit even removed hwpoison_entry_to_pfn().
>> Obviously even until now I assumed hwpoison is accounted as pfn swap entry
>> but it's just missing..
>>
>> Since this commit didn't really change is_pfn_swap_entry() itself, I was
>> thinking maybe an older fix tag would apply, but then I noticed the old
>> code indeed should work well even if hwpoison entry is missing.  For
>> example, it's a grey area on whether a hwpoisoned page should be accounted
>> in smaps.  So I think the Fixes tag is correct, and thanks for fixing this.
>>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> Thanks Peter

Thanks both.

> 
>> Fedora stopped having DEBUG_VM for some time, but not sure about when it's
>> still in the 6.1 trees.  It looks like cc stable is still reasonable from
>> that regard.
> 
> Good to know, thanks for the info.
> 
>> A side note is that when I'm looking at this, I went back and see why in
>> some cases we need the pfn maintained for the poisoned, then I saw the only
>> user is check_hwpoisoned_entry() who wants to do fast kills in some
>> contexts and that includes a double check on the pfns in a poisoned entry.
>> Then afaict this path is just too rarely used and buggy.
> 
> Yes, unfortunately memory-failure code does not get exercised that much,
> and so there might be subtly bugs lurking in there for quite some time.

There're many memory-failure testcases but some code paths still didn't get
exercised. That's a pity. :(

> 
>> A few things we may need fixing, maybe someone in the loop would have time
>> to have a look:
>>
>> - check_hwpoisoned_entry()
>>   - pte_none check is missing
>>   - all the rest swap types are missing (e.g., we want to kill the proc too
>>     if the page is during migration)

Firstly, I thought rest swap types just won't exist in this code path. But after second thought,
it seems it's possible. For example, when page is being isolated for migration, memory_failure
will fails to isolate it. And the second MCE event will goes to kill_accessing_process() and
see a migrate swap entry.

>> - check_hwpoisoned_pmd_entry()
>>   - need similar care like above (pmd_none is covered not others)
> 
> I will have a look and see what needs fixing, thanks for bringing it up.

Thanks for your time.
.

> 
> 



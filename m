Return-Path: <linux-kernel+bounces-31676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB0C833267
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 03:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB62F1C20EA5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 02:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9EAEC4;
	Sat, 20 Jan 2024 02:13:27 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20B5A4D
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 02:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705716806; cv=none; b=ELLHuox7x9iILYb199NWhgni1t/j0/1lcLNSsiM1h0rhfRt0CK0i0OIusikhpiduo7xaZIstsju9H4wKhJDGGVbjNtbcZNJEoq1pCLuaMxUrS1QhLmAutHc3qbV5kMm1e5hykN4OWcItXHnfoYgT+NRuYE/su/C4uskkE3Trbuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705716806; c=relaxed/simple;
	bh=Bq/03e/RWTFfEOJTIMM7o5q+Yo+2iJDaqY5hzBPmCJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mqBJHPp8zpgayc7XuhsR4NYBuQughkNeyg2zFWMHXbo2sRc0cBGnGW4+BSeQ8ATBqaqQqNkff7JxU3j40afOzjHmEeK6t3eQaCD5JG++9AHO+hLw1BFnLRTDWIdSaG0IFr3lCJ7EuafGJId3TR3UsmrKrHdHpTzBaaJeq/up/ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TH0Pl5smRzGpn8;
	Sat, 20 Jan 2024 10:12:59 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id D5834180017;
	Sat, 20 Jan 2024 10:13:20 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 20 Jan 2024 10:13:20 +0800
Message-ID: <2160e2ea-20af-46c4-b6b1-a974eb09b490@huawei.com>
Date: Sat, 20 Jan 2024 10:13:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: memory: move mem_cgroup_charge() into
 alloc_anon_folio()
Content-Language: en-US
To: Michal Hocko <mhocko@suse.com>
CC: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <ryan.roberts@arm.com>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@redhat.com>
References: <20240117103954.2756050-1-wangkefeng.wang@huawei.com>
 <ZalK3suIskEyaR7m@tiehlicka>
 <c7b1cc8e-c434-4c86-972e-4a105524646c@huawei.com>
 <ZaosK59cRa27K9zW@tiehlicka>
 <14ae628d-a9ef-42f3-9201-e90c5c88c133@huawei.com>
 <ZaqZPxDUOuxRWB5l@tiehlicka>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZaqZPxDUOuxRWB5l@tiehlicka>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/1/19 23:46, Michal Hocko wrote:
> On Fri 19-01-24 20:59:22, Kefeng Wang wrote:
>>>>> GFP_TRANSHUGE_LIGHT is more interesting though because those do not dive
>>>>> into the direct reclaim at all. With the current code they will reclaim
>>>>> charges to free up the space for the allocated THP page and that defeats
>>>>> the light mode. I have a vague recollection of preparing a patch to
>>>>
>>>> We are interesting to GFP_TRANSHUGE_LIGHT and _GFP_NORETRY as mentioned
>>>> above.
>>>
>>> if mTHP can be smaller than COSTLY_ORDER then you are correct and
>>> NORETRY makes a difference. Please mention that in the changelog as
>>> well.
>>>
>>
>> For memory cgroup charge, _GFP_NORETRY checked to make us directly skip
>> mem_cgroup_oom(), it has no concern with folio order or COSTLY_ORDER when
>> check _GFP_NORETRY in try_charge_memcg(), so I think NORETRY should
>> always make difference for all large order folio.
> 
> we do not OOM on COSTLY_ORDER (see mem_cgroup_oom). So NORETRY really
> makes a difference for small orders.

I see what you mean, but we may describe the different processes, if
GFP_TRANSHUGE | __GFP_NORETRY returned from vma_thp_gfp_mask(),
then we never involved with mem_cgroup_oom(), since mem_cgroup_oom()
will be skipped in try_charge_memcg(), that is what I want to say,
and in this case, no oom for order < COSTLY_ORDER or order > 
COSTLY_ORDER. But if GFP is GFP_TRANHUGE, then we may enter 
mem_cgroup_oom(), and maybe oom if order < COSTLY_ORDER.

So Yes, NORETRY really makes a difference for small orders.



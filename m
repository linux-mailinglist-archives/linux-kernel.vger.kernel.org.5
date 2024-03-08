Return-Path: <linux-kernel+bounces-97100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC83876589
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E2F1F21CF9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E240E3BBC1;
	Fri,  8 Mar 2024 13:45:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580D663B8
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709905543; cv=none; b=XUpjsSO/WtWbOOuUpaSU5EAMWP3LpYVNNS4EOS7B+AWdnhQ8PU6NRMuQOSemb86harERK7oIO7SM1o4Ni8SPTtW4uEADbMumJn6fmSMJmbFud8++t3AA+44A9i9gY++Y6ickn0rnNlB+rstkICTTEnLuytenbEHWC5GfqoCctzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709905543; c=relaxed/simple;
	bh=9xtUBUdedaQUnq7S4bilUju7BsfYPeHcOERY0pwxc+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kC5m+mMqo3/g93JieUCSjtZIYWH5hTWgfebpdzVMFHKvet45lWUDh6TYQ3L7k4nEeNwtdjWmXZRrFuR+H9u9iszo+b1cZGGp8o7HdoyP7ehmxF340PucuiMZaV7whYXw64Hn7MTUKvSkb6+RL7Naqwu/iocOLFVd68fxNzpZy9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1339DC15;
	Fri,  8 Mar 2024 05:46:17 -0800 (PST)
Received: from [10.57.70.163] (unknown [10.57.70.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88B433F762;
	Fri,  8 Mar 2024 05:45:36 -0800 (PST)
Message-ID: <252bac83-bf5e-4c40-a696-ac093da41fa3@arm.com>
Date: Fri, 8 Mar 2024 13:45:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: prohibit the last subpage from reusing the entire
 large folio
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Barry Song <21cnbao@gmail.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org
Cc: minchan@kernel.org, fengwei.yin@intel.com, linux-kernel@vger.kernel.org,
 mhocko@suse.com, peterx@redhat.com, shy828301@gmail.com,
 songmuchun@bytedance.com, wangkefeng.wang@huawei.com, xiehuan09@gmail.com,
 zokeefe@google.com, chrisl@kernel.org, yuzhao@google.com,
 Barry Song <v-songbaohua@oppo.com>, Lance Yang <ioworker0@gmail.com>
References: <20240308092721.144735-1-21cnbao@gmail.com>
 <519fd6a7-072e-43a2-a9a8-2467ee783524@redhat.com>
 <cfe7d2b5-eb41-4df0-bf6b-4ed4044e20ea@arm.com>
 <8e994734-1d3a-4c51-9c0b-4e2ce945f198@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <8e994734-1d3a-4c51-9c0b-4e2ce945f198@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/03/2024 13:24, David Hildenbrand wrote:
>>>> This patch migrates the last subpage to a small folio and immediately
>>>> returns the large folio to the system. It benefits both memory availability
>>>> and anti-fragmentation.
>>>
>>> It might be controversial optimization, and as Ryan said, there, are likely
>>> other cases where we'd want to migrate off-of a thp if possible earlier.
>>
>> Personally, I think there might also be cases where you want to copy/reuse the
>> entire large folio. If you're application is using 16K THPs perhaps it's a
>> bigger win to just treat it like a base page? I expect the cost/benefit will
>> change as the THP size increases?
> 
> Yes, I think for small folios (i.e., 16KiB) it will be rather easy to make a
> decision. The larger the folio, the larger the page fault latency due to
> scanning, copying, modifying, which can easily turn undesirable.
> 
> At least when it comes to page reuse, I have some simple backup plans for small
> folios if I won't be able to make progress with my other approach. 

Do you mean "small large folios" here? i.e. order >= 1? If so, great!


For larger
> folios, it won't really work/be desirable, though.
> 



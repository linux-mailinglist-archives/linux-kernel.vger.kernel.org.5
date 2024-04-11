Return-Path: <linux-kernel+bounces-141347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A73DB8A1CF1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE7B1F23F5C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113E71C233D;
	Thu, 11 Apr 2024 16:45:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487B515AE0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853946; cv=none; b=m81wymWiFVwVUJGeINyCytCJkRmaZrx0+GEmNzZL/KGFkoGD9AfUVkaQZKk42Reahxrv0bG6pvH4QYytKPFUGLdl/4db6aLqooaqGfWYwjTMIDtFL0du1k1U1/eDELGK0RBg7lWHa5NtvE5ueDjH4vtyJMqJrEfo7RtGa6k22a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853946; c=relaxed/simple;
	bh=uDph+pMQsOAPYZ80ULDa6Uo+7or2zXPtxlNdIjT8VjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=paFudzJg9iDz6QNH3naVmcojsuL6juN5A/HSro8TKM+4H2ERb40ubBt551SPkiUB1+d5tKoguDOUf/LbCg8zxs0GgNphRXsDuGlPF3JfazSc1K/L05c0tzyyEIWCAnQpF4Pu6IGD+RprrVJosRtGyCg85ycQXF4jzKzzMrjtbec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 341A6113E;
	Thu, 11 Apr 2024 09:46:14 -0700 (PDT)
Received: from [10.1.38.151] (XHFQ2J9959.cambridge.arm.com [10.1.38.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E9503F6C4;
	Thu, 11 Apr 2024 09:45:42 -0700 (PDT)
Message-ID: <e23420bb-0d97-4546-a2ae-8bfe3c10e259@arm.com>
Date: Thu, 11 Apr 2024 17:45:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] mm: add per-order mTHP alloc and swpout counters
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, david@redhat.com
Cc: linux-mm@kvack.org, cerasuolodomenico@gmail.com, chrisl@kernel.org,
 kasong@tencent.com, peterx@redhat.com, surenb@google.com,
 v-songbaohua@oppo.com, willy@infradead.org, yosryahmed@google.com,
 yuzhao@google.com, linux-kernel@vger.kernel.org
References: <20240405102704.77559-1-21cnbao@gmail.com>
 <20240405131140.8881aae1af0d877dc70c8ea9@linux-foundation.org>
 <CAGsJ_4zpKmha2YtnsuDdda9_w4MtPZrk=SbdnBhJbdoA9HbogA@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4zpKmha2YtnsuDdda9_w4MtPZrk=SbdnBhJbdoA9HbogA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/04/2024 23:04, Barry Song wrote:
> On Sat, Apr 6, 2024 at 9:11 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Fri,  5 Apr 2024 23:27:02 +1300 Barry Song <21cnbao@gmail.com> wrote:
>>
>>> The patchset introduces a framework to facilitate mTHP counters, starting
>>> with the allocation and swap-out counters. Currently, only four new nodes
>>> are appended to the stats directory for each mTHP size.
>>>
>>> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
>>>       anon_alloc
>>>       anon_alloc_fallback
>>>       anon_swpout
>>>       anon_swpout_fallback
>>
>> Please let's get these documented?
> 
> Sure, I will do it.
> 
> Furthermore, after careful consideration, I suggest renaming anon_alloc to
> anon_fault_alloc and anon_alloc_fallback to anon_fault_fallback. This
> renaming is consistent with the naming convention observed in
> thp_fault_alloc and thp_fault_fallback in vmstat. Additionally, this
> modification will facilitate the handling of large folio swap-ins.
> 
> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
>            anon_fault_alloc,
>            anon_fault_fallback,
>            anon_swpin_alloc,
>            anon_swpin_fallback,
> 
> Otherwise, without this renaming, it would be difficult to
> differentiate fault_alloc
> from swpin_alloc.
> 
> Hi David, Ryan,
> I would also appreciate your input on the modification I am considering.

Yes, this makes sense to me!

> 
>> Documentation/admin-guide/mm/transhuge.rst seems to be the place, and
>> under Documentation/ABI.
> 
> Thanks
> Barry



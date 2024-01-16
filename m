Return-Path: <linux-kernel+bounces-27498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC4682F10C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B32F1F2463B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895381BF45;
	Tue, 16 Jan 2024 15:07:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8031C283
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 15:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58FB02F4;
	Tue, 16 Jan 2024 07:08:18 -0800 (PST)
Received: from [10.1.38.190] (XHFQ2J9959.cambridge.arm.com [10.1.38.190])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 500193F766;
	Tue, 16 Jan 2024 07:07:30 -0800 (PST)
Message-ID: <dda2ce7c-a487-44a0-bb97-8405524a0ed0@arm.com>
Date: Tue, 16 Jan 2024 15:07:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: memory: move mem_cgroup_charge() into
 alloc_anon_folio()
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
References: <20240116071302.2282230-1-wangkefeng.wang@huawei.com>
 <2c24afdf-5103-4c1b-a649-2eeed185f3fb@arm.com>
 <ZaaX4Yi9JYBWrUEs@casper.infradead.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZaaX4Yi9JYBWrUEs@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/01/2024 14:51, Matthew Wilcox wrote:
> On Tue, Jan 16, 2024 at 02:35:54PM +0000, Ryan Roberts wrote:
>> On 16/01/2024 07:13, Kefeng Wang wrote:
>>> In order to allocate as much as possible of large folio, move
>>> the mem charge into alloc_anon_folio() and try the next order
>>> if mem_cgroup_charge() fails, also we change the GFP_KERNEL
>>> to gfp to be consistent with PMD THP.
>>
>> I agree that changing gfp gives you consistency. But it's not entirely clear to
>> me why THP should use one set of flags for this case, and since pages another.
>> Why does this difference exist?
> 
> I think it needs to be spelled out much better in the changelog.  Here's
> my attempt at explaining why we might want this change.
> 
> mem_cgroup_charge() uses the GFP flags in a fairly sophisticated way.
> In addition to checking gfpflags_allow_blocking(), it pays attention to
> __GFP_NORETRY and __GFP_RETRY_MAYFAIL to ensure that processes within
> this memcg do not exceed their quotas.  Using the same GFP flags ensures
> that we handle large anonymous folios correctly, including falling back
> to smaller orders when there is plenty of memory available in the system
> but this memcg is close to its limits.

Thanks for the explanation. Please add to the commit log.

Essentially you are saying that previously, all mTHP allocations would cause
reclaim from the memcg if the allocation caused the quota to be used up. But
with this change, it might now avoid that reclaim and just OOM, if the flags are
as such? So then we retry with the next lowest available size. Makes sense!


> 
> ... I remain not-an-expert in memcg and anonymous memory and welcome
> improvements to that text.

Me too...


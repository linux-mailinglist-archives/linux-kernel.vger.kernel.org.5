Return-Path: <linux-kernel+bounces-99970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D45879003
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4F3BB217FD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2CD77F0D;
	Tue, 12 Mar 2024 08:51:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989E677F0A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710233488; cv=none; b=slI5q1P+nJ2w2+cJ/FF+5W++XLQbhAI1zAb55fd7VxyNtOFRPAaM9RfUypFtvTlctIDWsnGkvrHBmnXhkIYC0YbSIT8xv0blYWJNOu/C6SwJYiIBb49sfOyXCLUjjavlTYYRaQsNkAvv/wTDNRz/lX8vKXxOqZjGiYA2Ogegxa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710233488; c=relaxed/simple;
	bh=wzgtpAlzqAf9lgAtgEoSt+aBjChvRcyTJi+7JedyZHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s0tKU/N0ikIDkC7BMpPEg5Ur+Hux6uoa3wnfpeXIHYd+MrspJmMSl4Ax7oPCf9f6iS/G96j/Dzl74FztGvF0rbLAxznoggsJNE+DU/DT+O9ypZBxzkVNW39n/HDwZglEeFsr9YlxjGzpgZP6xvqSC+b/w+3FB/IG5n768BO2bEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E19401007;
	Tue, 12 Mar 2024 01:52:02 -0700 (PDT)
Received: from [10.57.68.246] (unknown [10.57.68.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CEDA3F762;
	Tue, 12 Mar 2024 01:51:23 -0700 (PDT)
Message-ID: <2e236d6b-e6fc-428a-ad06-c2fb1dbf5c8b@arm.com>
Date: Tue, 12 Mar 2024 08:51:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] mm: swap: Simplify struct percpu_cluster
Content-Language: en-GB
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <20240311150058.1122862-4-ryan.roberts@arm.com>
 <87cyrz51lj.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <87cyrz51lj.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/03/2024 07:52, Huang, Ying wrote:
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
>> struct percpu_cluster stores the index of cpu's current cluster and the
>> offset of the next entry that will be allocated for the cpu. These two
>> pieces of information are redundant because the cluster index is just
>> (offset / SWAPFILE_CLUSTER). The only reason for explicitly keeping the
>> cluster index is because the structure used for it also has a flag to
>> indicate "no cluster". However this data structure also contains a spin
>> lock, which is never used in this context, as a side effect the code
>> copies the spinlock_t structure, which is questionable coding practice
>> in my view.
>>
>> So let's clean this up and store only the next offset, and use a
>> sentinal value (SWAP_NEXT_INVALID) to indicate "no cluster".
>> SWAP_NEXT_INVALID is chosen to be 0, because 0 will never be seen
>> legitimately; The first page in the swap file is the swap header, which
>> is always marked bad to prevent it from being allocated as an entry.
>> This also prevents the cluster to which it belongs being marked free, so
>> it will never appear on the free list.
>>
>> This change saves 16 bytes per cpu. And given we are shortly going to
>> extend this mechanism to be per-cpu-AND-per-order, we will end up saving
>> 16 * 9 = 144 bytes per cpu, which adds up if you have 256 cpus in the
>> system.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> LGTM, Thanks!

Thanks! What's a guy got to do to get Rb or Ack? :)

> 
> --
> Best Regards,
> Huang, Ying
> 



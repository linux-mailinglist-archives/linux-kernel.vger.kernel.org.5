Return-Path: <linux-kernel+bounces-109003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD2888133B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BDFAB232B1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFFF4207F;
	Wed, 20 Mar 2024 14:21:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633772628D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710944499; cv=none; b=EO8Cy6weQMMeVq5cnx0ukmTCAfKb9CUvso3bjbPaw8CbGesj3D3EPaW2OS6t3gOSCQdA2/X6Xw9B5jK/1tL6Eb2XHo0IkorNn57AGxL4hcEUf5adVmCQK9rkwwRWKbclte7GqXN4rRfw709qGakNlMX31LLflmYtVuu6o360e80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710944499; c=relaxed/simple;
	bh=sgvltgyVNo1Z71NR9F+7UwUoanVixUUJz+AVAcpQcU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sEX9EmrXFphOvpDkqOZ5/WCyD7wyj2C6VkPOeSJU0zMb7UdEWx4sxEiKFz33rHdEKjzvvpmBfwl+JhWh4WdlIIEMypNUioKhUioL0EQi6Nfel/RADTLXVe6hoiTvKQfXcBhDmhDrLkrWJi2f9ITugmBGjbrm4SuiF2ETGeqhgUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D9401007;
	Wed, 20 Mar 2024 07:22:12 -0700 (PDT)
Received: from [10.57.72.78] (unknown [10.57.72.78])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8029F3F64C;
	Wed, 20 Mar 2024 07:21:35 -0700 (PDT)
Message-ID: <a9aaf1b0-f8c4-404c-9f24-f73054e35156@arm.com>
Date: Wed, 20 Mar 2024 14:21:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] mm: swap: free_swap_and_cache_nr() as batched
 free_swap_and_cache()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <20240311150058.1122862-3-ryan.roberts@arm.com>
 <42ae8cdf-2352-4bb9-9b22-aed92a2c9930@arm.com>
 <f4ddda40-0ee5-4c0e-9487-c58914d79180@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <f4ddda40-0ee5-4c0e-9487-c58914d79180@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/03/2024 14:13, David Hildenbrand wrote:
> On 20.03.24 12:10, Ryan Roberts wrote:
>> Hi David,
> 
> I'm usually lazy with review during the merge window :P

Ahh no worries! I'll send out the latest version next week, and can go from there.

> 
>>
>> I hate to chase, but since you provided feedback on a couple of the other
>> patches in the series, I wondered if you missed this one? It's the one that does
>> the batching of free_swap_and_cache(), which you suggested in order to prevent
>> needlessly taking folio locks and refs.
>>
>> If you have any feedback, it would be appreciated, otherwise I'm planning to
>> repost as-is next week (nobody else has posted comments against this patch
>> either) as part of the updated series.
> 
> On my TODO list!
> 



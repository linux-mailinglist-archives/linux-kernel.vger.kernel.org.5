Return-Path: <linux-kernel+bounces-83407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64082869896
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E2928E388
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A931513B29B;
	Tue, 27 Feb 2024 14:40:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639CF16423
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044824; cv=none; b=e7YHtAB2HQ3YC1vL5HFwHTX4ArfP6NWt9Tp3s2VG7B3hzeX5mr9u8KVZoePrVnZth+5OzDofoMfY6SGenXiWG8M8H4QwaOEIS4ltrUTkzaKsEm/YIl3jzUcYbh5+DtDoZO2SXBi2r/0QBInUb4KnPhjBZkRIupcNTsZkkP0KJus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044824; c=relaxed/simple;
	bh=JIaLrHdBMuL/K0juRJDhcGKKTRVjiBE7RyfnkLDIaqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kgXJ0kNBr0xTpoergyf2yUnd+1IDj86jefYVFfd2JvXVWySpUVTDXNe+9flEZeJ5CyQnma22zBodT0ZAq6YtSeBE45FgbSUg9UqsbpeuhD6gCZd9/SDd9QFZ8BfGln0oZKYAOZXVGeXC/IWGYXJN0VRvKqAytnG+V39lfSzzlEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDAC0DA7;
	Tue, 27 Feb 2024 06:40:59 -0800 (PST)
Received: from [10.1.30.188] (XHFQ2J9959.cambridge.arm.com [10.1.30.188])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E7BB3F762;
	Tue, 27 Feb 2024 06:40:19 -0800 (PST)
Message-ID: <3a3461fc-4b30-4ba1-94c9-c048d08d40c0@arm.com>
Date: Tue, 27 Feb 2024 14:40:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 6/6] mm: madvise: don't split mTHP for MADV_PAGEOUT
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 david@redhat.com, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, mhocko@suse.com, shy828301@gmail.com,
 wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org,
 ying.huang@intel.com, yuzhao@google.com, surenb@google.com,
 steven.price@arm.com, Chuanhua Han <hanchuanhua@oppo.com>,
 Barry Song <v-songbaohua@oppo.com>
References: <20231025144546.577640-1-ryan.roberts@arm.com>
 <20240118111036.72641-1-21cnbao@gmail.com>
 <20240118111036.72641-7-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240118111036.72641-7-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/01/2024 11:10, Barry Song wrote:
> From: Chuanhua Han <hanchuanhua@oppo.com>
> 
> MADV_PAGEOUT and MADV_FREE are common cases in Android. Ryan's patchset has
> supported swapping large folios out as a whole for vmscan case. This patch
> extends the feature to madvise.
> 
> If madvised range covers the whole large folio, we don't split it. Otherwise,
> we still need to split it.
> 
> This patch doesn't depend on ARM64's CONT-PTE, alternatively, it defines one
> helper named pte_range_cont_mapped() to check if all PTEs are contiguously
> mapped to a large folio.

I'm going to rework this patch and integrate it into my series if that's ok with
you?



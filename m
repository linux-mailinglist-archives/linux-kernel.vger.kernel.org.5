Return-Path: <linux-kernel+bounces-127522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D580C894D09
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4BA282D29
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5A63D38D;
	Tue,  2 Apr 2024 07:58:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7B92BD1C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712044709; cv=none; b=IskmnUKkbgkxSZC6HktM1fejvs5HgC5kkqBGu04+wxBEzCBaStJE531OWyu2d8LF8V8QatPHTnasOQLuvZX9bpwZHEGhhgSIZfydK9BO6TRqCxkDfs6IiSFWjtJDa1cq+3qN9SPCcEWGnVlMMjVZifde+vaBsuXVHT8SRPw0lOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712044709; c=relaxed/simple;
	bh=Iu2KxyyynVxbq6gjxe89goGC/9h4PqUNeJWtGGqhlqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yg88Das6WXQg0APUnbZNFrG7aNfwBXW6B7kmqfuXDPdBUrDPG52b5JyLW8WS5gSN6C35V16zoCT95VfKeECCZQsfVe33VzJ/1ygJdMMpg+cNw0OMdN8gVMaaVGwzFcZmFNJmWL/JF7wyogntwuvEU1bl0bsZddcdp+jeLpuROc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8516A1042;
	Tue,  2 Apr 2024 00:58:59 -0700 (PDT)
Received: from [10.57.73.65] (unknown [10.57.73.65])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E991F3F64C;
	Tue,  2 Apr 2024 00:58:23 -0700 (PDT)
Message-ID: <a18b46b1-7b7d-4cd0-aa68-d715b0c16822@arm.com>
Date: Tue, 2 Apr 2024 08:58:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: alloc_anon_folio: avoid doing vma_thp_gfp_mask in
 fallback cases
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, John Hubbard
 <jhubbard@nvidia.com>, David Hildenbrand <david@redhat.com>,
 Alistair Popple <apopple@nvidia.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 David Rientjes <rientjes@google.com>, "Huang, Ying" <ying.huang@intel.com>,
 Hugh Dickins <hughd@google.com>, Itaru Kitayama <itaru.kitayama@gmail.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Vlastimil Babka <vbabka@suse.cz>, Yang Shi <shy828301@gmail.com>,
 Yin Fengwei <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
 Zi Yan <ziy@nvidia.com>
References: <20240329073750.20012-1-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240329073750.20012-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/03/2024 07:37, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Fallback rates surpassing 90% have been observed on phones utilizing 64KiB
> CONT-PTE mTHP. In these scenarios, when one out of every 16 PTEs fails
> to allocate large folios, the remaining 15 PTEs fallback. Consequently,
> invoking vma_thp_gfp_mask seems redundant in such cases. Furthermore,
> abstaining from its use can also contribute to improved code readability.
> 
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Itaru Kitayama <itaru.kitayama@gmail.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Yin Fengwei <fengwei.yin@intel.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  mm/memory.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index c9c1031c2ecb..010e7bb20d2b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4353,6 +4353,9 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>  
>  	pte_unmap(pte);
>  
> +	if (!orders)
> +		goto fallback;
> +
>  	/* Try allocating the highest of the remaining orders. */
>  	gfp = vma_thp_gfp_mask(vma);
>  	while (orders) {



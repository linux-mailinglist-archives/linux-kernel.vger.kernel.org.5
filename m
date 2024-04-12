Return-Path: <linux-kernel+bounces-142486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A87698A2C34
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5190B2377A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5D254669;
	Fri, 12 Apr 2024 10:21:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A3153815
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712917272; cv=none; b=ALwvv9iyEcKLRb/TcHL648YAnMokf7oIlJJCSrLsQMbEM6faO8cIXQEYMFGYp58mFkS0dpMM/NUKFK1dw7E6SVogWhLtKT/O8osiYURMFyqlZXD53Xk3F9oHfW6zuF50Ji84a1C1vM0EO2iJ1nscmEC09TyYrKUiSpKEDZFU1OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712917272; c=relaxed/simple;
	bh=43tw20QoZbinHEmGseIrO49gqIWDI3m3fqrMCGS59g0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HlPlb5PaAp6LgQ6CzcmYHCOEl/9x3fMdUu2Sqi29iugIhSot8Z6zb15LtwhTEq3R54WeO7/1IlSdzu9VCGMYUzkDN5pQ9dUiW5k0f45p/m5xbOcWMkd3Kx/iDAs7QbHnVh9O5O92wUBou4d/XthF11T01CbjFqVF31RJK9rghvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 697C4339;
	Fri, 12 Apr 2024 03:21:39 -0700 (PDT)
Received: from [10.57.73.208] (unknown [10.57.73.208])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 173113F64C;
	Fri, 12 Apr 2024 03:21:07 -0700 (PDT)
Message-ID: <2eae1247-02dc-47e1-b9b2-317a73937651@arm.com>
Date: Fri, 12 Apr 2024 11:21:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] mm: correct the docs for thp_fault_alloc and
 thp_fault_fallback
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: cerasuolodomenico@gmail.com, chrisl@kernel.org, david@redhat.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, peterx@redhat.com,
 surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org,
 yosryahmed@google.com, yuzhao@google.com, corbet@lwn.net
References: <20240412073740.294272-1-21cnbao@gmail.com>
 <20240412073740.294272-5-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240412073740.294272-5-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/04/2024 08:37, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> The documentation does not align with the code. In
> __do_huge_pmd_anonymous_page(), THP_FAULT_FALLBACK is incremented when
> mem_cgroup_charge() fails, despite the allocation succeeding, whereas
> THP_FAULT_ALLOC is only incremented after a successful charge.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Jonathan Corbet <corbet@lwn.net>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  Documentation/admin-guide/mm/transhuge.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index f436ff982f22..98e3a99ea780 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -369,7 +369,7 @@ monitor how successfully the system is providing huge pages for use.
>  
>  thp_fault_alloc
>  	is incremented every time a huge page is successfully
> -	allocated to handle a page fault.
> +	allocated and charged to handle a page fault.
>  
>  thp_collapse_alloc
>  	is incremented by khugepaged when it has found
> @@ -377,7 +377,7 @@ thp_collapse_alloc
>  	successfully allocated a new huge page to store the data.
>  
>  thp_fault_fallback
> -	is incremented if a page fault fails to allocate
> +	is incremented if a page fault fails to allocate or charge
>  	a huge page and instead falls back to using small pages.
>  
>  thp_fault_fallback_charge



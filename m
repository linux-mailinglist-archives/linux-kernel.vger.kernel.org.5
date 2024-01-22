Return-Path: <linux-kernel+bounces-33798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED4D836EAB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7609A1F2D5F7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E598051C54;
	Mon, 22 Jan 2024 17:22:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B37B51C50
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944167; cv=none; b=mCtBI08pMybMOfV3193PsziDBir6gAmlb7QXAN7d1Ym2l1bVJlRSNv/EAYYbR8j42EhbnNEIWApnGF/ZBgBHQuc5n3v1HLBYwhhZg+5G8oUa9T+fgPQk/1cUqiUw4chsughY9F4qF4br6lhNuAD37GYr1IfGBwLJKE43yYBZswQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944167; c=relaxed/simple;
	bh=cHclBrzs9BlYr7t/j2CTkwuESk1+v6PN7H5BUrU0yXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WKHCU6rf8feolCNIWbSlpW9VBIFE/qFFSbzy5wg+ZYXhBZeHYZSmKiBz5+5tpbMrdAL+jsE7RCNNMqe6P+PLcwm8W4nIkymRfU9JZzxXBfzVghqeBl4uby8vnnfEYuObxVOEi/hHQGIqChf+q7XnGX0K1fPnjz7sCIFKB5iWj+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC7B01FB;
	Mon, 22 Jan 2024 09:23:30 -0800 (PST)
Received: from [10.1.33.151] (XHFQ2J9959.cambridge.arm.com [10.1.33.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 271523F5A1;
	Mon, 22 Jan 2024 09:22:44 -0800 (PST)
Message-ID: <d2272d63-1999-4cb3-be61-4a9fbd00e728@arm.com>
Date: Mon, 22 Jan 2024 17:22:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/memory: fix folio_set_dirty() vs.
 folio_mark_dirty() in zap_pte_range()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240122171751.272074-1-david@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240122171751.272074-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/01/2024 17:17, David Hildenbrand wrote:
> The correct folio replacement for "set_page_dirty()" is
> "folio_mark_dirty()", not "folio_set_dirty()". Using the latter won't
> properly inform the FS using the dirty_folio() callback.

That set_page_dirty() naming is pretty nasty, hey.

> 
> This has been found by code inspection, but likely this can result in
> some real trouble when zapping dirty PTEs that point at clean pagecache
> folios.
> 
> Reported-by: Ryan Roberts <ryan.roberts@arm.com>
> Closes: https://lkml.kernel.org/r/2445cedb-61fb-422c-8bfb-caf0a2beed62@arm.com
> Fixes: c46265030b0f ("mm/memory: page_remove_rmap() -> folio_remove_rmap_pte()")
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  mm/memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 7e1f4849463aa..89bcae0b224d6 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1464,7 +1464,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  			delay_rmap = 0;
>  			if (!folio_test_anon(folio)) {
>  				if (pte_dirty(ptent)) {
> -					folio_set_dirty(folio);
> +					folio_mark_dirty(folio);
>  					if (tlb_delay_rmap(tlb)) {
>  						delay_rmap = 1;
>  						force_flush = 1;



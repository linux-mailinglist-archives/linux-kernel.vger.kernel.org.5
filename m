Return-Path: <linux-kernel+bounces-21963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C066A82972D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64342B25546
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9BE3FB12;
	Wed, 10 Jan 2024 10:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CK2U00TA"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD3A3FB0A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <73111be3-3077-4821-8c2f-9c5564cb2bb7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704882018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HqWLnzHdhYYeRCqMae8M6cQn2qiQCuRsbTV+dKiFGmo=;
	b=CK2U00TAoeJZ6otiqwyvKNb+WcXawuJ82/NZd9tetCf8iTBiKMn7NAC9B/zf42c5olKs7C
	jhGDBJMgEPZGg+e/Vd8rlmjcFITXUVHH+g6grdLSJW6vzqXGZSa84zjzRcck0H1BKUtfiD
	KwxG0N/Cw1i/0IhbkMXjD7tehX+NSVo=
Date: Wed, 10 Jan 2024 18:19:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/7] hugetlb: code clean for hugetlb_hstate_alloc_pages
To: Gang Li <gang.li@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 ligang.bdlg@bytedance.com, David Hildenbrand <david@redhat.com>,
 David Rientjes <rientjes@google.com>, Mike Kravetz
 <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>
References: <20240102131249.76622-1-gang.li@linux.dev>
 <20240102131249.76622-2-gang.li@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240102131249.76622-2-gang.li@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/1/2 21:12, Gang Li wrote:
> The readability of `hugetlb_hstate_alloc_pages` is poor. By cleaning the
> code, its readability can be improved, facilitating future modifications.
>
> This patch extracts two functions to reduce the complexity of
> `hugetlb_hstate_alloc_pages` and has no functional changes.
>
> - hugetlb_hstate_alloc_pages_node_specific() to handle iterates through
>    each online node and performs allocation if necessary.
> - hugetlb_hstate_alloc_pages_report() report error during allocation.
>    And the value of h->max_huge_pages is updated accordingly.
>
> Signed-off-by: Gang Li <gang.li@linux.dev>
> ---
>   mm/hugetlb.c | 46 +++++++++++++++++++++++++++++-----------------
>   1 file changed, 29 insertions(+), 17 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ed1581b670d42..2606135ec55e6 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3482,6 +3482,33 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
>   	h->max_huge_pages_node[nid] = i;
>   }
>   
> +static bool __init hugetlb_hstate_alloc_pages_node_specific(struct hstate *h)

I'd like to rename this to hugetlb_hstate_alloc_pages_specific_nodes.

Otherwise, LGTM.

Reviewed-by: Muchun Song <muchun.song@linux.dev>

> +{
> +	int i;
> +	bool node_specific_alloc = false;
> +
> +	for_each_online_node(i) {
> +		if (h->max_huge_pages_node[i] > 0) {
> +			hugetlb_hstate_alloc_pages_onenode(h, i);
> +			node_specific_alloc = true;
> +		}
> +	}
> +
> +	return node_specific_alloc;
> +}
> +
> +static void __init hugetlb_hstate_alloc_pages_report(unsigned long allocated, struct hstate *h)
> +{
> +	if (allocated < h->max_huge_pages) {
> +		char buf[32];
> +
> +		string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
> +		pr_warn("HugeTLB: allocating %lu of page size %s failed.  Only allocated %lu hugepages.\n",
> +			h->max_huge_pages, buf, allocated);
> +		h->max_huge_pages = allocated;
> +	}
> +}
> +
>   /*
>    * NOTE: this routine is called in different contexts for gigantic and
>    * non-gigantic pages.
> @@ -3499,7 +3526,6 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
>   	struct folio *folio;
>   	LIST_HEAD(folio_list);
>   	nodemask_t *node_alloc_noretry;
> -	bool node_specific_alloc = false;
>   
>   	/* skip gigantic hugepages allocation if hugetlb_cma enabled */
>   	if (hstate_is_gigantic(h) && hugetlb_cma_size) {
> @@ -3508,14 +3534,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
>   	}
>   
>   	/* do node specific alloc */
> -	for_each_online_node(i) {
> -		if (h->max_huge_pages_node[i] > 0) {
> -			hugetlb_hstate_alloc_pages_onenode(h, i);
> -			node_specific_alloc = true;
> -		}
> -	}
> -
> -	if (node_specific_alloc)
> +	if (hugetlb_hstate_alloc_pages_node_specific(h))
>   		return;
>   
>   	/* below will do all node balanced alloc */
> @@ -3558,14 +3577,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
>   	/* list will be empty if hstate_is_gigantic */
>   	prep_and_add_allocated_folios(h, &folio_list);
>   
> -	if (i < h->max_huge_pages) {
> -		char buf[32];
> -
> -		string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
> -		pr_warn("HugeTLB: allocating %lu of page size %s failed.  Only allocated %lu hugepages.\n",
> -			h->max_huge_pages, buf, i);
> -		h->max_huge_pages = i;
> -	}
> +	hugetlb_hstate_alloc_pages_report(i, h);
>   	kfree(node_alloc_noretry);
>   }
>   



Return-Path: <linux-kernel+bounces-22833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A8E82A3A8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55521F24455
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6264F882;
	Wed, 10 Jan 2024 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ju8XfZ2Z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5864B5BE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 21:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704923717; x=1736459717;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=kauCl20DmtVewkNVcUeFNOrPm0xT7hFAub/QzXwa5Qw=;
  b=Ju8XfZ2Zoa7ayzP3wlu+7OP+kC0HNa8Ay/9l5YZC95wMh6elgKx+0ufW
   3MAjYaAsZ+RCyzKli9+lVfNvqxsVtmLrJwAZO1HpiZ+31lJvPQ/L2fpJg
   9hLS32wNbjfXWoVcJC2eRyDdEk+VGuJ/wDuBZDYr3u4aE5xog1b5ff+dU
   FOJ7R1f5hJ/79prTJtroEXz35chgCwvfjSa6lN9YAKl481xMLrtL2yeg7
   qj2LqiOmcUMFaA0+s0p/DKwaC8Ob4XXORr9A/imW4+TcdQ3U4pgmDtRg0
   2XJ0Ma0BOMEpfHqcacOdKL+gHmadsnOV2HE/16wk/XNB3An2g1xAWveFs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="17261977"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="17261977"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 13:55:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="30741455"
Received: from phungng1-mobl.amr.corp.intel.com (HELO [10.255.229.71]) ([10.255.229.71])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 13:55:16 -0800
Message-ID: <46769d44703b2f8d2e279d6e95db960c8a87e39c.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/7] hugetlb: code clean for
 hugetlb_hstate_alloc_pages
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Gang Li <gang.li@linux.dev>, David Hildenbrand <david@redhat.com>, David
 Rientjes <rientjes@google.com>, Mike Kravetz <mike.kravetz@oracle.com>,
 Muchun Song <muchun.song@linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 ligang.bdlg@bytedance.com
Date: Wed, 10 Jan 2024 13:55:15 -0800
In-Reply-To: <20240102131249.76622-2-gang.li@linux.dev>
References: <20240102131249.76622-1-gang.li@linux.dev>
	 <20240102131249.76622-2-gang.li@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-02 at 21:12 +0800, Gang Li wrote:
> The readability of `hugetlb_hstate_alloc_pages` is poor. By cleaning the
> code, its readability can be improved, facilitating future modifications.
>=20
> This patch extracts two functions to reduce the complexity of
> `hugetlb_hstate_alloc_pages` and has no functional changes.
>=20
> - hugetlb_hstate_alloc_pages_node_specific() to handle iterates through
>   each online node and performs allocation if necessary.
> - hugetlb_hstate_alloc_pages_report() report error during allocation.
>   And the value of h->max_huge_pages is updated accordingly.

Minor nit, I think hugetlb_hstate_alloc_pages_errcheck() is more
descriptive than hugetlb_hstate_alloc_pages_report().

Otherwise

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>

>=20
> Signed-off-by: Gang Li <gang.li@linux.dev>
> ---
>  mm/hugetlb.c | 46 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 29 insertions(+), 17 deletions(-)
>=20
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ed1581b670d42..2606135ec55e6 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3482,6 +3482,33 @@ static void __init hugetlb_hstate_alloc_pages_onen=
ode(struct hstate *h, int nid)
>  	h->max_huge_pages_node[nid] =3D i;
>  }
> =20
> +static bool __init hugetlb_hstate_alloc_pages_node_specific(struct hstat=
e *h)
> +{
> +	int i;
> +	bool node_specific_alloc =3D false;
> +
> +	for_each_online_node(i) {
> +		if (h->max_huge_pages_node[i] > 0) {
> +			hugetlb_hstate_alloc_pages_onenode(h, i);
> +			node_specific_alloc =3D true;
> +		}
> +	}
> +
> +	return node_specific_alloc;
> +}
> +
> +static void __init hugetlb_hstate_alloc_pages_report(unsigned long alloc=
ated, struct hstate *h)
> +{
> +	if (allocated < h->max_huge_pages) {
> +		char buf[32];
> +
> +		string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
> +		pr_warn("HugeTLB: allocating %lu of page size %s failed.  Only allocat=
ed %lu hugepages.\n",
> +			h->max_huge_pages, buf, allocated);
> +		h->max_huge_pages =3D allocated;
> +	}
> +}
> +
>  /*
>   * NOTE: this routine is called in different contexts for gigantic and
>   * non-gigantic pages.
> @@ -3499,7 +3526,6 @@ static void __init hugetlb_hstate_alloc_pages(struc=
t hstate *h)
>  	struct folio *folio;
>  	LIST_HEAD(folio_list);
>  	nodemask_t *node_alloc_noretry;
> -	bool node_specific_alloc =3D false;
> =20
>  	/* skip gigantic hugepages allocation if hugetlb_cma enabled */
>  	if (hstate_is_gigantic(h) && hugetlb_cma_size) {
> @@ -3508,14 +3534,7 @@ static void __init hugetlb_hstate_alloc_pages(stru=
ct hstate *h)
>  	}
> =20
>  	/* do node specific alloc */
> -	for_each_online_node(i) {
> -		if (h->max_huge_pages_node[i] > 0) {
> -			hugetlb_hstate_alloc_pages_onenode(h, i);
> -			node_specific_alloc =3D true;
> -		}
> -	}
> -
> -	if (node_specific_alloc)
> +	if (hugetlb_hstate_alloc_pages_node_specific(h))
>  		return;
> =20
>  	/* below will do all node balanced alloc */
> @@ -3558,14 +3577,7 @@ static void __init hugetlb_hstate_alloc_pages(stru=
ct hstate *h)
>  	/* list will be empty if hstate_is_gigantic */
>  	prep_and_add_allocated_folios(h, &folio_list);
> =20
> -	if (i < h->max_huge_pages) {
> -		char buf[32];
> -
> -		string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
> -		pr_warn("HugeTLB: allocating %lu of page size %s failed.  Only allocat=
ed %lu hugepages.\n",
> -			h->max_huge_pages, buf, i);
> -		h->max_huge_pages =3D i;
> -	}
> +	hugetlb_hstate_alloc_pages_report(i, h);
>  	kfree(node_alloc_noretry);
>  }
> =20



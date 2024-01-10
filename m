Return-Path: <linux-kernel+bounces-22875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4589A82A4C0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 00:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C404828A987
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1193D4F8A0;
	Wed, 10 Jan 2024 23:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DcNlTTKw"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30994F895
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 23:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704928363; x=1736464363;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=oZto8Uu2fZ3IZ8wqMhOSNCyt5zHeJNO3Al5r6NP7YbE=;
  b=DcNlTTKwQh3YFdRIv80uusMa7WZ57KsGfZ7onR077xHTxa5+brj9bVwp
   KE805N9xpc37C4j/opBqlqt24VulTDhQ6AohzSJI9zNIJjyamxo3pBOyK
   KbMMKJV9NQbayQWnq+kLJ2oOdPZbmGJY3vXmMhy34EbOBq3rQvNEeXD5l
   H1PPpx1jStY2nmtUv9IqUfIajh8vCNbfQgi24chr8XxgPM07GKjP3Fh78
   nqpJ/Hy74ZpDlzHhxiAvXWaZX7HqY0mUTDPUp/nUZ2zfbYVoTgTfrTS9O
   gCP4zB7NFmU0MqnZw17Gs1AjhSq2yAyUHQYmS7Mne7SSy/uBMjxIKI9Jr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="402451307"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="402451307"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 15:12:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="905722185"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="905722185"
Received: from phungng1-mobl.amr.corp.intel.com (HELO [10.255.229.71]) ([10.255.229.71])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 15:12:39 -0800
Message-ID: <9b95c0ac0e5d560f1482af3753df54211a057b9d.camel@linux.intel.com>
Subject: Re: [PATCH v3 2/7] hugetlb: split hugetlb_hstate_alloc_pages
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Gang Li <gang.li@linux.dev>, David Hildenbrand <david@redhat.com>, David
 Rientjes <rientjes@google.com>, Mike Kravetz <mike.kravetz@oracle.com>,
 Muchun Song <muchun.song@linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 ligang.bdlg@bytedance.com
Date: Wed, 10 Jan 2024 15:12:38 -0800
In-Reply-To: <20240102131249.76622-3-gang.li@linux.dev>
References: <20240102131249.76622-1-gang.li@linux.dev>
	 <20240102131249.76622-3-gang.li@linux.dev>
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
> 1G and 2M huge pages have different allocation and initialization logic,
> which leads to subtle differences in parallelization. Therefore, it is
> appropriate to split hugetlb_hstate_alloc_pages into gigantic and
> non-gigantic.
>=20
> This patch has no functional changes.
>=20
> Signed-off-by: Gang Li <gang.li@linux.dev>
> ---
>  mm/hugetlb.c | 86 +++++++++++++++++++++++++++-------------------------
>  1 file changed, 45 insertions(+), 41 deletions(-)
>=20
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 2606135ec55e6..92448e747991d 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3509,6 +3509,47 @@ static void __init hugetlb_hstate_alloc_pages_repo=
rt(unsigned long allocated, st
>  	}
>  }
> =20
> +static unsigned long __init hugetlb_hstate_alloc_pages_gigantic(struct h=
state *h)
> +{
> +	unsigned long i;
> +
> +	for (i =3D 0; i < h->max_huge_pages; ++i) {
> +		/*
> +		 * gigantic pages not added to list as they are not
> +		 * added to pools now.
> +		 */

This comment unnecessary as now we don't have mix gigantic and non-gigantic=
 code,
which uses foilio list.  And folio_list is not in this routine.

Can be removed.

Otherwise Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>

> +		if (!alloc_bootmem_huge_page(h, NUMA_NO_NODE))
> +			break;
> +		cond_resched();
> +	}
> +
> +	return i;
> +}
> +
> +static unsigned long __init hugetlb_hstate_alloc_pages_non_gigantic(stru=
ct hstate *h)
> +{
> +	unsigned long i;
> +	struct folio *folio;
> +	LIST_HEAD(folio_list);
> +	nodemask_t node_alloc_noretry;
> +
> +	/* Bit mask controlling how hard we retry per-node allocations.*/
> +	nodes_clear(node_alloc_noretry);
> +
> +	for (i =3D 0; i < h->max_huge_pages; ++i) {
> +		folio =3D alloc_pool_huge_folio(h, &node_states[N_MEMORY],
> +						&node_alloc_noretry);
> +		if (!folio)
> +			break;
> +		list_add(&folio->lru, &folio_list);
> +		cond_resched();
> +	}
> +
> +	prep_and_add_allocated_folios(h, &folio_list);
> +
> +	return i;
> +}
> +
>  /*
>   * NOTE: this routine is called in different contexts for gigantic and
>   * non-gigantic pages.
> @@ -3522,10 +3563,7 @@ static void __init hugetlb_hstate_alloc_pages_repo=
rt(unsigned long allocated, st
>   */
>  static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
>  {
> -	unsigned long i;
> -	struct folio *folio;
> -	LIST_HEAD(folio_list);
> -	nodemask_t *node_alloc_noretry;
> +	unsigned long allocated;
> =20
>  	/* skip gigantic hugepages allocation if hugetlb_cma enabled */
>  	if (hstate_is_gigantic(h) && hugetlb_cma_size) {
> @@ -3539,46 +3577,12 @@ static void __init hugetlb_hstate_alloc_pages(str=
uct hstate *h)
> =20
>  	/* below will do all node balanced alloc */
>  	if (!hstate_is_gigantic(h)) {
> -		/*
> -		 * Bit mask controlling how hard we retry per-node allocations.
> -		 * Ignore errors as lower level routines can deal with
> -		 * node_alloc_noretry =3D=3D NULL.  If this kmalloc fails at boot
> -		 * time, we are likely in bigger trouble.
> -		 */
> -		node_alloc_noretry =3D kmalloc(sizeof(*node_alloc_noretry),
> -						GFP_KERNEL);
> +		allocated =3D hugetlb_hstate_alloc_pages_non_gigantic(h);
>  	} else {
> -		/* allocations done at boot time */
> -		node_alloc_noretry =3D NULL;
> -	}
> -
> -	/* bit mask controlling how hard we retry per-node allocations */
> -	if (node_alloc_noretry)
> -		nodes_clear(*node_alloc_noretry);
> -
> -	for (i =3D 0; i < h->max_huge_pages; ++i) {
> -		if (hstate_is_gigantic(h)) {
> -			/*
> -			 * gigantic pages not added to list as they are not
> -			 * added to pools now.
> -			 */
> -			if (!alloc_bootmem_huge_page(h, NUMA_NO_NODE))
> -				break;
> -		} else {
> -			folio =3D alloc_pool_huge_folio(h, &node_states[N_MEMORY],
> -							node_alloc_noretry);
> -			if (!folio)
> -				break;
> -			list_add(&folio->lru, &folio_list);
> -		}
> -		cond_resched();
> +		allocated =3D hugetlb_hstate_alloc_pages_gigantic(h);
>  	}
> =20
> -	/* list will be empty if hstate_is_gigantic */
> -	prep_and_add_allocated_folios(h, &folio_list);
> -
> -	hugetlb_hstate_alloc_pages_report(i, h);
> -	kfree(node_alloc_noretry);
> +	hugetlb_hstate_alloc_pages_report(allocated, h);
>  }
> =20
>  static void __init hugetlb_init_hstates(void)



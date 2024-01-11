Return-Path: <linux-kernel+bounces-24107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB2582B70C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A531F262FC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E0558AB9;
	Thu, 11 Jan 2024 22:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j9kOIsSL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34BB58AA6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705011705; x=1736547705;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=7YQEppjXt4a37tD2uey9CD8wKb3oJK9JqmRLmduDhrY=;
  b=j9kOIsSLrOvAkXw6b1DphiBZp7DrF03QjwW06OvHFgoriPGR8ekIo2rs
   8Vpfhb+V3F1SHjQVb8P2xnBeuJVJYBYc/WhNXLDVekRjvqW9p9m4FuXx/
   IHziR99wLVFUUEvNpUG5wihv/o1bx9XiFE4rMZGstTsHwljVciExx0PWc
   930Mr6m6WIJ7dzEkUufRmsOx9zqGkB2lBePQySG/h5mNAVUjFXX95EC7B
   lt2qQDxvFWucCSuVEV/zVV2k798ceYQbtaMDxVnvyvQufpYyi4HRTNTp1
   bonJPLSLfWZMwS6cCFHEqmp0EpNIopxcY/mIiwa/GI0uPbk7AK/z67Ucv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="20481191"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="20481191"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 14:21:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="1029718749"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="1029718749"
Received: from ldrake1-mobl3.amr.corp.intel.com (HELO [10.212.168.169]) ([10.212.168.169])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 14:21:43 -0800
Message-ID: <66af5bce84c9b6480feaa2ddaff199cd5722fcde.camel@linux.intel.com>
Subject: Re: [PATCH v3 4/7] hugetlb: pass *next_nid_to_alloc directly to
 for_each_node_mask_to_alloc
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Gang Li <gang.li@linux.dev>, David Hildenbrand <david@redhat.com>, David
 Rientjes <rientjes@google.com>, Mike Kravetz <mike.kravetz@oracle.com>,
 Muchun Song <muchun.song@linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 ligang.bdlg@bytedance.com
Date: Thu, 11 Jan 2024 14:21:42 -0800
In-Reply-To: <20240102131249.76622-5-gang.li@linux.dev>
References: <20240102131249.76622-1-gang.li@linux.dev>
	 <20240102131249.76622-5-gang.li@linux.dev>
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
> The parallelization of hugetlb allocation leads to errors when sharing
> h->next_nid_to_alloc across different threads. To address this, it's

Suggest you say
With parallelization of hugetlb allocation across different threads,
each thread works on a differnet node to allocate pages from, instead
of all allocating from a common node h->next_nid_to_alloc.  To address this=
, it's

> necessary to assign a separate next_nid_to_alloc for each thread.
>=20
> Consequently, the hstate_next_node_to_alloc and for_each_node_mask_to_all=
oc
> have been modified to directly accept a *next_nid_to_alloc parameter,
> ensuring thread-specific allocation and avoiding concurrent access issues=
.
>=20
> Signed-off-by: Gang Li <gang.li@linux.dev>
> ---
> This patch seems not elegant, but I can't come up with anything better.
> Any suggestions will be highly appreciated!
> ---
>  mm/hugetlb.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>=20
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 92448e747991d..a71bc1622b53b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1464,15 +1464,15 @@ static int get_valid_node_allowed(int nid, nodema=
sk_t *nodes_allowed)
>   * next node from which to allocate, handling wrap at end of node
>   * mask.
>   */
> -static int hstate_next_node_to_alloc(struct hstate *h,
> +static int hstate_next_node_to_alloc(int *next_nid_to_alloc,
>  					nodemask_t *nodes_allowed)
>  {
>  	int nid;
> =20
>  	VM_BUG_ON(!nodes_allowed);
> =20
> -	nid =3D get_valid_node_allowed(h->next_nid_to_alloc, nodes_allowed);
> -	h->next_nid_to_alloc =3D next_node_allowed(nid, nodes_allowed);
> +	nid =3D get_valid_node_allowed(*next_nid_to_alloc, nodes_allowed);
> +	*next_nid_to_alloc =3D next_node_allowed(nid, nodes_allowed);
> =20
>  	return nid;
>  }
> @@ -1495,10 +1495,10 @@ static int hstate_next_node_to_free(struct hstate=
 *h, nodemask_t *nodes_allowed)
>  	return nid;
>  }
> =20
> -#define for_each_node_mask_to_alloc(hs, nr_nodes, node, mask)		\
> +#define for_each_node_mask_to_alloc(next_nid_to_alloc, nr_nodes, node, m=
ask)		\
>  	for (nr_nodes =3D nodes_weight(*mask);				\
>  		nr_nodes > 0 &&						\
> -		((node =3D hstate_next_node_to_alloc(hs, mask)) || 1);	\
> +		((node =3D hstate_next_node_to_alloc(next_nid_to_alloc, mask)) || 1);	=
\
>  		nr_nodes--)
> =20
>  #define for_each_node_mask_to_free(hs, nr_nodes, node, mask)		\
> @@ -2350,12 +2350,13 @@ static void prep_and_add_allocated_folios(struct =
hstate *h,
>   */
>  static struct folio *alloc_pool_huge_folio(struct hstate *h,
>  					nodemask_t *nodes_allowed,
> -					nodemask_t *node_alloc_noretry)
> +					nodemask_t *node_alloc_noretry,
> +					int *next_nid_to_alloc)
>  {
>  	gfp_t gfp_mask =3D htlb_alloc_mask(h) | __GFP_THISNODE;
>  	int nr_nodes, node;
> =20
> -	for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
> +	for_each_node_mask_to_alloc(next_nid_to_alloc, nr_nodes, node, nodes_al=
lowed) {
>  		struct folio *folio;
> =20
>  		folio =3D only_alloc_fresh_hugetlb_folio(h, gfp_mask, node,
> @@ -3310,7 +3311,7 @@ int __alloc_bootmem_huge_page(struct hstate *h, int=
 nid)
>  		goto found;
>  	}
>  	/* allocate from next node when distributing huge pages */
> -	for_each_node_mask_to_alloc(h, nr_nodes, node, &node_states[N_MEMORY]) =
{
> +	for_each_node_mask_to_alloc(&h->next_nid_to_alloc, nr_nodes, node, &nod=
e_states[N_MEMORY]) {
>  		m =3D memblock_alloc_try_nid_raw(
>  				huge_page_size(h), huge_page_size(h),
>  				0, MEMBLOCK_ALLOC_ACCESSIBLE, node);
> @@ -3684,7 +3685,7 @@ static int adjust_pool_surplus(struct hstate *h, no=
demask_t *nodes_allowed,
>  	VM_BUG_ON(delta !=3D -1 && delta !=3D 1);
> =20
>  	if (delta < 0) {
> -		for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
> +		for_each_node_mask_to_alloc(&h->next_nid_to_alloc, nr_nodes, node, nod=
es_allowed) {
>  			if (h->surplus_huge_pages_node[node])
>  				goto found;
>  		}
> @@ -3799,7 +3800,8 @@ static int set_max_huge_pages(struct hstate *h, uns=
igned long count, int nid,
>  		cond_resched();
> =20
>  		folio =3D alloc_pool_huge_folio(h, nodes_allowed,
> -						node_alloc_noretry);
> +						node_alloc_noretry,
> +						&h->next_nid_to_alloc);
>  		if (!folio) {
>  			prep_and_add_allocated_folios(h, &page_list);
>  			spin_lock_irq(&hugetlb_lock);



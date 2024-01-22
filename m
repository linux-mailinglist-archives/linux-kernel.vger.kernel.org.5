Return-Path: <linux-kernel+bounces-32379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BAE835ADC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3501E281D07
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD68163A0;
	Mon, 22 Jan 2024 06:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Cv8EMnSK"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F70610C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 06:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705904210; cv=none; b=FGneIkxqFzpg7GrIQdsrWBIfBmKv79DQuxswSqQ8329X0KlQIFp1+L5UiCdSm3DyK4tibg2aBiIAVbQVMUJ+2+MofsZMvvK2HieBn5dcwlhZdIX58evrQsqvaJVAJwOMzmuXXOfMvnQOoK5tqkVca5dG7+6m8/nTowChY4yesXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705904210; c=relaxed/simple;
	bh=l6asL2N89M7lkNOnDBE2rHIir7CAoLNLt5T1osqgjv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OpzvsrkNbuT88GvOBd7bQkmTMmzyVNJ8Miq8nvzMR/ouiXhuzfGt96pOUA+jQBsPdJyyXSUD4/d1VO7BcHGghYzmodvcD5bMsb1CIRm99i6K5tH5D6vLpMG7WTN8o1jYwwQ2qz+rhfefBSvMl7ZtLgXVFN1JDQO5dUp3KlGcx7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Cv8EMnSK; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f7e072c0-4b41-40d3-bf2e-19d4fdf7bc0d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705904205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Pb80DoRWEyZoi0wqPXsfRRerxvgd/0OhZbYr/fDW1k=;
	b=Cv8EMnSK34A8/z8rlXk13g6F0z8uk3JfdETFL7MOLnZgIcCjw4qv3uKqH8gA3DPi89fLWm
	kz+S8S+k58QCbd8m6mSfsPNA0gxiQDFtMTWT8QOj+34W6OGnudn9vUj0IGAiC0CwMFl+6g
	MQARgoJzjqEMSyHitrjFOE4E0nUVxkk=
Date: Mon, 22 Jan 2024 14:16:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 4/7] hugetlb: pass *next_nid_to_alloc directly to
 for_each_node_mask_to_alloc
To: Gang Li <gang.li@linux.dev>, David Hildenbrand <david@redhat.com>,
 David Rientjes <rientjes@google.com>, Mike Kravetz
 <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 ligang.bdlg@bytedance.com
References: <20240118123911.88833-1-gang.li@linux.dev>
 <20240118123911.88833-5-gang.li@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240118123911.88833-5-gang.li@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/1/18 20:39, Gang Li wrote:
> With parallelization of hugetlb allocation across different threads, each
> thread works on a differnet node to allocate pages from, instead of all
> allocating from a common node h->next_nid_to_alloc.  To address this, it's
> necessary to assign a separate next_nid_to_alloc for each thread.
>
> Consequently, the hstate_next_node_to_alloc and for_each_node_mask_to_alloc
> have been modified to directly accept a *next_nid_to_alloc parameter,
> ensuring thread-specific allocation and avoiding concurrent access issues.
>
> Signed-off-by: Gang Li <gang.li@linux.dev>
> Tested-by: David Rientjes <rientjes@google.com>
> ---
>   mm/hugetlb.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 98ae108e1fac..effe5539e545 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1464,15 +1464,15 @@ static int get_valid_node_allowed(int nid, nodemask_t *nodes_allowed)
>    * next node from which to allocate, handling wrap at end of node
>    * mask.
>    */
> -static int hstate_next_node_to_alloc(struct hstate *h,
> +static int hstate_next_node_to_alloc(int *next_node,
>   					nodemask_t *nodes_allowed)
>   {
>   	int nid;
>   
>   	VM_BUG_ON(!nodes_allowed);
>   
> -	nid = get_valid_node_allowed(h->next_nid_to_alloc, nodes_allowed);
> -	h->next_nid_to_alloc = next_node_allowed(nid, nodes_allowed);
> +	nid = get_valid_node_allowed(*next_node, nodes_allowed);
> +	*next_node = next_node_allowed(nid, nodes_allowed);
>   
>   	return nid;
>   }
> @@ -1495,10 +1495,10 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
>   	return nid;
>   }
>   
> -#define for_each_node_mask_to_alloc(hs, nr_nodes, node, mask)		\
> +#define for_each_node_mask_to_alloc(next_node, nr_nodes, node, mask)		\
>   	for (nr_nodes = nodes_weight(*mask);				\
>   		nr_nodes > 0 &&						\
> -		((node = hstate_next_node_to_alloc(hs, mask)) || 1);	\
> +		((node = hstate_next_node_to_alloc(next_node, mask)) || 1);	\
>   		nr_nodes--)
>   
>   #define for_each_node_mask_to_free(hs, nr_nodes, node, mask)		\
> @@ -2350,12 +2350,13 @@ static void prep_and_add_allocated_folios(struct hstate *h,
>    */
>   static struct folio *alloc_pool_huge_folio(struct hstate *h,
>   					nodemask_t *nodes_allowed,
> -					nodemask_t *node_alloc_noretry)
> +					nodemask_t *node_alloc_noretry,
> +					int *next_node)
>   {
>   	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
>   	int nr_nodes, node;
>   
> -	for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
> +	for_each_node_mask_to_alloc(next_node, nr_nodes, node, nodes_allowed) {


A small question here, why not pass h->next_nid_to_alloc to
for_each_node_mask_to_alloc()? What's the purpose of the third
parameter of alloc_pool_huge_folio()?

Thanks.



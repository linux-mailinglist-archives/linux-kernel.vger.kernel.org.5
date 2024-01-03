Return-Path: <linux-kernel+bounces-15068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EE48226ED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6427284658
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717594A2A;
	Wed,  3 Jan 2024 02:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DkO2N/hL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FE04A13
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 02:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f6f9acea-e40d-49fb-894c-e45613e0a9d7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704248465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fnnzaHHZTJxojy45dlDauVj3BDpS6sAOuvKNoVP4Lz4=;
	b=DkO2N/hLoWlU/Xi0uGUM12Bqfsjd0ear7adaK2Sza8y+ahqXdxnVUJjVrX54d2wk/xfWpP
	lnh7YE+I0W+5aOYcDjssIdoDbFbj7CkXfc+Ng4Irl+zBD004Wu90tcUeSFpJCfI0Joh8d8
	lC8GMUZVxhM/zRDrgHZJa0W6eXWtatc=
Date: Wed, 3 Jan 2024 10:20:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/7] hugetlb: parallelize hugetlb page init on boot
Content-Language: en-US
To: David Rientjes <rientjes@google.com>
Cc: David Hildenbrand <david@redhat.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ligang.bdlg@bytedance.com
References: <20240102131249.76622-1-gang.li@linux.dev>
 <5c30a825-b588-e3a9-83db-f8eef4cb9012@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
In-Reply-To: <5c30a825-b588-e3a9-83db-f8eef4cb9012@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/1/3 09:52, David Rientjes wrote:
> 
> I tested 1GB hugetlb on a smaller AMD host with the following:
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3301,7 +3301,7 @@ int alloc_bootmem_huge_page(struct hstate *h, int nid)
>   int __alloc_bootmem_huge_page(struct hstate *h, int nid)
>   {
>          struct huge_bootmem_page *m = NULL; /* initialize for clang */
> -       int nr_nodes, node;
> +       int nr_nodes, node = nid;
>   
>          /* do node specific alloc */
>          if (nid != NUMA_NO_NODE) {
> 

Oh, if nid != NUMA_NO_NODE and memblock_alloc_try_nid_raw succeed,
`node` must take the value of `nid`.

Otherwise, list_add(&m->list, &huge_boot_pages[node]) will not be
executed correctly.

> After the build error is fixed, feel free to add:
> 
> 	Tested-by: David Rientjes <rientjes@google.com>
> 

Thanks!

> to each patch.  I think Andrew will probably take a build fix up as a
> delta on top of patch 4 rather than sending a whole new series unless
> there is other feedback that you receive.


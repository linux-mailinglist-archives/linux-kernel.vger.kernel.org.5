Return-Path: <linux-kernel+bounces-130222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F8D8975A0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9E51F2977A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30A0152168;
	Wed,  3 Apr 2024 16:52:09 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844B71514F4;
	Wed,  3 Apr 2024 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163129; cv=none; b=J5zi/5NYvR1mQ1KG+Hw7JpLXO4sme9dLW+NSzoDuoG4csMgC3rxHeeyPQSfMhXikFnxwhK+2iRu4W1IQm89u3fD0P04LpeOQw8tNBPskFmK+Wt0BWteiSOEDih2AfbOeaUo5r9/koVB38DsgpLZO9MYXPCdvyXAenE1L9hB1fx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163129; c=relaxed/simple;
	bh=fuwOPTXrOfm1gZklUqEdI1kNxV/jM6pfbA8+sSz01gM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nhiN+D5/fMAIhckWInd0iSxhjls7xMmzl+zJvKmfYskr9M/TBWbiK6GYeC6pOzt1bPSmCZj5BnaKiK/1Y/Cry2tZ7Rn4piJKY9NDFMYzTHB8dm+M+cJwVWcC2GQ0rSQlkO/sIsdboXAHyp2yBE+8k1w562kg+Lc4FOVCf1IwJ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V8rNM5jKhz6D8Yx;
	Thu,  4 Apr 2024 00:50:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C7A0140B67;
	Thu,  4 Apr 2024 00:52:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 3 Apr
 2024 17:52:02 +0100
Date: Wed, 3 Apr 2024 17:52:01 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
CC: "Huang, Ying" <ying.huang@intel.com>, Gregory Price
	<gourry.memverge@gmail.com>, <aneesh.kumar@linux.ibm.com>, <mhocko@suse.com>,
	<tj@kernel.org>, <john@jagalactic.com>, Eishan Mirakhur
	<emirakhur@micron.com>, Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
	Ravis OpenSrc <Ravis.OpenSrc@micron.com>, Alistair Popple
	<apopple@nvidia.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>, SeongJae
 Park <sj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, "Dave Jiang" <dave.jiang@intel.com>, Andrew
 Morton <akpm@linux-foundation.org>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, "Ho-Ren (Jack) Chuang" <horenc@vt.edu>, "Ho-Ren (Jack)
 Chuang" <horenchuang@gmail.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v10 1/2] memory tier: dax/kmem: introduce an abstract
 layer for finding, allocating, and putting memory types
Message-ID: <20240403175201.00000c2c@Huawei.com>
In-Reply-To: <20240402001739.2521623-2-horenchuang@bytedance.com>
References: <20240402001739.2521623-1-horenchuang@bytedance.com>
	<20240402001739.2521623-2-horenchuang@bytedance.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue,  2 Apr 2024 00:17:37 +0000
"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:

> Since different memory devices require finding, allocating, and putting
> memory types, these common steps are abstracted in this patch,
> enhancing the scalability and conciseness of the code.
> 
> Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

Hi,

I know this is a late entry to the discussion but a few comments inline.
(sorry I didn't look earlier!)

All opportunities to improve code complexity and readability as a result
of your factoring out.

Jonathan


> ---
>  drivers/dax/kmem.c           | 20 ++------------------
>  include/linux/memory-tiers.h | 13 +++++++++++++
>  mm/memory-tiers.c            | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 47 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 42ee360cf4e3..01399e5b53b2 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -55,21 +55,10 @@ static LIST_HEAD(kmem_memory_types);
>  
>  static struct memory_dev_type *kmem_find_alloc_memory_type(int adist)
>  {
> -	bool found = false;
>  	struct memory_dev_type *mtype;
>  
>  	mutex_lock(&kmem_memory_type_lock);
could use

	guard(mutex)(&kmem_memory_type_lock);
	return mt_find_alloc_memory_type(adist, &kmem_memory_types);

I'm fine if you ignore this comment though as may be other functions in
here that could take advantage of the cleanup.h stuff in a future patch.

> -	list_for_each_entry(mtype, &kmem_memory_types, list) {
> -		if (mtype->adistance == adist) {
> -			found = true;
> -			break;
> -		}
> -	}
> -	if (!found) {
> -		mtype = alloc_memory_type(adist);
> -		if (!IS_ERR(mtype))
> -			list_add(&mtype->list, &kmem_memory_types);
> -	}
> +	mtype = mt_find_alloc_memory_type(adist, &kmem_memory_types);
>  	mutex_unlock(&kmem_memory_type_lock);
>  
>  	return mtype;
 
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index 69e781900082..a44c03c2ba3a 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -48,6 +48,9 @@ int mt_calc_adistance(int node, int *adist);
>  int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
>  			     const char *source);
>  int mt_perf_to_adistance(struct access_coordinate *perf, int *adist);
> +struct memory_dev_type *mt_find_alloc_memory_type(int adist,
> +							struct list_head *memory_types);

That indent looks unusual.  Align the start of struct with start of int.

> +void mt_put_memory_types(struct list_head *memory_types);
>  #ifdef CONFIG_MIGRATION
>  int next_demotion_node(int node);
>  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
> @@ -136,5 +139,15 @@ static inline int mt_perf_to_adistance(struct access_coordinate *perf, int *adis
>  {
>  	return -EIO;
>  }
> +
> +struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct list_head *memory_types)
> +{
> +	return NULL;
> +}
> +
> +void mt_put_memory_types(struct list_head *memory_types)
> +{
> +
No blank line needed here. 
> +}
>  #endif	/* CONFIG_NUMA */
>  #endif  /* _LINUX_MEMORY_TIERS_H */
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 0537664620e5..974af10cfdd8 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -623,6 +623,38 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype)
>  }
>  EXPORT_SYMBOL_GPL(clear_node_memory_type);
>  
> +struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct list_head *memory_types)

Breaking this out as a separate function provides opportunity to improve it.
Maybe a follow up patch makes sense given it would no longer be a straight
forward code move.  However in my view it would be simple enough to be obvious
even within this patch.

> +{
> +	bool found = false;
> +	struct memory_dev_type *mtype;
> +
> +	list_for_each_entry(mtype, memory_types, list) {
> +		if (mtype->adistance == adist) {
> +			found = true;

Why not return here?
			return mtype;

> +			break;
> +		}
> +	}
> +	if (!found) {

If returning above, no need for found variable - just do this unconditionally.
+ I suggest you flip logic for simpler to follow code flow.
It's more code but I think a bit easier to read as error handling is
out of the main simple flow.

	mtype = alloc_memory_type(adist);
	if (IS_ERR(mtype))
		return mtype;

	list_add(&mtype->list, memory_types);

	return mtype;

> +		mtype = alloc_memory_type(adist);
> +		if (!IS_ERR(mtype))
> +			list_add(&mtype->list, memory_types);
> +	}
> +
> +	return mtype;
> +}
> +EXPORT_SYMBOL_GPL(mt_find_alloc_memory_type);
> +
> +void mt_put_memory_types(struct list_head *memory_types)
> +{
> +	struct memory_dev_type *mtype, *mtn;
> +
> +	list_for_each_entry_safe(mtype, mtn, memory_types, list) {
> +		list_del(&mtype->list);
> +		put_memory_type(mtype);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(mt_put_memory_types);
> +
>  static void dump_hmem_attrs(struct access_coordinate *coord, const char *prefix)
>  {
>  	pr_info(



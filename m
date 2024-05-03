Return-Path: <linux-kernel+bounces-168221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8283E8BB54F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36C51C236DA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92F082D6C;
	Fri,  3 May 2024 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HvRV8KDR"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCFA7EEE1
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714770687; cv=none; b=NcSjbivA08jUbfYhvNd0OQF/juoRQHqK742SGqGeubhs9vq0KlaK06MzCm9YL1XkDCGpY2/h8otIJ5mNY1Afu/eykRFV9jCnwwYm0Z/CY5MrsX1JH5YCukZ4wohIgddSCUr4TUJLJb8B9/HMya9KpVe0xxdpTcrTqojlxOa5pBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714770687; c=relaxed/simple;
	bh=J00LAADDjPb8NBZ3upW2XZR3qoYB/dZ5kE4EHLdL0p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BddcsFb6saVQvFdVJyd6dQu2k3woIHUiHSS73Jp1MKus7heLCsiS0T1hb+lJ44N+GivGVzT2PjKIr5wx2ChQJ1GhOaFwqmbs7actIbNPYXXkSXLh6QcYm8BfQ2IAdXvtqhRuvAS6fUoQgMJGL5uI6Lz9V52bADrPtvuF2Lpx5p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HvRV8KDR; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 3 May 2024 14:11:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714770682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rdXn9sax21XZKKXDAA9jeDaxTMIGpElRCzeux1UVVi8=;
	b=HvRV8KDRmn5xM1M6fSPYZy4sAHS+XgNcct797sVmrm96YD2iJ8aYfc/tqhjyiXKqP9tJeq
	vUBdXYCwnzPtpa9WXMzjAYTaNsMbwUuzDVx2yK6PXQGFxqhOoaW4MM9ML1+Rz3DXLBk2Wt
	QGY+1yNN0jZaP44O0LZPuGqtL45Mcvg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Frank van der Linden <fvdl@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] mm: memcg: merge multiple page_counters into a
 single structure
Message-ID: <vpkrdo4tbighfh3o3lrr4kfwxcauxpqzktthacj5chqkdkwiqc@h2dmudmh43d5>
References: <20240503201835.2969707-1-roman.gushchin@linux.dev>
 <20240503201835.2969707-3-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503201835.2969707-3-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, May 03, 2024 at 01:18:33PM -0700, Roman Gushchin wrote:
[...]
>  enum mem_counter_type {
> +#ifdef CONFIG_MEMCG
>  	MCT_MEMORY,		/* cgroup v1 and v2 */
>  	MCT_SWAP,		/* cgroup v2 only */
>  	MCT_MEMSW = MCT_SWAP,	/* cgroup v1 only */
>  	MCT_KMEM,		/* cgroup v1 only */
>  	MCT_TCPMEM,		/* cgroup v1 only */
> +#endif
> +#ifdef CONFIG_CGROUP_HUGETLB
> +	MCT_HUGETLB_MAX = __MCT_HUGETLB_MAX,
> +#endif
> +	__MCT_NR_ITEMS,
>  };
>  

Thanks for the awesome work. I haven't gone through all the patches yet
but wanted to ask a quick question. In the above enum are you trying to
do a union between memcg and hugetlb? It gave me a big pause to
understand what you are trying to do.


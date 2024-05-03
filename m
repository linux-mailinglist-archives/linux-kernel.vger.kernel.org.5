Return-Path: <linux-kernel+bounces-168234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2028BB57B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A661282FC1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9143950269;
	Fri,  3 May 2024 21:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iguv4xY+"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2AF250F8
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714771115; cv=none; b=eVvdANstNl2Y0ytFqgLnoE8ZSR1rRv+nnyEGGxYjSnBs4jF6nfHnbb/dQLCAIl7bxsV1erW6MibPsjF1gq8mlTiMxYIA/yoQLdGby2XnblloFnFJ+Pwx6Hst7pW72s5B2sKvc6/uM8bAGnxWxe6Z0N533CosXlgjW42akTEKJYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714771115; c=relaxed/simple;
	bh=AXXgXo4rUoTrzp4wanaBPPCJF/Cloe+G7j0+CWUlJ3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uP0nozDYvNbCuhP5zB/AgVWifRd1VlUfC6qjZDgHJlaYwaqkIT134MEnSA9k9yY1iob05LKoxvxWzOo+z2OQ//ZCDrnbVONiAxtyMjg3/Od5BmX1suZdgO+Yt3I1mBjV2k9/5166IWobWOfni/kEEFco+O5J/47Xn/+kV0l12a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iguv4xY+; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 3 May 2024 14:18:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714771112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xT5+RHaV8lJbYffD5b71+c1F6rsgkHI+a5HvXT+KXN4=;
	b=iguv4xY+X9y3LbAHrYmlYQ4CCe81hj+hATMgtNbLvxsXVxOAP0vB+qGk/0iXfHHeMqPCeX
	7BuZMFBeQjl3pqpbfyffdEb/l4j1oCcMeu+u/w531AdW6YdoD+2z6HGyyVyTq3wk9tYGcT
	m04RDqDWguTtVNheBYxTg0W/p2Wq55w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Frank van der Linden <fvdl@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] mm: memcg: merge multiple page_counters into a
 single structure
Message-ID: <ZjVUoxAWGCd1uFXg@P9FQF9L96D>
References: <20240503201835.2969707-1-roman.gushchin@linux.dev>
 <20240503201835.2969707-3-roman.gushchin@linux.dev>
 <vpkrdo4tbighfh3o3lrr4kfwxcauxpqzktthacj5chqkdkwiqc@h2dmudmh43d5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vpkrdo4tbighfh3o3lrr4kfwxcauxpqzktthacj5chqkdkwiqc@h2dmudmh43d5>
X-Migadu-Flow: FLOW_OUT

On Fri, May 03, 2024 at 02:11:17PM -0700, Shakeel Butt wrote:
> On Fri, May 03, 2024 at 01:18:33PM -0700, Roman Gushchin wrote:
> [...]
> >  enum mem_counter_type {
> > +#ifdef CONFIG_MEMCG
> >  	MCT_MEMORY,		/* cgroup v1 and v2 */
> >  	MCT_SWAP,		/* cgroup v2 only */
> >  	MCT_MEMSW = MCT_SWAP,	/* cgroup v1 only */
> >  	MCT_KMEM,		/* cgroup v1 only */
> >  	MCT_TCPMEM,		/* cgroup v1 only */
> > +#endif
> > +#ifdef CONFIG_CGROUP_HUGETLB
> > +	MCT_HUGETLB_MAX = __MCT_HUGETLB_MAX,
> > +#endif
> > +	__MCT_NR_ITEMS,
> >  };
> >  
> 
> Thanks for the awesome work. I haven't gone through all the patches yet
> but wanted to ask a quick question. In the above enum are you trying to
> do a union between memcg and hugetlb? It gave me a big pause to
> understand what you are trying to do.

Yep, sort of. So the page_counter structure supports N independent
counters, where N is sufficient enough for both memcg and hugetlb cases.

MCT_MEMORY, MCT_SWAP etc are used directly in the memcontrol.c code,
while hugetlb code just indexes. MCT_HUGETLB_MAX magic is needed to define
N at the compile time.

Thanks!


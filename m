Return-Path: <linux-kernel+bounces-63730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8CA8533C2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7917128CAF6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D915FB90;
	Tue, 13 Feb 2024 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KYTVHJp3"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFBA5FB81
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836120; cv=none; b=fVl+LLd4Ix9ote2beqTKobNb3VyboCGT16s6YyP8tckhc6AJf295ehdFb0zOIIF1XzvIItfNG+oZ5I9NdWWAUJpcpVIdJmKGeGAf6ouXFNvYKfiYzRxLagQerwuBCxysHJCplGzG8V0LXPXFxpNO4uyYiEdsdeVuSxeJHE5ryW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836120; c=relaxed/simple;
	bh=pbQ9YJSw5E0+ttHRSXOOHeePYtcyL9fOOfJ+pMzPZjw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=q9sfuDGrmzM+QjQLsP2apgLMlPpTLPtcRCvcuo5ifXX1uGEG/yQC5eEatNFvRZySBZOxNw7miISO5MjfCKgy9UU236KYD4FonuoqQCo6++yx2bLrm6nmSSCLuDkaIP9vIJ8UMwMjj3UyJE5LvZHzbVjsxE8KCRHj/2+cejOq3rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KYTVHJp3; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707836115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=odYQg0X9p03RWw1VAUk5+w53bWUrUJQlPaSag6Pv+fw=;
	b=KYTVHJp3bZ4HyXSa9gVUA7hxufisU/fPUeL6G7jUuLNTFkA3o2EphAGK6sIdAS3pHd1Lcl
	D8+S9dbL//Ecx9d2IEUQN2TwTFketNEQ1ZSC46SW7H0oCvZdkaeICRdoYwZtJLsUPfay7y
	E3sVn7QZdsvgvCcd3ijFrW1zjH8362s=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v1 2/2] hugetlb: process multiple lists in
 gather_bootmem_prealloc_parallel
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240213111347.3189206-3-gang.li@linux.dev>
Date: Tue, 13 Feb 2024 22:54:40 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 Jane Chu <jane.chu@oracle.com>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 kernel test robot <lkp@intel.com>,
 Gang Li <ligang.bdlg@bytedance.com>,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: 7bit
Message-Id: <1B2A09F0-8F2B-426A-9D1D-6A39C3A6CF64@linux.dev>
References: <20240213111347.3189206-1-gang.li@linux.dev>
 <20240213111347.3189206-3-gang.li@linux.dev>
To: Gang Li <gang.li@linux.dev>
X-Migadu-Flow: FLOW_OUT



> On Feb 13, 2024, at 19:13, Gang Li <gang.li@linux.dev> wrote:
> 
> gather_bootmem_prealloc_node currently only process one list in
> huge_boot_pages array. So gather_bootmem_prealloc expects
> padata_do_multithreaded to run num_node_state(N_MEMORY) instances of
> gather_bootmem_prealloc_node to process all lists in huge_boot_pages.
> 
> This works well in current padata_do_multithreaded implementation.
> It guarantees that size/min_chunk <= thread num <= max_threads.
> 
> ```
> /* Ensure at least one thread when size < min_chunk. */
> nworks = max(job->size / max(job->min_chunk, job->align), 1ul);
> nworks = min(nworks, job->max_threads);
> 
> ps.nworks      = padata_work_alloc_mt(nworks, &ps, &works);
> ```
> 
> However, the comment of padata_do_multithreaded API only promises a
> maximum value for the number of threads and does not specify a
> minimum value. Which may pass multiple nodes to
> gather_bootmem_prealloc_node and only one node will be processed.
> 
> To avoid potential errors, introduce gather_bootmem_prealloc_parallel
> to handle the case where the number of threads does not meet the
> requirement of max_threads.
> 
> Fixes: 0306f03dcbd7 ("hugetlb: parallelize 1G hugetlb initialization")
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.



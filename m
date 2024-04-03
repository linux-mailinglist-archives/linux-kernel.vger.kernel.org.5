Return-Path: <linux-kernel+bounces-130241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E568975D8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C981C2758F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE45152513;
	Wed,  3 Apr 2024 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hZoh+pO+"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537BD1514DB
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 17:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163781; cv=none; b=gTWFnCgDlco5b/3UHRW5LIPltTtmOkVtkG5DUsW4aU9tk1f3riss5BT0SGzJ5iKJiIHYam8Nyx8pG2sC+sts/6HZDy6LmW4bJTEpuMpPFVVIvqeUpxtbO8mNH2+xqn7ZnDxMYEbBONoTbgQBxOeIFhBnXNUrlUmrQ1dVU1wXuvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163781; c=relaxed/simple;
	bh=uy0uR4KNWQjTyhStmbFe7CExzINwuvct04FOVMIe8G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FY3BTaiaZtMytRGWDDzOuZoS2peiClREhjgOV67zFXVBkW2U0uryPHezxKuKgaVwpyPHOO3HlxnRtfBJqUMVkvypxL9Bmw9ScADJohM0lnLOqeS6wtBKJixe+rd04sGcXfw7bsU5wQXiY3s2sfykDMnt9KRsBFsqcxU+maGDNh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hZoh+pO+; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 3 Apr 2024 10:02:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712163777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l2xgd3X9t4EgBaNAFDJVjvxOH1jxFC0KojtDFbkugeQ=;
	b=hZoh+pO+l0APIgPQISDmnLTHEmqpxabM1zSle/bXSt0Rv0Hu5Vb48tN7QWGsBv2nWTDfZB
	PfmejjrzTBt5G7M7FpBZ7m1h684jEvO4ylLhoT46tLRwJrbcun1U5Bi2j0KgR41qRLra/o
	k172DDMShT0o2CtvIZmeFyo3MVW6cyk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Aishwarya TCV <aishwarya.tcv@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, Kees Cook <kees@kernel.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] mm, slab: move memcg charging to post-alloc hook
Message-ID: <Zg2LsNm6twOmG69l@P9FQF9L96D.corp.robot.car>
References: <20240325-slab-memcg-v2-0-900a458233a6@suse.cz>
 <20240325-slab-memcg-v2-1-900a458233a6@suse.cz>
 <30df7730-1b37-420d-b661-e5316679246f@arm.com>
 <4af50be2-4109-45e5-8a36-2136252a635e@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4af50be2-4109-45e5-8a36-2136252a635e@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 03, 2024 at 05:48:24PM +0200, Vlastimil Babka wrote:
> On 4/3/24 1:39 PM, Aishwarya TCV wrote:
> > 
> > 
> > On 25/03/2024 08:20, Vlastimil Babka wrote:
> >> The MEMCG_KMEM integration with slab currently relies on two hooks
> >> during allocation. memcg_slab_pre_alloc_hook() determines the objcg and
> >> charges it, and memcg_slab_post_alloc_hook() assigns the objcg pointer
> >> to the allocated object(s).
> >> 
> >> As Linus pointed out, this is unnecessarily complex. Failing to charge
> >> due to memcg limits should be rare, so we can optimistically allocate
> >> the object(s) and do the charging together with assigning the objcg
> >> pointer in a single post_alloc hook. In the rare case the charging
> >> fails, we can free the object(s) back.
> >> 
> >> This simplifies the code (no need to pass around the objcg pointer) and
> >> potentially allows to separate charging from allocation in cases where
> >> it's common that the allocation would be immediately freed, and the
> >> memcg handling overhead could be saved.
> >> 
> >> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> >> Link: https://lore.kernel.org/all/CAHk-=whYOOdM7jWy5jdrAm8LxcgCMFyk2bt8fYYvZzM4U-zAQA@mail.gmail.com/
> >> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> >> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> ---
> >>  mm/slub.c | 180 +++++++++++++++++++++++++++-----------------------------------
> >>  1 file changed, 77 insertions(+), 103 deletions(-)
> > 
> > Hi Vlastimil,
> > 
> > When running the LTP test "memcg_limit_in_bytes" against next-master
> > (next-20240402) kernel with Arm64 on JUNO, oops is observed in our CI. I
> > can send the full logs if required. It is observed to work fine on
> > softiron-overdrive-3000.
> > 
> > A bisect identified 11bb2d9d91627935c63ea3e6a031fd238c846e1 as the first
> > bad commit. Bisected it on the tag "next-20240402" at repo
> > "https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git".
> > 
> > This works fine on  Linux version v6.9-rc2
> 
> Oops, sorry, can you verify that this fixes it?
> Thanks.
> 
> ----8<----
> From b0597c220624fef4f10e26079a3ff1c86f02a12b Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Wed, 3 Apr 2024 17:45:15 +0200
> Subject: [PATCH] fixup! mm, slab: move memcg charging to post-alloc hook
> 
> The call to memcg_alloc_abort_single() is wrong, it expects a pointer to
> single object, not an array.
> 
> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Oh, indeed.
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Vlastimil, here is another small comments fixup for the same original patch:

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0745a28782de..9bd0ffd4c547 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -353,7 +353,7 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,

 /*
  * A lot of the calls to the cache allocation functions are expected to be
- * inlined by the compiler. Since the calls to memcg_slab_pre_alloc_hook() are
+ * inlined by the compiler. Since the calls to memcg_slab_post_alloc_hook() are
  * conditional to this static branch, we'll have to allow modules that does
  * kmem_cache_alloc and the such to see this symbol as well
  */



Thanks!


Return-Path: <linux-kernel+bounces-77745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF138609A3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0481F21075
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF65A12B74;
	Fri, 23 Feb 2024 03:50:28 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568B028EB
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 03:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708660228; cv=none; b=fdIr2j1klmk3xKNzzZFWApkurUuat1DbJUcklI3VatAbocSbRWothNc2FYlW+CGQn9RrXC+7G79okKI7dgEUXUP6/vb0T5tsBcP1S+w694/rF8QBBgrogOvmsCB3dvGrlRv6nyAI6HjEzN6wkq6/51LJWP/RvDkAgU41KDSEa9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708660228; c=relaxed/simple;
	bh=Wz1ij4XE+Xal/OvaUhVrrc7xORw9ZjD0Q9G2kN4OgxM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KR08B3evym+ZZqgLwOWdfp/FnvMgBqj6tzmZSKHHSLEEt06UAtlIRPwjwfn/0QMbYzUc4IkyD/CLNSKEhQsZ6YWAEEC+1mo5Dyq7wQv8WnaAwge58yqy+M7btxgix+vtH2Ftq02edUzP3UqSQ9T0lkREBA/1DfY9szOjE+eik5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id 897B040AA8; Thu, 22 Feb 2024 19:50:24 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 88A1840788;
	Thu, 22 Feb 2024 19:50:24 -0800 (PST)
Date: Thu, 22 Feb 2024 19:50:24 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Chengming Zhou <chengming.zhou@linux.dev>
cc: Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>, 
    Jianfeng Wang <jianfeng.w.wang@oracle.com>, penberg@kernel.org, 
    iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, 
    roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH] slub: avoid scanning all partial slabs in
 get_slabinfo()
In-Reply-To: <e924c39b-7636-4c34-bfe9-603cf07c21d3@linux.dev>
Message-ID: <b8f393fb-2b1d-213c-9301-35d4ffca1f50@linux.com>
References: <20240215211457.32172-1-jianfeng.w.wang@oracle.com> <6b58d81f-8e8f-3732-a5d4-40eece75013b@google.com> <fee76a21-fbc5-4ad8-b4bf-ba8a8e7cee8f@suse.cz> <55ccc92a-79fa-42d2-97d8-b514cf00823b@linux.dev> <6daf88a2-84c2-5ba4-853c-c38cca4a03cb@linux.com>
 <e924c39b-7636-4c34-bfe9-603cf07c21d3@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 23 Feb 2024, Chengming Zhou wrote:

>> Can we guestimate the free objects based on the number of partial slabs. That number is available.
>
> Yeah, the number of partial slabs is easy to know, but I can't think of a way to
> estimate the free objects, since __slab_free() is just double cmpxchg in most cases.

Well a starting point may be half the objects possible in a slab page?


>> How accurate need the accounting be? We also have fuzzy accounting in the VM counters.
>
> Maybe not need to be very accurate, some delay/fuzzy should be acceptable.
>
> Another direction I think is that we don't distinguish slabs on cpu partial list or
> slabs on node partial list anymore (different with current behavior).
>
> Now we have three scopes:
> 1. SL_ALL: include all slabs
> 2. SL_PARTIAL: only include partial slabs on node
> 3. SL_CPU: only include partail slabs on cpu and the using cpu slab
>
> If we change SL_PARTIAL to mean all partial slabs, it maybe simpler.

Thats not going to work since you would have to scan multiple lists 
instead of a single list.

Another approach may be to come up with some way to scan the partial lists 
without taking locks. That actually would improve the performance of the 
allocator. It may work with a single linked lists and RCU.



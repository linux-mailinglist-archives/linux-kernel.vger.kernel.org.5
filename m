Return-Path: <linux-kernel+bounces-103918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD5D87C68F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345311F21BBE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BEE11C85;
	Thu, 14 Mar 2024 23:45:09 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68A91079D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 23:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710459909; cv=none; b=YhvrmaT7KNcwuXLj+8eUAKBNgwwU+qcv2LmN/Bl5xUQYFrt/RZjdMS4S4OhJktNm48a1D0sDT3dGL6/Vlhb1zJYFS6voGTXfQeNHDSKMAXhfBPNoDt1z6mTJgsPV3mKqgZr3jHFH6+wd8WbKkUHGgFxS+0gN0jDPZTOcbkrYGus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710459909; c=relaxed/simple;
	bh=y6IxvqeK/kUaQYRto7LRl/agj/gFzMwPTYAanWQEbVM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=C7RW3J3nVcLDB68CJOlwuARMqXtqliGvwSoYit+K5gPjctLYoLRbQWjWlSuuFt1BF7sRmInQdHInAnEqM+Da8mUUruRy3cqCITwY+toSxmljjU9R3+es1tJhIKbtq5YBAuum+CGu0NBEmWEoxLfpc3RlH/kuUqD7tn8G8dixeXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id B71BC40AB2; Thu, 14 Mar 2024 16:45:04 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id B4C8340A8D;
	Thu, 14 Mar 2024 16:45:04 -0700 (PDT)
Date: Thu, 14 Mar 2024 16:45:04 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Jianfeng Wang <jianfeng.w.wang@oracle.com>
cc: Vlastimil Babka <vbabka@suse.cz>, 
    Chengming Zhou <chengming.zhou@linux.dev>, 
    David Rientjes <rientjes@google.com>, penberg@kernel.org, 
    iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, 
    roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slub: avoid scanning all partial slabs in
 get_slabinfo()
In-Reply-To: <9578474c-2e46-4d3e-9a2f-1eaeb9bfabbc@oracle.com>
Message-ID: <1e01092b-140d-2bab-aeba-321a74a194ee@linux.com>
References: <20240215211457.32172-1-jianfeng.w.wang@oracle.com> <6b58d81f-8e8f-3732-a5d4-40eece75013b@google.com> <fee76a21-fbc5-4ad8-b4bf-ba8a8e7cee8f@suse.cz> <55ccc92a-79fa-42d2-97d8-b514cf00823b@linux.dev> <6daf88a2-84c2-5ba4-853c-c38cca4a03cb@linux.com>
 <e924c39b-7636-4c34-bfe9-603cf07c21d3@linux.dev> <b8f393fb-2b1d-213c-9301-35d4ffca1f50@linux.com> <347b870e-a7d5-45df-84ba-4eee37b74ff6@linux.dev> <1a952209-fa22-4439-af27-bf102c7d742b@suse.cz> <cce26aef-ab3e-447b-8b33-5ecd78bf747d@linux.dev>
 <2744dd57-e76e-4d80-851a-02898f87f9be@suse.cz> <036f2bb4-b086-2988-e46d-86d399405687@linux.com> <eec445a6-7024-40b6-9d4e-7fc2bc71cce7@linux.dev> <1eeb84d4-42b1-d204-ece1-b76bfbc548bf@linux.com> <0aa3ce20-438f-49fb-8f04-4fc1dbf49728@linux.dev>
 <9578474c-2e46-4d3e-9a2f-1eaeb9bfabbc@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 13 Mar 2024, Jianfeng Wang wrote:

> I am not sure that the RCU change will solve the lockup problem.
> The reason is that iterating a super long list of partial slabs is a problem by itself, e.g., on a
> non-preemptive kernel, then count_partial() can be stuck in the loop for a while, which can cause problems.
>
> Also, even if we check the list ownership for slabs, we may spend too much time in the loop if no updater shows up,
> or fail and re-do many times the loop if several updates happen. The latter can exacerbate this lockup issue. So,
> in the end, reading /proc/slabinfo can take a super long time just for a counter that may be changing all the time.

Well we could also cache the values somehow to avoid the scans? invalidate 
the counter if something significant happens.


> Thus, I prefer the "guesstimate" approach, even if the number is inaccurate or biased. Let me know if this makes sense.

Come up with a patch and then lets see how well it works.



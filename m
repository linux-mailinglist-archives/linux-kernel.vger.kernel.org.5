Return-Path: <linux-kernel+bounces-72176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF8485B078
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72691F227F5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E58224CB;
	Tue, 20 Feb 2024 01:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yiMVc/cc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E46022307
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 01:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708392092; cv=none; b=gcUlZ3WdoSwfVuecqLS0KwpT6ngSNh0V5sOJj7O5tTsQNyHf2KJUOiHevYWUpNNnNKVNhErwUD2HoXR6ZJlHiVnMkOd8tHjwhAGNOOX/5AiX/5xO6R9cnPasGJRU7YJazcEkw4vj2cOPP78a1icBQfqdtTvrbspIqjbjr7lAM7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708392092; c=relaxed/simple;
	bh=f+LPJ3IkItGv4h0sbqHYTpkIh+AiELeDo8BUNQvdob8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=edfQjisWbXKvP7nMp2SRnOTkYaJZ/jrV8dMNHGLy1nKrJOqqcvpTGixbdGK5h9oRj2GS0p8IBA9NDGKKQO58ax9qR3BbKyxu5Sa5rRyVncxzL1Inxz5/q5puOgJmS1j8eSYe2Bx+g3e2vKdXHAP+zQT7oftthreMQBxgjVRGx/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yiMVc/cc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2ACC433F1;
	Tue, 20 Feb 2024 01:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708392092;
	bh=f+LPJ3IkItGv4h0sbqHYTpkIh+AiELeDo8BUNQvdob8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yiMVc/ccH+/PxpbGZa9TzNl1kxMg8K43yII2wPHR+9K2AWtRnvhstQJn0yX/5Yz3T
	 h/E//Lh7iS0xDFPR7d8WppgRE6jHyAIpCa5KbWFmrUjLpQk+N8eZQE4jBRFB5XSkVM
	 zVwX9+yzepIwDqIoeeqiHR4M6ZWgAj+stTYsQG+Y=
Date: Mon, 19 Feb 2024 17:21:30 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Donet Tom <donettom@linux.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Aneesh Kumar
 <aneesh.kumar@kernel.org>, Huang Ying <ying.huang@intel.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Mel Gorman <mgorman@suse.de>, Ben Widawsky
 <ben.widawsky@intel.com>, Feng Tang <feng.tang@intel.com>, Michal Hocko
 <mhocko@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Rik van Riel
 <riel@surriel.com>, Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox
 <willy@infradead.org>, Mike Kravetz <mike.kravetz@oracle.com>, Vlastimil
 Babka <vbabka@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Hugh
 Dickins <hughd@google.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Suren
 Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 1/3] mm/mempolicy: Use the already fetched local
 variable
Message-Id: <20240219172130.82a16c1ebecbf8ba86a8987d@linux-foundation.org>
In-Reply-To: <63a0f7c4-3c3f-4097-9a24-d1e3fc7b6030@linux.ibm.com>
References: <9c3f7b743477560d1c5b12b8c111a584a2cc92ee.1708097962.git.donettom@linux.ibm.com>
	<20240218133851.22c22b55460e866a099be5ce@linux-foundation.org>
	<63a0f7c4-3c3f-4097-9a24-d1e3fc7b6030@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 14:04:23 +0530 Donet Tom <donettom@linux.ibm.com> wrote:

> >> --- a/mm/mempolicy.c
> >> +++ b/mm/mempolicy.c
> >> @@ -2526,7 +2526,7 @@ int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
> >>   		if (node_isset(curnid, pol->nodes))
> >>   			goto out;
> >>   		z = first_zones_zonelist(
> >> -				node_zonelist(numa_node_id(), GFP_HIGHUSER),
> >> +				node_zonelist(thisnid, GFP_HIGHUSER),
> >>   				gfp_zone(GFP_HIGHUSER),
> >>   				&pol->nodes);
> >>   		polnid = zone_to_nid(z->zone);
> > 	int thisnid = cpu_to_node(thiscpu);
> >
> > Is there any dofference between numa_node_id() and
> > cpu_to_node(raw_smp_processor_id())?  And it it explicable that we're
> > using one here and not the other?
> 
> Hi Andrew
> 
> Both numa_node_id() and cpu_to_node(raw_smp_processor_id()) return the current execution node id,
> Since the current execution node is already fetched at the beginning (thisnid) we can reuse it instead of getting it again.

Sure, but mine was a broader thought: why do we have both?  Is one
preferable and if so why?


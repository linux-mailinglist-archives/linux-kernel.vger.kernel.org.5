Return-Path: <linux-kernel+bounces-71529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BA385A6B7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CFF728399E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361A937714;
	Mon, 19 Feb 2024 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AuWLj+ph"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AAF1DDD5
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354862; cv=none; b=F186nXt5Rr9ldzCtyHd9MxhMytggZyN9Cd0yLVCoIL/2fAWCCqDy6P4eYw2k455/pcF/1XWZVVFmlLLBdKh7EMZ703CIf1ugeFdGuNFmpGzhdMVJh+ypsajUilT+jOzCCpuVzvq/lyXAKXXY1S17lO9FYoh9x+fuIu+VCTvkDuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354862; c=relaxed/simple;
	bh=AYEyjEkHwol4fFgLkvEh9A00aPKw67Bae3yjLrAwXXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmU8nTyHftrry1er985CyjXsMEcYx5/bg5W8KLi6tupyAIQAil/1c5H6VMXJj9NJalyOrRC9CGdnMl+RhVrJmL/Iy+OVQ9onRCJZm4PGxd05Y25vV1viAE6ribMGJJ1VA2300ZWOBIIiMsvetOTRIlLjzVGO52MdSm8jh1mvt7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AuWLj+ph; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708354859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q5dBDj1kDlmWCbGoSjQ1BBTQ4aeYU8rqDaj67mpl6Gs=;
	b=AuWLj+phrIW0C9uvBC9kKInP5tssrbtsz8Y2UBwBCbfJLkG2/wcGyLBMe86pK+uOZAyhGD
	2vwpuxL7mkgEOvmmim/1Ncg/WU31o/JZvlTLenhTzBIIrM+1WQLBlSmx0V2jIYQZA6UDOA
	bzNQwiwLwY/QEoC7ED5w+HJzXcULVd8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-ThxWcfgWNUGCd941DoO2fQ-1; Mon, 19 Feb 2024 10:00:55 -0500
X-MC-Unique: ThxWcfgWNUGCd941DoO2fQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C4BA886461;
	Mon, 19 Feb 2024 15:00:54 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.39.195.107])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 68EB524E4;
	Mon, 19 Feb 2024 15:00:47 +0000 (UTC)
Date: Mon, 19 Feb 2024 10:00:43 -0500
From: Phil Auld <pauld@redhat.com>
To: Byungchul Park <byungchul@sk.com>
Cc: Oscar Salvador <osalvador@suse.de>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org
Subject: Re: [PATCH v3] sched/numa, mm: do not promote folios to nodes not
 set N_MEMORY
Message-ID: <20240219150043.GA184804@lorien.usersys.redhat.com>
References: <20240216114045.24828-1-byungchul@sk.com>
 <Zc9oXOwGMGGE4bBh@localhost.localdomain>
 <20240219020854.GA65758@system.software.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219020854.GA65758@system.software.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Mon, Feb 19, 2024 at 11:08:54AM +0900 Byungchul Park wrote:
> On Fri, Feb 16, 2024 at 02:51:24PM +0100, Oscar Salvador wrote:
> > On Fri, Feb 16, 2024 at 08:40:45PM +0900, Byungchul Park wrote:
> > > From 150af2f78e19217a1d03e47e3ee5279684590fb4 Mon Sep 17 00:00:00 2001
> > > From: Byungchul Park <byungchul@sk.com>
> > > Date: Fri, 16 Feb 2024 20:18:10 +0900
> > > Subject: [PATCH v3] sched/numa, mm: do not promote folios to nodes not set N_MEMORY
> > 
> > "do not try to promote folios to memoryless nodes"
> 
> Thank you. I will.
> 
> > because AFAICS we are just trying.
> > Even if should_numa_migrate_memory() returns true, I assume that we will
> > fail somewhere down the chain e.g: migrate_pages() when we see that this
> > node does not any memory, right?
> 
> Yes.
> 
> > > A numa node might not have its local memory but CPUs. Promoting a folio
> > > to the node's local memory is nonsense. So avoid nodes not set N_MEMORY
> > > from getting promoted.
> > 
> > If you talk about memoryless nodes everybody gets it better IMHO.
> > "Memoryless nodes do not have any memory to migrate to, so stop trying it."
> 
> Much better.
> 
> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > ---
> > >  kernel/sched/fair.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index d7a3c63a2171..7ed9ef3c0134 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -1828,6 +1828,13 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
> > >  	int dst_nid = cpu_to_node(dst_cpu);
> > >  	int last_cpupid, this_cpupid;
> > >  
> > > +	/*
> > > +	 * A node of dst_nid might not have its local memory. Promoting
> > > +	 * a folio to the node is meaningless.
> > > +	 */
> > > +	if (!node_state(dst_nid, N_MEMORY))
> > > +		return false;
> > 
> > "Cannot migrate to memoryless nodes"
> > 
> > seems shorter and more clear.
> 
> Agree.
>

We clearly have dst_cpu when we call this so I still think a
check could be done farther up. But this one still looks reasonable
to me.

Thanks,
Phil


Reviewed-by: Phil Auld <pauld@redhat.com>


> 	Byungchul
> 
> > So, what happens when we return true here? will we fail at
> > migrate_pages() I guess? That is quite down the road so I guess
> > this check can save us some time.
> > 
> > 
> > -- 
> > Oscar Salvador
> > SUSE Labs
> 

-- 



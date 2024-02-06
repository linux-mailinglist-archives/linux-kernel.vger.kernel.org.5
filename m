Return-Path: <linux-kernel+bounces-54112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F6484AAF6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C4A1C236F4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E931D15A7;
	Tue,  6 Feb 2024 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qOsAQHWA"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B8D1362
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 00:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707178235; cv=none; b=QQ908hflrd6/arLqJJNuY98BHT9nUBR/+j3QpAsBpAMartku8FWGHayAXImZDQYOSbs+cHyHS3BqMv0x3iecbJW+NidbldvxL0N0tsDAOMrAJub1TX4ECdIsh8r5YUcwrBI+vWOF7rG+/sglgrWIivip2IrwDKIX0+ukVAKKWPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707178235; c=relaxed/simple;
	bh=mY3kM4wkEcCfDb8VcAjk8TVVa8cwcy1QsEtwBHhbYzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUZdI4tSnv5RGEbUn9C1yQ03uYqOUsbG2+svvVrQGvMml3Ca77GDzjlzFcGU/vLqxKAC/5m+QHIQaK2xPkINM8lTSoINTLFc43AD/j3eZnctU/jd/uDCF0XAkA+1pW1pYxObrWDNaEdvM7vwNHJO/a17b1cgWf21nDhHRWG92OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qOsAQHWA; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 5 Feb 2024 19:10:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707178230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DGtsKhqTTNpaIDjq1vKDcZl0fR89t64g8nFeZ7iH1Uo=;
	b=qOsAQHWA4L0Bjk0srxhctSJinauhHQq3yXq31wFyts011eQd0XotTcMs9/2pJAELDGFVlO
	+gvRWbGsZu901GPSYhTcIDa5qwfyhacsCN/Zd3tpbmvAsrYykcild9nfaX16ERyxHORLbI
	U4OWXlFzMf1Kl6MpbbiZnik839L+nKw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Use alloc_ordered_workqueue() to create
 ordered workqueues
Message-ID: <kksa5w6lgxu66h223quzkw33523zgoltqvl74lmthb4aaj7iat@rss6cnpn3t2p>
References: <ZcF2JaEuwMdg9kYi@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcF2JaEuwMdg9kYi@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 05, 2024 at 01:58:29PM -1000, Tejun Heo wrote:
> BACKGROUND
> ==========
> 
> When multiple work items are queued to a workqueue, their execution order
> doesn't match the queueing order. They may get executed in any order and
> simultaneously. When fully serialized execution - one by one in the queueing
> order - is needed, an ordered workqueue should be used which can be created
> with alloc_ordered_workqueue().
> 
> However, alloc_ordered_workqueue() was a later addition. Before it, an
> ordered workqueue could be obtained by creating an UNBOUND workqueue with
> @max_active==1. This originally was an implementation side-effect which was
> broken by 4c16bd327c74 ("workqueue: restore WQ_UNBOUND/max_active==1 to be
> ordered"). Because there were users that depended on the ordered execution,
> 5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
> made workqueue allocation path to implicitly promote UNBOUND workqueues w/
> @max_active==1 to ordered workqueues.
> 
> While this has worked okay, overloading the UNBOUND allocation interface
> this way creates other issues. It's difficult to tell whether a given
> workqueue actually needs to be ordered and users that legitimately want a
> min concurrency level wq unexpectedly gets an ordered one instead. With
> planned UNBOUND workqueue updates to improve execution locality and more
> prevalence of chiplet designs which can benefit from such improvements, this
> isn't a state we wanna be in forever.
> 
> This patch series audits all callsites that create an UNBOUND workqueue w/
> @max_active==1 and converts them to alloc_ordered_workqueue() as necessary.
> 
> WHAT TO LOOK FOR
> ================
> 
> The conversions are from
> 
>   alloc_workqueue(WQ_UNBOUND | flags, 1, args..)
> 
> to 
> 
>   alloc_ordered_workqueue(flags, args...)
> 
> which don't cause any functional changes. If you know that fully ordered
> execution is not ncessary, please let me know. I'll drop the conversion and
> instead add a comment noting the fact to reduce confusion while conversion
> is in progress.
> 
> If you aren't fully sure, it's completely fine to let the conversion
> through. The behavior will stay exactly the same and we can always
> reconsider later.
> 
> As there are follow-up workqueue core changes, I'd really appreciate if the
> patch can be routed through the workqueue tree w/ your acks. Thanks.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Brian Foster <bfoster@redhat.com>
> ---
>  fs/bcachefs/btree_update_interior.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/fs/bcachefs/btree_update_interior.c
> +++ b/fs/bcachefs/btree_update_interior.c
> @@ -2484,7 +2484,7 @@ void bch2_fs_btree_interior_update_init_
>  int bch2_fs_btree_interior_update_init(struct bch_fs *c)
>  {
>  	c->btree_interior_update_worker =
> -		alloc_workqueue("btree_update", WQ_UNBOUND|WQ_MEM_RECLAIM, 1);
> +		alloc_ordered_workqueue("btree_update", WQ_MEM_RECLAIM);
>  	if (!c->btree_interior_update_worker)
>  		return -BCH_ERR_ENOMEM_btree_interior_update_worker_init;
>  

This one doesn't actually need to be ordered - if anything, we might
want to bump up max_active.

Tejun, can you drop this patch? If you're trying to get rid of all
WQ_UNBOUND with max_active=1 workqueues for your own auditing, either
you or I could change that to 8.


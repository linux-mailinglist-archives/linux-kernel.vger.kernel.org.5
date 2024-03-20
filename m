Return-Path: <linux-kernel+bounces-108925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D33F881202
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5F271F247DC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AB840850;
	Wed, 20 Mar 2024 13:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R9snuk0E"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8A34084A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 13:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710939678; cv=none; b=TxHEY601zP/jhaSlQOVY4b1CeWtS+65nxkVexp4qT/neNjA7BsgEWIE1Dt67sToNQgDaSzP/9C2EyWAcdSSiRBFW87uXOwGhMq1SJGqiZNttl82ZKZWiqrEVslolr+cz+YDKckQR6m1KG6oe3XewDk6mRnw4dGcweNG03WzU5U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710939678; c=relaxed/simple;
	bh=BO+73+xIJDj6fO5JS9nxVFoht09VhXIE75p+8aYFASU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hu7zzTG4tFoD5MweoXw2TPkV2H9EaFngWct58XOwb5c2kI0YFELRthUs1SJLe1IqmSPEnqUYQusoMn7AJjXsduAvSsg4uNxus3iMKtc5iY9+l9Axk1dImLOqDkMvIft9p36zIAPr7BR+LBYcaZ1BpiiQztuekk6hBIWS+MfNK2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R9snuk0E; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Pcs/qG/ocyE/tlTca8TkKVXl8mnst2CUx2O+igwbRzI=; b=R9snuk0E2vaBgnxz7miYmX5FOe
	8ho70rGWZUDLIOHgErUJpawK6NtkPaaw4znVkvXxj6cDVa3pF/DwsCri3aJYW5Ee5n8EYVCHCefr+
	RmPRR+IyMC201dc5hTT2Dt3G9tqR9JYRYKhBAMlpSRF6t6PBhA8HKNq/gDwpah8BJr1rsmT6494gz
	z0jUceKAtpTjyc20uph3JoYD5fywmMPqzUvM9SyznO1D0YxeSyokls6eq4dyttX89qcBnJu9VmFWj
	1yMRM0z4xcjt8xtThjTKxcPczW0Bj7aZ1mCb9GzwSEzEWyiqMZlYCXNu2ywwjuB7dT1e2GXdhkW/Q
	qa38H1OA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmvYw-00000004L7b-24U0;
	Wed, 20 Mar 2024 13:00:58 +0000
Date: Wed, 20 Mar 2024 13:00:58 +0000
From: Matthew Wilcox <willy@infradead.org>
To: alexs@kernel.org
Cc: Izik Eidus <izik.eidus@ravellosystems.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Hugh Dickins <hughd@google.com>, Chris Wright <chrisw@sous-sol.org>,
	kasong@tencent.com, Andrew Morton <akpm@linux-foundation.org>,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/11] mm/ksm: use a folio in remove_stable_node
Message-ID: <ZfreCicoK9C6GW1t@casper.infradead.org>
References: <20240320074049.4130552-1-alexs@kernel.org>
 <20240320074049.4130552-4-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320074049.4130552-4-alexs@kernel.org>

On Wed, Mar 20, 2024 at 03:40:39PM +0800, alexs@kernel.org wrote:
> @@ -1124,22 +1124,22 @@ static int remove_stable_node(struct ksm_stable_node *stable_node)
>  	 * merge_across_nodes/max_page_sharing be switched.
>  	 */
>  	err = -EBUSY;
> -	if (!page_mapped(page)) {
> +	if (!folio_mapped(folio)) {
>  		/*
>  		 * The stable node did not yet appear stale to get_ksm_page(),
> -		 * since that allows for an unmapped ksm page to be recognized
> +		 * since that allows for an unmapped ksm folio to be recognized
>  		 * right up until it is freed; but the node is safe to remove.
> -		 * This page might be in an LRU cache waiting to be freed,
> +		 * This folio might be in an LRU cache waiting to be freed,
>  		 * or it might be PageSwapCache (perhaps under writeback),

s/PageSwapCache/in the swapcache/

>  		 * or it might have been removed from swapcache a moment ago.
>  		 */
> -		set_page_stable_node(page, NULL);
> +		set_page_stable_node(&folio->page, NULL);

Before this patch, introduce a folio_set_stable_node() (and convert the
one caller which already has a folio).  I'd do it the other way around
from ksm_get_folio(); that is:

static inline void folio_set_stable_node(struct folio *folio,
		struct ksm_stable_node *stable_node)
{
	set_page_stable_node(&folio->page, stable_node);
}

and then we can merge the two later when there are no more calls to
set_page_stable_node().



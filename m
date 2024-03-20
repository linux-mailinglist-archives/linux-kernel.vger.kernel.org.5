Return-Path: <linux-kernel+bounces-109092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AC788148D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629DD1C20C95
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6732156759;
	Wed, 20 Mar 2024 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YrD+Wcvw"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D52056443
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948384; cv=none; b=l6Emd/mC97k3C+2ikTCXsQ3X8YjNRU7w5Qh0err+LxSCjgZlOM97ML7a8uPfYD/joLIhrqHq/7oO9Cq84tTF5jg8lRkeV36uFuXUUQCbGeuTHkM+mt5lfnGTqgzJKeSoA29Pvycm7PxpGf315YOjI+GKlopK5JvLV4I9ApVkW3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948384; c=relaxed/simple;
	bh=JjjeykGzgnfQed95HEXTSgvvfjBVVcv4C71TtqIX6+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETid5O6yhRl0y5VWVo1pPU7sJQALeHveNKEr4JLhFWklBO8F+O596RP9gjtq2RKlzLSGtAq8Tc/fnhpWP267k1i0WzqiXCt7K5sITGvbyYYfChSEwb8CvK5Ezu7v+8V+PY/n5IqYNAJno0+Tl8O04tpl1/ZElfnIQ298ljNXycA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YrD+Wcvw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6H2VrsJPvIBusad9w260eghYblSiBWSXqydVmnydmLM=; b=YrD+Wcvwx2bJM1ESgcaNERrVAe
	qEyALxKKXv8LwVp8hBZlatltvaJZ3KlGjjMjYFkmK429NNtMIHBhuRDGQTXHV4p4wzlxvKTKPvTrx
	G1dxO4C6YWUBjFlPwMko3aJolkShkKYFfdrWFxFZSvE6nXKaiLEKwx5pqI+iu/tPGPRnpjxeIQcbl
	dPZvdcvAS8opSsNWuZbKhKU+DwueaHI2KTE2SC/vDAD81NPL8uJsosYfPQl+RfGmqEyGVA+I3WD9X
	1OIisBF9L7cra+PWumYnIEGry9/vusAXwTvyp+JMaeLX5U+SEA0bngKd61Z5i7VYywO40IfdidiVl
	GfM+5fig==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmxpS-00000004ZpL-0V6A;
	Wed, 20 Mar 2024 15:26:10 +0000
Date: Wed, 20 Mar 2024 15:26:10 +0000
From: Matthew Wilcox <willy@infradead.org>
To: alexs@kernel.org
Cc: Izik Eidus <izik.eidus@ravellosystems.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Hugh Dickins <hughd@google.com>, Chris Wright <chrisw@sous-sol.org>,
	kasong@tencent.com, Andrew Morton <akpm@linux-foundation.org>,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/11] mm/ksm: Convert stable_tree_search to use folio
Message-ID: <ZfsAEl5nipppfeLx@casper.infradead.org>
References: <20240320074049.4130552-1-alexs@kernel.org>
 <20240320074049.4130552-10-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320074049.4130552-10-alexs@kernel.org>

On Wed, Mar 20, 2024 at 03:40:45PM +0800, alexs@kernel.org wrote:
> @@ -1820,28 +1820,30 @@ static struct page *stable_tree_search(struct page *page)
>  	struct rb_node *parent;
>  	struct ksm_stable_node *stable_node, *stable_node_dup, *stable_node_any;
>  	struct ksm_stable_node *page_node;
> +	struct folio *folio;
>  
> -	page_node = page_stable_node(page);
> +	folio = (struct folio *)page;

These casts make me nervous.  Remember that we're heading towards a
future where struct page and struct folio don't point to the same
memory, and part of that will be finding all these casts and removing
them.  Please, unless there's a good reason, just use page_folio().



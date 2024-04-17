Return-Path: <linux-kernel+bounces-148862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 338B08A8847
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B581C219A9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E23148301;
	Wed, 17 Apr 2024 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gABxYm5r"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5F713C668
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369377; cv=none; b=J0F8RU913VS8lnd/5bzyx439x5uCl2n8D4YYE65z08IhxYOCABd2X5WSQxhXo6hnJL2CDCzhePAkU/stf64crC3ktnILgH+5e8A6aE9SAT7EkHaSyW5xjCLq7UX5H8+QG139DglsQq8077k7M/k6Vkyt9/RX3WWMDQE7uZdmBkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369377; c=relaxed/simple;
	bh=1HJA2VdK3RAaj67dxwu5w6hgb+z6kceHLJGcPzv7A0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tq78pz+gI1gSuIzx9Ea2kqFx1I2AKQX5Mz3204Dfhoqru+jnmDVSEj4HPVSv/1/rCfaj/EV5D9O5S4DMHCjHxIjII3YiSdci/PfZVXw8991oQWIXpHiKMVPbm8AXsRo7RYunhFTgyIekD1tCn1ej8JN32IZa5IJUfgfnPHV52jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gABxYm5r; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IOcLkk8PjhwZlvBRGqM0/Q1grY9Me9kV6PKtmwbZ0LM=; b=gABxYm5rrL79az8YN5G3Iu0Rqu
	yhOW7dgDrNJ4bLn9mSDg0KFRJrbODPpxfTTCYiFFrYYP1GQ1nJHm0RL2FGrZ9pAzkFESEEhY8+7VF
	4e+gj5aoTsE8fUU9sgz6BZHtYo873F3xj+OckC7gKTcjr8+2bRIPzZpjMGqhKFLhfmeG7a8UvKOG5
	rMBfMLL6sLRZWFdkCBr4bGtmP7p+Pq4SJfU0YS2lm+Lza1f2ZkGBykVXJ8bZCC9OtvQeP7kZH6kEU
	bz+DYAfNqXODF5kyXmpGRtBQuIikOE+qhVwLM/7iCJBJMMVlHJ0T1GSsdlvF8tsUMoK3YNZNcWJhy
	eInJNjrg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx7db-00000003Eet-3Beb;
	Wed, 17 Apr 2024 15:55:55 +0000
Date: Wed, 17 Apr 2024 16:55:55 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Byungchul Park <byungchul@sk.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	ying.huang@intel.com, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, david@redhat.com,
	peterz@infradead.org, luto@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: Re: [PATCH v9 7/8] mm: add folio_put_mgen() to deliver migrc's
 generation number to pcp or buddy
Message-ID: <Zh_xC76oTjrgutl_@casper.infradead.org>
References: <20240417071847.29584-1-byungchul@sk.com>
 <20240417071847.29584-8-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417071847.29584-8-byungchul@sk.com>

On Wed, Apr 17, 2024 at 04:18:46PM +0900, Byungchul Park wrote:
> Introduced a new API, folio_put_mgen(), to deliver migrc's generation
> number to pcp or buddy that will be used by migrc mechanism to track
> need of tlb flush for each page residing in pcp or buddy.
> 
> migrc makes decision whether tlb flush is needed or not, based on a
> generation number stored in the interesting page and the global
> generation number, for that tlb flush required has been completed.
> 
> For now, the delivery works only for the following call path but not for
> e.g. free_the_page(), __free_pages_ok() and free_unref_page_list() that
> are not for releasing source folios during migration:
> 
>    folio_put_mgen()
>       __folio_put_mgen()
> 	__folio_put_small()
> 	   free_unref_page()
> 	      free_unref_page_commit()
> 	      free_one_page()
> 	         __free_one_page()

You're going to want to rebase this on mm-unstable.  __folio_put_small()
went away in "mm: combine __folio_put_small, __folio_put_large and
__folio_put"



Return-Path: <linux-kernel+bounces-99804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA81A878DAC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1CA1C20F2A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7EAB662;
	Tue, 12 Mar 2024 03:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IjG7Y0cQ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509FAAD2C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 03:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710215169; cv=none; b=SBuZUPu3M/DCxuFEK/Z8fAZUn3W3BjCVuYDryvUx8S6m3amHwIjyVbjG/CbeUpbCL5beiQCeE4TZABFO43lcLKZDy/hao3xcvbGOzdJ8zwd01Zw95G0fU1l9JrtZghlfEgwy25jZjL46zWSOo1O3o9wRiZwzyo34TEDr09ZiiS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710215169; c=relaxed/simple;
	bh=RCIHBrSJeH3ER4nlMYsUSPpPCeYXpetsDd/zC3xQeS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWRUzIhk7MjRxn15PHFA8JtiDSWBs2u+hsDGbPKdiPtmCKR0nSB8hwOtpOL8XEL2sY7lb1Do8Tf7TlYV3KMQ/vFpZhwh9XgNWX6x4t2UZcROksmH67l1+Pyku6ZgPqV7LRCHp4i+jFx0Tkzw67OhGcS3C6fyYTstWpBDkq7OU/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IjG7Y0cQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HxUcv7Fm4MUGTSEA7CZZNMCascC7JNYS1DaeiBPDSXI=; b=IjG7Y0cQbifNB1bLRHAIVx+7Q8
	3ANUIWVtCXBG6LaT7P0n0kvnMRQcsvIjr6EQT5OCBI2DldQ0RRkQyWvLW512CjW6O+YP4FXfi1G6w
	QecfYDwzFZpxdThmadeNoz0l9c9C7Oe266BUcmLf3ZYJMU8Y+00pkDmDdYWexznClHR2KaABx3oV3
	Ndh8pRY2cJe1hwfeVGknNKP6h551DpMnAp6ur0HZDQPgCFR6TNgzd6uma7lznAdc6i7XxrJ7edaCY
	8WxAi5OiFH5x7mvoBGBFZcxIPBKIsjDE3iQSyQRby94gQ6L/AtHyQQ2w0z/lSwRHSOmz2aB1M+voE
	cQWEJjKA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjt5H-00000002AFY-2jsz;
	Tue, 12 Mar 2024 03:45:47 +0000
Date: Tue, 12 Mar 2024 03:45:47 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Yang Shi <shy828301@gmail.com>, Huang Ying <ying.huang@intel.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/migrate: put dest folio on deferred split list if
 source was there.
Message-ID: <Ze_P6xagdTbcu1Kz@casper.infradead.org>
References: <20240311195848.135067-1-zi.yan@sent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311195848.135067-1-zi.yan@sent.com>

On Mon, Mar 11, 2024 at 03:58:48PM -0400, Zi Yan wrote:
> @@ -1168,6 +1172,17 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>  		folio_lock(src);
>  	}
>  	locked = true;
> +	if (folio_test_large_rmappable(src) &&
> +		!list_empty(&src->_deferred_list)) {
> +		struct deferred_split *ds_queue = get_deferred_split_queue(src);
> +
> +		spin_lock(&ds_queue->split_queue_lock);
> +		ds_queue->split_queue_len--;
> +		list_del_init(&src->_deferred_list);
> +		spin_unlock(&ds_queue->split_queue_lock);
> +		old_page_state |= PAGE_WAS_ON_DEFERRED_LIST;
> +	}

I have a few problems with this ...

Trivial: your whitespace is utterly broken.  You can't use a single tab
for both indicating control flow change and for line-too-long.

Slightly more important: You're checking list_empty outside the lock
(which is fine in order to avoid unnecessarily acquiring the lock),
but you need to re-check it inside the lock in case of a race.  And you
didn't mark it as data_race(), so KMSAN will whinge.

Much more important: You're doing this with a positive refcount, which
breaks the (undocumented) logic in deferred_split_scan() that a folio
with a positive refcount will not be removed from the list.

Maximally important: Wer shouldn't be doing any of this!  This folio is
on the deferred split list.  We shouldn't be migrating it as a single
entity; we should be splitting it now that we're in a context where we
can do the right thing and split it.  Documentation/mm/transhuge.rst
is clear that we don't split it straight away due to locking context.
Splitting it on migration is clearly the right thing to do.

If splitting fails, we should just fail the migration; splitting fails
due to excess references, and if the source folio has excess references,
then migration would fail too.



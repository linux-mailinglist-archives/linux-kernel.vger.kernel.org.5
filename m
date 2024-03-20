Return-Path: <linux-kernel+bounces-109138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14C8881521
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AC5EB21EF5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D4154661;
	Wed, 20 Mar 2024 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hdwhtcHV"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C83123B0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710950586; cv=none; b=Yu9Dn5hW/bTOQcpZlt7dG1yZ8Y4F5EGYx7Muw5DNoTeUrzi/k8LauCG2wmp+K7EqelSYWyhFmMZ86cOucqDimJpzSheujW+H+2hdKP6GFgUVr5+T2sJ9ePnv7K9Py3AFtgwBQ5gmByB/vVuKAxcrViUyDHkRsYwY2fdSE+yOipU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710950586; c=relaxed/simple;
	bh=xNPkEPkfgiwAJOBWBG40pqctHi9CWeXTwkz2p5MGIZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3I3dzrvJO7wNpUKnLeW+JHznLXg2jv3qQBL4pBM/zZoM5BA1WDQIEl4isxDR/RTMTWeUSY+Wt4NGEQEzNnOBx98FBl2LhXg9cXaIAeiWLqWeRfljQzcMCztAuhaVeHd4lQzqgcRNkXcFX98osvpXmyv2vKE4+IepyKJKJfApEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hdwhtcHV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ml4jVPHJCd5/UtmiBCSa0uU8hAgWpRkM7OQMSO//QPw=; b=hdwhtcHVAOejkXQy/AyeOX7Zwa
	PdFKdvvIW1Ufr9GkUMjCix7l0d1UFk4Y61Jdxz/vMrMHf6bcqt8eYN7lKGNEx8FrwgYsFGNkUveGu
	7uudldc9YTIK+8k+m5HefHNVWy8fQJrPgZLTRA6a8a7GTwjl3aBmGIG4l6ugjJcrtdSZAxqFeM52a
	gXI4xyPZCw9Lkj1Yok2qxdBTyPrywZog9QP8y43gkl55ewAocO+v5RedA8ti08XPzXDJBNBl2WNs0
	QTCfH8krpMK7aB9prrBKFWQRoLe8avTG5dgyHXkup74ZYrINIQAcUeE5u/aN+iO4yG0rd7NIWwl4U
	xXGK/uFA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmyOt-00000004e56-2Rq5;
	Wed, 20 Mar 2024 16:02:47 +0000
Date: Wed, 20 Mar 2024 16:02:47 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Yang Shi <shy828301@gmail.com>, Huang Ying <ying.huang@intel.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Yin, Fengwei" <fengwei.yin@intel.com>,
	SeongJae Park <sj@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm/migrate: split source folio if it is on deferred
 split list
Message-ID: <ZfsIp8GlLx2LoW2G@casper.infradead.org>
References: <20240320014511.306128-1-zi.yan@sent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320014511.306128-1-zi.yan@sent.com>

On Tue, Mar 19, 2024 at 09:45:11PM -0400, Zi Yan wrote:
> +++ b/mm/migrate.c
> @@ -1654,25 +1654,65 @@ static int migrate_pages_batch(struct list_head *from,
>  
>  			/*
>  			 * Large folio migration might be unsupported or
> -			 * the allocation might be failed so we should retry
> -			 * on the same folio with the large folio split
> +			 * the folio is on deferred split list so we should
> +			 * retry on the same folio with the large folio split
>  			 * to normal folios.
>  			 *
>  			 * Split folios are put in split_folios, and
>  			 * we will migrate them after the rest of the
>  			 * list is processed.
>  			 */
> -			if (!thp_migration_supported() && is_thp) {
> -				nr_failed++;
> -				stats->nr_thp_failed++;
> -				if (!try_split_folio(folio, split_folios)) {
> -					stats->nr_thp_split++;
> -					stats->nr_split++;
> +			if (is_thp) {
> +				bool is_on_deferred_list = false;
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +				/*
> +				 * Check without taking split_queue_lock to
> +				 * reduce locking overheads. The worst case is
> +				 * that if the folio is put on the deferred
> +				 * split list after the check, it will be
> +				 * migrated and not put back on the list.
> +				 * The migrated folio will not be split
> +				 * via shrinker during memory pressure.
> +				 */
> +				if (!data_race(list_empty(&folio->_deferred_list))) {
> +					struct deferred_split *ds_queue;
> +					unsigned long flags;
> +
> +					ds_queue =
> +						get_deferred_split_queue(folio);
> +					spin_lock_irqsave(&ds_queue->split_queue_lock,
> +							  flags);
> +					/*
> +					 * Only check if the folio is on
> +					 * deferred split list without removing
> +					 * it. Since the folio can be on
> +					 * deferred_split_scan() local list and
> +					 * removing it can cause the local list
> +					 * corruption. Folio split process
> +					 * below can handle it with the help of
> +					 * folio_ref_freeze().
> +					 */
> +					is_on_deferred_list =
> +						!list_empty(&folio->_deferred_list);
> +					spin_unlock_irqrestore(&ds_queue->split_queue_lock,
> +							       flags);
> +				}
> +#endif
> +				if (!thp_migration_supported() ||
> +						is_on_deferred_list) {
> +					nr_failed++;
> +					stats->nr_thp_failed++;
> +					if (!try_split_folio(folio,
> +							     split_folios)) {
> +						stats->nr_thp_split++;
> +						stats->nr_split++;
> +						continue;
> +					}
> +					stats->nr_failed_pages += nr_pages;
> +					list_move_tail(&folio->lru, ret_folios);
>  					continue;
>  				}
> -				stats->nr_failed_pages += nr_pages;
> -				list_move_tail(&folio->lru, ret_folios);
> -				continue;
>  			}

I don't think we need to try quite this hard.  I don't think we need
to take the lock to be certain if it's on the deferred list -- is
there anything preventing the folio being added to the deferred list
after we drop the lock?

I also don't think we should account this as a thp split since those
are treated by callers as failures.  So maybe this?

+++ b/mm/migrate.c
@@ -1652,6 +1652,17 @@ static int migrate_pages_batch(struct list_head *from,

                        cond_resched();

+                       /*
+                        * The rare folio on the deferred split list should
+                        * be split now.  It should not count as a failure.
+                        */
+                       if (nr_pages > 2 &&
+                           !list_empty(&folio->_deferred_list)) {
+                               if (try_split_folio(folio, from) == 0) {
+                                       is_large = is_thp = false;
+                                       nr_pages = 1;
+                               }
+                       }
                        /*
                         * Large folio migration might be unsupported or
                         * the allocation might be failed so we should retry



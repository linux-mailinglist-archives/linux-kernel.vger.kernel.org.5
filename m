Return-Path: <linux-kernel+bounces-108187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCB588073C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0E98B21624
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3169751C5B;
	Tue, 19 Mar 2024 22:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l1Bv3Q9O"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8542B4F889
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710886810; cv=none; b=lTguwL/BY8dj3rH8MtnrU3hAVfjK83ifx70ZwtckTlY1O5YMP0WVP0PscKPxdkkNflM/ocBImX+luQG+V1MVLMfLGjV55giw5dcMeYO4nC0wz5DguuIZZDs8Z6EY0LvsGZ3Zk/hnfYpvV0rQbNdobPb4i1dKHIYWVDBBzWVOWVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710886810; c=relaxed/simple;
	bh=jFW/66QaU6CAHywCWFFJMkt6vYCQmKXCckS48E1mFi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQ4IACOtptMVocBUDaYcORwEFyzkUKzUeFSzKZfvIjncSX/gWO0UX2RrvuhSyqtUxSCL+gVQPPwX6gAdrsWoJO8PxxbLLFSUQW64LGWUuY/ooCaNzqkEnUoMPN8DqaH7SRTCMTVJ8IT3jjMU4Z+4NfAosw//XGaY8c73M3mZ2es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l1Bv3Q9O; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SKvPkFmK+oZX/ahAFGgHvLNEelgSfIBv198c1OD915o=; b=l1Bv3Q9OeLvJmrbDatOGg2pNGL
	H3nbqRnimgXFDFeSf0JZa0Gvl1b4OhLxOyIahR2KTZFb8XLEEKGgIm5dKhLu9uVqhHLKyWoZDnXG0
	Ubsgfx8oQxG/Q+3hgctVziqG0oAMc+WiDXZcpY8fWLcAgP8pvcQOTUpO+cC+wp0XL424QLiAGEwEp
	L7nHpUaECOrvOwjF4fuMfls6KiLNFy53uyqZuX4lyekaIEEkx8mhCU2U8guP72ppGTpQnP7qNBBh9
	ot1QJWASrUMHaUTPRJD6FRyRUzOc8M85kACm1IIphjNusnWiwxUdRoU5KSeevLGmgob/VGdyb6rfX
	XlEl0TlA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmhoL-00000002spj-2boa;
	Tue, 19 Mar 2024 22:19:57 +0000
Date: Tue, 19 Mar 2024 22:19:57 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mm/filemap: optimize filemap folio adding
Message-ID: <ZfoPjUyPiXpFSxA4@casper.infradead.org>
References: <20240319092733.4501-1-ryncsn@gmail.com>
 <20240319092733.4501-5-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319092733.4501-5-ryncsn@gmail.com>

On Tue, Mar 19, 2024 at 05:27:33PM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Instead of doing multiple tree walks, do one optimism range check
> with lock hold, and exit if raced with another insertion. If a shadow
> exists, check it with a new xas_get_order helper before releasing the
> lock to avoid redundant tree walks for getting its order.
> 
> Drop the lock and do the allocation only if a split is needed.
> 
> In the best case, it only need to walk the tree once. If it needs
> to alloc and split, 3 walks are issued (One for first ranced
> conflict check and order retrieving, one for the second check after
> allocation, one for the insert after split).
> 
> Testing with 4k pages, in an 8G cgroup, with 20G brd as block device:
> 
> fio -name=cached --numjobs=16 --filename=/mnt/test.img \
>   --buffered=1 --ioengine=mmap --rw=randread --time_based \
>   --ramp_time=30s --runtime=5m --group_reporting
> 
> Before:
> bw (  MiB/s): min=  790, max= 3665, per=100.00%, avg=2499.17, stdev=20.64, samples=8698
> iops        : min=202295, max=938417, avg=639785.81, stdev=5284.08, samples=8698
> 
> After (+4%):
> bw (  MiB/s): min=  451, max= 3868, per=100.00%, avg=2599.83, stdev=23.39, samples=8653
> iops        : min=115596, max=990364, avg=665556.34, stdev=5988.20, samples=8653
> 
> Test result with THP (do a THP randread then switch to 4K page in hope it
> issues a lot of splitting):
> 
> fio -name=cached --numjobs=16 --filename=/mnt/test.img \
>   --buffered=1 --ioengine mmap -thp=1 --readonly \
>   --rw=randread --random_distribution=random \
>   --time_based --runtime=5m --group_reporting
> 
> fio -name=cached --numjobs=16 --filename=/mnt/test.img \
>   --buffered=1 --ioengine mmap --readonly \
>   --rw=randread --random_distribution=random \
>   --time_based --runtime=5s --group_reporting
> 
> Before:
> bw (  KiB/s): min=28071, max=62359, per=100.00%, avg=53542.44, stdev=179.77, samples=9520
> iops        : min= 7012, max=15586, avg=13379.39, stdev=44.94, samples=9520
> bw (  MiB/s): min= 2457, max= 6193, per=100.00%, avg=3923.21, stdev=82.48, samples=144
> iops        : min=629220, max=1585642, avg=1004340.78, stdev=21116.07, samples=144
> 
> After (+-0.0%):
> bw (  KiB/s): min=30561, max=63064, per=100.00%, avg=53635.82, stdev=177.21, samples=9520
> iops        : min= 7636, max=15762, avg=13402.82, stdev=44.29, samples=9520
> bw (  MiB/s): min= 2449, max= 6145, per=100.00%, avg=3914.68, stdev=81.15, samples=144
> iops        : min=627106, max=1573156, avg=1002158.11, stdev=20774.77, samples=144
> 
> The performance is better (+4%) for 4K cached read and unchanged for THP.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/filemap.c | 127 ++++++++++++++++++++++++++++++---------------------
>  1 file changed, 76 insertions(+), 51 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 6bbec8783793..c1484bcdbddb 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -848,12 +848,77 @@ void replace_page_cache_folio(struct folio *old, struct folio *new)
>  }
>  EXPORT_SYMBOL_GPL(replace_page_cache_folio);
>  
> +static int __split_add_folio_locked(struct xa_state *xas, struct folio *folio,
> +				    pgoff_t index, gfp_t gfp, void **shadowp)

I don't love the name of this function.  Splitting is a rare thing that
it does.  I'd suggest it's more filemap_store().

> +{
> +	void *entry, *shadow, *alloced_shadow = NULL;
> +	int order, alloced_order = 0;
> +
> +	gfp &= GFP_RECLAIM_MASK;
> +	for (;;) {
> +		shadow = NULL;
> +		order = 0;
> +
> +		xas_for_each_conflict(xas, entry) {
> +			if (!xa_is_value(entry))
> +				return -EEXIST;
> +			shadow = entry;
> +		}
> +
> +		if (shadow) {
> +			if (shadow == xas_reload(xas)) {

Why do you need the xas_reload here?

> +				order = xas_get_order(xas);
> +				if (order && order > folio_order(folio)) {
> +					/* entry may have been split before we acquired lock */
> +					if (shadow != alloced_shadow || order != alloced_order)
> +						goto unlock;
> +					xas_split(xas, shadow, order);
> +					xas_reset(xas);
> +				}
> +				order = 0;
> +			}

I don't think this is right.  I think we can end up skipping a split
and storing a folio into a slot which is of greater order than the folio
we're storing.

> +			if (shadowp)
> +				*shadowp = shadow;
> +		}
> +
> +		xas_store(xas, folio);
> +		/* Success, return with mapping locked */
> +		if (!xas_error(xas))
> +			return 0;
> +unlock:
> +		/*
> +		 * Unlock path, if errored, return unlocked.
> +		 * If allocation needed, alloc and retry.
> +		 */
> +		xas_unlock_irq(xas);
> +		if (order) {
> +			if (unlikely(alloced_order))
> +				xas_destroy(xas);
> +			xas_split_alloc(xas, shadow, order, gfp);
> +			if (!xas_error(xas)) {
> +				alloced_shadow = shadow;
> +				alloced_order = order;
> +			}
> +			goto next;
> +		}
> +		/* xas_nomem result checked by xas_error below */
> +		xas_nomem(xas, gfp);
> +next:
> +		xas_lock_irq(xas);
> +		if (xas_error(xas))
> +			return xas_error(xas);
> +
> +		xas_reset(xas);
> +	}
> +}

Splitting this out into a different function while changing the logic
really makes this hard to review ;-(

I don't object to splitting the function, but maybe two patches; one
to move the logic and a second to change it?


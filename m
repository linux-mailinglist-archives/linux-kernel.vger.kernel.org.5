Return-Path: <linux-kernel+bounces-39477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEC783D1C6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B91BB269F4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E7E816;
	Fri, 26 Jan 2024 00:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbAonHmC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C02B387
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706230590; cv=none; b=B5/wROnQnTWXbixKymJekmYwKkYRIPl90oYH1SoU+y7PWGZnZ99mwLzLM2Usw+eIGQVnc1yIkIUWdyqi7xTQWPWloCErQu+6zFRVsP1u0AucYe7NxfX7DKKtGZhWjbmMjYtColm8ibdXkNi2bKyxrt3IRe0eF7z2M2tN1v9z2pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706230590; c=relaxed/simple;
	bh=WbcgTvp8TfQS/w6R/mlYgDgTg9ShuwbJ49WG68DhQG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSX8Z3Jvkiop0MArh7YvAUZ8ux9607lJEKbcRgT5DBpGdxNGb/VPDT+IGVxit44q5NMrzsFCCI5ZKPM7/PelAXjKKnwsIBEVOAZnAJ39BNq7TKaiNNPQVl/sheTnWv12hmZvwABbndj3wa36mUqgV4iGPEyMQmluOJRX2pybd5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbAonHmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74933C433F1;
	Fri, 26 Jan 2024 00:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706230589;
	bh=WbcgTvp8TfQS/w6R/mlYgDgTg9ShuwbJ49WG68DhQG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NbAonHmCb1uEHhagz9V59i37+JdZmwW/mX2o1B9LYr5vWW2oUobKAKLPSx62sJC55
	 2eMNxfkmknCfnuaU3MXbBidqvfz7Uh5ImMh9iqAGvZkRiOP7o6actc3E6AYd4t3LfU
	 nfQYnXKQ8Sk0c7VEZdTB4NUZofcK2em+UCmHhA1sG9zYVkmwGvZiM+yezDb8+i2i+1
	 mS5UHjzl9WzUMXtBTb667aBfu/TIGklkHPY+fi9e34/Bwh0gQNiqnVn0M0rYF4Leiq
	 qOpGRn+/B5qquUOJOoMLIXHnBNOZ0twi7gHHa3TZfIaGipRLe6lWQKmgPvEjkgppzI
	 Sn9OKxRhVmaUQ==
Date: Thu, 25 Jan 2024 16:56:27 -0800
From: Chris Li <chrisl@kernel.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Yu Zhao <yuzhao@google.com>, Wei Xu <weixugc@google.com>,
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] mm, lru_gen: try to prefetch next page when
 scanning LRU
Message-ID: <ZbMDO5mkAFmN2LHz@google.com>
References: <20240123184552.59758-1-ryncsn@gmail.com>
 <20240123184552.59758-2-ryncsn@gmail.com>
 <CAF8kJuNZP-uvsSshVrEY0bPsYLB+5Oi-bQKsEQ3RV6yOW+RgNA@mail.gmail.com>
 <CAMgjq7CbxZQ2CmWNjsNjJajBEVkZ839_X5twwLfiiv0-ZgN32A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMgjq7CbxZQ2CmWNjsNjJajBEVkZ839_X5twwLfiiv0-ZgN32A@mail.gmail.com>

On Fri, Jan 26, 2024 at 01:51:44AM +0800, Kairui Song wrote:
> > >  mm/vmscan.c | 30 ++++++++++++++++++++++++++----
> > >  1 file changed, 26 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index 4f9c854ce6cc..03631cedb3ab 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -3681,15 +3681,26 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
> > >         /* prevent cold/hot inversion if force_scan is true */
> > >         for (zone = 0; zone < MAX_NR_ZONES; zone++) {
> > >                 struct list_head *head = &lrugen->folios[old_gen][type][zone];
> > > +               struct folio *prev = NULL;
> > >
> > > -               while (!list_empty(head)) {
> > > -                       struct folio *folio = lru_to_folio(head);
> > > +               if (!list_empty(head))
> > > +                       prev = lru_to_folio(head);
> > > +
> > > +               while (prev) {
> > > +                       struct folio *folio = prev;
> > >
> > >                         VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(folio), folio);
> > >                         VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio), folio);
> > >                         VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(folio) != type, folio);
> > >                         VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) != zone, folio);
> > >
> > > +                       if (unlikely(list_is_first(&folio->lru, head))) {
> > > +                               prev = NULL;
> > > +                       } else {
> > > +                               prev = lru_to_folio(&folio->lru);
> > > +                               prefetchw(&prev->flags);
> > > +                       }
> >
> > This makes the code flow much harder to follow. Also for architecture
> > that does not support prefetch, this will be a net loss.
> >
> > Can you use refetchw_prev_lru_folio() instead? It will make the code
> > much easier to follow. It also turns into no-op when prefetch is not
> > supported.
> >
> > Chris
> >
> 
> Hi Chris,
> 
> Thanks for the suggestion.
> 
> Yes, that's doable, I made it this way because in previous series (V1
> & V2) I applied the bulk move patch first which needed and introduced
> the `prev` variable here, so the prefetch logic just used it.
> For V3 I did a rebase and moved the prefetch commit to be the first
> one, since it seems to be the most effective one, and just kept the

Maybe something like this? Totally not tested. Feel free to use it any way you want.

Chris

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4f9c854ce6cc..2100e786ccc6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3684,6 +3684,7 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
 
 		while (!list_empty(head)) {
 			struct folio *folio = lru_to_folio(head);
+			prefetchw_prev_lru_folio(folio, head, flags);
 
 			VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(folio), folio);
 			VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio), folio);
@@ -4346,7 +4347,10 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 
 		while (!list_empty(head)) {
 			struct folio *folio = lru_to_folio(head);
-			int delta = folio_nr_pages(folio);
+			int delta;
+
+			prefetchw_prev_lru_folio(folio, head, flags);
+			delta = folio_nr_pages(folio);
 
 			VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(folio), folio);
 			VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio), folio);



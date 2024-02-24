Return-Path: <linux-kernel+bounces-79852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C43D86279C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0000CB218A0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EAC481BD;
	Sat, 24 Feb 2024 20:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icvaP+T4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8841DFE5;
	Sat, 24 Feb 2024 20:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708808096; cv=none; b=W4mqbH1tKPNfgg3dld7cQOOM3BGAfrPVz/llMjhVApvj9DpKMx4ZqBkJbzr9b9sOMYHkM6yvp9jwARJQFM2WocaXkIv1Fjv0Wclvmp12RDz7cEpGBu5cBaTCp6mkRk8SJFMBfWlYAm6GkPYAa8PNofOehV+1m9o4KXll2kYAMLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708808096; c=relaxed/simple;
	bh=sAzkLyInW8vnZNRVOTYLy2onbr1cozPVspALWkhdV+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUvWbrojvN36DS2lJAB6nnwskjK8g6VqrHtWc5GFg5VUf8W4jzLY+TGAhYk2fug2f7qTt8vhiEJnFZClbXrnQwQ7i0LwrHb8z/3syV603McdIROzDCkVsH2TeDFhhw9ul0q7lONX4WHNuxFJx7vN2IVd6OGuWEnEm//nNQRUjIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icvaP+T4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E17C433C7;
	Sat, 24 Feb 2024 20:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708808095;
	bh=sAzkLyInW8vnZNRVOTYLy2onbr1cozPVspALWkhdV+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=icvaP+T4vL8lB7rJAw7kuQPyoy5Z1d0qfqLK91Eo1y66kRKHm3r+iIv5nKlb0jqRc
	 e8nWOD/9qE/pg4F7owoaH12r9daoQsAonOsUODrhb8+jnFbzwddfin86cks4REEmgh
	 BbAvtx45d35WCYkxgwhZFvMtHikQu1uPOSqhpOlTRgNI1K+ptA8/nHWsMblAwz/+LQ
	 lshJ3rm04YvFl4pi3t6rVyFFw5Hv8V0yT6l3A4hy71mxtKzOEUlXNIDQAAb0fHN5Bw
	 nlbjmgCPwxnsKrGsbtjNPvVSXMax6XBdt6RsxcWXSO6jOM/gBEcpBZVsNeuddo4OcI
	 w9gF+kZDN2Dpw==
From: SeongJae Park <sj@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	hannes@cmpxchg.org,
	Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH RFC] mm: madvise: pageout: ignore references rather than clearing young
Date: Sat, 24 Feb 2024 12:54:52 -0800
Message-Id: <20240224205453.47096-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAGsJ_4w5JF8zjsM=vEiArUpnvN9LjAdnUn98mEUJSAhg4Y9XjQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 25 Feb 2024 04:01:40 +0800 Barry Song <21cnbao@gmail.com> wrote:

> On Sun, Feb 25, 2024 at 3:07 AM SeongJae Park <sj@kernel.org> wrote:
> >
> > Hi Barry,
> >
> > On Sat, 24 Feb 2024 12:37:59 +0800 Barry Song <21cnbao@gmail.com> wrote:
> >
> > [...]
> > >
> > > BTW，
> > > Hi SeongJae,
> > > I am not quite sure if damon also needs this, so I have kept damon as is by
> > > setting ignore_references = false.  MADV_PAGEOUT is an explicit hint users
> > > don't want the memory to be reclaimed, I don't know if it is true for damon as
> > > well. If you have some comments, please chime in.
> >
> > Thank you for calling my name :)
> >
> > For DAMON's usecase, the document simply says the behavior would be same to
> > MADV_PAGEOUT, so if we conclude to change MADV_PAGEOUT, I think same change
> > should be made for DAMON's usecase, or update DAMON document.
> 
> Hi SeongJae,
> 
> I don't find similar clearing pte young in damon_pa_pageout(), so i
> guess damon's
> behaviour is actually different with MADV_PAGEOUT which has  pte-clearing. damon
> is probably the best-effort but MADV_PAGEOUT isn't .
> 
> static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
> {
>         unsigned long addr, applied;
>         LIST_HEAD(folio_list);
> 
>         for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
>                      struct folio *folio = damon_get_folio(PHYS_PFN(addr));
>                      ....
> 
>                      if (damos_pa_filter_out(s, folio))
>                                 goto put_folio;
> 
>                     folio_clear_referenced(folio);
>                     folio_test_clear_young(folio);
>                     if (!folio_isolate_lru(folio))
>                          goto put_folio;
>                     if (folio_test_unevictable(folio))
>                           folio_putback_lru(folio);
>                     else
>                           list_add(&folio->lru, &folio_list);
> put_folio:
>                folio_put(folio);
>          }
>          applied = reclaim_pages(&folio_list);
>          cond_resched();
>          return applied * PAGE_SIZE;
> }
> 
> am i missing something?

Thank you for checking this again.  You're right.

Technically speaking, DAMON's usage of MADV_PAGEOUT is in vaddr.c.  paddr.c is
using not MADV_PAGEOUT but reclaim_pages().  Usage of reclaim_pages() from
paddr is different from that of MADV_PAGEOUT since paddr doesn't clear PTE.  I
was confused from the difference between vaddr and paddr.  I actually wanted to
document the difference but haven't had a time for that yet.  Thank you for
letting me remind this.

So, your change on MADV_PAGEOUT will make an effect to vaddr, and I think it's
ok.  Your change on reclaim_pages() could make an effect to paddr, depending on
the additional parameter's value.  I now think it would better to make no
effect here.  That is, let's keep the change for paddr.c in your patch as is.


Thanks,
SJ

> 
> >
> >
> > Thanks,
> > SJ
> >
> 
> Thanks
> Barry


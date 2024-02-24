Return-Path: <linux-kernel+bounces-79855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 191BF8627A3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7198282406
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E9D4D131;
	Sat, 24 Feb 2024 21:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIXU0YxG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51C44CDFB;
	Sat, 24 Feb 2024 21:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708808549; cv=none; b=l8V9A9v7+5S+N3kQYeLsdiFjBNVgEplLIjtrDl1K2meanIi1Izs5LKMEnpJYBGJUDU8InA/PHV0kS8/tpVbExfU23u2L4N48npI5++QQZ/W6PO09XkI3WbVUuDQDA/a1QtgLKXpOpYlZtHuCg9gsy0SC3IisZd/Yt4oJgDviiuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708808549; c=relaxed/simple;
	bh=DBksNLTYfjt6+EX3HN5+PfdJ9HZ1Fi3NzTEwfk1Wj9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uMO6Nz9+6hJNURGc12d5COIPaWmkG0uzGZpP6FaWVkhM2D+DhzkIP3/3PfF5okAvMy5+WZ8j/xXoUMfG0NWxE0xAfXoYscOryyENbIN20OEn/7xVSAxnElvqN/Re8In86EwsFgIsfWvmdl/3am8aMxVM81zwtfCbZgkvw+uUVAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIXU0YxG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93603C433C7;
	Sat, 24 Feb 2024 21:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708808548;
	bh=DBksNLTYfjt6+EX3HN5+PfdJ9HZ1Fi3NzTEwfk1Wj9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LIXU0YxGcL2vXyF1XOBoBcPw3rrkRPzvqdj/mE4SgPvlIj/lK4sF7d93bkGTngfuQ
	 qSlm74y0cI0vOODSbKmMFEKHyuFlrlxpsrcteyCwPGXBtfPaoFrt3w0Pp79VvePY7e
	 Buk7Yfguhg5My1B56YP+UVna4Dcuy+OS537MGhwCji7vzPTvVGGsVx0pfQZuDhe0pj
	 BwBw95v4h8+dUFHz3wh0yfMWeVijLI8OKvzOn1M90jQRHLEac670wYptO1Ut4FV7aq
	 6OzpcYwkOJz39eJJnPqA8lhyez6C0tGKVZKh4D9zdxkkghpN+h77XLqCCVTE+8ZDka
	 0Qic/paZ8CRSw==
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
Date: Sat, 24 Feb 2024 13:02:25 -0800
Message-Id: <20240224210225.47149-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAGsJ_4w4wnbryJaAKRtNGNMg_YTGkeG3QwL9_JkT=wtwq1+_+Q@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 25 Feb 2024 04:33:25 +0800 Barry Song <21cnbao@gmail.com> wrote:

> On Sun, Feb 25, 2024 at 4:12 AM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Sat, 24 Feb 2024 11:07:23 -0800 SeongJae Park <sj@kernel.org> wrote:
> >
> > > Hi Barry,
> > >
> > > On Sat, 24 Feb 2024 12:37:59 +0800 Barry Song <21cnbao@gmail.com> wrote:
> > >
> > > [...]
> > > >
> > > > BTW\uff0c
> > > > Hi SeongJae,
> > > > I am not quite sure if damon also needs this, so I have kept damon as is by
> > > > setting ignore_references = false.  MADV_PAGEOUT is an explicit hint users
> > > > don't want the memory to be reclaimed, I don't know if it is true for damon as
> > > > well. If you have some comments, please chime in.
> > >
> > > Thank you for calling my name :)
> > >
> > > For DAMON's usecase, the document simply says the behavior would be same to
> > > MADV_PAGEOUT, so if we conclude to change MADV_PAGEOUT, I think same change
> > > should be made for DAMON's usecase, or update DAMON document.
> >
> > Thanks to Barry's nice explanation on my other reply to the patch, now I think
> > the change is modest, and therefore I'd prefer the first way: Changing DAMON's
> > usecase, and keep the document as is.
> 
> Hi SeongJae,
> 
> thanks! I actually blindly voted for keeping DAMON's behaviour but
> slightly updated the
> document as I set ignore_references to false for the DAMON case in the RFC :-)
> 
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -249,7 +249,7 @@ static unsigned long damon_pa_pageout(struct
> damon_region *r, struct damos *s)
>  put_folio:
>   folio_put(folio);
>   }
> - applied = reclaim_pages(&folio_list);
> + applied = reclaim_pages(&folio_list, false);
>   cond_resched();
>   return applied * PAGE_SIZE;
>  }
> 
> MADV_PAGEOUT comes from userspace by a specific process to tell the kernel
> to reclaim its own memory(actually focus on non-shared memory as it
> skips folios with
> mapcount>1).
> The range is a virtual address and the app does know it doesn't want
> to access the
> range in the foreseeable future.  and the affected app is itself not global.
> 
> In the DAMON case,  it seems the range is the physical address.  if
> the pa is mapped
> by more than one process, it seems safer to double-check in the kernel
> as it might
> affect multiple processes?
> 
> Please correct me if I am wrong.

You're correct.  Please consider below in my previous reply[1] as my opinion.

    let's keep the change for paddr.c in your patch as is.

[1] https://lore.kernel.org/r/20240224205453.47096-1-sj@kernel.org


Thanks,
SJ

> 
> >
> >
> > Thanks,
> > SJ
> >
> > >
> > >
> > > Thanks,
> > > SJ
> 
> Thanks
>  Barry


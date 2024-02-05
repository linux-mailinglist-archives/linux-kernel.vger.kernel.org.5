Return-Path: <linux-kernel+bounces-52802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B00B849CD2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F3811C2565E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1BB2C1A5;
	Mon,  5 Feb 2024 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ku1VTSUT"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B1C2C19D
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142618; cv=none; b=DtR3q857WvNwC/E9HUDfvFgb/kCnn8AL++v+M4chVzWmkPQynUac1KJ3rMFP4GZBcyWEWNsdsnlyM/5pbydd12YSb+vQmApU6zJbN+h6IdQ94rJqi8F+Eaz+8IKXapNlFd7xgZgb2FyNGwYcAA3U5cH4rFCKcZtSFJJYJbKUOtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142618; c=relaxed/simple;
	bh=BrCdySG7AMcyjgkC49tQK4hkrYtEGLlsAo7i/IRHlfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqmZJwYlA7oshqZ6/sa3YkNTV10EKJMsItBuFOtUZgxdb4RroqBmmzmzsNJTyR61u2S2rpaerlk22CWbkuzNzcybjkWbykMfLeoxgsa+PYDjci129hUm3M7H3NZtufr8r9m4/R/zY25wiSTE/oSf9RYnB+GWuUOrxTI3HCyj4mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ku1VTSUT; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d0a96bad85so17840561fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 06:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707142615; x=1707747415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y693qVlKnW7MrGgRCQ2yznDJT6ahGyd4dQiskVCDqY8=;
        b=Ku1VTSUT59nrNzlrjsfgADJUNPbwSkBzmPmzADwX8fnU5QF0NCOZh6YFKgUOtrhJXb
         ZilRTvxnQftI9OE12+nbpIYxiM/4oGWJD0SouFjhT7qLRZ0qTkJFTfDq7yqz56loV+9l
         XP36TJ8cDT0ay55Dcl4+Rqr9ULoumAwPrT44yDdT8so+8X4iAIo+jOXinaKooaWn9hQ6
         hlFB4isz4ozASFkjA/qbCLv8H+CWZgW2pQZQinfRtoUEUpfdvXzOLdQWJV1z5MJGMUqu
         QNXBAe8OeEp8ZAgR3a5pdDtSXkAqmkF/SH0SQuN9k2IZk/NEz1L5FHIIZtNpkxqYO85N
         9lMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707142615; x=1707747415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y693qVlKnW7MrGgRCQ2yznDJT6ahGyd4dQiskVCDqY8=;
        b=i2/WLkQ2htBhFlFbzUgOIQH+cBIqBb2w7M1IR6D4moju4AJ9S3mULoWjdJAaIl1syJ
         6qmXWnsucP/JgBiQ+AvxOFC/0JOw/Y/RGI8/e2knBGJfU3cnrIGTM5/bNGK48aJ5WeI9
         Q5amnSZUunYBapHNTfKzhhJncja9VtaHz7Z3VbxigO4VcPihL3Qy5h8omwBu04vmJco/
         gcuGhMj2YlQfNvVX216j93fb5NAeMqgaiaUfOep5J9CltaX4fzHDeuhyUNLGdTtdFiM7
         +PLG7Iz7jEJdQf9/p7pCTLndBMFir76EI94KYvY0g7CKR6EgJjpsOT24OyozL7eHpOov
         fHdg==
X-Gm-Message-State: AOJu0YyJcudd6ICuncv2bXoSj4n8GEz2mrUF4MnvBkLVYbqTf8rS6GFu
	/pSqsZtfXXFBwRHZCM+CeQY2gIzwKf3tNlnSUdf6EyJk42x/N6bMKt1lt65M/PIiVWCJdBrtp50
	WXWrtB0Ac/e3R+1clDcD1tw2fVa4=
X-Google-Smtp-Source: AGHT+IEUSj0T4591sSE8qKJHUcVrqra1VsOm7YnWe7xFhJQZ5Y+jhiVoNzLmFx68LCegotBhkQ3TwZ7pkDUoHSnNs1k=
X-Received: by 2002:a2e:9d51:0:b0:2d0:50c4:cafe with SMTP id
 y17-20020a2e9d51000000b002d050c4cafemr7428765ljj.37.1707142614642; Mon, 05
 Feb 2024 06:16:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205110959.4021-1-ryncsn@gmail.com> <CAGsJ_4zyQk4fFnUL77TVt2p=XHzmai1e0xtMEy++GT2sMjQxpg@mail.gmail.com>
In-Reply-To: <CAGsJ_4zyQk4fFnUL77TVt2p=XHzmai1e0xtMEy++GT2sMjQxpg@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 5 Feb 2024 22:16:36 +0800
Message-ID: <CAMgjq7DeJ9SEzMU36Crbzd7d8n2bfsdR+8tNtMBokkD6-mZQEA@mail.gmail.com>
Subject: Re: [PATCH] mm/swap: fix race condition in direct swapin path
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>, 
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, Yu Zhao <yuzhao@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 8:25=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>

Hi, Barry

Thanks for the comments.

> On Mon, Feb 5, 2024 at 7:10=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wro=
te:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > In the direct swapin path, when two or more threads swapin the same ent=
ry
> > at the same time, they get different pages (A, B) because swap cache is
> > skipped. Before one thread (T0) finishes the swapin and installs page (=
A)
> > to the PTE, another thread (T1) could finish swapin of page (B),
> > swap_free the entry, then modify and swap-out the page again, using the
>
> Even if T0's  swap_read_folio is later than T1, problems can still happen=
.
> after T1 swaps in and sets ptes, then frees the swap entry. T0 reads zRAM
> later. it will get zero as zRAM will fill zero for freed slot,
>
> static int zram_read_from_zspool(struct zram *zram, struct page *page,
>                                  u32 index)
> {
>        ...
>
>
>                  value =3D handle ? zram_get_element(zram, index) : 0;
>                 mem =3D kmap_local_page(page);
>                zram_fill_page(mem, PAGE_SIZE, value);
>                  kunmap_local(mem);
>                 return 0;
>          }
>  }
>
> Even though nobody modifies the data before the page is swapped out to th=
e
> same swap offset as before tT0's orig_pte, T0's pte_same check is still t=
rue
> and T0 will map filled zeroed page to pte.
>
> so there is more than one risk besides modified data losses.

Thanks for the complement, I think this is true, and it shares the
same problem of the entry reuse, so this patch also covered this
potential race. I can add more words later to cover this case as well.

>
> > same entry. It break the pte_same check because PTE value is unchanged,
> > causing ABA problem. Then thread (T0) will then install the stalled pag=
e
> > (A) into the PTE so new data in page (B) is lost, one possible callstac=
k
> > is like this:
> >
> > CPU0                                CPU1
> > ----                                ----
> > do_swap_page()                      do_swap_page() with same entry
> > <direct swapin path>                <direct swapin path>
> > <alloc page A>                      <alloc page B>
> > swap_readpage() <- read to page A   swap_readpage() <- read to page B
> > <slow on later locks or interrupt>  <finished swapin first>
> > ..                                 set_pte_at()
> >                                     swap_free() <- Now the entry is fre=
ed.
> >                                     <write to page B, now page A stalle=
d>
> >                                     <swap out page B using same swap en=
try>
> > pte_same() <- Check pass, PTE seems
> >               unchanged, but page A
> >               is stalled!
> > swap_free() <- page B content lost!
> > set_pte_at() <- staled page A installed!
> >
> > To fix this, reuse swapcache_prepare which will pin the swap entry usin=
g
> > the cache flag, and allow only one thread to pin it. Release the pin
> > after PT unlocked. Racers will simply busy wait since it's a rare
> > and very short event.
> >
> > Other methods like increasing the swap count don't seem to be a good
> > idea after some tests, that will cause racers to fall back to the
> > cached swapin path, two swapin path being used at the same time
> > leads to a much more complex scenario.
> >
> > Reproducer:
> >
> > This race issue can be triggered easily using a well constructed
> > reproducer and patched brd (with a delay in read path) [1]:
> >
> > With latest 6.8 mainline, race caused data loss can be observed easily:
> > $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
> >   Polulating 32MB of memory region...
> >   Keep swapping out...
> >   Starting round 0...
> >   Spawning 65536 workers...
> >   32746 workers spawned, wait for done...
> >   Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data loss!
> >   Round 0: Error on 0x395200, expected 32746, got 32743, 3 data loss!
> >   Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data loss!
> >   Round 0 Failed, 15 data loss!
>
> i am also reading these codes recently. It is quite unbelievable this
> is really happening
> now. as freeing swaps is returning slot to slots_ret, but allocating
> swap is from slots.
> so if swapfile is large, the chance that the newly allocated swap was
> a recently freed swap
> is close to 0%. but yes, the code does have the risk.

Indeed, for reproducing I used a 32M swap device, and the data being
swapped in/out is large enough to make full use of it. So the
reproduce rate is increased by a lot. It's not a completely fictional
test as some low end device do have smaller swaps, and real world race
could happen in many strange ways.

> >
> > This reproducer spawns multiple threads sharing the same memory region
> > using a small swap device. Every two threads updates mapped pages one b=
y
> > one in opposite direction trying to create a race, with one dedicated
> > thread keep swapping out the data out using madvise.
> >
> > The reproducer created a reproduce rate of about once every 5 minutes,
> > so the race should be totally possible in production.
> >
> > After this patch, I ran the reproducer for over a few hundred rounds
> > and no data loss observed.
> >
> > Performance overhead is minimal, microbenchmark swapin 10G from 32G
> > zram:
> >
> > Before:     10934698 us
> > After:      11157121 us
> > Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
> >
> > Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchronou=
s device")
> > Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stres=
s-race [1]
> > Signed-off-by: Kairui Song <kasong@tencent.com>
>
> I will also run your patch on my problem I reported today[1]. will update
> the result to you this week.
>
> [1] https://lore.kernel.org/linux-mm/d4f602db-403b-4b1f-a3de-affeb40bc499=
@arm.com/T/#m41701d0c0e127cdae636e97a13ab521364a810f4
>

Thanks!


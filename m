Return-Path: <linux-kernel+bounces-116703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DF988A2C1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C981C389CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBDC5C90B;
	Mon, 25 Mar 2024 10:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AejJBxrw"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F01E15573D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711355967; cv=none; b=IdApYwognTKZ78GBe0LuOUTKEeijBqX7Vl1rJ4iM8zroktoOGPwBdVa/Qf8iTx8D9+4o/QqCmSd4V8wU1XLEQe+OpqLf7ZQ2AfvsmH+qWerTqz3t5RcpMleXS7nGnMT2ITeEfsa4vn97eK0qw84K453/u4TpJMEinim3cXoYsC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711355967; c=relaxed/simple;
	bh=BAC+WVMO1tGwo33xnug+/2dC0AeTsQNT40RAmXUK4xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsYETpqs/wf3wrMnfjh6MEBCwVXn67kzIzoGc3uWgfDmBsA+izSbaFNlOlynbX+cNpKFts/OZzoRst6VyRv3CiknvHQr+lHHCwpXDnD9rktYmo+kKTIODNqQcwcwyi2sien75TSrwKKZYGbuknlWZJ3O7ZBkSgE5ULKezKiui6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AejJBxrw; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4a3a5e47baso49078366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 01:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711355964; x=1711960764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0kZP691y+X37CeRc5a1b81NRGe9/CqFEZLGS/IX9lU=;
        b=AejJBxrwlY9xMNHTAWsRBde6Bh81IF2usY9qx0V3mmk8vL/V34nE6lnKoSJdXIp1T/
         WgtWI0hemmrxb/yD/niOZYOKa9+dP+dyX+qr3830Pzm0S6PEs2MS3pHL8ivcyVEcvuEU
         Ekt4A3LEdbHD/KDOTzwMJ6P9XxsSgx67YHb0N0SELG/hddkSaSfZPFlDevctAWRzCm5A
         F96wL6X0Ean8jJkPGPBZrADj1KtXnt5qBV5RzbxFdlcFsWdRz1vykxw637MQFH18w1gv
         kq/Ghm/QUfA5U7Nc1ZsSoFOQUgunIcAxhhUTjeGNq4OO6/byjloGPn9LPWkRs9VTCn6w
         /yTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711355964; x=1711960764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0kZP691y+X37CeRc5a1b81NRGe9/CqFEZLGS/IX9lU=;
        b=VvdnppPV0iHGUfWZkeplDoWaf8RIciZmJviFjAzXN5Y2JUefTfyTxJFCdsqsNGC/Qk
         lHraQ+yFkEtlIb60UXlWtzR1ZDaTUOIhyADp2D02ssOH3+vzjYF5ypVhoPFXKn0WKnMs
         v8On67hoTPwg8QinUEn9W1vsBjYQMKItczysPC7RX+NfRhjyvTR1J5rW7twnHYcPxDH6
         oXayiT47nvhIp34xx7FerRw0Kxf3gEg6nF3vHPwjRlUm2Be/hf/ym0iAKqbooq861Xey
         FJrJUC3Mndos2Qh0faq4ED2r7WaZDXc0nlbQsrAu5iFVfq+KXRTLB/uS7xibc+Evj30i
         V7Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVvCbe8UxpBv13Ox3gPI9IhWLvcHi2pns16H3cjDtBSlmah0QJA0+rx4eyjN10iwItJPPXflIPQQXNxQOfyG8fr3xAw06bug8Ar5SD5
X-Gm-Message-State: AOJu0YxWjVAQ63PfJc6hGWywEYBVeL0iEyrid+mlEWwO2Vk2azdDwSvU
	aLmG6vzaBndEQGD9/G95vgaEO9e9Eko+Xkoe1WvRp0Rwp7raFNp4HuJpG8L2jakqlObadyI7MBD
	yLpnMrINmQVFdFuZwylpf3QWUsBMlfaB9nZmX
X-Google-Smtp-Source: AGHT+IFgl4zrYBmL1mnbXRObDbHIPSKGVSR/6CfTP061t6LzL7AucWLMmH83VFZD1AhGOhS3BZxguvOWKzC2W1yUwAk=
X-Received: by 2002:a17:906:c109:b0:a47:6bd4:cbd9 with SMTP id
 do9-20020a170906c10900b00a476bd4cbd9mr2433483ejc.52.1711355964219; Mon, 25
 Mar 2024 01:39:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324210447.956973-1-hannes@cmpxchg.org> <CAJD7tkaWQAV=X1pzYG=VkWe7Ue9ZFbjt9uQ5m1NJujtLspWJTA@mail.gmail.com>
 <CAGsJ_4yeBmNsMGXEWwC+1Hs5zJUP+becq4wG+6CpU7V1=EOvhg@mail.gmail.com>
 <CAJD7tka5K69q20bxTsBk38JC7mdPr3UsxXpsnggDO_iQA=qxug@mail.gmail.com> <1e7ce417-b9dd-4d62-9f54-0adf1ccdae35@linux.dev>
In-Reply-To: <1e7ce417-b9dd-4d62-9f54-0adf1ccdae35@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 25 Mar 2024 01:38:47 -0700
Message-ID: <CAJD7tkYc3oFho5eEkS1zmr_+CC-Ag1HucUTyAy2RJbEb4SqRoQ@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix data loss on SWP_SYNCHRONOUS_IO devices
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Barry Song <21cnbao@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Zhongkun He <hezhongkun.hzk@bytedance.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Chris Li <chrisl@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 12:33=E2=80=AFAM Chengming Zhou
<chengming.zhou@linux.dev> wrote:
>
> On 2024/3/25 15:06, Yosry Ahmed wrote:
> > On Sun, Mar 24, 2024 at 9:54=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> >>
> >> On Mon, Mar 25, 2024 at 10:23=E2=80=AFAM Yosry Ahmed <yosryahmed@googl=
e.com> wrote:
> >>>
> >>> On Sun, Mar 24, 2024 at 2:04=E2=80=AFPM Johannes Weiner <hannes@cmpxc=
hg.org> wrote:
> >>>>
> >>>> Zhongkun He reports data corruption when combining zswap with zram.
> >>>>
> >>>> The issue is the exclusive loads we're doing in zswap. They assume
> >>>> that all reads are going into the swapcache, which can assume
> >>>> authoritative ownership of the data and so the zswap copy can go.
> >>>>
> >>>> However, zram files are marked SWP_SYNCHRONOUS_IO, and faults will t=
ry
> >>>> to bypass the swapcache. This results in an optimistic read of the
> >>>> swap data into a page that will be dismissed if the fault fails due =
to
> >>>> races. In this case, zswap mustn't drop its authoritative copy.
> >>>>
> >>>> Link: https://lore.kernel.org/all/CACSyD1N+dUvsu8=3DzV9P691B9bVq33er=
wOXNTmEaUbi9DrDeJzw@mail.gmail.com/
> >>>> Reported-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> >>>> Fixes: b9c91c43412f ("mm: zswap: support exclusive loads")
> >>>> Cc: stable@vger.kernel.org      [6.5+]
> >>>> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> >>>> Tested-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> >>
> >> Acked-by: Barry Song <baohua@kernel.org>
> >>
> >>>
> >>> Do we also want to mention somewhere (commit log or comment) that
> >>> keeping the entry in the tree is fine because we are still protected
> >>> from concurrent loads/invalidations/writeback by swapcache_prepare()
> >>> setting SWAP_HAS_CACHE or so?
> >>
> >> It seems that Kairui's patch comprehensively addresses the issue at ha=
nd.
> >> Johannes's solution, on the other hand, appears to align zswap behavio=
r
> >> more closely with that of a traditional swap device, only releasing an=
 entry
> >> when the corresponding swap slot is freed, particularly in the sync-io=
 case.
> >
> > It actually worked out quite well that Kairui's fix landed shortly
> > before this bug was reported, as this fix wouldn't have been possible
> > without it as far as I can tell.
> >
> >>
> >> Johannes' patch has inspired me to consider whether zRAM could achieve
> >> a comparable outcome by immediately releasing objects in swap cache
> >> scenarios.  When I have the opportunity, I plan to experiment with zRA=
M.
> >
> > That would be interesting. I am curious if it would be as
> > straightforward in zram to just mark the folio as dirty in this case
> > like zswap does, given its implementation as a block device.
> >
>
> This makes me wonder who is responsible for marking folio dirty in this s=
wapcache
> bypass case? Should we call folio_mark_dirty() after the swap_read_folio(=
)?

In shrink_folio_list(), we try to add anonymous folios to the
swapcache if they are not there before checking if they are dirty.
add_to_swap() calls folio_mark_dirty(), so this should take care of
it. There is an interesting comment there though. It says that PTE
should be dirty, so unmapping the folio should have already marked it
as dirty by the time we are adding it to the swapcache, except for the
MADV_FREE case.

However, I think we actually unmap the folio after we add it to the
swapcache in shrink_folio_list(). Also, I don't immediately see why
the PTE would be dirty. In do_swap_page(), making the PTE dirty seems
to be conditional on the fault being a write fault, but I didn't look
thoroughly, maybe I missed it. It is also possible that the comment is
just outdated.


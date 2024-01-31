Return-Path: <linux-kernel+bounces-47387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1C7844D2B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB651C214C2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E98C3B798;
	Wed, 31 Jan 2024 23:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QATPpItI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AD53B785
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706744295; cv=none; b=bgsin4Bmiax0EhKdmpe3feDrKQKsGya96qJiEdqoLGtASRDDOTvwD0sNKve0J1xb60NZjew1hCNCJI9aAoqWqfs2tigNDeHSURoYWePcB2W270YtX8tOTtZzdfgu9FW8seAhhex+F7rMwDemeF/vfR3TtyYFaVQl3ee03KGZZ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706744295; c=relaxed/simple;
	bh=6WEOBZD8BEPfYQSuPkRb9qFLZYglJJhBpRxM4e7iLD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yys7OUGh1wUFHOz6nDumLYDHJh7NJ7ZLLruHyFh+aafJZXp87G1XT3uQCdhY1D0EJqNGQsiO1uuVrod1vZG8RM5KCqugTPCRatoamR697ODaTmSkayJyEkGJ0vwZARVEWDHr4fhrzjCV+18gB6U0Ws41GAQ+hZH1N/Jyw2AnZOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QATPpItI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB10C433C7
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706744295;
	bh=6WEOBZD8BEPfYQSuPkRb9qFLZYglJJhBpRxM4e7iLD0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QATPpItIWBSTebzG8b5hlHSthvcoig7hoxvezVOI8IdMJeR98lIGKaIUoZiF7F6JN
	 2OrvhTRfEwP1Dd88fWA2rHp/vtTR3jS3aYT9aJU802ew7sYNXn9SIHyPx6heHH60eP
	 K84d8lEXsniPWcGef6rIKtWRpcGZ/vjApURVNAYgKKG388MunSJYXc29g478lCjMYZ
	 FezMa+jisWrrbBOgd10K/jGnplcXTk2+BOKruPCtDsB88mVT0Jev+QKGBcUin4WIjE
	 BL7aAsJE4U8HgGlaJAlBCLW80I2pyHKphrfdukPrmZ9DmczomOruO7wXTw2lRWZ1yV
	 9wIRoOmqQxG+Q==
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-363793e88abso1579685ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:38:15 -0800 (PST)
X-Gm-Message-State: AOJu0YwP0ldOQ05N08HuRW7PVyqCwy6zLgFW7MsoZ1485juAN2RLJuMj
	aLk9LgSC3hU7nAwGZIQiyGSz0bU1EQajRliuo54qludKy4lmUdMZgnrwoLT10rBdvTuupjCPYT1
	LSPW07ju93WzkX3FrsyOvZOWUiQxNePey4Ixg
X-Google-Smtp-Source: AGHT+IHkW8gERceSlDMAZa1yGDxWtMSq/h8BOCgzZX46kKgBoVsQnlZ0Y7oJTnRREO5qNS/fauhJ1BuHWuaubhHNZD8=
X-Received: by 2002:a92:d190:0:b0:363:9665:1a64 with SMTP id
 z16-20020a92d190000000b0036396651a64mr841907ilz.10.1706744294562; Wed, 31 Jan
 2024 15:38:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129175423.1987-1-ryncsn@gmail.com> <20240129175423.1987-7-ryncsn@gmail.com>
 <87bk92gqpx.fsf_-_@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87bk92gqpx.fsf_-_@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 31 Jan 2024 15:38:02 -0800
X-Gmail-Original-Message-ID: <CAF8kJuPq-yQ-0Ka4BmqFZDwbiHNdb5MZyXVK4zxBWSgRZvNfrw@mail.gmail.com>
Message-ID: <CAF8kJuPq-yQ-0Ka4BmqFZDwbiHNdb5MZyXVK4zxBWSgRZvNfrw@mail.gmail.com>
Subject: Re: Whether is the race for SWP_SYNCHRONOUS_IO possible? (was Re:
 [PATCH v3 6/7] mm/swap, shmem: use unified swapin helper for shmem)
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Minchan Kim <minchan@kernel.org>, Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org, 
	Kairui Song <kasong@tencent.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 6:53=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Hi, Minchan,
>
> When I review the patchset from Kairui, I checked the code to skip swap
> cache in do_swap_page() for swap device with SWP_SYNCHRONOUS_IO.  Is the
> following race possible?  Where a page is swapped out to a swap device
> with SWP_SYNCHRONOUS_IO and the swap count is 1.  Then 2 threads of the
> process runs on CPU0 and CPU1 as below.  CPU0 is running do_swap_page().
>
> CPU0                            CPU1
> ----                            ----
> swap_cache_get_folio()
> check sync io and swap count
> alloc folio
> swap_readpage()
> folio_lock_or_retry()
>                                 swap in the swap entry
>                                 write page
>                                 swap out to same swap entry
> pte_offset_map_lock()
> check pte_same()
> swap_free()   <-- new content lost!
> set_pte_at()  <-- stale page!
> folio_unlock()
> pte_unmap_unlock()

Yes, that path looks possible but hard to hit due to the requirement
of swap in and swap out in a short window.
I have the similar question on the previous zswap rb tree to xarray
discussion regarding deleting an entry where the entry might change
due to swap in then swap out.

Chris


Return-Path: <linux-kernel+bounces-54368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5936084AE4C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D97C1C23E88
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9EB83CA8;
	Tue,  6 Feb 2024 06:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="p8pNrKbt"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AFC83CA3
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 06:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707199410; cv=none; b=e60v56PZQ2uoeQyI/tQM6YuOw39PC5k5GDlpoKE+PRdGwLgABfiu9btovuAyLhBVDKxDo/3bLoXfGQYfTl2mamY44nY861Uzd1wgwQpPLo3ynp1C6t3p/bBho2I334NzzEhRIuemFhTE5RBthty+fsv+QTqDampzxyVe9nESLI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707199410; c=relaxed/simple;
	bh=qE4jXBKDVxmzKu5TuMJNlE+KfnbUmz1DhmtgM/TzPyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cO5in3MLVe2yde3uXLsuyzkyUsXawssnusB33YhkHbGouG/Zhm+QpniAMqguszxxj68swLgQ4LgzfuhrdZvbOtVFbIBWnsaIADT8H2+G5MKEfFSdxRiBvFtwN24d6vOE6k+1rSFiJOVQuIxaGwcVPHteXEwRLjjhiLnCkTyNvaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p8pNrKbt; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40f00adacfeso26345e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 22:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707199407; x=1707804207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjFH8fbG0Ckyf4Y0Lr6C3ppBK8/hdbSaW/tDrqzlhi8=;
        b=p8pNrKbtzZ0L1saEtWwi55ZNH4CCOJAhfca1t9r5GwWwcl831OfYPONHQBUg5+P9Ke
         0DPXd3A+s0rx97K6VdZm/hxt1DrSFxY7WOyqyMoNL6JhWFfC9ScUBIkV41r0p+xvEFP5
         yrFsWy0iv3+/PPXRc6vvGcfbrS6IR1BWcsF82HX18+2M5NmjlV4z1XMK5byx0xR21YZC
         gP61gRoYsp8kUpPC4ZOmJEq1+SGJ3k99CQNII4itD5g/241u8+/dGmoaVAv5ahgHYTgK
         yXqM1YfkiLFYlm6pxun51h3yXfHbVpWoEdQ6LKbdZxlOxCImhI45egPTTa9j9xXN3HnR
         bvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707199407; x=1707804207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjFH8fbG0Ckyf4Y0Lr6C3ppBK8/hdbSaW/tDrqzlhi8=;
        b=XqSASycvjHRi3d5zTsVOpD+ZcUpISia/ITGK/543b9yhuHr/Jb3yIJwDbpX+sqcGjF
         AeKL5HZ7Ik9zIbcIchIrBRPMrVFltWjNZCA7xKPhbsq8yNoKvKdjFsQ8WBw3V2I26Fma
         cilz/9YJ97jss4D2OLVYv6+jGz/zEiUJHdSJYwWXdSTGSsMlmiA41oqjGfj/75c2p5/p
         HngRjh5hHTFgy4SSJBoxpqBu2gMs5fK/k49CKt9u5koJyaWWB0xeljo9W+u3Ng7kkpNA
         S8GljdP9iuOzTj5OgG993yDFpFYWEInsdBRBfsopwO8E29iwh+m1W4MgK7bZuXjaDQzh
         D9SQ==
X-Gm-Message-State: AOJu0Yyw6oobA+NUN+1gxUrDD4AkcVruOMl2m7NKbPe65Z0oMAodGA/Y
	F3routs6UKdk4iIvK3FoV9wfm8GvKc5oaiQsk/pqydL8rt67ty1kOQ184FOVhset9gjr8KSiIrL
	pfyBj/+d2u/i62wVs3CH2dr6+UQLYR63sxPo0
X-Google-Smtp-Source: AGHT+IEEW3JbfMzW7WyrRJQVHFCdE7tui9MBRHxUgJxt8SfSAJRDiSJgaaNfFo8POz1iaNq0F9cDwueTtNqwrGbmWVo=
X-Received: by 2002:a05:600c:3d8a:b0:40e:f5c6:738a with SMTP id
 bi10-20020a05600c3d8a00b0040ef5c6738amr134041wmb.0.1707199406818; Mon, 05 Feb
 2024 22:03:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205110959.4021-1-ryncsn@gmail.com>
In-Reply-To: <20240205110959.4021-1-ryncsn@gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 5 Feb 2024 23:02:48 -0700
Message-ID: <CAOUHufYYoW6Nn26YsdBwxDw8iNLRf2c6ZLoF530YCgYZ2uvikQ@mail.gmail.com>
Subject: Re: [PATCH] mm/swap: fix race condition in direct swapin path
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>, 
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 4:10=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> From: Kairui Song <kasong@tencent.com>
>
> In the direct swapin path, when two or more threads swapin the same entry

There is no other places referring to that path as "direct" swapin.

I'd rephrase it as: "When skipping swapcache for SWP_SYNCHRONOUS_IO,
..", and similarly for the subject: "mm: fix race when skipping
swapcache".

> at the same time, they get different pages (A, B) because swap cache is
> skipped. Before one thread (T0) finishes the swapin and installs page (A)
> to the PTE, another thread (T1) could finish swapin of page (B),
> swap_free the entry, then modify and swap-out the page again, using the
> same entry. It break the pte_same check because PTE value is unchanged,
> causing ABA problem. Then thread (T0) will then install the stalled page
> (A) into the PTE so new data in page (B) is lost, one possible callstack
> is like this:
>
> CPU0                                CPU1
> ----                                ----
> do_swap_page()                      do_swap_page() with same entry
> <direct swapin path>                <direct swapin path>
> <alloc page A>                      <alloc page B>
> swap_readpage() <- read to page A   swap_readpage() <- read to page B
> <slow on later locks or interrupt>  <finished swapin first>
> ...                                 set_pte_at()
>                                     swap_free() <- Now the entry is freed=
.
>                                     <write to page B, now page A stalled>
>                                     <swap out page B using same swap entr=
y>
> pte_same() <- Check pass, PTE seems
>               unchanged, but page A
>               is stalled!
> swap_free() <- page B content lost!
> set_pte_at() <- staled page A installed!
>
> To fix this, reuse swapcache_prepare which will pin the swap entry using
> the cache flag, and allow only one thread to pin it. Release the pin
> after PT unlocked. Racers will simply busy wait since it's a rare
> and very short event.
>
> Other methods like increasing the swap count don't seem to be a good
> idea after some tests, that will cause racers to fall back to the
> cached swapin path, two swapin path being used at the same time
> leads to a much more complex scenario.
>
> Reproducer:
>
> This race issue can be triggered easily using a well constructed
> reproducer and patched brd (with a delay in read path) [1]:
>
> With latest 6.8 mainline, race caused data loss can be observed easily:
> $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
>   Polulating 32MB of memory region...
>   Keep swapping out...
>   Starting round 0...
>   Spawning 65536 workers...
>   32746 workers spawned, wait for done...
>   Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data loss!
>   Round 0: Error on 0x395200, expected 32746, got 32743, 3 data loss!
>   Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data loss!
>   Round 0 Failed, 15 data loss!
>
> This reproducer spawns multiple threads sharing the same memory region
> using a small swap device. Every two threads updates mapped pages one by
> one in opposite direction trying to create a race, with one dedicated
> thread keep swapping out the data out using madvise.
>
> The reproducer created a reproduce rate of about once every 5 minutes,
> so the race should be totally possible in production.
>
> After this patch, I ran the reproducer for over a few hundred rounds
> and no data loss observed.
>
> Performance overhead is minimal, microbenchmark swapin 10G from 32G
> zram:
>
> Before:     10934698 us
> After:      11157121 us
> Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
>
> Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchronous =
device")
> Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stress-=
race [1]
> Signed-off-by: Kairui Song <kasong@tencent.com>

Cc: stable@vger.kernel.org

Acked-by: Yu Zhao <yuzhao@google.com>


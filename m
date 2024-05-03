Return-Path: <linux-kernel+bounces-168196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F27618BB4F8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B3A1F211A8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F29C23775;
	Fri,  3 May 2024 20:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsqdJ6Oc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961151C68C
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 20:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714768639; cv=none; b=BqRs+xOot0qqzyWhwmNaSqDxJuS5EgWkQ5mp8Ih5GJytXEp1I9tY0vI+6aoHAHXSH/cHhkltmZmoCkIxUWwp8x/QJ2Odto9DN9cfVTXhUxSCi+0vGKAhYWeG2nkIjTLkbPWaM2egr0b9Lvi/b1yC/Pr7Y1eoSP1tGEKUsZrpizU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714768639; c=relaxed/simple;
	bh=Ro+9bsKaVb7uKrUgAz6odmTDr5TLuTDADOERyWJUfzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bdvdJi0SVtwujnTcRJkKqvTYRXOEzPPNOPfwRVuG7atHRGXv3GrvHPJShUA1NTWRJOCrUz3o/AOc8yTa/AW6h+Zf65NeVblUWTFqs43ofuS6Hb/UZ/Bzd7Ux9S2ztZVjTG3lx3UJSI2nD+6ux7K8tydJ380yvk/0LxHSPtfFAJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsqdJ6Oc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29849C4AF1D
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 20:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714768639;
	bh=Ro+9bsKaVb7uKrUgAz6odmTDr5TLuTDADOERyWJUfzo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EsqdJ6OcJWETWUhpCwpMA7kVhcwZbo4QGKsPZtOs9q7uO3/eGBBBCWZKREVzl4RIK
	 hdAiCBv1k9GwUDF4nK0yl6Qwwr0GnMu7WtEcF/WYH00xkIr5jlvxoDXKdqlfOSCN9V
	 XUaxC4s/2EMuszcHyJxbBP5SWt2UHBHOf41LJqsYJzcWS4impzbgs9NahTZuFGDI08
	 90zPJ5xsZ4PxCL807Y4t6UPj//c+N3fpOcxH8ImzjStW3kzck2w6W04G39nB+sQyjW
	 qHWKENAVkMtKy42gzCGJs+1fSuJsLhRRU7qjmW64MDaB8Yzyz6LkrNyPqJ7DAIMaIJ
	 ggBwULvOxCwTw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2db6f5977e1so987431fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 13:37:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+kwxqv5szS0SXyDll0Or9caOhO3VaTANkAZF4EYVVEXIiHZ4I9ZhD93ayx9ga4c5nD2hbjNvNi0e7vJBMYq4ya6wzhFhoxyWoBtzK
X-Gm-Message-State: AOJu0Yy1q2WllTQX5qUlZnMNaRclL97RQuiyGhKTB2S/3KLfLXHkLn49
	WROHYc2KXRFIEfb+pffuurmOKijTlw9fBvKvkSuTv6CAAihEIDXeO0jat/KkXY4kfa26T9+GT7B
	j/kFqOS+eYENZ+nm8cYHlEwKmUQ==
X-Google-Smtp-Source: AGHT+IEU6kJH3Hj6GBk7ZMK9MNzSJ/pnpqC7ouSpGxATXAjHjv95yzliu3RZvgHmJZWZt8RFNmPRaERLowg9znSoslg=
X-Received: by 2002:a2e:9d19:0:b0:2e1:eb27:3513 with SMTP id
 t25-20020a2e9d19000000b002e1eb273513mr2443272lji.52.1714768637832; Fri, 03
 May 2024 13:37:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503005023.174597-1-21cnbao@gmail.com> <20240503005023.174597-3-21cnbao@gmail.com>
 <e0c1cbb2-da06-4658-a23a-962496e83557@arm.com>
In-Reply-To: <e0c1cbb2-da06-4658-a23a-962496e83557@arm.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 3 May 2024 13:37:06 -0700
X-Gmail-Original-Message-ID: <CANeU7QkYXmpmTAVjGqin4Wpg9hydPPYZKho-MwQMMt9uJ8Lu4Q@mail.gmail.com>
Message-ID: <CANeU7QkYXmpmTAVjGqin4Wpg9hydPPYZKho-MwQMMt9uJ8Lu4Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] mm: remove swap_free() and always use swap_free_nr()
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, david@redhat.com, hanchuanhua@oppo.com, 
	hannes@cmpxchg.org, hughd@google.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, xiang@kernel.org, ying.huang@intel.com, 
	yosryahmed@google.com, yuzhao@google.com, ziy@nvidia.com, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 2:31=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 03/05/2024 01:50, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > To streamline maintenance efforts, we propose discontinuing the use of
> > swap_free(). Instead, we can simply invoke swap_free_nr() with nr set
> > to 1. This adjustment offers the advantage of enabling batch processing
> > within kernel/power/swap.c. Furthermore, swap_free_nr() is designed wit=
h
> > a bitmap consisting of only one long, resulting in overhead that can be
> > ignored for cases where nr equals 1.
> >
> > Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Hugh Dickins <hughd@google.com>
> > ---
> >  include/linux/swap.h |  5 -----
> >  kernel/power/swap.c  |  7 +++----
> >  mm/memory.c          |  2 +-
> >  mm/rmap.c            |  4 ++--
> >  mm/shmem.c           |  4 ++--
> >  mm/swapfile.c        | 19 +++++--------------
> >  6 files changed, 13 insertions(+), 28 deletions(-)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index d1d35e92d7e9..f03cb446124e 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -482,7 +482,6 @@ extern int add_swap_count_continuation(swp_entry_t,=
 gfp_t);
> >  extern void swap_shmem_alloc(swp_entry_t);
> >  extern int swap_duplicate(swp_entry_t);
> >  extern int swapcache_prepare(swp_entry_t);
> > -extern void swap_free(swp_entry_t);
>
> I wonder if it would be cleaner to:
>
> #define swap_free(entry) swap_free_nr((entry), 1)
>
> To save all the churn for the callsites that just want to pass a single e=
ntry?
>
Either way works. It will produce the same machine code. I have a
slight inclination to just drop swap_free(entry) API so that it
discourages the caller to do a for loop over swap_free().

Acked-by: Chris Li <chrisl@kernel.org>

Chris


Return-Path: <linux-kernel+bounces-41465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 155D383F246
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEA2E28258D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C65E23745;
	Sat, 27 Jan 2024 23:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMCoWS7R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DC822F0F
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 23:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706398923; cv=none; b=L2w2IH0lSasoZKufl4LyFzcGfXMpJlUGO1vABMONVVdnN1t2odMxmigw825vvVF0C3WUNuRNRsQCDFmq4q1tn363NWm4UKGCx+mKCa7+sv8bdsdtcPjnCzF52GORMx5XBs3pcTbrugbvNSTMvv2vy202yxklwo4KcS7+Pddr2Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706398923; c=relaxed/simple;
	bh=aLwsjk+yqZJ8iDmZN++A6YSY8VPjmsd8uJByyE+0yic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTmeN3mQcCBxOh5uUjW67BoUiR8YmZ+12g58g9z9SdMrC5/niGIsSgfY0uaBntwnP1pQO3LYNwreKVETZLJd6VIt3T//asHixTmCVurCTo6LGLBoQ9tCQ8tv3e+0JwUQ8vQhp4bdxfynIe+fUTsfcV/eIyhg5+OhDwF1A4kjJuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMCoWS7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89135C4166B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 23:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706398923;
	bh=aLwsjk+yqZJ8iDmZN++A6YSY8VPjmsd8uJByyE+0yic=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RMCoWS7RHEo8nhQFvZPcaWsccsH97v0vREo4GbTlKeqs1Ma/nR7q8KiYpgf2S5krL
	 5ed0URKDyDU6ppoyYCyQZYunRGrT98uaxFaFOaKECCtPSxKMq2SbVjLSmKbAqyMZpe
	 w9/hrV9Re7Sbreays5AxS6Vi28D9karYZmqtA9zzr1UjsBwkwuYTM0tFm1HjUb2p/1
	 wycOdo1v1stuZwd7RilsmoGrhoBiU+Ghu6WrpJhAXJ0tOQqCgkGDdgkQqrxnX4Fsq4
	 X4ZiImJEvqnbo/is7lOhleMeG6USBd9mFLudy9ZmKUcpoL5WAAlez4Weh9lw47ttJ0
	 qenfayiqkpFoA==
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3606ebda57cso4820595ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 15:42:03 -0800 (PST)
X-Gm-Message-State: AOJu0YzU4zUvffb8yVXfZ/ThK18xSmvodXOV6e9ut3eTEbTqr/7JyAHa
	rAgj7YSTf3I8HudgzXSHvDN1I/Es9X9VWDvwfezWhlpT2egchfF7J1dkJQH/uhiN5RSDQ7zK/lJ
	ELr3emHisye+UhO3HrAsiW5LFB26kyzXKDh+x
X-Google-Smtp-Source: AGHT+IHMmu2yTpnyL+/ZXXoAtF/7A3G+VhWLCcrtqUzTADdDWs3F5D1IQl0EO/XykzpJM61HYI/TYpJ5L4Hlk9Ugw8w=
X-Received: by 2002:a92:2a03:0:b0:363:73ae:5f86 with SMTP id
 r3-20020a922a03000000b0036373ae5f86mr2119802ile.2.1706398922757; Sat, 27 Jan
 2024 15:42:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025144546.577640-1-ryan.roberts@arm.com> <20240118111036.72641-1-21cnbao@gmail.com>
 <20240118111036.72641-6-21cnbao@gmail.com>
In-Reply-To: <20240118111036.72641-6-21cnbao@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Sat, 27 Jan 2024 15:41:50 -0800
X-Gmail-Original-Message-ID: <CAF8kJuN0RkubcLpj-NT8Crycf2-TciM2yGhUDBNpzBji6TQ3rg@mail.gmail.com>
Message-ID: <CAF8kJuN0RkubcLpj-NT8Crycf2-TciM2yGhUDBNpzBji6TQ3rg@mail.gmail.com>
Subject: Re: [PATCH RFC 5/6] mm: rmap: weaken the WARN_ON in __folio_add_anon_rmap()
To: Barry Song <21cnbao@gmail.com>
Cc: ryan.roberts@arm.com, akpm@linux-foundation.org, david@redhat.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	shy828301@gmail.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, yuzhao@google.com, surenb@google.com, 
	steven.price@arm.com, Barry Song <v-songbaohua@oppo.com>, 
	Chuanhua Han <hanchuanhua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 3:12=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> In do_swap_page(), while supporting large folio swap-in, we are using the=
 helper
> folio_add_anon_rmap_ptes. This is triggerring a WARN_ON in __folio_add_an=
on_rmap.
> We can make the warning quiet by two ways
> 1. in do_swap_page, we call folio_add_new_anon_rmap() if we are sure the =
large
> folio is new allocated one; we call folio_add_anon_rmap_ptes() if we find=
 the
> large folio in swapcache.
> 2. we always call folio_add_anon_rmap_ptes() in do_swap_page but weaken t=
he
> WARN_ON in __folio_add_anon_rmap() by letting the WARN_ON less sensitive.
>
> Option 2 seems to be better for do_swap_page() as it can use unified code=
 for
> all cases.
>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Tested-by: Chuanhua Han <hanchuanhua@oppo.com>
> ---
>  mm/rmap.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index f5d43edad529..469fcfd32317 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1304,7 +1304,10 @@ static __always_inline void __folio_add_anon_rmap(=
struct folio *folio,
>                  * page.
>                  */
>                 VM_WARN_ON_FOLIO(folio_test_large(folio) &&
> -                                level !=3D RMAP_LEVEL_PMD, folio);
> +                                level !=3D RMAP_LEVEL_PMD &&
> +                                (!IS_ALIGNED(address, nr_pages * PAGE_SI=
ZE) ||
Some minor nitpick here.
There are two leading "(" in this and next line. This is the first "("
> +                                (folio_test_swapcache(folio) && !IS_ALIG=
NED(folio->index, nr_pages)) ||
 Second "("  here.

These two "(" are NOT at the same nested level. They should not have
the same indentation.
On my first glance, I misread the scope of the "||" due to the same
level indentation.
We can do one of the two
1) add more indentation on the second "(" to reflect the nesting level.

> +                                page !=3D &folio->page), folio);

Also moving the folio to the next line, because the multiline
expression is huge and complex. Make it obvious the ending "folio" is
not part of the testing condition.

2) Move the multiline test condition to a checking function. Inside
the function it can return early when the shortcut condition is met.
That will also help the readability of this warning condition.

Chris

>                 __folio_set_anon(folio, vma, address,
>                                  !!(flags & RMAP_EXCLUSIVE));
>         } else if (likely(!folio_test_ksm(folio))) {
> --
> 2.34.1
>
>


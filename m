Return-Path: <linux-kernel+bounces-121372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECF088E707
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423C51C2E0B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA44213B2A7;
	Wed, 27 Mar 2024 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWHMtXU2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34DC757E2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711546632; cv=none; b=AWe8EnihKi4BULp1ixJo/ei8hdNf4YEUVtV03em5MXybL/V0vBBKQ/jS4ramOjrgZaaI1u3cIwZkEPFN1QPOJo6hyZnuFtsHMgWClJFNw4N+vsjGd+arsIWum6zNgwV+gWdmTlpkuUwOdY+FM9VKUC3KvBadNcgkFV/SpRKHoBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711546632; c=relaxed/simple;
	bh=4kHnzA0Y1bG0RjYt/6IjBJD4JLhF/tyQ/ysWOdr8TTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSoi7fMVt6QYoyW1LfspRVY+A/uroxZkUAWKUTfmrUszOGSjYguo2/cXCDM8j1GeloXLjRQsHL80Qen0rpevWDLwwUmcTeO2o0A8WS9/2Bwc1RIKGNb38euKjAMaMArcfK57iJEKVt4g1vJnaTlhNtYKvOkCSwp9HVcjBF7B4dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWHMtXU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEB0C43390
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711546631;
	bh=4kHnzA0Y1bG0RjYt/6IjBJD4JLhF/tyQ/ysWOdr8TTM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CWHMtXU2B4HXGHS+6Ee9JEN2Km5g8yVGTdDS+iga/kGFktMmBB2XA0m/8X0GZu0mL
	 MWuD35/QjRisFtZfAsZY+FMwjL07hRSqueCKpcgKWpvZ4pHwlMJ6qJyDReDlxFB3iL
	 iTv53ZzqJ2H+l6xVpPsqTCxXWiJtQAcE376er8eIPfc61gTNefQVYN9E4DhgIoSMgO
	 BOvIoX20KaeNMUkIZzxn8ux1Zn1MYMDs/BtuQqr0Dfbmm8rjMj1n+vELDG77fbanDU
	 qlKMLRjDjyP4zrtf/DljLRzEO4XvjTXLgwf5r343h8y4hZKHKHcNLckvRnHKAo9wPE
	 0tuzilvumGf6A==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d228a132acso90380331fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 06:37:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2m5r+rLzxo4r6MZFe7xw9oOZx+acOIgaUazGUawarPvi0TJ4Bs/p0WVcj54504uFNBReN28sHiiqmECkmplK5qs6TwnE5OidInKa0
X-Gm-Message-State: AOJu0YwdRKO+7XAI0zGicLxnC5YLNCbczBeBBuj2AQ2hiG+v7bb/W98O
	7KoCnpQKzrHT5w4zluXKTQwPdCPSMNdPFGev2+EgPzE3yOQqy8wd8pMCcHc8hHH/t7lDMIFKkBK
	8GFdlaZQIjm06ic4reZQiRmuiBmo=
X-Google-Smtp-Source: AGHT+IHPy1Xcev/pWnJqRHKFj89rYyteSuve3dI04GTmEZcix/SbYeGZAnwvl8cQKm40ItA9gFEIPUrZ0ZDvUd8EPsI=
X-Received: by 2002:a2e:a7d0:0:b0:2d6:93c9:1f87 with SMTP id
 x16-20020a2ea7d0000000b002d693c91f87mr49104ljp.4.1711546629919; Wed, 27 Mar
 2024 06:37:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326101448.3453626-1-ryan.roberts@arm.com>
 <CAMj1kXEEi2ZXs+1qwR97zod5Z+TerPKcKZBN8LGZ5XTRV0_-rg@mail.gmail.com> <e1078fe2-0b0b-48c6-8d24-3b2e835201b1@arm.com>
In-Reply-To: <e1078fe2-0b0b-48c6-8d24-3b2e835201b1@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 27 Mar 2024 15:36:58 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGtNYce5cOwUc+X5ceyxLGzD1xUEx7JRXqg7+4XQMAORw@mail.gmail.com>
Message-ID: <CAMj1kXGtNYce5cOwUc+X5ceyxLGzD1xUEx7JRXqg7+4XQMAORw@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Speed up boot with faster linear map creation
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, David Hildenbrand <david@redhat.com>, 
	Donald Dutile <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 12:43, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> On 27/03/2024 10:09, Ard Biesheuvel wrote:
> > Hi Ryan,
> >
> > On Tue, 26 Mar 2024 at 12:15, Ryan Roberts <ryan.roberts@arm.com> wrote:
> >>
> >> Hi All,
> >>
> >> It turns out that creating the linear map can take a significant proportion of
> >> the total boot time, especially when rodata=full. And a large portion of the
> >> time it takes to create the linear map is issuing TLBIs. This series reworks the
> >> kernel pgtable generation code to significantly reduce the number of TLBIs. See
> >> each patch for details.
> >>
> >> The below shows the execution time of map_mem() across a couple of different
> >> systems with different RAM configurations. We measure after applying each patch
> >> and show the improvement relative to base (v6.9-rc1):
> >>
> >>                | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
> >>                | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
> >> ---------------|-------------|-------------|-------------|-------------
> >>                |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
> >> ---------------|-------------|-------------|-------------|-------------
> >> base           |  151   (0%) | 2191   (0%) | 8990   (0%) | 17443   (0%)
> >> no-cont-remap  |   77 (-49%) |  429 (-80%) | 1753 (-80%) |  3796 (-78%)
> >> no-alloc-remap |   77 (-49%) |  375 (-83%) | 1532 (-83%) |  3366 (-81%)
> >> lazy-unmap     |   63 (-58%) |  330 (-85%) | 1312 (-85%) |  2929 (-83%)
> >>
> >> This series applies on top of v6.9-rc1. All mm selftests pass. I haven't yet
> >> tested all VA size configs (although I don't anticipate any issues); I'll do
> >> this as part of followup.
> >>
> >
> > These are very nice results!
> >
> > Before digging into the details: do we still have a strong case for
> > supporting contiguous PTEs and PMDs in these routines?
>
> We are currently using contptes and pmds for the linear map when rodata=[on|off]
> IIRC?

In principle, yes. In practice?

> I don't see a need to remove the capability personally.
>

Since we are making changes here, it is a relevant question to ask imho.

> Also I was talking with Mark R yesterday and he suggested that an even better
> solution might be to create a temp pgtable that maps the linear map with pmds,
> switch to it, then create the real pgtable that maps the linear map with ptes,
> then switch to that. The benefit being that we can avoid the fixmap entirely
> when creating the second pgtable - we think this would likely be significantly
> faster still.
>

If this is going to be a temporary mapping for the duration of the
initial population of the linear map page tables, we might just as
well use a 1:1 TTBR0 mapping here, which would be completely disjoint
from swapper. And we'd only need to map memory that is being used for
page tables, so on those large systems we'd need to map only a small
slice. Maybe it's time to bring back the memblock alloc limit so we
can manage this more easily?

> My second patch adds the infrastructure to make this possible. But your changes
> for LPA2 make it significantly more effort; since that change we are now using
> the swapper pgtable when we populate the linear map into it - the kernel is
> already mapped and that isn't done in paging_init() anymore. So I'm not quite
> sure how we can easily make that work at the moment.
>

I think a mix of the fixmap approach with a 1:1 map could work here:
- use TTBR0 to create a temp 1:1 map of DRAM
- map page tables lazily as they are allocated but using a coarse mapping
- avoid all TLB maintenance except at the end when tearing down the 1:1 mapping.


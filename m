Return-Path: <linux-kernel+bounces-140432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAAF8A145D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029DB283EC5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F20A14B088;
	Thu, 11 Apr 2024 12:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlM4zlXF"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B91E13DDD6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712838240; cv=none; b=ld/8aW7i/r5JOojffS6+5WjAKoOm08QeUzmcWp3unVf9ujNiEazFvgK+Rdcg6CqnNbqpSLQONKkTYZFDKp1piaRzG9cHqLuxAMjmQ1mtIyd+Ww8h/ridrxp4yapQTMDnc9aXJoTCg2sk0IWeUk1XPsHgzaIZf1/YaaFJWbs2VTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712838240; c=relaxed/simple;
	bh=KcZp8o3xXaz77TGqXrvppTqu3b/14PqKNY4zyxkxfxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UxuhKyfymHUTVn1Obu0LyVLym9WeZOi/7K9qsp0DKIjtJDCIsnpgNCSxQqQIkuEVQQbKOwvdj6yVOLccn3lX1jQHZYkAc91d9IJBe76A7VAqTf8/W+S9VBoiM8e9DZnG14RyGwM9Fr9GG7lorbqjTAL63wNPWauT20fSgbjfaPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlM4zlXF; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56fc155b646so2182268a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 05:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712838237; x=1713443037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KU++dEJizkyzzjRVdJjTg00DMJh8Wg2GKkxH84UqySk=;
        b=UlM4zlXFfCzroDGkaNtOzF8zvFdR9G0LRznQkNIC3zbXaKwvKY8iiP9qtVAp4DtLgX
         Vnf7CkHNDEX2X1v4bcACJcKuMoFyHuYGJwoFCXhf2NWhtEkU+3rpmS7yiPeOASOoL5Ts
         kQy90+GH9KLIJwmgikiUapIxAVpdwBfmIVuVdRXlmz7wK/fXteRqH5FxexNUNRHwYXFm
         uEPiD/QG241mcRgLuQe4nmS3/XQyk5SW7TXPpbLI8Ivr8pIVNwEBPBmS9yw0jYb0A7Si
         Q2LB2hUMXt/1HHvnCx5R7JruOL4jyMksgiOtpMXxzNtby/GkzAuZ3fIEKJGDYarTbcX5
         wSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712838237; x=1713443037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KU++dEJizkyzzjRVdJjTg00DMJh8Wg2GKkxH84UqySk=;
        b=Q3QCy03JxctFP9YwCQLLFgugalwA+EiRij9zuU37DwPh2zOeb3snhp6HLALDsvM+yp
         964DFz5QrD9F0Wxcdhawot0PMaVh1V7UK8bIQmlZiNUOzJ9jKP5oZ4wWyILF7MLIZpzF
         f3EG4jbSZctpGaUmq2X/eF3LELinynM73DoExPdKMeDgIt+OTGCyPANjV4GgZVgsGj/4
         MsOir92jWhkAohdVmid/LQaTAqnZKZ+sAcSPXI+Etf3TdPfj4HOkpr+SMd+FUATYnj0K
         DVvDlj9wDGtQR0y4E7PJmZDxmgFB+1zn4R4Tj2Z8qpr96ojQNfLV1QDTn6drDhazEUHg
         XR3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXi1f7Jn4x8xC+Qb0DNIJWQWZtJoqwWAvVc8beDKJqdNfGWmPyaFiu3gh8tzLrUsTYVZRn6aJd8vF8+YmfmhDHG86E0i4Fuhgtz9Jrv
X-Gm-Message-State: AOJu0YxqKMNq35HNVRRXVZb9KiXwVaWpiAVumSJh44QP0B64Zjt+GaIh
	QDHm5DrAzO82rP6KvgMa1P1VGP0hU3HCQ98Bv3CUysxtEMndEB7HOlpOdP9QGAaF/26ZPBbabSF
	XBKy0Gj9j+pfewoU4U7bhXyJdRRaAmEQH
X-Google-Smtp-Source: AGHT+IE3t1pmqvMACILLqYDEGV6+9xv33IawmivlcP4lNK34k2Ig9vuy8e85f0vHE1SVn0Cp+YoYNdRswrzD5sPpSZM=
X-Received: by 2002:a50:d598:0:b0:56d:e73d:6d74 with SMTP id
 v24-20020a50d598000000b0056de73d6d74mr3361451edi.12.1712838236771; Thu, 11
 Apr 2024 05:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408042437.10951-1-ioworker0@gmail.com> <20240408042437.10951-2-ioworker0@gmail.com>
 <38c4add8-53a2-49ca-9f1b-f62c2ee3e764@arm.com> <013334d5-62d2-4256-8045-168893a0a0cf@redhat.com>
 <a59496b6-ffdf-40ce-b030-283cc911203e@arm.com>
In-Reply-To: <a59496b6-ffdf-40ce-b030-283cc911203e@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 11 Apr 2024 20:23:45 +0800
Message-ID: <CAK1f24=hf2aBRMF5rSwyBxYa3pf7Cq9Y-wpuJ_HDyRxRrbM8sA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] mm/madvise: optimize lazyfreeing with mTHP in madvise_free
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, 21cnbao@gmail.com, 
	mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com, 
	shy828301@gmail.com, xiehuan09@gmail.com, wangkefeng.wang@huawei.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 7:27=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 11/04/2024 12:20, David Hildenbrand wrote:
> > On 11.04.24 13:11, Ryan Roberts wrote:
> >> On 08/04/2024 05:24, Lance Yang wrote:
> >>> This patch optimizes lazyfreeing with PTE-mapped mTHP[1]
> >>> (Inspired by David Hildenbrand[2]). We aim to avoid unnecessary folio
> >>> splitting if the large folio is fully mapped within the target range.
> >>>
> >>> If a large folio is locked or shared, or if we fail to split it, we j=
ust
> >>> leave it in place and advance to the next PTE in the range. But note =
that
> >>> the behavior is changed; previously, any failure of this sort would c=
ause
> >>> the entire operation to give up. As large folios become more common,
> >>> sticking to the old way could result in wasted opportunities.
> >>>
> >>> On an Intel I5 CPU, lazyfreeing a 1GiB VMA backed by PTE-mapped folio=
s of
> >>> the same size results in the following runtimes for madvise(MADV_FREE=
) in
> >>> seconds (shorter is better):
> >>>
> >>> Folio Size |   Old    |   New    | Change
> >>> ------------------------------------------
> >>>        4KiB | 0.590251 | 0.590259 |    0%
> >>>       16KiB | 2.990447 | 0.185655 |  -94%
> >>>       32KiB | 2.547831 | 0.104870 |  -95%
> >>>       64KiB | 2.457796 | 0.052812 |  -97%
> >>>      128KiB | 2.281034 | 0.032777 |  -99%
> >>>      256KiB | 2.230387 | 0.017496 |  -99%
> >>>      512KiB | 2.189106 | 0.010781 |  -99%
> >>>     1024KiB | 2.183949 | 0.007753 |  -99%
> >>>     2048KiB | 0.002799 | 0.002804 |    0%
> >>>
> >>> [1] https://lkml.kernel.org/r/20231207161211.2374093-5-ryan.roberts@a=
rm.com
> >>> [2] https://lore.kernel.org/linux-mm/20240214204435.167852-1-david@re=
dhat.com
> >>>
> >>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> >>> ---
> >>>   include/linux/pgtable.h |  34 +++++++++
> >>>   mm/internal.h           |  12 +++-
> >>>   mm/madvise.c            | 149 ++++++++++++++++++++++---------------=
---
> >>>   mm/memory.c             |   4 +-
> >>>   4 files changed, 129 insertions(+), 70 deletions(-)
> >>>
> >>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> >>> index 0f4b2faa1d71..4dd442787420 100644
> >>> --- a/include/linux/pgtable.h
> >>> +++ b/include/linux/pgtable.h
> >>> @@ -489,6 +489,40 @@ static inline pte_t ptep_get_and_clear(struct mm=
_struct
> >>> *mm,
> >>>   }
> >>>   #endif
> >>>   +#ifndef mkold_clean_ptes
> >>> +/**
> >>> + * mkold_clean_ptes - Mark PTEs that map consecutive pages of the sa=
me folio
> >>> + *        as old and clean.
> >>> + * @mm: Address space the pages are mapped into.
> >>> + * @addr: Address the first page is mapped at.
> >>> + * @ptep: Page table pointer for the first entry.
> >>> + * @nr: Number of entries to mark old and clean.
> >>> + *
> >>> + * May be overridden by the architecture; otherwise, implemented by
> >>> + * get_and_clear/modify/set for each pte in the range.
> >>> + *
> >>> + * Note that PTE bits in the PTE range besides the PFN can differ. F=
or example,
> >>> + * some PTEs might be write-protected.
> >>> + *
> >>> + * Context: The caller holds the page table lock.  The PTEs map cons=
ecutive
> >>> + * pages that belong to the same folio.  The PTEs are all in the sam=
e PMD.
> >>> + */
> >>> +static inline void mkold_clean_ptes(struct mm_struct *mm, unsigned l=
ong addr,
> >>> +                    pte_t *ptep, unsigned int nr)
> >>

Thanks for the suggestions, Ryan, David!

> >> Just thinking out loud, I wonder if it would be cleaner to convert mko=
ld_ptes()
> >> (which I added as part of swap-out) to something like:

Yeah, this is definitely cleaner than before.

> >>
> >> clear_young_dirty_ptes(struct mm_struct *mm, unsigned long addr,
> >>                pte_t *ptep, unsigned int nr,
> >>                bool clear_young, bool clear_dirty);
> >>
> >> Then we can use the same function for both use cases and also have the=
 ability
> >> to only clear dirty in future if we ever need it. The other advantage =
is that we
> >> only need to plumb a single function down the arm64 arch code. As it c=
urrently
> >> stands, those 2 functions would be duplicating most of their code.

Agreed. It's indeed a good idea to use a single function for both use cases=
.

> >
> > Yes. Maybe better use proper __bitwise flags, the compiler should be sm=
art
> > enough to optimize either way.

Nice. I'll use the __bitwise flags as the input.

>
> Agreed. I was also thinking perhaps it makes sense to start using output =
bitwise
> flags for folio_pte_batch() since this patch set takes us up to 3 optiona=
l bool
> pointers for different things. Might be cleaner to have input flags to te=
ll it
> what we care about and output flags to highlight those things. I guess th=
e
> compiler should be able to optimize in the same way.
>

Should I start using output bitwise flags for folio_pte_batch() in
this patch set?

Thanks,
Lance


Return-Path: <linux-kernel+bounces-88342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B676386E040
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5720287EA5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99C56CBFF;
	Fri,  1 Mar 2024 11:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="WneJFLwN"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0B74438E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292573; cv=none; b=ETYXOmoQzutl6FahQC8tW42+os+Oe/NLAP8nDHXgKwdQwVoL99aFnfN9wmUON6doGMHfRC5f4qA/AVyVbFfQ0rPsgps0fzgAnw+VnzvmInjtoAipLu7aSrzbwJ/+IMIfn2elES62sHhhY9EcEZ5wPb/zFOD4BgzyMOndE4O2dAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292573; c=relaxed/simple;
	bh=JP0454diuQRJWxe3AgLViK7eNSSpoIs2Qcd44phtQ1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/BVNsbzRymOy7LJqwz422YWk5b5ZfBXxVbOCHTnAp3Thqo4OxnBBvVsgQxNA5h6ZRQsY8juto36oytfRQmvHtITLDeG/9Fu06mkZs905sVxS1YPxXm5ORxekB3RtT4yRhKreV2KBiAQEUS9nfcHPDYvjB283mXb8ELzdi+XIQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=WneJFLwN; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-566e869f631so187016a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 03:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709292569; x=1709897369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6rqbYpfS5pcWnhkyceNm4nCsA9xdZ82hdVcREX/cMw=;
        b=WneJFLwN6GrhP8pFgBS6R0ZlODnnxQ5/+Fwgw7iE4P73MuAQZJg7fD81SfFJZ7zRuj
         iQDickLD/WqKwsOXPs7MHdO2/AqOgf7Je0Rg+JNOFlR/Cxg3pa3GA9e93LT7OGgFpbG8
         QroQbl8YBtUhK+HKlWMuq/VgaxMXi08u/q+btGX7qGytIjKXJIZbR6bkV+lO5lLmLSZB
         Psfnoa/QS25ow6X5YtQrEGEmO2nxD5VGnsorMPTFcvteMzov9AT5+X6BCBz1LwxDIh95
         rv30ZkijHSW1rWV7Tnxp8cnL0caZtzrzrxQofUAf++mdp/bCfMdN/UCGTOGIJJ1mOryf
         EbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709292569; x=1709897369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6rqbYpfS5pcWnhkyceNm4nCsA9xdZ82hdVcREX/cMw=;
        b=cyXOl0E72rpdaX3X5Wp7sEAID+vnTG2zleShUJQIw1U4UxzxUqi8UWp+0nYWKJijQX
         AuIT6kQZvBjM9LNZFnRPr3XhfSoXytA0YA3nf7uBuVJBbst5kXEOp5JK93562LIWUUTD
         WN28JaOITmK2czb+6dF8ht9kyTphAsPr92hLteM9hdvL2b1KEFqROdrdOME5rKTxuXTw
         jFpWj8wvwV1M5zlSC++ZfTgPPGEBG0KnBz+CJ6o6cL1lHJI8M35MB1TJTzfM53IaT1G3
         rY1k1P8Mzv+s6Ra8VfB6R6PV2aDpnM//F08kyproGxp5SrxLTr9EPW4ekX7NSDfjPrEU
         1Ndw==
X-Forwarded-Encrypted: i=1; AJvYcCUwwxUpqMRjJ0MrIkSGVo8BAhEOJho864pvnbSiVDdo6aX67qbAGuEPwSqA8s2h64rmlGdqQgkkWAgwINfRkdLNZPutG8Rm9wuTbhAc
X-Gm-Message-State: AOJu0YzrDRRy0YzQNe0/FVorkfgUIthCBlJIaY8pkCYEg1iQ4swpERJ4
	x4Xdfp4Zd+ORf0HOxtVdU1UN7gW3enrKLDVfznSQzV2GWv5c+vSqS+v7uq6YIawN427IVgIur4k
	//1Z6DTOqWE9e4epnUTf44Y2jAofrbYh/8FdTfw==
X-Google-Smtp-Source: AGHT+IGhWExtL6QtBViwPNAoKlHWs7DOlO2fT48mVk9Foe5Dl0xsN+CFFn8dgQruLadr4n6Yxb7nj2ska+hps6+i1zE=
X-Received: by 2002:a05:6402:222b:b0:566:6640:10e5 with SMTP id
 cr11-20020a056402222b00b00566664010e5mr938238edb.12.1709292569232; Fri, 01
 Mar 2024 03:29:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301091455.246686-1-alexghiti@rivosinc.com> <b99f47f9-18d0-4619-aae7-19274197b85e@arm.com>
In-Reply-To: <b99f47f9-18d0-4619-aae7-19274197b85e@arm.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Fri, 1 Mar 2024 12:29:18 +0100
Message-ID: <CAHVXubiH64beFuB_GHSq5BKCus=O_+bqYTCwWQ+=2Q-F=T=ctQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] Merge arm64/riscv hugetlbfs contpte support
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

On Fri, Mar 1, 2024 at 11:45=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> Hi Alexandre,
>
> I confess I haven't looked at the patches yet, but this cover letter rais=
es a
> few quesions for me. I'll aim to look at the actual patches in due course=
.
>
> On 01/03/2024 09:14, Alexandre Ghiti wrote:
> > This patchset intends to merge the contiguous ptes hugetlbfs implementa=
tion
> > of arm64 and riscv.
> >
> > Both arm64 and riscv support the use of contiguous ptes to map pages th=
at
> > are larger than the default page table size, respectively called contpt=
e
> > and svnapot.
> >
> > The riscv implementation differs from the arm64's in that the LSBs of t=
he
> > pfn of a svnapot pte are used to store the size of the mapping, allowin=
g
> > for future sizes to be added (for now only 64KB is supported). That's a=
n
> > issue for the core mm code which expects to find the *real* pfn a pte p=
oints
> > to. Patch 1 fixes that by always returning svnapot ptes with the real p=
fn
> > and restores the size of the mapping when it is written to a page table=
.
>
> Yes that makes sense to me. The intention for mTHP (!hugetlb) is to fully
> encapsulate PTEs beind set_ptes(), ptep_get() and friends, so what's actu=
ally
> written to the pgtable is arch-specific and well abstracted.
>
> >
> > The following patches are just merges of the 2 different implementation=
s
> > that currently exist in arm64 and riscv which are very similar. It pave=
s
> > the way to the reuse of the recent contpte THP work by Ryan [1] to avoi=
d
> > reimplementing the same in riscv.
>
> You seem to be talking about both hugetlb (which uses the "huge" pte help=
ers)
> and contpte for THP (i.e. mTHP, which uses the regular pte helpers). They=
 are
> pretty separate in my mind, so not sure why you would be modifying them b=
oth in
> the same series?

I don't, this patchset only deals with hugetlb, I just meant that this
series was just the beginning as I'm working on moving the contpte for
THP support in the generic code for riscv to use.

Sorry my wording was ambiguous :)

Thanks,

Alex

>
> Thanks,
> Ryan
>
> >
> > This patchset was tested by running the libhugetlbfs testsuite with 64K=
B
> > and 2MB pages on both architectures (on a 4KB base page size arm64 kern=
el).
> >
> > [1] https://lore.kernel.org/linux-arm-kernel/20240215103205.2607016-1-r=
yan.roberts@arm.com/
> >
> > Alexandre Ghiti (9):
> >   riscv: Restore the pfn in a NAPOT pte when manipulated by core mm cod=
e
> >   riscv: Safely remove huge_pte_offset() when manipulating NAPOT ptes
> >   mm: Use common huge_ptep_get() function for riscv/arm64
> >   mm: Use common set_huge_pte_at() function for riscv/arm64
> >   mm: Use common huge_pte_clear() function for riscv/arm64
> >   mm: Use common huge_ptep_get_and_clear() function for riscv/arm64
> >   mm: Use common huge_ptep_set_access_flags() function for riscv/arm64
> >   mm: Use common huge_ptep_set_wrprotect() function for riscv/arm64
> >   mm: Use common huge_ptep_clear_flush() function for riscv/arm64
> >
> >  arch/arm64/Kconfig                  |   1 +
> >  arch/arm64/include/asm/pgtable.h    |  59 +++++-
> >  arch/arm64/mm/hugetlbpage.c         | 291 +---------------------------
> >  arch/riscv/Kconfig                  |   1 +
> >  arch/riscv/include/asm/hugetlb.h    |   2 +-
> >  arch/riscv/include/asm/pgtable-64.h |  11 ++
> >  arch/riscv/include/asm/pgtable.h    | 120 +++++++++++-
> >  arch/riscv/mm/hugetlbpage.c         | 227 ----------------------
> >  mm/Kconfig                          |   3 +
> >  mm/Makefile                         |   1 +
> >  mm/contpte.c                        | 268 +++++++++++++++++++++++++
> >  11 files changed, 456 insertions(+), 528 deletions(-)
> >  create mode 100644 mm/contpte.c
> >
>


Return-Path: <linux-kernel+bounces-73696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FA385C613
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 830EBB23264
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE501509BC;
	Tue, 20 Feb 2024 20:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BPJaEjEg"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B871509A5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 20:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708462255; cv=none; b=XhIJuO/9OohfeGk59GiFPm62C8VtHYiJ/LQwj7l3aWscOlSyPLjcGsgdVCqN1HxZOdhPn+GD5uWwU6cMvxn5ZoHnghqef9qhX8rZrv2bSd7CVMS2kRbGBZfmuxTUOEdoC5jDqDgmuiQMz1GN0VcyTIebXUtGJhb9iMXo7frCx4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708462255; c=relaxed/simple;
	bh=RAe+U6DW6RT1iY/pRrGMdhEaQQttfMr1lO8qOA6ny8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVuJNcJuwkMrFdtj8eU+T6C6ZckcG+k/Z7+/CknETbqa19xwGtkJT3ElM2f286XKUI/rD4CDakE7EYWAvFRVb7c0Dma9thMzPWCKP6PGO+ipK7uG3UU06nZKw3MXAcnY61v2SU99UrSWa9bjK7ZhLYqV1H7w4ArIVdtz3FkoehA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BPJaEjEg; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-512b700c8ebso3287870e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708462251; x=1709067051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dGB6b6W2iBBGppzYQ3zaXWNNMQ0jXoqG7lbe80bwbM=;
        b=BPJaEjEgLvali7ABOAsgAaLtfIyOHLoLYt1tqxi+ZgX8rtJMBphcjvr5vsGBgEI5mJ
         oTUWvkENHCqmszzU7MNkN6GB/MS++JrwU5NWdGRDRJxBmjG7qmBvC8X43qprOAg2VfL+
         qe/gmkLQYVL7fjPjR0hF00ucefchnYMtV5Yh80BFACinNJF1EBgkC6rQ3l0qHOPetbIF
         r72TzysCaFal/qiYGEPWz32R9zsZxqMZwLcahm1jdncy2raLrSK78YddMZtu/3e1517G
         ZZcoylVeox19ixCWjiK7Y3RI8fOoBlfiGBh6tteHKZ9KH0Nl+CB0R1Nz32tbRtNMAvt+
         iw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708462251; x=1709067051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dGB6b6W2iBBGppzYQ3zaXWNNMQ0jXoqG7lbe80bwbM=;
        b=E+EqWOzamI70hgLtHOX5kknmZb7p49TcDeDFBWR5bzG7biGd3gauPqzca7sddUNicP
         Tw5IugNhkOvekmlvPHgXiLNRoiDT1qTdH7kT22okeEnC4Nnzaw8eYjgJFXRQTs1uBN8f
         qzD61toZIoxNAVfxkxjpejFaeHEIXLfyrjh02SJTMgUw1+aWAJ4LKO6BG6Rhpj6HZtTA
         ajLDdYNMGjnjfLZnXs35p1i+9NO8OcmxSzoyEX/qTBB/hOEcNydI+F00UdVNA68rxSru
         O32hvdtfo4CN3XnI2xO/IEAmI8JtQLRxMM/iIf9vLN0T8kJFXs6d+MDy9MpN95DMCfOU
         4uMA==
X-Forwarded-Encrypted: i=1; AJvYcCW06UCY07WitpQe8arbuVR7J93Y5PT7IgsseFbE9G4hkGtOpxSQOT6fK7nK62mbSvKhLsriKOBq9kWh33CnKCLuwmyAz0HaH5BkCEZ6
X-Gm-Message-State: AOJu0YzQtlyDNkFDDsBNKPE7oE9pj7TWeVjq8HOQK/kQ0RJyrJrAGna2
	QrPSwaiW9xiFfRvi1W0PrF4YN72P6Xb6+q9jGu5IwQFfqjVgdyOj0AAcC2M737aEpSglvj9Hb7C
	gZy989WnwzuKz3cPejQpCwOAiqBO/SXOj8ty4gg==
X-Google-Smtp-Source: AGHT+IF5unIkoKmRJ4c3FFOvRdbxLAjB51nS85peyOB9fBG8DXHZ2LmqyUGv8eLL80geUI/uI2KFo/+qVqxj7xkzXfI=
X-Received: by 2002:ac2:4825:0:b0:512:ac36:e871 with SMTP id
 5-20020ac24825000000b00512ac36e871mr4871541lft.43.1708462250816; Tue, 20 Feb
 2024 12:50:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHVXubjanrxkDrNTZMrPtmewjqyf3L4_TTtqXhjGV+k+qkynmA@mail.gmail.com>
 <cc83e4a4-4d5a-4175-8c0f-c2a7baabdfe8@csd.uoc.gr> <c1bfe028-e17d-4975-9ac2-72bc597f7182@ics.forth.gr>
In-Reply-To: <c1bfe028-e17d-4975-9ac2-72bc597f7182@ics.forth.gr>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 20 Feb 2024 21:50:38 +0100
Message-ID: <CAHVXubgtOoHQBED-aF7PS8Cq1h6X-M2tou532=qk3ZmAVm73gQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] sparsemem: warn on out-of-bounds initialization
To: dvlachos <dvlachos@ics.forth.gr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	clameter@sgi.com, akpm@linux-foundation.org, rppt@kernel.org, arnd@arndb.de, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, mick@ics.forth.gr, 
	csd4492@csd.uoc.gr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dimitris,

On Mon, Feb 19, 2024 at 3:59=E2=80=AFPM dvlachos <dvlachos@ics.forth.gr> wr=
ote:
>
> Alexandre,
>
> Yes, you understood correctly, I indeed proposed to change
> pfn_to_page()/page_to_pfn() but your solution appears to solve the
> problem without risking any modifications to the conversion macros. In
> addition, your solution seems to be valid for any phys_ram_base/pfn
> value inside the limits of physical memory.
>
> However, I wanted to note that if the pfn is large enough, vmemmap will
> not be a valid SV39/48 address unless a pfn offset is applied to it. I
> can't think of a possible scenario where vmemmap would be used without
> an offset. I would like to know your opinion on that, does it concern you=
?

No, I don't see when that could happen, that would be a mistake and
then it would be easy to catch with this patch :)

>
> Finally, do you want me to send a patch or will you do it?
>

I'd be happy to help if you need, and if it's too much of a pain for
you, I'll do it, let me know.

Thanks,

Alex

> Dimitris
>
> On 2/18/2024 10:58 PM, Dimitris Vlachos wrote:
> >
> >
> >
> >
> > -------- Forwarded Message --------
> > Subject:      Re: [PATCH] [RFC] sparsemem: warn on out-of-bounds
> > initialization
> > Date:         Tue, 6 Feb 2024 22:17:44 +0100
> > From:         Alexandre Ghiti <alexghiti@rivosinc.com>
> > To:   Dimitris Vlachos <csd4492@csd.uoc.gr>
> > CC:   linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
> > clameter@sgi.com, akpm@linux-foundation.org, rppt@kernel.org,
> > arnd@arndb.de, paul.walmsley@sifive.com, palmer@dabbelt.com,
> > mick@ics.forth.gr
> >
> >
> >
> > Hi Dimitris,
> >
> > On Fri, Feb 2, 2024 at 2:59=E2=80=AFPM Alexandre Ghiti
> > <alexghiti@rivosinc.com> wrote:
> >> Hi Dimitris,
> >>
> >> On Fri, Feb 2, 2024 at 2:50=E2=80=AFPM Dimitris Vlachos<csd4492@csd.uo=
c.gr>  wrote:
> >>> From: Dimitris Vlachos<dvlachos@ics.forth.gr>
> >>>
> >>> Hello all
> >>>
> >>> I am sending this email with regards to a bug that I discovered in th=
e Sparse Memory Model configuration and more specifically, the Virtual Memo=
ry Map optimization. Moreover, I would like to inquire about possible ways =
of fixing it.
> >>>
> >>> I work as a pre-graduate research assistant at ICS-FORTH in the Compu=
ter Architecture and VLSI Systems laboratory.
> >>> We were running some tests in our prototype hardware (RISC-V), where =
we noticed that the Kernel crashes early in the boot process with the follo=
wing setup:
> >>>
> >>> We are using the default Kconfig configurations (defconfig) that incl=
udes Sparse Memory + Virtual Memory Map.
> >>> The DRAM base address of our system is : 0x800000000000
> >>> A 3-level page table is used (Sv39).
> >>>
> >>> When the vmemmap optimization is enabled the macro pfn_to_page() is c=
alled, which offsets the vmemmap with the pfn argument to acquire a struct =
page pointer.
> >>>
> >>> As our DRAM starts at 0x800000000000, the initial pfn will be 0x80000=
0000000 divided by PAGE_SIZE. The calculation result will be:
> >>> 0xffffffcf00000000 (vmemmap start) +  (0x800000000 (pfn) * 64 (sizeof=
(struct page))
> >>>
> >>> This causes an overflow as the number is very large, the resulting ad=
dress is 0x1c700000000 which is not a valid Sv39 address (all bits above bi=
t 38 should be set) and does not belong to the kernel=E2=80=99s virtual add=
ress space.
> >>>
> >>> The same will happen with all valid pfns as the memory is being initi=
alized. When the Kernel will try to access a page using pfn_to_page, a page=
 fault will occur crashing the system.
> >>> It should be noted that when the vmemmap is disabled the system boots=
 normally.
> >>>
> >>> However, I would like to emphasize another important detail. When the=
 DRAM base is small enough to avoid an overflow, the virtual memory map map=
pings will be initialized out of bounds with regard to the vmemmap address =
space which is 4GiB in Sv39.
> >>> The system will not crash, but the address space used for this purpos=
e will be outside of the designated range.
> >>>
> >>> Everything mentioned above holds true when Sv48 is used as well. Give=
n a high enough DRAM base the system will either crash or perform false ini=
tializations. Given the fact that virtual memory map is not only used by RI=
SC-V systems, this could be an issue for other architectures as well.
> >>>
> >>> The kernel already contains mminit_validate_memmodel_limits() that ch=
ecks memory limits.
> >>> However, it only checks physical memory ranges. I added a few checks,=
 provided that virtual memory map is enabled, to determine whether offset s=
tart and offset end fall inside the range of virtual memory map. Otherwise,=
 a warning will be printed.
> >>>
> >>> Finally, I would like to ask you for any information/advice that coul=
d help me fix/prevent the issues that I mentioned (if it=E2=80=99s possible=
) or recover from them at runtime by disabling the optimization and reverti=
ng back to the non-vmemmap mappings.
> >>>
> >>> Thank you in advance.
> >>> Best regards,
> >>> Dimitris Vlachos
> >>> ---
> >>>   mm/sparse.c | 20 ++++++++++++++++++++
> >>>   1 file changed, 20 insertions(+)
> >>>
> >>> diff --git a/mm/sparse.c b/mm/sparse.c
> >>> index 338cf946d..33b57758e 100644
> >>> --- a/mm/sparse.c
> >>> +++ b/mm/sparse.c
> >>> @@ -149,6 +149,26 @@ static void __meminit mminit_validate_memmodel_l=
imits(unsigned long *start_pfn,
> >>>                  WARN_ON_ONCE(1);
> >>>                  *end_pfn =3D max_sparsemem_pfn;
> >>>          }
> >>> +
> >>> +       /*check vmemmap limits*/
> >>> +       #ifdef CONFIG_SPARSEMEM_VMEMMAP
> >>> +
> >>> +       unsigned long vmemmap_offset_start =3D (unsigned long) pfn_to=
_page(*start_pfn);
> >>> +       unsigned long vmemmap_offset_end   =3D (unsigned long) pfn_to=
_page(*end_pfn);
> >>> +
> >>> +       if (vmemmap_offset_start < VMEMMAP_START) {
> >>> +               mminit_dprintk(MMINIT_WARNING, "pfnvalidation",
> >>> +                       "Start of range %lu -> %lu exceeds bounds of =
SPARSEMEM virtual memory map address range %lu -> %lu\n",
> >>> +                       vmemmap_offset_start, vmemmap_offset_end, VME=
MMAP_START,VMEMMAP_END);
> >>> +               WARN_ON_ONCE(1);
> >>> +
> >>> +       } else if (vmemmap_offset_end > VMEMMAP_END ) {
> >>> +               mminit_dprintk(MMINIT_WARNING, "pfnvalidation",
> >>> +                       "End of range %lu -> %lu exceeds bounds of SP=
ARSEMEM virtual memory map address range %lu -> %lu\n",
> >>> +                       vmemmap_offset_start, vmemmap_offset_end, VME=
MMAP_START,VMEMMAP_END);
> >>> +               WARN_ON_ONCE(1);
> >>> +       }
> >>> +       #endif
> >>>   }
> >>>
> >>>   /*
> >>> --
> >>> 2.39.2
> >>>
> >>
> >> Since struct pages are only available for memory,  we could offset
> >> vmemmap so that VMEMMAP_START actually points to the first pfn?
> >
> >> Hello Alexandre,
> >> My first thought was to use a "better" offset for vmemmap as well.Sinc=
e pfn is essential for pfn_to_page and page_to_pfn i think that maybe we co=
uld get a smaller number out of pfn to offset the vmemmap and ensure that i=
t's  bounds are respected for pfn_to_page operation.
> >> If we use only a part of the pfn for the offset we could get the  pfn =
from page_to_pfn by adding PAGE-VMEMMAP_START
> >> to the DRAM base/PAGE_SIZE which is the first pfn.
> >
> > Let's keep the discussion here.
> >
> > IIUC you propose to change pfn_to_page()/page_to_pfn() but what I
> > proposed was to directly offset vmemmap like this:
> >
> > #define vmemmap ((struct page *)VMEMMAP_START - phys_ram_base
> >>> PAGE_SHIFT)
> >
> > So that the first page in vmemmap corresponds to the first page of
> > physical memory, that avoids the burden of changing the conversion
> > macros, WDYT?
> >
> > Thanks,
> >
> > Alex


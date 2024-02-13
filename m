Return-Path: <linux-kernel+bounces-63597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DE4853203
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3B2282357
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A47E5644C;
	Tue, 13 Feb 2024 13:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjW66I/R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506C855E71
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831228; cv=none; b=MuJl6MYATDzmQ6KTkK/KlOkze6LYvBeA68jAbZxjxHwCmQ/eRci1HaPa8TEZ79gWznLDT1EviQKh93u5lC21l1y+MxmIN3ZcZu8ouqS6w5muA6CxcJykP9mFGbJakFUFtYSOh8D8oEciTaEWQK/uqxMcDUdpJJhv/2A6p/LEeQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831228; c=relaxed/simple;
	bh=19Y5ahn44aBoKaRpMWdk3LKXXQE0FO77x5Y2b3wdKaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DMlepuGIgFfiBRJRyH7o9uUASLH8xa+birzAVtIDf6CtXxXsbTI7BKqQU1D649CzNvDf2qfXL5SruNXp6q5vPK88x+ajvlAv7T4+M6gdaAfejfJXv64eQvHp1YPMOPDTuUnYp1i/5g5DYcQzo9j6Tw2nTakm3C7yd+XCp0RVIes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjW66I/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2503FC43399
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707831228;
	bh=19Y5ahn44aBoKaRpMWdk3LKXXQE0FO77x5Y2b3wdKaw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NjW66I/RyK5Frul2lsV16RtBUelOEL2efXL0HqOYl4F16m7wLEGAHyV4kBDhXEsiT
	 gAM9cdHcPSKpwelVKU8x0KBBx3UsrmVTKSa1jgCnIy87XFxBbUd0jdRBp85YdpUu0X
	 0MyUq2MKRjgo4BqRtwj16TRwyGe8EifSBGdTKzooV6APrXmVrhhG8N/8SsZL5S2Hk7
	 pCHfsKiZmZJBgKaNtdny7oGew3cHzeUe3G9H32susD2FhAS1sro8Ox9Hfa1B6eBDiL
	 DJ4SXJmH97QizhHKLRswJkmfT482ugHVyyLl8iQxEI+0+bdR+MlxIIUxAFDU9LUL8v
	 1NVgpw3xO/rww==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51181d8f52fso1160792e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:33:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVhGftbBrQaIt+mWCx5XoVKsM01UkgbS7YtErvqkh1mE+k7qph0TFqyAc2+cEUmPcQutQSJFLPU32U7C4co0wk31Zjhcs7sViFvACkR
X-Gm-Message-State: AOJu0Yw+nvq8Tou/81av9ppJwQAk++RFYs6wpE5Xmo2itBjrxKGL8d31
	6ZPWkuBV9o0IgESKusVtuqlleOXz+KGHhRwXccKp3f1ZAzZRGG5b3bRlZUVgX3o9Icl3uGPLNig
	dNW/Ju4WDVO77kCQk9frI2Wh9xv8=
X-Google-Smtp-Source: AGHT+IG4e5NfncV3RTrOH8gQhvaJJElu+/4o3kIRvOaccoBXLTJkqtjEBr950PGwXa4lfyB9fWPqF6zsh0CZ/o4MARQ=
X-Received: by 2002:ac2:4318:0:b0:511:7b36:933e with SMTP id
 l24-20020ac24318000000b005117b36933emr5957570lfh.58.1707831226284; Tue, 13
 Feb 2024 05:33:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202080756.1453939-1-ryan.roberts@arm.com>
 <20240202080756.1453939-20-ryan.roberts@arm.com> <ZcoIVypNwOPIX30w@FVFF77S0Q05N>
 <c899f252-dbf3-4e7b-8342-b5a5180486cd@arm.com> <aa232591-e0c8-422d-a641-fa555914c5f0@arm.com>
 <64395ae4-3a7d-45dd-8f1d-ea6b232829c5@arm.com> <d6ce951f-f83b-4a5a-a814-311f2d8b01e4@arm.com>
 <41499621-482f-455b-9f68-b43ea8052557@redhat.com> <1d302d7a-50ab-4ab4-b049-75ed4a71a87d@arm.com>
 <99e2a92c-f2a2-4e1e-8ce2-08caae2cb7e4@redhat.com> <dce5f80d-942f-439c-a549-5290666464ca@arm.com>
In-Reply-To: <dce5f80d-942f-439c-a549-5290666464ca@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 13 Feb 2024 14:33:34 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEVf1m4hVXORc6t9ytAOb75KZLcW-OJ6999VaKbkVdQ3A@mail.gmail.com>
Message-ID: <CAMj1kXEVf1m4hVXORc6t9ytAOb75KZLcW-OJ6999VaKbkVdQ3A@mail.gmail.com>
Subject: Re: [PATCH v5 19/25] arm64/mm: Wire up PTE_CONT for user mappings
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	James Morse <james.morse@arm.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, John Hubbard <jhubbard@nvidia.com>, 
	Zi Yan <ziy@nvidia.com>, Barry Song <21cnbao@gmail.com>, Alistair Popple <apopple@nvidia.com>, 
	Yang Shi <shy828301@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Feb 2024 at 14:21, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> On 13/02/2024 13:13, David Hildenbrand wrote:
> > On 13.02.24 14:06, Ryan Roberts wrote:
> >> On 13/02/2024 12:19, David Hildenbrand wrote:
> >>> On 13.02.24 13:06, Ryan Roberts wrote:
> >>>> On 12/02/2024 20:38, Ryan Roberts wrote:
> >>>>> [...]
> >>>>>
> >>>>>>>>> +static inline bool mm_is_user(struct mm_struct *mm)
> >>>>>>>>> +{
> >>>>>>>>> +    /*
> >>>>>>>>> +     * Don't attempt to apply the contig bit to kernel mapping=
s, because
> >>>>>>>>> +     * dynamically adding/removing the contig bit can cause pa=
ge faults.
> >>>>>>>>> +     * These racing faults are ok for user space, since they g=
et
> >>>>>>>>> serialized
> >>>>>>>>> +     * on the PTL. But kernel mappings can't tolerate faults.
> >>>>>>>>> +     */
> >>>>>>>>> +    return mm !=3D &init_mm;
> >>>>>>>>> +}
> >>>>>>>>
> >>>>>>>> We also have the efi_mm as a non-user mm, though I don't think w=
e
> >>>>>>>> manipulate
> >>>>>>>> that while it is live, and I'm not sure if that needs any specia=
l handling.
> >>>>>>>
> >>>>>>> Well we never need this function in the hot (order-0 folio) path,=
 so I
> >>>>>>> think I
> >>>>>>> could add a check for efi_mm here with performance implication. I=
t's
> >>>>>>> probably
> >>>>>>> safest to explicitly exclude it? What do you think?
> >>>>>>
> >>>>>> Oops: This should have read "I think I could add a check for efi_m=
m here
> >>>>>> *without* performance implication"
> >>>>>
> >>>>> It turns out that efi_mm is only defined when CONFIG_EFI is enabled=
 I can do
> >>>>> this:
> >>>>>
> >>>>> return mm !=3D &init_mm && (!IS_ENABLED(CONFIG_EFI) || mm !=3D &efi=
_mm);
> >>>>>
> >>>>> Is that acceptable? This is my preference, but nothing else outside=
 of efi
> >>>>> references this symbol currently.
> >>>>>
> >>>>> Or perhaps I can convince myself that its safe to treat efi_mm like=
 userspace.
> >>>>> There are a couple of things that need to be garanteed for it to be=
 safe:
> >>>>>
> >>>>>     - The PFNs of present ptes either need to have an associated st=
ruct
> >>>>> page or
> >>>>>       need to have the PTE_SPECIAL bit set (either pte_mkspecial() =
or
> >>>>>       pte_mkdevmap())
> >>>>>
> >>>>>     - Live mappings must either be static (no changes that could ca=
use
> >>>>> fold/unfold
> >>>>>       while live) or the system must be able to tolerate a temporar=
y fault
> >>>>>
> >>>>> Mark suggests efi_mm is not manipulated while live, so that meets t=
he latter
> >>>>> requirement, but I'm not sure about the former?
> >>>>
> >>>> I've gone through all the efi code, and conclude that, as Mark sugge=
sts, the
> >>>> mappings are indeed static. And additionally, the ptes are populated=
 using only
> >>>> the _private_ ptep API, so there is no issue here. As just discussed=
 with Mark,
> >>>> my prefereence is to not make any changes to code, and just add a co=
mment
> >>>> describing why efi_mm is safe.
> >>>>
> >>>> Details:
> >>>>
> >>>> * Registered with ptdump
> >>>>       * ptep_get_lockless()
> >>>> * efi_create_mapping -> create_pgd_mapping =E2=80=A6 -> init_pte:
> >>>>       * __ptep_get()
> >>>>       * __set_pte()
> >>>> * efi_memattr_apply_permissions -> efi_set_mapping_permissions =E2=
=80=A6 ->
> >>>> set_permissions
> >>>>       * __ptep_get()
> >>>>       * __set_pte()
> >>>
> >>> Sound good. We could add some VM_WARN_ON if we ever get the efi_mm vi=
a the
> >>> "official" APIs.
> >>
> >> We could, but that would lead to the same linkage issue, which I'm try=
ing to
> >> avoid in the first place:
> >>
> >> VM_WARN_ON(IS_ENABLED(CONFIG_EFI) && mm =3D=3D efi_mm);
> >>
> >> This creates new source code dependencies, which I would rather avoid =
if
> >> possible.
> >
> > Just a thought, you could have a is_efi_mm() function that abstracts al=
l that.
> >
> > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > index c74f47711f0b..152f5fa66a2a 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -692,6 +692,15 @@ extern struct efi {
> >
> >  extern struct mm_struct efi_mm;
> >
> > +static inline void is_efi_mm(struct mm_struct *mm)
> > +{
> > +#ifdef CONFIG_EFI
> > +       return mm =3D=3D &efi_mm;
> > +#else
> > +       return false;
> > +#endif
> > +}
> > +
> >  static inline int
> >  efi_guidcmp (efi_guid_t left, efi_guid_t right)
> >  {
> >
> >
>
> That would definitely work, but in that case, I might as well just check =
for it
> in mm_is_user() (and personally I would change the name to mm_is_efi()):
>
>
> static inline bool mm_is_user(struct mm_struct *mm)
> {
>         return mm !=3D &init_mm && !mm_is_efi(mm);
> }
>
> Any objections?
>

Any reason not to use IS_ENABLED(CONFIG_EFI) in the above? The extern
declaration is visible to the compiler, and any references should
disappear before the linker could notice that efi_mm does not exist.

In any case, feel free to add

Acked-by: Ard Biesheuvel <ardb@kernel.org>

when you roll a patch based on the above, with or without IS_ENABLED().

And as you concluded, efi_mm is indeed set in stone once the runtime
regions described by the firmware have been mapped, although this may
happen in two passes depending on how the runtime regions are
described. But by the time user MMs might exist, efi_mm should
effectively be immutable.


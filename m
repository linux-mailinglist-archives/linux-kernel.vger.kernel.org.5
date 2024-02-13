Return-Path: <linux-kernel+bounces-63642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 584758532AB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D5971C2650F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192805731B;
	Tue, 13 Feb 2024 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tu/LiHhQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAF73EA78
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833333; cv=none; b=c9bxhU7WfYvizz62DaSLcIhypoo9s/XNA6WLvqAAVs4nT2WumFuPeE2U7MiersSFk/zowD/4mvGRErMxpSIcdjqUKLkkaQ+FamoUbGoUoUkjJlvTKBobv0CiJjjTGe3Yz7MWKo13h/3y/jMh7YnWENJlDP/tU67cxiZZ8gLMmKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833333; c=relaxed/simple;
	bh=TsHGewO4d1sZ/2Wke7Alzolt9Fz7V7TAkLcK4gqK7t4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A97t2tOZN3iv3GfJSRMgYX9cHB3UUr6kHZJGWSUf1Pp8AAqtJQbMAhuhh4v6QVexODR5DZcniCLX63LtCG7I1Zga0X5T9hE+RATxrB3bkhKc0zoC0CL3yQ7AuFVuc1vDkZlJFvkH3ynmryMu1Dw/ekVYiOywTXDA+JTzzdjK1D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tu/LiHhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91F0C433A6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707833332;
	bh=TsHGewO4d1sZ/2Wke7Alzolt9Fz7V7TAkLcK4gqK7t4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Tu/LiHhQ1ASQkknxYy5I2zbpBLo3Lke7GhTHufl7uofAXbgbEe1jZcVkcpsWcXG2f
	 yRo4KTwjF0w0rUA57dPszbcC/4sDiwAtBb3k5omG8X2jUt5bVmzr6WXIxc69HK4IAh
	 4GBvbrLwnELnRYURYkRQ83RxSnTzgS90NWsYF3YxAX8/IIGbMzXnzd1QvwA62+kk+T
	 tHOIU4Zy1ByBI3P71eRSNYhBol4KDImVoeQleaAwtHsB6F8Mfrjm+EMM3/EzF2piKO
	 aE57OkljvhTV+9P73w0F7bFWZ/mjd9kJrufdcOsgKtH9g2zvdniF1QDKv8tCLb2Ssv
	 WR+UMWaBwATzg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5116ec49081so4699984e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:08:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUCW/qbfqo3ABqUyftdePQNW7y1cKXhR9nU2+yod482l4UGnh3QO3y+yQZdFwoulajL1f+tjGyW1OcsGobu3QXwwNALxcILe1LdOkxd
X-Gm-Message-State: AOJu0YxXWQQB64AaWOu8qJcPpB4S0AMCC2dX319BPPZX0Xw8kipz2pmM
	Bn6WXW1q7P2hfktRw+XGePoU5DHH7zwifGpZNrIKgUSQBM09XMewuw9l/lXh0m7TjxOLYH/Q9xV
	2GHODJKfXBc4yyP3O2HcVcTGWFgA=
X-Google-Smtp-Source: AGHT+IERJ2V7pHlFw7AMG1Pn749RuDSeXLXoZ89U8U4kBT5ImaY5HxngrTnEeqgTjll4w3fZWaJ2CtEbeq0i1i4Nh6M=
X-Received: by 2002:ac2:46da:0:b0:511:96d0:5ae1 with SMTP id
 p26-20020ac246da000000b0051196d05ae1mr1799024lfo.40.1707833330972; Tue, 13
 Feb 2024 06:08:50 -0800 (PST)
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
 <CAMj1kXEVf1m4hVXORc6t9ytAOb75KZLcW-OJ6999VaKbkVdQ3A@mail.gmail.com>
 <64b872bd-4b12-4dbd-b043-1ad11aeaa19a@redhat.com> <3de2130b-9f0f-4a11-ac06-7bf814de641c@arm.com>
 <f93e5552-5e46-4f49-918a-21b63156eb32@redhat.com>
In-Reply-To: <f93e5552-5e46-4f49-918a-21b63156eb32@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 13 Feb 2024 15:08:39 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEK6wiHkO9sJ5h6D3L88dR=2UndEqGeQjv=TftZ3PnN9w@mail.gmail.com>
Message-ID: <CAMj1kXEK6wiHkO9sJ5h6D3L88dR=2UndEqGeQjv=TftZ3PnN9w@mail.gmail.com>
Subject: Re: [PATCH v5 19/25] arm64/mm: Wire up PTE_CONT for user mappings
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
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

On Tue, 13 Feb 2024 at 15:05, David Hildenbrand <david@redhat.com> wrote:
>
> On 13.02.24 15:02, Ryan Roberts wrote:
> > On 13/02/2024 13:45, David Hildenbrand wrote:
> >> On 13.02.24 14:33, Ard Biesheuvel wrote:
> >>> On Tue, 13 Feb 2024 at 14:21, Ryan Roberts <ryan.roberts@arm.com> wrote:
> >>>>
> >>>> On 13/02/2024 13:13, David Hildenbrand wrote:
..
> >>>>> Just a thought, you could have a is_efi_mm() function that abstracts all that.
> >>>>>
> >>>>> diff --git a/include/linux/efi.h b/include/linux/efi.h
> >>>>> index c74f47711f0b..152f5fa66a2a 100644
> >>>>> --- a/include/linux/efi.h
> >>>>> +++ b/include/linux/efi.h
> >>>>> @@ -692,6 +692,15 @@ extern struct efi {
> >>>>>
> >>>>>    extern struct mm_struct efi_mm;
> >>>>>
> >>>>> +static inline void is_efi_mm(struct mm_struct *mm)
> >>>>> +{
> >>>>> +#ifdef CONFIG_EFI
> >>>>> +       return mm == &efi_mm;
> >>>>> +#else
> >>>>> +       return false;
> >>>>> +#endif
> >>>>> +}
> >>>>> +
> >>>>>    static inline int
> >>>>>    efi_guidcmp (efi_guid_t left, efi_guid_t right)
> >>>>>    {
> >>>>>
> >>>>>
> >>>>
> >>>> That would definitely work, but in that case, I might as well just check for it
> >>>> in mm_is_user() (and personally I would change the name to mm_is_efi()):
> >>>>
> >>>>
> >>>> static inline bool mm_is_user(struct mm_struct *mm)
> >>>> {
> >>>>           return mm != &init_mm && !mm_is_efi(mm);
> >>>> }
> >>>>
> >>>> Any objections?
> >>>>
> >>>
> >>> Any reason not to use IS_ENABLED(CONFIG_EFI) in the above? The extern
> >>> declaration is visible to the compiler, and any references should
> >>> disappear before the linker could notice that efi_mm does not exist.
> >>>
> >>
> >> Sure, as long as the linker is happy why not. I'll let Ryan mess with that :)
> >
> > I'm not sure if you are suggesting dropping the mm_is_efi() helper and just use
> > IS_ENABLED(CONFIG_EFI) in mm_is_user() to guard efi_mm, or if you are suggesting
> > using IS_ENABLED(CONFIG_EFI) in mm_is_efi() instead of the ifdefery?
> >
> > The former was what I did initially; It works great, but I didn't like that I
> > was introducing a new code dependecy between efi and arm64 (nothing else outside
> > of efi references efi_mm).
> >
> > So then concluded that it is safe to not worry about efi_mm (thanks for your
> > confirmation). But then David wanted a VM_WARN check, which reintroduces the
> > code dependency. So he suggested the mm_is_efi() helper to hide that... This is
> > all starting to feel circular...
>
> I think Ard meant that inside mm_is_efi(), we could avoid the #ifdef and
> simply use IS_ENABLED().
>

Yes.

static inline void mm_is_efi(struct mm_struct *mm)
{
    return IS_ENABLED(CONFIG_EFI) && mm == &efi_mm;
}


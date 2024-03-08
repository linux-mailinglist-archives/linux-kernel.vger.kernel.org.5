Return-Path: <linux-kernel+bounces-97571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A457D876C04
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C1C1C212DB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA825E089;
	Fri,  8 Mar 2024 20:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="odAR7b2V"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F6A1EF1E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 20:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709931014; cv=none; b=Ie8KGKennC85vaYnDATAfPbkabkO8oBc1fHyuZDvPS+4zMyzDJGZkHH24UT2RXnWhXMvMEzGWxnPhRv/5bmLRPFBgr5RaAt3Q1U4tz1asqFryF+zA4vZJ2pR0bVJtvKWbkYorC53RYwTnnPkapC8xcvJSpLqrvjN6S1IjTSk5FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709931014; c=relaxed/simple;
	bh=9Yk2zU22u4ahP1TfGgXBQ5aj6Z1/aKxFStFwhwlLi0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rO/4ZSUvlztvIaXd01WDlZIfaVNJ13FB9+8y/ub5ErbCSfoLvUpQp/c4lNHLtSDx8+5cz7kkfXl0Qeb681/OuCrG8opQt8waS56vDj0+R8Ke7tD5rcDZcljbd/EeGSAlUqNDjb4MRYDgpz9ApttO8TsCoaOFn2x4SIrLLB1tDzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=odAR7b2V; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4d35b644c1bso400453e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 12:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709931011; x=1710535811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yhono+IKW3A3aFCNK76Tw4xIWHBRl+7R1BmzIBU82N4=;
        b=odAR7b2VM8Jmvl3vFl72J6FR/IsqG/XZ0bjhZmCFumoCrPm3wHApXDDsELpSjbLOtj
         Sv080E9KIFytIDTDwKbwJ/bsaNrt4PcdxUhHTw6PNPFdK4nRmnrjR1Phxv5V6SbVf4il
         nb0RORr3Z9cuZoyVER3K5kAtNOEyNn5yVRJ33HQx+8TSbK+R9/p2nrEe+M//4HsMZ0kO
         2X24/XdWmsd76jRZRXui1CAjixV8YzTh6buUhm/NAshlQKoqe3v6WBLyttWPZ/SD8h2v
         of6jXNakW8yX0Fd3BuAXdbXpwNu9rVyUaFPTZJCL4pdh3u9zfIAgMYlRtUp7XzaPEOdk
         rJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709931011; x=1710535811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yhono+IKW3A3aFCNK76Tw4xIWHBRl+7R1BmzIBU82N4=;
        b=Whx4cZZvt+obqie0sSb0I+iT+qzLIMLDcM+XjzveTBCTu+0h/21OomlFtXgB3MJpM1
         5sMm0Kq0ftJwqbDIrHvPEgOeVbQ2W8PzrJ5CZVILzrPg2YwSs7DL43o18XG94UdaUlA7
         kJf0Sk5t6Ie9D6O52XHbhsGncxGrafDYBwt1aIx/4oo58KnJXpRV9cT+CUV5nwONCelK
         0HE+VFjMErsk6+a+Pv5uaV+668Q/QWJRHKk3U6iCEXOWQC9ki9uepVegqXqkK3510kTA
         FNdq2jLBCUqUxajgFwnCs+ljkUMIUttzkCPxT2JHZ1W/ZIqZ5c3ZMPEWT12e6EfsHW8f
         Irkg==
X-Forwarded-Encrypted: i=1; AJvYcCUtlKW6J1Wuxtr2ecbBoLxeXJuy6NJWxjqYao1wD6tRHK9DvB6xIQpBvvT212eQKU4A+GiMerIk9JuR7rX6tRy9kv7tGy+eGS4vlXyz
X-Gm-Message-State: AOJu0YyVV2UCg9HAUdB+6CldBUTYSyzQ9nbv6njy7oUdap4gNnXo3HFF
	ZC6/YkUKxTQNRzr8Y9EPFcltKRwulgohM/772souoWtBqOHvE2uHn9bQSTYSkAPuFENCGzvyT+V
	Do9vu+0ojKx0g2AsHPP1Qq3Sle/wkYtSTufoj
X-Google-Smtp-Source: AGHT+IHqmsZ/CPjFAWcQSxB2JNuicl3QdjXnnBY4zIUXjm3Tz1h1yUMw0R0+5QOQDfDoF8BXygBAd/kpoc1NI9oJZpE=
X-Received: by 2002:a05:6122:907:b0:4d3:43f8:8533 with SMTP id
 j7-20020a056122090700b004d343f88533mr402266vka.13.1709931011092; Fri, 08 Mar
 2024 12:50:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGdbjmK9WoOQSbKUvcTdLJDW-RB=qe2tHFDZ-MeD266xZOxh7w@mail.gmail.com>
 <20240222202404.36206-1-kevinloughlin@google.com> <CAMj1kXFsX1HZ3=x1cjN0-7i5EV9LXkSrAW22dc1wERUaTdAMaA@mail.gmail.com>
In-Reply-To: <CAMj1kXFsX1HZ3=x1cjN0-7i5EV9LXkSrAW22dc1wERUaTdAMaA@mail.gmail.com>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Fri, 8 Mar 2024 15:50:00 -0500
Message-ID: <CAGdbjmLVN0dxqGHno0BjaryCbb=51EnkX3qESveE46GH1asffw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kernel: skip ROM range scans and validation for
 SEV-SNP guests
To: Ard Biesheuvel <ardb@kernel.org>
Cc: acdunlap@google.com, alexander.shishkin@linux.intel.com, 
	andrisaar@google.com, bhe@redhat.com, bp@alien8.de, brijesh.singh@amd.com, 
	dave.hansen@linux.intel.com, dionnaglaze@google.com, grobler@google.com, 
	hpa@zytor.com, jacobhxu@google.com, jpoimboe@kernel.org, kai.huang@intel.com, 
	linux-kernel@vger.kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	peterz@infradead.org, pgonda@google.com, ross.lagerwall@citrix.com, 
	sidtelang@google.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	x86@kernel.org, ytcoode@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 5:31=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Thu, 22 Feb 2024 at 21:25, Kevin Loughlin <kevinloughlin@google.com> w=
rote:
> >
> > SEV-SNP requires encrypted memory to be validated before access.
> > Because the ROM memory range is not part of the e820 table, it is not
> > pre-validated by the BIOS. Therefore, if a SEV-SNP guest kernel wishes
> > to access this range, the guest must first validate the range.
> >
> > The current SEV-SNP code does indeed scan the ROM range during early
> > boot and thus attempts to validate the ROM range in probe_roms().
> > However, this behavior is neither necessary nor sufficient.
> >
> > With regards to sufficiency, if EFI_CONFIG_TABLES are not enabled and
> > CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK is set, the kernel will
> > attempt to access the memory at SMBIOS_ENTRY_POINT_SCAN_START (which
> > falls in the ROM range) prior to validation. The specific problematic
> > call chain occurs during dmi_setup() -> dmi_scan_machine() and results
> > in a crash during boot if SEV-SNP is enabled under these conditions.
> >
> > With regards to necessity, SEV-SNP guests currently read garbage (which
> > changes across boots) from the ROM range, meaning these scans are
> > unnecessary. The guest reads garbage because the legacy ROM range
> > is unencrypted data but is accessed via an encrypted PMD during early
> > boot (where the PMD is marked as encrypted due to potentially mapping
> > actually-encrypted data in other PMD-contained ranges).
> >
> > While one solution would be to overhaul the early PMD mapping to treat
> > the ROM region of the PMD as unencrypted, SEV-SNP guests do not rely on
> > data from the legacy ROM region during early boot (nor can they
> > currently, since the data would be garbage that changes across boots).
> > As such, this patch opts for the simpler approach of skipping the ROM
> > range scans (and the otherwise-necessary range validation) during
> > SEV-SNP guest early boot.
> >
> > Ultimatly, the potential SEV-SNP guest crash due to lack of ROM range
> > validation is avoided by simply not accessing the ROM range.
> >
> > Fixes: 9704c07bf9f7 ("x86/kernel: Validate ROM memory before accessing =
when SEV-SNP is active")
> > Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
> > ---
> >  arch/x86/include/asm/sev.h   |  2 --
> >  arch/x86/kernel/mpparse.c    |  7 +++++++
> >  arch/x86/kernel/probe_roms.c | 11 ++++-------
> >  arch/x86/kernel/sev.c        | 15 ---------------
> >  drivers/firmware/dmi_scan.c  |  7 ++++++-
> >  5 files changed, 17 insertions(+), 25 deletions(-)
> >
>
> Agree with the analysis and the conclusion. However, this will need to
> be split into generic and x86 specific changes, given that the DMI
> code is shared between all architectures, and explicitly checking for
> SEV-SNP support in generic code is not appropriate.
>
> So what we will need is:
> - a generic change that implements a static inline wrapper around
> IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK), and wires it up
> in  drivers/firmware/dmi_scan.c;
> - a x86 specific change that overrides this DMI helper in terms of
> cc_platform_has(CC_ATTR_GUEST_SEV_SNP);
> - x86 specific changes that deal with the other scanning
>
> Note that this means that Oak based platforms will lose DMI reporting
> and DMI-based quirks, but I think this is reasonable.

Agreed. However, upon further review, I think we can get away with
only modifying arch/x86/ code.

Besides the DMI case, all other needed changes are already contained
in arch/x86/, and we can replace the relevant init functions for
SEV-SNP guests with empty stubs as Boris and you mention in our
discussion.

For the DMI case, we can add an x86-init function pointer to
dmi_setup() that defaults to the generic dmi_setup function(), which
would be modified to point to snp_dmi_setup() on SNP-enabled guests
during initialization (where the fallback scan would be skipped for
SNP guests). This way, we would both leave multi-arch code alone and
avoid spreading cc_platform_has() scans around as Boris mentioned.

I plan to implement this behavior in v3 unless you have a preference
for something different.

>
> More feedback below.
>
>
> > diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> > index 5b4a1ce3d368..474c24ba0f6f 100644
> > --- a/arch/x86/include/asm/sev.h
> > +++ b/arch/x86/include/asm/sev.h
> > @@ -203,7 +203,6 @@ void __init early_snp_set_memory_private(unsigned l=
ong vaddr, unsigned long padd
> >                                          unsigned long npages);
> >  void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned =
long paddr,
> >                                         unsigned long npages);
> > -void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum=
 psc_op op);
> >  void snp_set_memory_shared(unsigned long vaddr, unsigned long npages);
> >  void snp_set_memory_private(unsigned long vaddr, unsigned long npages)=
;
> >  void snp_set_wakeup_secondary_cpu(void);
> > @@ -227,7 +226,6 @@ static inline void __init
> >  early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,=
 unsigned long npages) { }
> >  static inline void __init
> >  early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, =
unsigned long npages) { }
> > -static inline void __init snp_prep_memory(unsigned long paddr, unsigne=
d int sz, enum psc_op op) { }
> >  static inline void snp_set_memory_shared(unsigned long vaddr, unsigned=
 long npages) { }
> >  static inline void snp_set_memory_private(unsigned long vaddr, unsigne=
d long npages) { }
> >  static inline void snp_set_wakeup_secondary_cpu(void) { }
> > diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
> > index b223922248e9..39ea771e2d4c 100644
> > --- a/arch/x86/kernel/mpparse.c
> > +++ b/arch/x86/kernel/mpparse.c
> > @@ -553,6 +553,13 @@ static int __init smp_scan_config(unsigned long ba=
se, unsigned long length)
> >                     base, base + length - 1);
> >         BUILD_BUG_ON(sizeof(*mpf) !=3D 16);
> >
> > +       /*
> > +        * Skip scan in SEV-SNP guest if it would touch the legacy ROM =
region,
> > +        * as this memory is not pre-validated and would thus cause a c=
rash.
> > +        */
> > +       if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && base < 0x100000 &=
& base + length >=3D 0xC0000)
> > +               return 0;
> > +
>
> Please don't use magic numbers like this, and use memory_intersects()
> [unless there is a reason to avoid it which I missed]

Yes, memory_intersects() is better, as are macros here. Thanks.

>
> Also, really?!? Does modern x86 still rely on scanning arbitrary
> regions of memory for magic numbers? Or is this only for those who
> prefer vintage boot protocols?
>
> If so, I suppose we might need a generic helper
>
> static inline bool platform_allows_memory_probing(void)
>
> [modulo bikeshedding over the name] where the generic implementation
> returns false, and the x86 implementation could take
> cc_platform_has(CC_ATTR_GUEST_SEV_SNP) into account, and return true
> otherwise.
>
> (On ARM based systems, memory probing is never ok, because the memory
> map is not architected, and so probing random addresses might bring
> down the machine)

Roughly-speaking, the x86 memory probes are generally performed to
support legacy devices/reserved regions/boot sequences that assume
these hardcoded addresses. Given the ability to point probe_roms() and
similar x86_init functions to empty stubs (and the fact that x86_init
functions are, by definition, x86-specific), we should be able to
avoid needing a "platform_allows_memory_probing()" function in these
cases.

As for the DMI probing behavior in dmi_scan_machine(), the probing
only currently occurs if both (a) the config tables are not provided
by EFI [i.e., `efi_enabled(EFI_CONFIG_TABLES)` is false] and (b)
DMI_SCAN_MACHINE_NON_EFI_FALLBACK is set [which is not selected on
ARM, consistent with memory probing on ARM being disallowed]. As such,
DMI_SCAN_MACHINE_NON_EFI_FALLBACK effectively provides the
"platform_allows_memory_probing" functionality for this singular use
case.


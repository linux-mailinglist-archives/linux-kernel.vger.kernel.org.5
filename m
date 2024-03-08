Return-Path: <linux-kernel+bounces-97276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B508B876825
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6741F23008
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EC354BDA;
	Fri,  8 Mar 2024 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eIMG/ZeP"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B182C6A9
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914257; cv=none; b=rwy2nvJ6n5mFnnMjlRW4bItPR+HnH2UWL1rQ0Nhdz290Y/ogeE0CCZiLrzHwrcguz29u6/b16ywd8LZxky0IFjAnYyHvAphIK/eWIGe2sMKmj0H6ZeIpAKs72ch4M1UVW94IvhlC6sLCWIMnDyZM551aaXcoC+tODh6CpfJNG4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914257; c=relaxed/simple;
	bh=p9xUexFZbMUaJQTlLhk2bBQV54eWhyVLMMdjm6OQD0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NtO4zA7BqfBPQfJhZ7P5VvdjN853orpyMXr4Ox9jQyPjM4tV0v25ko+E4LXekn9xKRe2WHAikR/FrrgWd4e8+hcfXAPqbsDfWdEGh6c179iN4bss6mnuGkHgbD4BGmEpxmLMW/pJyPsr+9GKqgzRFd7R24fmBWin2L5U4r9hQ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eIMG/ZeP; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78851160a10so66702785a.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 08:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709914254; x=1710519054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbai3WraUD6CrZileQIlG/JfsqMGqB0GItLDXcvUCc0=;
        b=eIMG/ZePbT5bXtDGaUkFqK2zEKTiLIDiwnXfNw+wRAPNQpD91Gk58rXb4YsqsWXy1u
         tn61yt0CD7suXYlNaZSHgE73JzSvcjv3Ec7U0WzaO2cmJMlvQmbKbbQA03TjgcQKJwiG
         pqVOH3n7HGUQ4giv86VnExXoorDREjjjHbpnIDpB13Nwl/gKc8soU0El3hz0+Lu8jhlN
         pBxodM/Ypf4A9wUO3621mQNoxS/lZiaK3Q/CPUO9fHS0zj7CpwSEdGBCynn8fE2saW5G
         YewDApYYIvatQTWoXt58Iq+moG1T5lmL2PVzFQWXnyzl74+FRu0TxPB8Us4SHU8MDxcr
         Od+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709914254; x=1710519054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbai3WraUD6CrZileQIlG/JfsqMGqB0GItLDXcvUCc0=;
        b=EOM/hYoOszjxsz1hRidj19ktI4d+QSkxCF21iKduuWJg67MRQ4Uw/yE6csKjHgCXSH
         M0jPF3Volc2PBWl9kEDsl/XAIbSgFqJXqAIXyCrsV/4/kExAO6bLgyTQyZ+HAiFVtEag
         TLEoL+WDAGf8Sv9XIo35DNxsbD0Ps+oVfjUIr24/rA65uD+qcWZkSAvYcZu+lJfDpI0w
         m0OfOusAIaR9HWsOJ+xEI+wclTpXuA2UxKZ5xccuH271ybnrgONTxo5ptehLJVWD9wMJ
         iqcy9/ssvIHLCC21mWXMIsrhcPQ3jSG49QUQ5DK/D8qiu4vtpI/eXVhmUUysFTLOygqX
         Pm8A==
X-Forwarded-Encrypted: i=1; AJvYcCUxshtjU+RTzJ6d9iybgRsELiuSUWs+Tsr05YedgOUE86pUYCZOdJm3DCjYQqOUgoZmQQBOJtWwp6yM//bvy1B1eQWRQdiAgVaOs1ym
X-Gm-Message-State: AOJu0YzBOCeN5N3+Npfg1yUCKJT0LyYB5YO1kb8LYlByTjDvyzT84jdv
	ICjJ/84ypwqh7lnH2gRyHD/wBeujGPpKt8EQXEusIfJUmeAWgv+pz4CihbtnA96BOeJc4/pQJGk
	yG1JlPycTVSgohZ9wgB2js6uugdrUu7uUvK6Z
X-Google-Smtp-Source: AGHT+IFlqnldP9PAzmWhDd0oTdyz1NrYVxTra+57t8uRdURahLerBwRBntqy+gCSspGQ6FXViJ14BegoxorvpoTQCFE=
X-Received: by 2002:a05:620a:2b93:b0:788:441f:6a7e with SMTP id
 dz19-20020a05620a2b9300b00788441f6a7emr1050885qkb.19.1709914254202; Fri, 08
 Mar 2024 08:10:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGdbjmK9WoOQSbKUvcTdLJDW-RB=qe2tHFDZ-MeD266xZOxh7w@mail.gmail.com>
 <20240222202404.36206-1-kevinloughlin@google.com> <4463AFB9-58AC-4E65-BB04-EB2C9F2D9301@broadcom.com>
In-Reply-To: <4463AFB9-58AC-4E65-BB04-EB2C9F2D9301@broadcom.com>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Fri, 8 Mar 2024 11:10:43 -0500
Message-ID: <CAGdbjmJ+xiqycaDU9XMUEj2z70Adx-+ZCOiAFGXoNCojt_X=qA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kernel: skip ROM range scans and validation for
 SEV-SNP guests
To: Mike Stunes <mike.stunes@broadcom.com>
Cc: acdunlap@google.com, alexander.shishkin@linux.intel.com, 
	andrisaar@google.com, ardb@kernel.org, bhe@redhat.com, 
	Borislav Petkov <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, dave.hansen@linux.intel.com, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, grobler@google.com, hpa@zytor.com, 
	jacobhxu@google.com, jpoimboe@kernel.org, "Huang, Kai" <kai.huang@intel.com>, 
	linux-kernel@vger.kernel.org, Michael Roth <michael.roth@amd.com>, mingo@redhat.com, 
	peterz@infradead.org, Peter Gonda <pgonda@google.com>, ross.lagerwall@citrix.com, 
	sidtelang@google.com, tglx@linutronix.de, 
	Thomas Lendacky <thomas.lendacky@amd.com>, x86@kernel.org, ytcoode@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 2:16=E2=80=AFPM Mike Stunes <mike.stunes@broadcom.c=
om> wrote:
>
> Hi,
>
> > On Feb 22, 2024, at 12:24 PM, Kevin Loughlin <kevinloughlin@google.com>=
 wrote:
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
> > arch/x86/include/asm/sev.h   |  2 --
> > arch/x86/kernel/mpparse.c    |  7 +++++++
> > arch/x86/kernel/probe_roms.c | 11 ++++-------
> > arch/x86/kernel/sev.c        | 15 ---------------
> > drivers/firmware/dmi_scan.c  |  7 ++++++-
> > 5 files changed, 17 insertions(+), 25 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> > index 5b4a1ce3d368..474c24ba0f6f 100644
> > --- a/arch/x86/include/asm/sev.h
> > +++ b/arch/x86/include/asm/sev.h
> > @@ -203,7 +203,6 @@ void __init early_snp_set_memory_private(unsigned l=
ong vaddr, unsigned long padd
> > unsigned long npages);
> > void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned l=
ong paddr,
> > unsigned long npages);
> > -void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum=
 psc_op op);
> > void snp_set_memory_shared(unsigned long vaddr, unsigned long npages);
> > void snp_set_memory_private(unsigned long vaddr, unsigned long npages);
> > void snp_set_wakeup_secondary_cpu(void);
> > @@ -227,7 +226,6 @@ static inline void __init
> > early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, =
unsigned long npages) { }
> > static inline void __init
> > early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, u=
nsigned long npages) { }
> > -static inline void __init snp_prep_memory(unsigned long paddr, unsigne=
d int sz, enum psc_op op) { }
> > static inline void snp_set_memory_shared(unsigned long vaddr, unsigned =
long npages) { }
> > static inline void snp_set_memory_private(unsigned long vaddr, unsigned=
 long npages) { }
> > static inline void snp_set_wakeup_secondary_cpu(void) { }
> > diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
> > index b223922248e9..39ea771e2d4c 100644
> > --- a/arch/x86/kernel/mpparse.c
> > +++ b/arch/x86/kernel/mpparse.c
> > @@ -553,6 +553,13 @@ static int __init smp_scan_config(unsigned long ba=
se, unsigned long length)
> >    base, base + length - 1);
> > BUILD_BUG_ON(sizeof(*mpf) !=3D 16);
> >
> > + /*
> > + * Skip scan in SEV-SNP guest if it would touch the legacy ROM region,
> > + * as this memory is not pre-validated and would thus cause a crash.
> > + */
> > + if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && base < 0x100000 && base=
 + length >=3D 0xC0000)
> > + return 0;
> > +
> > while (length > 0) {
> > bp =3D early_memremap(base, length);
> > mpf =3D (struct mpf_intel *)bp;
> > diff --git a/arch/x86/kernel/probe_roms.c b/arch/x86/kernel/probe_roms.=
c
> > index 319fef37d9dc..84ff4b052fc1 100644
> > --- a/arch/x86/kernel/probe_roms.c
> > +++ b/arch/x86/kernel/probe_roms.c
> > @@ -204,14 +204,11 @@ void __init probe_roms(void)
> > int i;
> >
> > /*
> > - * The ROM memory range is not part of the e820 table and is therefore=
 not
> > - * pre-validated by BIOS. The kernel page table maps the ROM region as=
 encrypted
> > - * memory, and SNP requires encrypted memory to be validated before ac=
cess.
> > - * Do that here.
> > + * These probes are skipped in SEV-SNP guests because the ROM range
> > + * is not pre-validated, meaning access would cause a crash.
> > */
> > - snp_prep_memory(video_rom_resource.start,
> > - ((system_rom_resource.end + 1) - video_rom_resource.start),
> > - SNP_PAGE_STATE_PRIVATE);
> > + if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> > + return;
> >
> > /* video rom */
> > upper =3D adapter_rom_resources[0].start;
> > diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> > index c67285824e82..d2362631da91 100644
> > --- a/arch/x86/kernel/sev.c
> > +++ b/arch/x86/kernel/sev.c
> > @@ -774,21 +774,6 @@ void __init early_snp_set_memory_shared(unsigned l=
ong vaddr, unsigned long paddr
> > early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_SHARED);
> > }
> >
> > -void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum=
 psc_op op)
> > -{
> > - unsigned long vaddr, npages;
> > -
> > - vaddr =3D (unsigned long)__va(paddr);
> > - npages =3D PAGE_ALIGN(sz) >> PAGE_SHIFT;
> > -
> > - if (op =3D=3D SNP_PAGE_STATE_PRIVATE)
> > - early_snp_set_memory_private(vaddr, paddr, npages);
> > - else if (op =3D=3D SNP_PAGE_STATE_SHARED)
> > - early_snp_set_memory_shared(vaddr, paddr, npages);
> > - else
> > - WARN(1, "invalid memory op %d\n", op);
> > -}
> > -
> > static unsigned long __set_pages_state(struct snp_psc_desc *data, unsig=
ned long vaddr,
> >       unsigned long vaddr_end, int op)
> > {
> > diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
> > index 015c95a825d3..22e27087eb5b 100644
> > --- a/drivers/firmware/dmi_scan.c
> > +++ b/drivers/firmware/dmi_scan.c
> > @@ -703,7 +703,12 @@ static void __init dmi_scan_machine(void)
> > dmi_available =3D 1;
> > return;
> > }
> > - } else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK)) {
> > + } else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK) &&
> > + !cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
> > + /*
> > + * This scan is skipped in SEV-SNP guests because the ROM range
> > + * is not pre-validated, meaning access would cause a crash.
> > + */
> > p =3D dmi_early_remap(SMBIOS_ENTRY_POINT_SCAN_START, 0x10000);
> > if (p =3D=3D NULL)
> > goto error;
> > --
> > 2.44.0.rc0.258.g7320e95886-goog
> >
> >
>
> In addition to these changes, I also had to skip pirq_find_routing_table =
if SEV-SNP is active.

Thanks. I will update this in v3.


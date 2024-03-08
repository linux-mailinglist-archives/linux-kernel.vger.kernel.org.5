Return-Path: <linux-kernel+bounces-97603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B626876C6B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10A8D2823E2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2035FDCF;
	Fri,  8 Mar 2024 21:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b0LX2o2P"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D147E1DFE8
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 21:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709933469; cv=none; b=cVhyH1QdwruOy79eF4ejxDcSg7ut3eqyMefY0yvYSisJDw45Z8tk30OJ04067S0nAirseyIMeggpp2PMu8wCHz0AFLB6IoMw6z0eFOWk6rWPcj01DT0TJHg0XPxKETFfuZOc5vtuRjuQTZrnK+RTAE6Ndc/VuLJGWVltGYSTN0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709933469; c=relaxed/simple;
	bh=wDQi6wp9RRr44B56eQIgPHtKlT4O/Gu6tcIIGS7tJUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tnUkYFrnr6A52K6gCRfzAmncCoSwXCi6pO/saFvFNCerR8lTLZrEaJxDLVvK+X1uV6SX0yQVCT2ctOkKT4e7RDYSHSABpWqURtxedGz5qPawZtC+bOFhsCWpHpADgKp0B5gck2y0pOPqX8GOIyFw1vxqS0g8R0QT4cBhS83sI3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b0LX2o2P; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7db994598cfso727825241.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 13:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709933467; x=1710538267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZ+to0Q+8xaCm+pY9x5oG46OtCwT4i6oSkFwzJJM5hs=;
        b=b0LX2o2PlkcP237EdaUjZHAp23jVMyWKRnmYNdDX/Q3W1M0Jb59X+EqPvHZASaGqKO
         t7LyPsd14yeP/NCaL3HDY0E6oAF3idvHQ34X9rDp0CEl7pMcOUpGuxZY+Y10oGRkoXgN
         tH2qHBqWVQpL6tXhCrNdj/dPDtooaPu8LtFSVnvznYtHGS7PmQFesRSB2Iv7QVokoeyc
         e+ABo3a0qfDudYLbgpAu2T2XfUgOzhX2mXRtgFSVd7B1wWJXvxE7/Ysmcmj9WUkC2waW
         lutkN2UEplK9a/tNJcfmpIhzugEDMqVTcqX2zednQgDy/gDaZULDNaISUknDiktFkDCN
         bLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709933467; x=1710538267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZ+to0Q+8xaCm+pY9x5oG46OtCwT4i6oSkFwzJJM5hs=;
        b=MwPX9kIgYF3HHlQE4M4XXey9fQgwnIbCqDbf10wxpjYao7rQh8YxkSqP3DrMQviuW/
         8EGHu0g8LzLABNdI9kkpFGVEtnpQILKBZdvaIMZM0gRA1VTE4Us797cRtKANesPHpM85
         ejck3lKmHAwojBKJqwNfTHjE0BxVPN9D4x1PnVDO5xJQrbO/qipSkadFT/puZiZ4orQW
         6rYZYEgW42Y+SW+Kk9cvpdHrj0PkJPHbPCF2rKBYrJiOGXClkG+DJ0GifurhYUbi7esc
         AASnxa0/mXC+2sn3czusN5vS9r43XcY4rKvvESSSo4sUZV29w0Wt6BWjY5eOcXbfOjt9
         9+Ag==
X-Forwarded-Encrypted: i=1; AJvYcCV1WO7ZDjSwK1XVIQcmQ7MTg1r/dgB5YI0WLZrWWyHNzninLXCV2iw1I5dQD2E08GqAkIF2IaJktA6LrRFskeh8+sexiR7peHbZSN97
X-Gm-Message-State: AOJu0Yx2LnBKRQlr3Hda3NwENlrwIEcr0G+BH1YOnQs/+Da29tQfFxKz
	V3GdWO8vP6GdVbM+usCTU3u5HRji/8D/9kaFNbfJcLvclUmvWcD6ETXLitUfcVHLnhMzkOQpLG5
	2vWxWB0iu5NyYAAmGaxqCKXOY1F8Pe0U8/CAl
X-Google-Smtp-Source: AGHT+IHaLQFOVqSZ8K/Kr+NluYW72eg8BqF4V3uS45q1tOJJtLDBMAEt5tMYhSQQtTQvYWdd+uT6YkLqA76k5j5T81I=
X-Received: by 2002:a05:6102:2909:b0:472:69ab:f7bf with SMTP id
 cz9-20020a056102290900b0047269abf7bfmr291795vsb.9.1709933466557; Fri, 08 Mar
 2024 13:31:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGdbjmK9WoOQSbKUvcTdLJDW-RB=qe2tHFDZ-MeD266xZOxh7w@mail.gmail.com>
 <20240222202404.36206-1-kevinloughlin@google.com> <4463AFB9-58AC-4E65-BB04-EB2C9F2D9301@broadcom.com>
 <CAGdbjmJ+xiqycaDU9XMUEj2z70Adx-+ZCOiAFGXoNCojt_X=qA@mail.gmail.com> <20240308204151.jny3hyo6nyjqk6qt@amd.com>
In-Reply-To: <20240308204151.jny3hyo6nyjqk6qt@amd.com>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Fri, 8 Mar 2024 16:30:55 -0500
Message-ID: <CAGdbjmK=68Gte2MOvstMa_BoKxX2SEhbXeuRYpO_bdd2FY_xxw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kernel: skip ROM range scans and validation for
 SEV-SNP guests
To: Michael Roth <michael.roth@amd.com>
Cc: Mike Stunes <mike.stunes@broadcom.com>, acdunlap@google.com, 
	alexander.shishkin@linux.intel.com, andrisaar@google.com, ardb@kernel.org, 
	bhe@redhat.com, Borislav Petkov <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, 
	dave.hansen@linux.intel.com, Dionna Amalie Glaze <dionnaglaze@google.com>, grobler@google.com, 
	hpa@zytor.com, jacobhxu@google.com, jpoimboe@kernel.org, 
	"Huang, Kai" <kai.huang@intel.com>, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	peterz@infradead.org, Peter Gonda <pgonda@google.com>, ross.lagerwall@citrix.com, 
	sidtelang@google.com, tglx@linutronix.de, 
	Thomas Lendacky <thomas.lendacky@amd.com>, x86@kernel.org, ytcoode@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 3:44=E2=80=AFPM Michael Roth <michael.roth@amd.com> =
wrote:
>
> On Fri, Mar 08, 2024 at 11:10:43AM -0500, Kevin Loughlin wrote:
> > On Mon, Feb 26, 2024 at 2:16=E2=80=AFPM Mike Stunes <mike.stunes@broadc=
om.com> wrote:
> > >
> > > Hi,
> > >
> > > > On Feb 22, 2024, at 12:24 PM, Kevin Loughlin <kevinloughlin@google.=
com> wrote:
> > > >
> > > > SEV-SNP requires encrypted memory to be validated before access.
> > > > Because the ROM memory range is not part of the e820 table, it is n=
ot
> > > > pre-validated by the BIOS. Therefore, if a SEV-SNP guest kernel wis=
hes
> > > > to access this range, the guest must first validate the range.
> > > >
> > > > The current SEV-SNP code does indeed scan the ROM range during earl=
y
> > > > boot and thus attempts to validate the ROM range in probe_roms().
> > > > However, this behavior is neither necessary nor sufficient.
> > > >
> > > > With regards to sufficiency, if EFI_CONFIG_TABLES are not enabled a=
nd
> > > > CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK is set, the kernel will
> > > > attempt to access the memory at SMBIOS_ENTRY_POINT_SCAN_START (whic=
h
> > > > falls in the ROM range) prior to validation. The specific problemat=
ic
> > > > call chain occurs during dmi_setup() -> dmi_scan_machine() and resu=
lts
> > > > in a crash during boot if SEV-SNP is enabled under these conditions=
.
> > > >
> > > > With regards to necessity, SEV-SNP guests currently read garbage (w=
hich
> > > > changes across boots) from the ROM range, meaning these scans are
> > > > unnecessary. The guest reads garbage because the legacy ROM range
> > > > is unencrypted data but is accessed via an encrypted PMD during ear=
ly
> > > > boot (where the PMD is marked as encrypted due to potentially mappi=
ng
> > > > actually-encrypted data in other PMD-contained ranges).
> > > >
> > > > While one solution would be to overhaul the early PMD mapping to tr=
eat
> > > > the ROM region of the PMD as unencrypted, SEV-SNP guests do not rel=
y on
> > > > data from the legacy ROM region during early boot (nor can they
> > > > currently, since the data would be garbage that changes across boot=
s).
> > > > As such, this patch opts for the simpler approach of skipping the R=
OM
> > > > range scans (and the otherwise-necessary range validation) during
> > > > SEV-SNP guest early boot.
> > > >
> > > > Ultimatly, the potential SEV-SNP guest crash due to lack of ROM ran=
ge
> > > > validation is avoided by simply not accessing the ROM range.
> > > >
> > > > Fixes: 9704c07bf9f7 ("x86/kernel: Validate ROM memory before access=
ing when SEV-SNP is active")
> > > > Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
> > > > ---
> > > > arch/x86/include/asm/sev.h   |  2 --
> > > > arch/x86/kernel/mpparse.c    |  7 +++++++
> > > > arch/x86/kernel/probe_roms.c | 11 ++++-------
> > > > arch/x86/kernel/sev.c        | 15 ---------------
> > > > drivers/firmware/dmi_scan.c  |  7 ++++++-
> > > > 5 files changed, 17 insertions(+), 25 deletions(-)
> > > >
> > > > diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.=
h
> > > > index 5b4a1ce3d368..474c24ba0f6f 100644
> > > > --- a/arch/x86/include/asm/sev.h
> > > > +++ b/arch/x86/include/asm/sev.h
> > > > @@ -203,7 +203,6 @@ void __init early_snp_set_memory_private(unsign=
ed long vaddr, unsigned long padd
> > > > unsigned long npages);
> > > > void __init early_snp_set_memory_shared(unsigned long vaddr, unsign=
ed long paddr,
> > > > unsigned long npages);
> > > > -void __init snp_prep_memory(unsigned long paddr, unsigned int sz, =
enum psc_op op);
> > > > void snp_set_memory_shared(unsigned long vaddr, unsigned long npage=
s);
> > > > void snp_set_memory_private(unsigned long vaddr, unsigned long npag=
es);
> > > > void snp_set_wakeup_secondary_cpu(void);
> > > > @@ -227,7 +226,6 @@ static inline void __init
> > > > early_snp_set_memory_private(unsigned long vaddr, unsigned long pad=
dr, unsigned long npages) { }
> > > > static inline void __init
> > > > early_snp_set_memory_shared(unsigned long vaddr, unsigned long padd=
r, unsigned long npages) { }
> > > > -static inline void __init snp_prep_memory(unsigned long paddr, uns=
igned int sz, enum psc_op op) { }
> > > > static inline void snp_set_memory_shared(unsigned long vaddr, unsig=
ned long npages) { }
> > > > static inline void snp_set_memory_private(unsigned long vaddr, unsi=
gned long npages) { }
> > > > static inline void snp_set_wakeup_secondary_cpu(void) { }
> > > > diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
> > > > index b223922248e9..39ea771e2d4c 100644
> > > > --- a/arch/x86/kernel/mpparse.c
> > > > +++ b/arch/x86/kernel/mpparse.c
> > > > @@ -553,6 +553,13 @@ static int __init smp_scan_config(unsigned lon=
g base, unsigned long length)
> > > >    base, base + length - 1);
> > > > BUILD_BUG_ON(sizeof(*mpf) !=3D 16);
> > > >
> > > > + /*
> > > > + * Skip scan in SEV-SNP guest if it would touch the legacy ROM reg=
ion,
> > > > + * as this memory is not pre-validated and would thus cause a cras=
h.
> > > > + */
> > > > + if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && base < 0x100000 && =
base + length >=3D 0xC0000)
> > > > + return 0;
> > > > +
> > > > while (length > 0) {
> > > > bp =3D early_memremap(base, length);
> > > > mpf =3D (struct mpf_intel *)bp;
> > > > diff --git a/arch/x86/kernel/probe_roms.c b/arch/x86/kernel/probe_r=
oms.c
> > > > index 319fef37d9dc..84ff4b052fc1 100644
> > > > --- a/arch/x86/kernel/probe_roms.c
> > > > +++ b/arch/x86/kernel/probe_roms.c
> > > > @@ -204,14 +204,11 @@ void __init probe_roms(void)
> > > > int i;
> > > >
> > > > /*
> > > > - * The ROM memory range is not part of the e820 table and is there=
fore not
> > > > - * pre-validated by BIOS. The kernel page table maps the ROM regio=
n as encrypted
> > > > - * memory, and SNP requires encrypted memory to be validated befor=
e access.
> > > > - * Do that here.
> > > > + * These probes are skipped in SEV-SNP guests because the ROM rang=
e
> > > > + * is not pre-validated, meaning access would cause a crash.
> > > > */
> > > > - snp_prep_memory(video_rom_resource.start,
> > > > - ((system_rom_resource.end + 1) - video_rom_resource.start),
> > > > - SNP_PAGE_STATE_PRIVATE);
> > > > + if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> > > > + return;
> > > >
> > > > /* video rom */
> > > > upper =3D adapter_rom_resources[0].start;
> > > > diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> > > > index c67285824e82..d2362631da91 100644
> > > > --- a/arch/x86/kernel/sev.c
> > > > +++ b/arch/x86/kernel/sev.c
> > > > @@ -774,21 +774,6 @@ void __init early_snp_set_memory_shared(unsign=
ed long vaddr, unsigned long paddr
> > > > early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_SHARED);
> > > > }
> > > >
> > > > -void __init snp_prep_memory(unsigned long paddr, unsigned int sz, =
enum psc_op op)
> > > > -{
> > > > - unsigned long vaddr, npages;
> > > > -
> > > > - vaddr =3D (unsigned long)__va(paddr);
> > > > - npages =3D PAGE_ALIGN(sz) >> PAGE_SHIFT;
> > > > -
> > > > - if (op =3D=3D SNP_PAGE_STATE_PRIVATE)
> > > > - early_snp_set_memory_private(vaddr, paddr, npages);
> > > > - else if (op =3D=3D SNP_PAGE_STATE_SHARED)
> > > > - early_snp_set_memory_shared(vaddr, paddr, npages);
> > > > - else
> > > > - WARN(1, "invalid memory op %d\n", op);
> > > > -}
> > > > -
> > > > static unsigned long __set_pages_state(struct snp_psc_desc *data, u=
nsigned long vaddr,
> > > >       unsigned long vaddr_end, int op)
> > > > {
> > > > diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_sca=
n.c
> > > > index 015c95a825d3..22e27087eb5b 100644
> > > > --- a/drivers/firmware/dmi_scan.c
> > > > +++ b/drivers/firmware/dmi_scan.c
> > > > @@ -703,7 +703,12 @@ static void __init dmi_scan_machine(void)
> > > > dmi_available =3D 1;
> > > > return;
> > > > }
> > > > - } else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK)) =
{
> > > > + } else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK) &=
&
> > > > + !cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
> > > > + /*
> > > > + * This scan is skipped in SEV-SNP guests because the ROM range
> > > > + * is not pre-validated, meaning access would cause a crash.
> > > > + */
> > > > p =3D dmi_early_remap(SMBIOS_ENTRY_POINT_SCAN_START, 0x10000);
> > > > if (p =3D=3D NULL)
> > > > goto error;
> > > > --
> > > > 2.44.0.rc0.258.g7320e95886-goog
> > > >
> > > >
> > >
> > > In addition to these changes, I also had to skip pirq_find_routing_ta=
ble if SEV-SNP is active.
> >
> > Thanks. I will update this in v3.
>
> There's also another access a bit later in boot:
>
>   static __init int eisa_bus_probe(void)
>   {
>     ...
>     ioremap(0x0FFFD9, 4);
>   }
>
> This time it's via ioremap() with the encryption bit *unset*, so it
> won't necessarily cause a crash but it's inconsistent with the early
> page table having that region set as encrypted.
>
> We discussed unsetting the encryption bit in early page table with
> security folks and the general consensus was that *if* any VMM/firmware
> ever came along that does want to make use of legacy region for any reaso=
n
> (such as providing DMI/SMBIOS info) it would be safest to require that th=
ey
> encrypt the data in the region before handing off to guest kernel, so it
> makes sense to patch away unecrypted accesses to the legacy region so the
> don't cause problems down the road (like causing implicit page state
> change from private->shared and throwing away data in the region later
> in boot).

Sounds good, thanks. Since this one won't cause crashes, I will place
it in a separate patch in the series to separate (current) functional
fixes from cleanup, especially since there may be similar legacy
probes to cleanup in various types of guests. Please let me know if
you feel differently or have additional thoughts.


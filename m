Return-Path: <linux-kernel+bounces-97279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7E7876831
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561131F215E0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F362D60B;
	Fri,  8 Mar 2024 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w4rqisZi"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862EB2C18F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914481; cv=none; b=ukFUqLgkJ7KLH0XGwYAjf294dhhZlg3XH9Cc/RmSv2R22ODHvlcssi0WkpfNMBKYI9J8BeJJIO2y2l86LUeNrbTJ5ISSQvy7wZ/0AwUyqrvA5ZOguCuMBF2kF7btrVM7Il+L/z6Wxrnkfk4wEWpfmYQ1XEkEA2Ny7mXYygkKRp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914481; c=relaxed/simple;
	bh=+rQ8Eeo4lkrT42RTK+a+svyLAUpAVu74MS6HRmM6Lhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cq0AL+s/2YaELluwIROECv9Dsv35htoevNBUiTMVUJvyEVi38lPghlfOJx5EhSUVe97o2cRcO8NlT//fP4hGQ74v7oFFl5d2Hnm6M3t5YoSjTCJ71AjYKGzIby3hdY6LbZ8VLXC8ZOGua2e+1HIMXpG2YkUbCcap8uSHX0vFoAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w4rqisZi; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c1e6c32a55so512375b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 08:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709914478; x=1710519278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vR5BQjosb9lKgHvtgH8zUVTq199daWLXws9EoE2DvPI=;
        b=w4rqisZiNDBiPIwnc/pjTwSGaJx2IUcluo6DRq4ZsKGL3z9dQbwbgT+BVkcgJp5OSH
         /5tZl0uSx6pN/xzJzWHp0I/V8AH9sl3TZ8IJKhl3fnKs/g5LmhDX64z76T1e60lGMYlo
         sGJGFxrKf6EciXHX4c90ORjydhCtdfVzMSdvUugE1fnr8u0RBwLWeP9XHgHdVwjIiPY5
         g6URqXtqwzbKKwMj+ei4y6tkftzU83+OVCnlrOHKo0KZt5quj0Ee62rZOjU7BRmmknWw
         CuPZ0VI/uQWb9SkVNYgNcJ5IAa8UR2FWcrtuyWP9Y+HVVjrinQZVHPayDyqIflIft5Ir
         1m1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709914478; x=1710519278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vR5BQjosb9lKgHvtgH8zUVTq199daWLXws9EoE2DvPI=;
        b=u8f8TAAktFNd67P1EfF12nZt5ox6aSnTuqdNKHR4sS0cyjYUpXvlKjMkdIReK8BXE5
         aqxcTD9FJhfYIeETKEnWGkhFUgt66QP73TtPw9wcva+lT6PEVxXal/Y4EJ1gAEp4q72x
         UDU1W9UIO8pzSRai0IlioPYSL9Hn3U3af4Ar3cHIGgLpvlbqm3Wx/ydpt8GTMa9QE8U4
         NYxpzNiEw4zFW4KTP+nkNEH7WuqzCj6ZRXrkR67WFhzILrRutJyjSY2G7tSYa8SI1Kxv
         zc8paFJ7GTXF0BUd/ug5YRSemD90S0jjgB5fLhF9T4uUHHBGgH9POfCLKnOgvpgv8Is/
         hyAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW91zr77mz3SaZshG1tBzNepVBX0QUkeb24i9shX1Nvu4hmPYBIDUV3ggT4EEN/WR1/WJAo5WMSQZyfN6DEIQBPQGh3E95XMRq+iha
X-Gm-Message-State: AOJu0Yy24xwSLddrNaYaIc4bpoztroMiylCGdKVp89avxEXNboJGeMTi
	O9YJP0aenas/TiX+QuLsakC0Je0boOKRBjenz3P7X+at8/I6WWX6mPff1WCZJju6w/dN2yYlfbY
	XFzsqpqYyXblj1/jjTH59pVyrc2qL3NVegyX3
X-Google-Smtp-Source: AGHT+IE2YMh30/zW87ohaM9CjuMm2VymxDRAeAlgWDTkCzMi80XbBtMWoYatE8uZVmKRAQhN5QT/pmgav1CQt73hMEw=
X-Received: by 2002:a05:6808:2017:b0:3c1:de76:4d43 with SMTP id
 q23-20020a056808201700b003c1de764d43mr14180837oiw.54.1709914478264; Fri, 08
 Mar 2024 08:14:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGdbjmK9WoOQSbKUvcTdLJDW-RB=qe2tHFDZ-MeD266xZOxh7w@mail.gmail.com>
 <20240222202404.36206-1-kevinloughlin@google.com> <20240229165458.GLZeC24r5_-joAqNLp@fat_crate.local>
In-Reply-To: <20240229165458.GLZeC24r5_-joAqNLp@fat_crate.local>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Fri, 8 Mar 2024 11:14:27 -0500
Message-ID: <CAGdbjmLog2vU-enar+CDKU5wzeDqToib9QHVs6Q=N8XUOD9TcQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kernel: skip ROM range scans and validation for
 SEV-SNP guests
To: Borislav Petkov <bp@alien8.de>
Cc: acdunlap@google.com, alexander.shishkin@linux.intel.com, 
	andrisaar@google.com, ardb@kernel.org, bhe@redhat.com, brijesh.singh@amd.com, 
	dave.hansen@linux.intel.com, dionnaglaze@google.com, grobler@google.com, 
	hpa@zytor.com, jacobhxu@google.com, jpoimboe@kernel.org, kai.huang@intel.com, 
	linux-kernel@vger.kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	peterz@infradead.org, pgonda@google.com, ross.lagerwall@citrix.com, 
	sidtelang@google.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	x86@kernel.org, ytcoode@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 11:55=E2=80=AFAM Borislav Petkov <bp@alien8.de> wro=
te:
>
> On Thu, Feb 22, 2024 at 08:24:04PM +0000, Kevin Loughlin wrote:
> > SEV-SNP requires encrypted memory to be validated before access.
> > Because the ROM memory range is not part of the e820 table, it is not
> > pre-validated by the BIOS. Therefore, if a SEV-SNP guest kernel wishes
> > to access this range, the guest must first validate the range.
> >
> > The current SEV-SNP code does indeed scan the ROM range during early
> > boot and thus attempts to validate the ROM range in probe_roms().
> > However, this behavior is neither necessary nor sufficient.
>
> Why is this not necessary, all of a sudden?
>
> > With regards to sufficiency, if EFI_CONFIG_TABLES are not enabled and
> > CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK is set, the kernel will
>
> What is that use case exactly?
>
> CONFIG_DMI_... is usually enabled but the absence of EFI_CONFIG_TABLES
> tells me that you're booting some guest with some special OVMF which
> doesn't sport such tables.
>
> Why?
>
> /me scrolls upthread
>
> Aha, some project oak thing doing a minimal fw. I can see why but this
> should be explained here as to why is this a relevant use case and what
> it is using and so on so that future readers can piece it all together.

Will do in v3 commit message, thanks.

>
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
>
> I don't mind ripping that ROM probing thing but that thread we're on
> here talks more about why it could be problematic to keep doing so so
> pls summarize that here.
>
> A commit should contain all arguments for why it has been arrived at
> the decision to do it this way.

Ditto.

>
> > While one solution would be to overhaul the early PMD mapping to treat
> > the ROM region of the PMD as unencrypted, SEV-SNP guests do not rely on
> > data from the legacy ROM region during early boot (nor can they
> > currently, since the data would be garbage that changes across boots).
>
> That's better.
>
> > As such, this patch opts for the simpler approach of skipping the ROM
>
> Avoid having "This patch" or "This commit" in the commit message. It is
> tautologically useless.
>
> Also, do
>
> $ git grep 'This patch' Documentation/process
>
> for more details.

Ack, will fix.

>
> > range scans (and the otherwise-necessary range validation) during
> > SEV-SNP guest early boot.
> >
> > Ultimatly, the potential SEV-SNP guest crash due to lack of ROM range
>   ^^^^^^^^^^
>
> Please introduce a spellchecker into your patch creation workflow.

Woops, thanks. I'll fix that.

>
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
>
> ...
>
> > diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
> > index b223922248e9..39ea771e2d4c 100644
> > --- a/arch/x86/kernel/mpparse.c
> > +++ b/arch/x86/kernel/mpparse.c
> > @@ -553,6 +553,13 @@ static int __init smp_scan_config(unsigned long ba=
se, unsigned long length)
> >                   base, base + length - 1);
> >       BUILD_BUG_ON(sizeof(*mpf) !=3D 16);
> >
> > +     /*
> > +      * Skip scan in SEV-SNP guest if it would touch the legacy ROM re=
gion,
> > +      * as this memory is not pre-validated and would thus cause a cra=
sh.
> > +      */
> > +     if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && base < 0x100000 && =
base + length >=3D 0xC0000)
> > +             return 0;
>
> I don't like spreading around CoCo checks everywhere around the tree.
>
> Think of a better way pls.

Will do. I'll follow up on this in a message in reply to the
subsequent discussion involving Ard.


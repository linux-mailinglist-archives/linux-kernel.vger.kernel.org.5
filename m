Return-Path: <linux-kernel+bounces-64513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBBD853FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A057C1C27EB2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8E7629E5;
	Tue, 13 Feb 2024 23:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s1/ZTPwy"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7072160B9D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707865860; cv=none; b=FB9+6QVTNxf8M4pxHhyeu3l4iozEynf/IC+RrP/5+0Gx8uy8CuGPAtYebtwkzfKEZ9dN83aM6NZ6Rdqiva40AmZnZCiMLNtcMXxw0lnaKDLg/1olFLvkI4VmTUN/AlAF1rK4a3LHs+tRCdIxuUG6e3BfF7jxNiNKS+0DV7DPAsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707865860; c=relaxed/simple;
	bh=MSZPLVgvusOimnP2D4BEcyweB3P11DzVb4tIlxWityM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXjuKLdfP9IoJfwAkq8S2zcWd72OhbIJlhQ5C0lJ68diLmRau3JBOD3n+/vSdQlFQNM3pqQkTW8bSITWvUItnju5w/TtFhtwOT5tq28qp4CYC5xNoYFHZ50T1XBzpbD2wy3647BQIQ9gsGX1NMGqmJXT4OzokmGxHaBcAvbHg/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s1/ZTPwy; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4c081a16e6dso695128e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707865857; x=1708470657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSZPLVgvusOimnP2D4BEcyweB3P11DzVb4tIlxWityM=;
        b=s1/ZTPwy2YAU0eVncJF86QvhCYukZWK37A2VnRpNPFO/YtN64Uj2l2ohJE3c/uf139
         ZsnH29xXT48lFT+YaicrBTGFlBRROLiPpzaTBma6etUJlDwRvL3oTZZqvd9KzN2hBvOo
         QKQ2+b6cP6WBqjYr459GLTbkHDWCe47Z5beFegJ551ztavL49jV63bjaeMVibdUrFMBn
         BwhC2wtpfWnMBqP9/Y9sMDsT+Ae7HirNPNZmPBwOlQp912MR69cdIC8gEzg8NUOrs2jd
         EsyemS2OmTjkr84IMFCIMjcSYpps8KzH6UfbmrrgAjLwoZv3E2eMCUlQlS9Mdz3Ikbyo
         6/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707865857; x=1708470657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSZPLVgvusOimnP2D4BEcyweB3P11DzVb4tIlxWityM=;
        b=WoVKpv2ZsrB6tF4RjkYws7frW1vleTDUaNSSDDYvMgxNbchkQ1nAFLYwo6GPHP35Wm
         KzRzt/NMJOcR0MHw5F2GA08xsIh1hV7zXPGETbhh5m0likHJRBB7JniqBb4Cr/U+iqhT
         xA7hxqDwmalhlbX+wexO73/2XuHuNINjaM1d5uvbv21FVUXY//bSVHnMJg56QWdyR9a2
         FLOd5TFalAJSCKsDEPkof0LNPCID4XgS0ldLL7dXtjl4FEiBV0m0Mf5pj6FX5QxeVyKC
         ozXDz46aj0MjWw3WFuJO5tYcQcFh2HWYDJRzSjYU5Ufo2od0QHHulBxPUVXMeSMGDRrC
         /Org==
X-Forwarded-Encrypted: i=1; AJvYcCVIVW71797o2n6cfp9DF4WEGN8cybGULFjjqZ/bc5ncHFXvWxoRLjpQ6fFBw87tvcoyXw9OPQeNQsDtuGFwsNAr7wJfcCUDzaP6Mv4Z
X-Gm-Message-State: AOJu0Yzwr6VA8zDVfXgFE4UVwz4J9BAHGtIDcIyYINwIxFFmbkr3ow+w
	Z7wVnbTD+rsJOcjlS/yimE2ngg+1CP9U695zAFaoslpeeyXiYWpgjldZiO7B3HcjR2g8lFEFKc3
	JwETumYcOhSHe4EMqPTVobvGiS+Ka+EraaxrI
X-Google-Smtp-Source: AGHT+IFh0hE8/tiztO7thRvmT67cRCOpIlzpdYWbOA4P49FUSOECa7BMOrBaN+E3JaJ84QCOGvSxCpRGoKfD4PgOSWs=
X-Received: by 2002:a05:6102:22e8:b0:46d:2d23:f500 with SMTP id
 b8-20020a05610222e800b0046d2d23f500mr931935vsh.18.1707865857118; Tue, 13 Feb
 2024 15:10:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213040747.1745939-1-kevinloughlin@google.com> <170785457569.2934648.10119965441921727215@amd.com>
In-Reply-To: <170785457569.2934648.10119965441921727215@amd.com>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Tue, 13 Feb 2024 15:10:46 -0800
Message-ID: <CAGdbjmJAE5Uo5LA=hkMFwp+LdnNxxKgSwgkpdWZ69kwS-tLkFw@mail.gmail.com>
Subject: Re: [PATCH] x86/kernel: Validate ROM before DMI scanning when SEV-SNP
 is active
To: Michael Roth <michael.roth@amd.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dionna Glaze <dionnaglaze@google.com>, 
	"H.Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Kai Huang <kai.huang@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ross Lagerwall <ross.lagerwall@citrix.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Yuntao Wang <ytcoode@gmail.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, 
	Adam Dunlap <acdunlap@google.com>, Peter Gonda <pgonda@google.com>, Jacob Xu <jacobhxu@google.com>, 
	Sidharth Telang <sidtelang@google.com>, Conrad Grobler <grobler@google.com>, 
	Andri Saar <andrisaar@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 12:03=E2=80=AFPM Michael Roth <michael.roth@amd.com=
> wrote:
>
> Quoting Kevin Loughlin (2024-02-12 22:07:46)
> > SEV-SNP requires encrypted memory to be validated before access. The
> > kernel is responsible for validating the ROM memory range because the
> > range is not part of the e820 table and therefore not pre-validated by
> > the BIOS.
> >
> > While the current SEV-SNP code attempts to validate the ROM range in
> > probe_roms(), this does not suffice for all existing use cases. In
> > particular, if EFI_CONFIG_TABLES are not enabled and
> > CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK is set, the kernel will
> > attempt to access the memory at SMBIOS_ENTRY_POINT_SCAN_START (which
> > falls in the ROM range) prior to validation. The specific problematic
> > call chain occurs during dmi_setup() -> dmi_scan_machine() and results
> > in a crash during boot if SEV-SNP is enabled under these conditions.
>
> AFAIK, QEMU doesn't actually include any legacy ROMs as part of the initi=
al
> encrypted guest image, and I'm not aware of any VMM implementations that
> do this either.

I'm using a VMM implementation that uses (non-EFI) Oak stage0 firmware [0].

[0] https://github.com/project-oak/oak/tree/main/stage0_bin

> If dmi_setup() similarly scans these ranges, it seems likely the same
> issue would be present: the validated/private regions would only contain
> ciphertext rather than the expected ROM data. Does that agree with the
> behavior you are seeing?
>
> If so, maybe instead probe_roms should just be skipped in the case of SNP=
?

If probe_roms() is skipped, SEV-SNP guest boot also currently crashes;
I just quickly tried that (though admittedly haven't looked into why).
Apparently though, the fix for early ROM range accesses is not as
simple as just skipping probe_roms() if SEV-SNP is enabled.
Furthermore, skipping probe_roms() was also *not* the route taken in
the initial attempt that prevents this issue for EFI use cases [1].

[1] https://lore.kernel.org/lkml/20220307213356.2797205-21-brijesh.singh@am=
d.com/

> And perhaps dmi_setup() should similarly skip the legacy ROM ranges for
> the kernel configs in question?

Given (a) non-EFI firmware is supported in other SME/SEV boot code
patches [2], (b) this patch does not seem to introduce significant
complexity (it just moves [1] to earlier in the boot process to
additionally handle the non-EFI case), and (c) skipping
probe_roms()+dmi_setup() doesn't work without additional changes, I'm
currently still inclined to simply validate the legacy ROM ranges
early enough to prevent this issue (as is already done when using EFI
firmware).

[2] https://lore.kernel.org/lkml/CAMj1kXFZKM5wU8djcVBxDmnCJwV4Xpest6u1EbE=
=3D7wyLUUeUUQ@mail.gmail.com/


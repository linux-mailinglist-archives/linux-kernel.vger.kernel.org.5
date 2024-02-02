Return-Path: <linux-kernel+bounces-50252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D8F847668
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D211F2190C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB1B168B9;
	Fri,  2 Feb 2024 17:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="0BmDXPVC"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF8F14A4E9
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895681; cv=none; b=PfOq+0vWgdoHF8OqLC3aqKgdNAitkvgXofIp0jmg3taHroonqJW1vz2FtWu8xYRCCKgcOlReI7lhclmVQK19YKIC7Sg2I43s98/yyNgYpeVGCX1j7ybi+BNkxWnPOqiWgFjx8NdPgpHF9UxTsTwwzN3u5s2NTaNjA2RII7mLfJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895681; c=relaxed/simple;
	bh=bZlfqok9qew6k9fz+Z27UK6LPlwWG6tsG4PeKP4rbXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1UIchmFsDhMqe2tRQWLWab0cukO8zhCmNGVbBFlvEMvwi1F6zUYeG2Xp+6qgxCGNtX1tb7t+C3ABNq443SxGTMFdaLpvbzMEVgDp+QQxpFHHBq2n5peWx1QP0CmGBRk0YtyUPo2jz15V/2YBxW1w86dqq7pbZi7HJgT/c+k6pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=0BmDXPVC; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so206042866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 09:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706895676; x=1707500476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWtC7jO98lUeRBHL4RQhZAFvZjsqfE/uVt4nvdNHZP4=;
        b=0BmDXPVCkF4bYZYVpY2IE1feYwif9ZVfDxf4Ai5kQ2+xDCQfVyIqRnNpIiqtzx7Wop
         0/U+LW+t26DHFW/DdtukGLDFEuOQe3VEVp7AcJgo7w/vWqiok1OzprsQLDHBvXMl6P6j
         Y9xN2wj/q8cqsaotpugzLZ4NO9t77zu9lB9QXPQuUfw3fImZKPXzKO7jPOMyzPBr+imv
         F7Ymf956Ev3UfbjFNbCZWj1fvmwUiwDKPGlcwtNwJAo6q2XE2PAV+5koXBcTx+0fhdTZ
         NUzoW42EtSGesG9Kelhb0NZmuDibQODc/sqbaQOE6U7xtVmpsCcxvjsbI6NuW10Qm8/d
         Jopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895676; x=1707500476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWtC7jO98lUeRBHL4RQhZAFvZjsqfE/uVt4nvdNHZP4=;
        b=RmvYWWw+1QQTNcgjNUNPIperrWOeuK+nyIk6zgZCLBVd07JSwFVGYGG0QjfWOhLBpB
         zvo2UAXl9ovQ2a1b6DYSYvxiLF0QMMcAGKiB2DqPuxZHPrQyk635zykzvtctKVIpFtOd
         smL6vP72uvyeTaY7bAvjxFCz7czG91FVi9Aj6p5gyX9z+VLB7mqNWLo1zoTu5HZCUGzV
         rFW44E8SpRI9Njqk5g+QC8mA2B4W91j85wnOPbpqGWC7AoBJxTLJDaAlCIbE8X2MTuX0
         PVItF2RfczqqgTpiMhm3s1xbgM2Ng/zy8yrEf7MxzOVq9Wmy3hoNnn3Vr4IeGnlWxQXJ
         hRjQ==
X-Gm-Message-State: AOJu0YwhgB70R2nWHGYiXlJV/+xgzPfQdKVGCLCMXxbn6Hu5i9yxYRBs
	YOVvu7s8AVmHKfKQq3ueOoDc7TNmkYBgkfbMUmYcIuQnvuJuFWdVStYT/fzWhwfJr22KpbDQocO
	o3vpQcprwz76QGTH/ftYSDHnwomBatBRMnEKQgQ==
X-Google-Smtp-Source: AGHT+IHHACEG53UViD2eXG7vvDC/BBy9cKKGK86pK1KqKt9yPaQGwmh1+pUQisp4lH6+ccNGliBBByhYVThQhkwmoN4=
X-Received: by 2002:a17:907:971a:b0:a37:1778:7d7f with SMTP id
 jg26-20020a170907971a00b00a3717787d7fmr1914343ejc.29.1706895675962; Fri, 02
 Feb 2024 09:41:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202163433.786581-1-abrestic@rivosinc.com>
 <20240202163433.786581-3-abrestic@rivosinc.com> <CAMj1kXH7=9-Ww_z6a4Z5K8MrbH8x17Y3EzYk9Qf-3PL-JgMcww@mail.gmail.com>
In-Reply-To: <CAMj1kXH7=9-Ww_z6a4Z5K8MrbH8x17Y3EzYk9Qf-3PL-JgMcww@mail.gmail.com>
From: Andrew Bresticker <abrestic@rivosinc.com>
Date: Fri, 2 Feb 2024 12:41:04 -0500
Message-ID: <CALE4mHq4KhfBd+n2waUpHt48fTRXdBWZyiEJf5a3=hfUA_ue3Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi: Don't add memblocks for unusable memory
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 11:45=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Fri, 2 Feb 2024 at 17:34, Andrew Bresticker <abrestic@rivosinc.com> wr=
ote:
> >
> > Adding memblocks (even if nomap) for such regions unnecessarily consume=
s
> > resources by creating struct pages for memory that may never be used or=
,
> > in the case of soft-reserved regions, prevents the memory from later
> > being hotplugged in by dax_kmem. This is also consistent with how x86
> > handles unusable memory found in the EFI memory map.
> >
>
> x86 doesn't care as much about memory vs device semantics as ARM does.
>
> This affects the output of memblock_is_[region_]memory(), so we'd have
> to double check that none of those uses get broken by this.
>
> If the soft reserved regions need to be omitted from memblock, we can
> deal with that separately perhaps, but changing it at this level seems
> inappropriate to me.

Sure, I can constrain this to just the soft-reserved regions.

-Andrew

>
>
> > Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
> > ---
> >  drivers/firmware/efi/efi-init.c | 12 +-----------
> >  1 file changed, 1 insertion(+), 11 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi=
-init.c
> > index d4987d013080..f05bacac89b7 100644
> > --- a/drivers/firmware/efi/efi-init.c
> > +++ b/drivers/firmware/efi/efi-init.c
> > @@ -24,13 +24,6 @@
> >
> >  unsigned long __initdata screen_info_table =3D EFI_INVALID_TABLE_ADDR;
> >
> > -static int __init is_memory(efi_memory_desc_t *md)
> > -{
> > -       if (md->attribute & (EFI_MEMORY_WB|EFI_MEMORY_WT|EFI_MEMORY_WC)=
)
> > -               return 1;
> > -       return 0;
> > -}
> > -
> >  /*
> >   * Translate a EFI virtual address into a physical address: this is ne=
cessary,
> >   * as some data members of the EFI system table are virtually remapped=
 after
> > @@ -195,12 +188,9 @@ static __init void reserve_regions(void)
> >                 memrange_efi_to_native(&paddr, &npages);
> >                 size =3D npages << PAGE_SHIFT;
> >
> > -               if (is_memory(md)) {
> > +               if (is_usable_memory(md)) {
> >                         early_init_dt_add_memory_arch(paddr, size);
> >
> > -                       if (!is_usable_memory(md))
> > -                               memblock_mark_nomap(paddr, size);
> > -
> >                         /* keep ACPI reclaim memory intact for kexec et=
c. */
> >                         if (md->type =3D=3D EFI_ACPI_RECLAIM_MEMORY)
> >                                 memblock_reserve(paddr, size);
> > --
> > 2.34.1
> >


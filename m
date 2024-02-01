Return-Path: <linux-kernel+bounces-48541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC57845D68
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9975B31141
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372744C6C;
	Thu,  1 Feb 2024 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4PJ92BAP"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097B63FDB
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706805517; cv=none; b=YEgX1RKQxjxEEnizCEcXSdJW3ZpiZYfqTDnmBid/no3NfM7KbY4XgXDbIK2nd0WJZcbbjnxL0fj0ESJQXE7ZJ+zcc3hOidNsC/yDzbwo5H3wTB8IDLFcBJQIo/JL26dCT3SaMJw8InBgopXoAFOx8N5Tx9JACNLHOdS3RvQByNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706805517; c=relaxed/simple;
	bh=EKKfK1jLKXIPEoqnvWWsPVTEbHgmCxR3CtVMQy6TP7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPobg1A/f5DdLjpjKt/cg1yV8Tnzl3GKW8erUHfSwZekNLD1HAscsCic7gU4dV6PGgX09Iv8sXB8PLYu8lKwSgahP4AQbAUTMld3r0Sph5rebtaqNbF9xxV7BQEPiisnOCw0ySRGjNsO48aHNf4uhk1C0MHg5azQ14X1A7FlELY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4PJ92BAP; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d317aafbd1so517022241.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 08:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706805515; x=1707410315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxydBSYt78Q3tDYYvbfwJIQv5drJs2GhS3kKeICFZ4k=;
        b=4PJ92BAPG0ePNH+0DWC8NYkvFLXgI4F6VwNdH1Vh1vYEVogyWdSHmTLucoyhJrwhY8
         N/RlAAzAhfSJT13yRa33F5J2M43I4tpsII0yExqdfA9HxAw/NsRWhew8OTm7iGJSndfe
         tqC+hbKquseLzhF0Rajw+Jtg/Z9EWpVUnNqQdIJvmSZJA0rNkoUt1CI+FAZzkPswjAiV
         47aBHF4u8hciDoH6tzcP42JGUjTN0wqhJJ2Y/t66RtDzPXkup4CMkr+3nwAaeoeeU5f9
         tpAR9bWbAf3XeexFc3WUM+bK/FW01enZn78wb9qZQHsAcYhILDAId4fclyKmvRPD6x+h
         On6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706805515; x=1707410315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxydBSYt78Q3tDYYvbfwJIQv5drJs2GhS3kKeICFZ4k=;
        b=I2jjrciPF2gVQLRqJLQHdUdZmMTeFeasbRjezDJnCZgfyCj5gYf3YrD62fGKuXaOur
         vt2Ab4vxNPNoJIOl7W5Ut+96sHKVbaWn5JyCLshPN5HVLgPUaYEoExWnyTXLlIrUcTgh
         I85soPHc7JvrxvXrpSlePvPkbsVWTRusyOeUcUQ7fOWCPeJ9JAxGqa1xAxZMCK7RMMFZ
         CJweV3FRIiwjYaWIB8dfsdMxknbKmXpCau45KTwwa3moBwfHy7rFQRVwWu0585sxhBeV
         /aqUK8hf6h0MTOanJGpAHCLR+0H39mAYzzpbAJYl1CHCkHh6iml+83tLo8mUyApDxnh3
         H8Qg==
X-Gm-Message-State: AOJu0YzK5kj86hC46dknKYfLXgPQJkn9mG8hoTTsD8msR9hR/7OSfKDD
	E+S0PXUMSMkYVz3uvzmOCibTnSM8naquOI78wlkwZ5WAWAMS5E2dcGYagTyps1EJDGmSdnuCQ8j
	JqbEbIUVNk8J9u/xecGZiMpPYx4ltTZjUYXqH
X-Google-Smtp-Source: AGHT+IFvLBp7+wMbKBKxwjYgXGrG962W6VY58iu9bhsBfRyOqGFPu3+P1yJI2ZKLHaKwekY3Mc56N8uf1sMgdb+Cosg=
X-Received: by 2002:ac5:cb6b:0:b0:4b6:c3ae:97f6 with SMTP id
 l11-20020ac5cb6b000000b004b6c3ae97f6mr4498112vkn.0.1706805514702; Thu, 01 Feb
 2024 08:38:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240121182040.GBZa1geI5NxWSslvt0@fat_crate.local>
 <20240130220845.1978329-3-kevinloughlin@google.com> <sx3i6e6rgggh6wxtqt6odvwubg5vqotfleyjditiicjvjgpf6r@bswwhdt6zzti>
In-Reply-To: <sx3i6e6rgggh6wxtqt6odvwubg5vqotfleyjditiicjvjgpf6r@bswwhdt6zzti>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Thu, 1 Feb 2024 08:38:23 -0800
Message-ID: <CAGdbjmKOwRbWa9w3M6NH-gTnTOt-ZaM0UA700TMhFzrX8z5MVw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] x86/head64: Replace pointer fixups with RIP_RELATIVE_ADDR()
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Dionna Glaze <dionnaglaze@google.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Michael Roth <michael.roth@amd.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-coco@lists.linux.dev, Ashish Kalra <ashish.kalra@amd.com>, 
	Andi Kleen <ak@linux.intel.com>, Adam Dunlap <acdunlap@google.com>, 
	Peter Gonda <pgonda@google.com>, Jacob Xu <jacobhxu@google.com>, 
	Sidharth Telang <sidtelang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 12:24=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Tue, Jan 30, 2024 at 10:08:45PM +0000, Kevin Loughlin wrote:
> > @@ -594,15 +579,15 @@ static void set_bringup_idt_handler(gate_desc *id=
t, int n, void *handler)
> >  /* This runs while still in the direct mapping */
> >  static void __head startup_64_load_idt(unsigned long physbase)
> >  {
> > -     struct desc_ptr *desc =3D fixup_pointer(&bringup_idt_descr, physb=
ase);
> > -     gate_desc *idt =3D fixup_pointer(bringup_idt_table, physbase);
> > +     struct desc_ptr *desc =3D RIP_RELATIVE_ADDR(bringup_idt_descr);
> > +     gate_desc *idt =3D RIP_RELATIVE_ADDR(bringup_idt_table);
> >
> >
> >       if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
> >               void *handler;
> >
> >               /* VMM Communication Exception */
> > -             handler =3D fixup_pointer(vc_no_ghcb, physbase);
> > +             handler =3D RIP_RELATIVE_ADDR(vc_no_ghcb);
> >               set_bringup_idt_handler(idt, X86_TRAP_VC, handler);
> >       }
> >
>
> Looks like you removed all physbase users in the function. No need to pas=
s
> it to it.

Thanks, will fix.

>
> > @@ -629,7 +614,7 @@ void early_setup_idt(void)
> >  void __head startup_64_setup_env(unsigned long physbase)
> >  {
> >       /* Load GDT */
> > -     startup_gdt_descr.address =3D (unsigned long)fixup_pointer(startu=
p_gdt, physbase);
> > +     startup_gdt_descr.address =3D (unsigned long)RIP_RELATIVE_ADDR(st=
artup_gdt);
> >       native_load_gdt(&startup_gdt_descr);
> >
> >       /* New GDT is live - reload data segment registers */
>
> With startup_64_load_idt() fixed, no users for physbase in this function
> either.

Ditto.


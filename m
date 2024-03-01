Return-Path: <linux-kernel+bounces-89232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5B886ED05
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C3F1C21A0F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B22E5F46B;
	Fri,  1 Mar 2024 23:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjhB4Mon"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9945EE97
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 23:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709336780; cv=none; b=LSh9MEDarwB1SozZFf203Bi0pFY4MSS/vwyZ93BrnIM+/8lQTFgQmR4V8OYj+IluTtQ3RArxYQJPisp//Z3PpL1qpyx41eh3zK9C0pPofDLX/gCIUYyT4x8KAytI3LeRpnpSJKNMKjPtqRHTVzg9lJ/fPrctZJZ990xJ5XwgxzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709336780; c=relaxed/simple;
	bh=+uNFhMCpAr9FTagP3fHMlwrfqXFhrmRHd1x8+/2be0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fDNccf9qtE+RmHbRJCtKnjAv/K12xM3NaPueNFN3Nj4lZZj2SEundcgL4bG5lnnVSgSKgJKho9qD20KnuAGkS9zTgec64xVJfkdLDxD/fbOMjc4IZlIKUx53Qqw6RPbjg2ShbcyuTREh1qmNi2Eh7yxzDZcqBJVWmbTuNhDfiBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjhB4Mon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED97C43394
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 23:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709336779;
	bh=+uNFhMCpAr9FTagP3fHMlwrfqXFhrmRHd1x8+/2be0s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JjhB4MonG34FmZw8eclKbfIp5Bo3yWy8hhHNy+2o3qaZxaQ201JF0WEgy37EhqfcS
	 UJQ98NRLJse/7wFeDe58ZDOLTeIr9+8rRPraqQTXeWGtF3v3JdLBDI+HwB5sNbooEJ
	 wKMKG8xDtGToW80OC3HhH+WL9lPnBnWANJkT95TlSNJL0FRrISkYADmDctwGLs6smh
	 QYQmkgBYMQHNz/7iwFBPwRvNbDYWLTfkDzd1HfV3lZuGcmwHwPx34mLzW4Gp0pApF4
	 SbIa0CMnUXGi+gA0kxaD016VwEyxNAvBh6QE4pHRDNkZ87y91NYMChJ6k99G+fLAjK
	 Cj/SHLIiWkXdw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-513382f40e9so405943e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 15:46:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXvNO1hbinEg4crWM47PH1s0YRpoXigoHpmBH+rdF8nDANLHlKugcel/JsrbCVpiMp7b+2rljG6vrJfClgt+OMybDtf3E48N3EvhqCq
X-Gm-Message-State: AOJu0YwB+GttRP/GXpatLuVMIS3MaD7Ssc9zPEHpx0HQWMpE4DmiXvQZ
	R+NSahIaJUNCrDN6TbsgRTRzIh+ms+Qw11FPsJwNDD23nRI48nMBv7+jPDUuSobUg3WOUgZCsVk
	ve2cH94nLRyR+DLdbIH6zksf0v3s=
X-Google-Smtp-Source: AGHT+IGx/l3T6qdODQYCSS7aQE7kZ9SeKK5aVAzg7YpZm2Pj4c++uQLvuYEqI0y3eKxFrmFnR6sMSpv1/OtkvnqOoHc=
X-Received: by 2002:ac2:5a1c:0:b0:512:a943:a0ca with SMTP id
 q28-20020ac25a1c000000b00512a943a0camr1744096lfn.18.1709336777989; Fri, 01
 Mar 2024 15:46:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227151907.387873-11-ardb+git@google.com> <20240227151907.387873-17-ardb+git@google.com>
 <20240301191640.GNZeIpmAU3iM1EIg4S@fat_crate.local>
In-Reply-To: <20240301191640.GNZeIpmAU3iM1EIg4S@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 2 Mar 2024 00:46:06 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHnXRBke1P5nqLwuprJzyKk36bZQPNfwSerAYunvPAzMA@mail.gmail.com>
Message-ID: <CAMj1kXHnXRBke1P5nqLwuprJzyKk36bZQPNfwSerAYunvPAzMA@mail.gmail.com>
Subject: Re: [PATCH v7 6/9] x86/boot: Move mem_encrypt= parsing to the decompressor
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Glaze <dionnaglaze@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Mar 2024 at 20:17, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Feb 27, 2024 at 04:19:14PM +0100, Ard Biesheuvel wrote:
> > diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> > index 01d19fc22346..eeea058cf602 100644
> > --- a/arch/x86/include/uapi/asm/bootparam.h
> > +++ b/arch/x86/include/uapi/asm/bootparam.h
> > @@ -38,6 +38,7 @@
> >  #define XLF_EFI_KEXEC                        (1<<4)
> >  #define XLF_5LEVEL                   (1<<5)
> >  #define XLF_5LEVEL_ENABLED           (1<<6)
> > +#define XLF_MEM_ENCRYPTION           (1<<7)
>
> Needs documenting in Documentation/arch/x86/boot.rst.
>

Ack.

> And yes, those 5LEVEL things are not documented either but I'm even
> questioning the justification for their existence. We'll see...
>

Yeah that seems unnecessary to me. They are only used by kexec, and
only for cases where you want to kexec a [much] older kernel that
cannot deal with 5-level paging at all. AFAICT 5-level support was
added in v4.13.

So I think we might be able to drop these entirely, no?


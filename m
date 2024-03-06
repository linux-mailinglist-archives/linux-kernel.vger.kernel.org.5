Return-Path: <linux-kernel+bounces-93977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D15218737BB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0BE1F230BE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87472130E4B;
	Wed,  6 Mar 2024 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dnQKyjq5"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ED7130ADC
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709731865; cv=none; b=hAofs5xvdmXorpj/20l/kLnHGyU2H8dzFtBHCfy/IgB9uGdqTojUqppCImn8XXYuxuUA7ZroiDe7xg4HZcR6Fe1YaaAYJi6WGTdMLv/vEM7avUD2VzvkLeynQQdGZSp/by7eEw+lDlCl5QZ+pSVwEcTU7gmBUuzPwLMfIIdp4lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709731865; c=relaxed/simple;
	bh=s9L9wOsEMWKTm3VHb4hKYH2x0J14mbxKsTebR1oSvmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4rZkinXyKhb1iceMTg+jpyyYcMoHJynrFrJl5npDNBzBmJJafGq/J6hK8hs91ixm9GFoP/1B6Wnb9+76JEgRL7OkJpvZc86Eyv8AV8b9/WThgGiucl89Odr1sPYr+XAU3FWNze+9g1J4b8g1Am1qQH1GFfVbxkZ2VFlU6Uu/0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dnQKyjq5; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-21e45ece781so4983262fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 05:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709731863; x=1710336663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kh51b/rQt55meA6gXpgSjO1cqO3LzSbrLvgk9FvgIw=;
        b=dnQKyjq5cztTK1swhDMh8Vq4s4iV7HiTfu7TdrSN2zTcqD66Oo/Cc4CtZxbdYD3Q/B
         ypahWzWzG4f0CfxUd3H35WGHuxyx+1ejKdAB7w479/XdVFmCojL2fLHjXFcqKWrkqVuA
         kjoeriG4TGwsL79GqfuD3NoyrfxuxSBzFTShcKjXLFilcvSaX6wZcDNQws0ueDwE+62N
         n7AVpR2hHgMTTpKdiHKclCeW2Vpe/UBv3HU+YeTP+gVH2kpP8bQXWRThaSyvz6qhsxZK
         tv9vDHhd0uMQAO49Z4ZyqFVSqVt731j5iHcWaLl1yimunmjR9JtGZEHoh2bB5PX+E8rF
         attg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709731863; x=1710336663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kh51b/rQt55meA6gXpgSjO1cqO3LzSbrLvgk9FvgIw=;
        b=AVFK7cCId8BQhYRtJpJO7PIO1LKwRliJh1KXjl6ur0i4FcnHI2q3I1I5+UZ4JCwVba
         dE4CKUiRcw3hKSGltdVfgz3usg3NOofDh0wVoJTkGmvSGWwkfMlRvrQWRKOdb2Nrahgz
         xCoBSo6s4c8bxZj9NwbrknNANzjHf4tzXTcpCDnhYgEXzCK1cbu0Z5GK1s8JhTfV2KMT
         qz/0DHzsdkHCfCUa4k69/MhPRy3f1R3RlM/xDxcYGG14GYja7Bw4EXsRF94D9ashFCOO
         tOxgS8rP5mIhZcjXnGaNobDewpm/N0p7Ip10Gdo4KqY/NPlRIbztiBxm2WlQOunk8GEL
         pSJw==
X-Forwarded-Encrypted: i=1; AJvYcCWCQ5vvJXubGClg+fnSWMEuRGDu4CtW69pj+mjujPMKMcE+hbEHlbVlHUbFbmcPX8OBKHJz9vwmcNfF8Fy6+w0PoHt8HAMn4lEN4i2p
X-Gm-Message-State: AOJu0YwKHOQNVlf2gTU3IcrGp+eINgnXExgRG8H9vF+g0JO6IIhTqCiT
	yeuKyGFjjKy6dwzUrA2okvxu2T29CVXdXCR1Sr3BT4O/swIqZrNeEEtMy2rgH6E8ZmeKHF3QqSO
	nhyOoUlXL/Va2WbzEm50y3FQOxDzyPLq9cgubng==
X-Google-Smtp-Source: AGHT+IGsESZ28cADtj1/qO3+J9Uodvw2vXH9gd6MIiRper+aJOdmK0FpZ5KKlkyJpg9j4OHGhq9BJkjNjaQwfBjs/x0=
X-Received: by 2002:a05:6870:2302:b0:220:bce1:448f with SMTP id
 w2-20020a056870230200b00220bce1448fmr4753787oao.40.1709731863257; Wed, 06 Mar
 2024 05:31:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306085622.87248-1-cuiyunhui@bytedance.com>
 <20240306085622.87248-3-cuiyunhui@bytedance.com> <CAMj1kXEjjFAeVAVwiDO22RJECSM=L=0q6J=zog7JR38rUZpLGQ@mail.gmail.com>
 <CAEEQ3w=2pX+pjwoz=hNFpR4thD+d6o9OmBob8LMzZ8BbKZ=pqg@mail.gmail.com>
 <CAMj1kXFG=y_XXiaBHZOXDApZiCb48i0U5pX+GBRO2KAUom52VA@mail.gmail.com> <CAMj1kXH1oMbONoHFMPaatfaqrHNE2ryfrG7kw-7J-eFsuXkK-Q@mail.gmail.com>
In-Reply-To: <CAMj1kXH1oMbONoHFMPaatfaqrHNE2ryfrG7kw-7J-eFsuXkK-Q@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 6 Mar 2024 21:30:52 +0800
Message-ID: <CAEEQ3wnuqBYcrwaRhx46E2kbwcHR_miE4+JzK=CmYhF0zMA07Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 3/3] efistub: fix missed the initialization
 of gp
To: Ard Biesheuvel <ardb@kernel.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	xuzhipeng.1973@bytedance.com, alexghiti@rivosinc.com, samitolvanen@google.com, 
	bp@alien8.de, xiao.w.wang@intel.com, jan.kiszka@siemens.com, 
	kirill.shutemov@linux.intel.com, nathan@kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ard,

On Wed, Mar 6, 2024 at 9:09=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Wed, 6 Mar 2024 at 14:02, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Wed, 6 Mar 2024 at 13:34, yunhui cui <cuiyunhui@bytedance.com> wrote=
:
> > >
> > > Hi Ard,
> > >
> > > On Wed, Mar 6, 2024 at 5:36=E2=80=AFPM Ard Biesheuvel <ardb@kernel.or=
g> wrote:
> > > >
> > > > On Wed, 6 Mar 2024 at 09:56, Yunhui Cui <cuiyunhui@bytedance.com> w=
rote:
> > > > >
> > > > > Compared with gcc version 12, gcc version 13 uses the gp
> > > > > register for compilation optimization, but the efistub module
> > > > > does not initialize gp.
> > > > >
> > > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > > > Co-Developed-by: Zhipeng Xu <xuzhipeng.1973@bytedance.com>
> > > >
> > > > This needs a sign-off, and your signoff needs to come after.
> > > >
> > > > > ---
> > > > >  arch/riscv/kernel/efi-header.S | 11 ++++++++++-
> > > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kernel/e=
fi-header.S
> > > > > index 515b2dfbca75..fa17c08c092a 100644
> > > > > --- a/arch/riscv/kernel/efi-header.S
> > > > > +++ b/arch/riscv/kernel/efi-header.S
> > > > > @@ -40,7 +40,7 @@ optional_header:
> > > > >         .long   __pecoff_data_virt_end - __pecoff_text_end      /=
/ SizeOfInitializedData
> > > > >  #endif
> > > > >         .long   0                                       // SizeOf=
UninitializedData
> > > > > -       .long   __efistub_efi_pe_entry - _start         // Addres=
sOfEntryPoint
> > > > > +       .long   _efistub_entry - _start         // AddressOfEntry=
Point
> > > > >         .long   efi_header_end - _start                 // BaseOf=
Code
> > > > >  #ifdef CONFIG_32BIT
> > > > >         .long  __pecoff_text_end - _start               // BaseOf=
Data
> > > > > @@ -121,4 +121,13 @@ section_table:
> > > > >
> > > > >         .balign 0x1000
> > > > >  efi_header_end:
> > > > > +
> > > > > +       .global _efistub_entry
> > > > > +_efistub_entry:
> > > >
> > > > This should go into .text or .init.text, not the header.
> > > >
> > > > > +       /* Reload the global pointer */
> > > > > +       load_global_pointer
> > > > > +
> > > >
> > > > What is supposed to happen here if CONFIG_SHADOW_CALL_STACK=3Dy? Th=
e EFI
> > > > stub Makefile removes the SCS CFLAGS, so the stub will be built
> > > > without shadow call stack support, which I guess means that it migh=
t
> > > > use GP as a global pointer as usual?
> > > >
> > > > > +       call __efistub_efi_pe_entry
> > > > > +       ret
> > > > > +
> > > >
> > > > You are returning to the firmware here, but after modifying the GP
> > > > register. Shouldn't you restore it to its old value?
> > > There is no need to restore the value of the gp register. Where gp is
> > > needed, the gp register must first be initialized. And here is the
> > > entry.
> > >
> >
> > But how should the firmware know that GP was corrupted after calling
> > the kernel's EFI entrypoint? The EFI stub can return to the firmware
> > if it encounters any errors while still running in the EFI boot
> > services.
> >
>
> Actually, I wonder if GP can be modified at all before
> ExitBootServices(). The EFI timer interrupt is still live at this
> point, and so the firmware is being called behind your back, and might
> rely on GP retaining its original value.

OK, in v2 I will restore the value of gp as follows:

  efi_header_end:
+
+ __INIT
+ .global_efistub_entry
+_efistub_entry:
+ /* Reload the global pointer */
+.option push
+.option norelax
+ addi sp,sp,-8
+ sd gp,0(sp)
+ la gp, __global_pointer$
+.option pop
+ call __efistub_efi_pe_entry
+ld gp,0(sp)
+addi sp,sp,8
+ret
+ __HEAD
+
         .endm

what do you think?

Thanks,
Yunhui


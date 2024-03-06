Return-Path: <linux-kernel+bounces-93901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9A9873689
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AEFE1F212CE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C357FBC0;
	Wed,  6 Mar 2024 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="S79WCtKD"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD501DA4C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 12:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728474; cv=none; b=oGrX3sV965HwrbG2791X57H9iK12WBRlmYU/y6jNysQMKof1cxXh4kh8Pj0peAjlLeFVj5H0rUS3CYJpTttWXLMVvZxsGhjw8n2bTkVL2kbQiW+NR66ys4FXLh3k2XdmuLKPcQiEE0I2RdD6sIG1KWxbPYU0s4EmWS/MSQy+4UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728474; c=relaxed/simple;
	bh=lOmHXFV1q2SkSccnYTkh8HGuSJYGo1dzQ6tvcIEPcCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDrkUDnlGCR9Xe82L0vyh5i+uPomT11F2RUq3F+Eax+dCBAtV8+ldkGXOkEH6l+twn42FiyVjcDyxUzx9cdfAXv4rTocjSkNItpSTWrHlwAp+NvOxD6cw0WeL5cyRKqWCrcqRBH824mVSV2QnmC/HOjcYuAguJmo/PC1QxIVwig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=S79WCtKD; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c1a7d51fb5so4864699b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 04:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709728472; x=1710333272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBGRXmGCAD/uVlbKtB45vlqVQka6EkYD3kJejOBpkfw=;
        b=S79WCtKDScbaBeFmt1Ss0CwynTLXHrzSgKqEp4shWDY+Si9OnNybthD07qlKCBpYBP
         V48e+NAPuqDz0hhOwp8NvqpZkhYzpRYrPM7jBxyaMR6mn7aQXjl/poPeeXMQdjoPYWY6
         nUnQHP/tUKl7ephrlfa2SYcx3TBxCgfmAChAiOJCjpcWCGeC8JyrWsLTiwZIbdTe99lw
         Qn3f8m4z4OfLWknarloOyiIZeydsEGz3g9u41rqITxiMlEp4SEDnpdISCVE/6Wv3VC7Z
         koGcL2mIinUaWqswSJ7/ek2cLefXy5+e/NBp9KVhezaQ/x8X2MZeFfIO7QVdeBBqAET2
         dpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709728472; x=1710333272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBGRXmGCAD/uVlbKtB45vlqVQka6EkYD3kJejOBpkfw=;
        b=q33T5gIi6HsPuXeHd8Q1yIG8+Aa0TtCq+t1DTF8HTURv+regLucrOhSlRPEuuIcUci
         NraCCVVuiNtHZhojqyra8vjI7LalCo5hl6BFofoWnKsaZ99a6fFWCGcNbeOPDBBwZICi
         x/xVtodMQWr31uPMLVFkdagtlUob/zRpOYH+zXk0ItO8f+f2ExE8vLyrEll7sB+4gCZ1
         hN75AiuipTrJzmd2bT6+cAIBIzwMFuAsmUegfH16A9f83Lk92lOrCJNrJ313yClDORFX
         UeAfz63mli8QoJrBPFWL9WWGyeq+RM3vydW7Xk8/VjCq9eI66TXV8we03FoEj9+K7hrk
         xd0g==
X-Forwarded-Encrypted: i=1; AJvYcCWHgXATFv/5G5jHZW3b5RPsC5m7AAQyd6dWMol4j0BdASGFc1H8FNGVOv+MsaQjdisiU1LS+JP4ATtzYVQabQBRMSyQBRi96T89/i6T
X-Gm-Message-State: AOJu0YyM1j5anX80lzhNdR+qYxgqmTmz3p5yqolEKpHhiI+8lEenXiWM
	IAjircK+92wdjfUC+3tM5aO1a6bEcwh9m1NUlmGcIV63x92mc4YpQr/YsHdC9noSZ2MET03h5/Q
	wvDO1VD5T4IuSIrEzo3yXFQfVSyG/Q6oTPBRmSQ==
X-Google-Smtp-Source: AGHT+IEKZchaHuxM+IkeNKMSoR23Mk/EGmhIpibhcWiKs7wVibMip+LebNngnKtOjIhBOtdjNHUw+nGKFWAgS+qZ5g4=
X-Received: by 2002:a05:6870:c192:b0:21f:dc6e:e4f9 with SMTP id
 h18-20020a056870c19200b0021fdc6ee4f9mr5153338oad.1.1709728472158; Wed, 06 Mar
 2024 04:34:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306085622.87248-1-cuiyunhui@bytedance.com>
 <20240306085622.87248-3-cuiyunhui@bytedance.com> <CAMj1kXEjjFAeVAVwiDO22RJECSM=L=0q6J=zog7JR38rUZpLGQ@mail.gmail.com>
In-Reply-To: <CAMj1kXEjjFAeVAVwiDO22RJECSM=L=0q6J=zog7JR38rUZpLGQ@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 6 Mar 2024 20:34:21 +0800
Message-ID: <CAEEQ3w=2pX+pjwoz=hNFpR4thD+d6o9OmBob8LMzZ8BbKZ=pqg@mail.gmail.com>
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

On Wed, Mar 6, 2024 at 5:36=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Wed, 6 Mar 2024 at 09:56, Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> >
> > Compared with gcc version 12, gcc version 13 uses the gp
> > register for compilation optimization, but the efistub module
> > does not initialize gp.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > Co-Developed-by: Zhipeng Xu <xuzhipeng.1973@bytedance.com>
>
> This needs a sign-off, and your signoff needs to come after.
>
> > ---
> >  arch/riscv/kernel/efi-header.S | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kernel/efi-hea=
der.S
> > index 515b2dfbca75..fa17c08c092a 100644
> > --- a/arch/riscv/kernel/efi-header.S
> > +++ b/arch/riscv/kernel/efi-header.S
> > @@ -40,7 +40,7 @@ optional_header:
> >         .long   __pecoff_data_virt_end - __pecoff_text_end      // Size=
OfInitializedData
> >  #endif
> >         .long   0                                       // SizeOfUninit=
ializedData
> > -       .long   __efistub_efi_pe_entry - _start         // AddressOfEnt=
ryPoint
> > +       .long   _efistub_entry - _start         // AddressOfEntryPoint
> >         .long   efi_header_end - _start                 // BaseOfCode
> >  #ifdef CONFIG_32BIT
> >         .long  __pecoff_text_end - _start               // BaseOfData
> > @@ -121,4 +121,13 @@ section_table:
> >
> >         .balign 0x1000
> >  efi_header_end:
> > +
> > +       .global _efistub_entry
> > +_efistub_entry:
>
> This should go into .text or .init.text, not the header.
>
> > +       /* Reload the global pointer */
> > +       load_global_pointer
> > +
>
> What is supposed to happen here if CONFIG_SHADOW_CALL_STACK=3Dy? The EFI
> stub Makefile removes the SCS CFLAGS, so the stub will be built
> without shadow call stack support, which I guess means that it might
> use GP as a global pointer as usual?
>
> > +       call __efistub_efi_pe_entry
> > +       ret
> > +
>
> You are returning to the firmware here, but after modifying the GP
> register. Shouldn't you restore it to its old value?
There is no need to restore the value of the gp register. Where gp is
needed, the gp register must first be initialized. And here is the
entry.

Regarding your first two comments above, I plan to make the following
changes in v2,
efi_header_end:
+
+       __INIT
+       .global _efistub_entry
+_efistub_entry:
+       /* Reload the global pointer */
+.option push
+.option norelax
+       la gp, __global_pointer$
+.option pop
+
+       call __efistub_efi_pe_entry
+       ret
+       __HEAD
+
        .endm

what do you think?

Thanks,
Yunhui


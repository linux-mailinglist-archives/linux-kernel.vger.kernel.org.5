Return-Path: <linux-kernel+bounces-88443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3355586E1AC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9B01F21F95
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F55E6EB76;
	Fri,  1 Mar 2024 13:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsYRQk45"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7B66EB7E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298918; cv=none; b=NE8HtSfbK6aCY4y7vWDGHeRJCdwdWFsbRaNMOF/TlIp+mIGfyIaTWVQkGVxfmiAMEoRSvX4eBJ2/hKnP4ffT4P+X/pNFaWcNxM3TtkDqDWlbnilKceBmkVVjcRzrhsZRcEVhTwst906GUGRFLS2x+zVYfL9f3BaxGUUibPX0brY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298918; c=relaxed/simple;
	bh=8mbZMluVV7uxCPUSfvI/xi4AxmELics9y5Dj7dgLU1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0nHi8hrcgyIiH7puRW1EltPAhp8aJHtBYOsFpa3boK/tBuWwyvkyvkG6GKyPRPM3B0X4N8VWUILPOm+zVo6t7LM4Sr7N8E6Qry9znv3XGgfzWLllpzC5VuMWx6GhI+Q07eZxWYOUOm5TcTAIxleYn+znn4AWifTSVgWdcaae/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsYRQk45; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5131d0c3517so1975195e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 05:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709298915; x=1709903715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7jI6YpRXYWEOJt3lCJ5FPI/CE2amSmrkBbV5C7Gjjw=;
        b=AsYRQk45By+X+HFe3EwpkJpNxKF9/NGb/2NySZ8/mbyYlR33Glt1Zl1ug/3ElyF9yd
         o7f4B6OzEPb9gEStENhuiPFj5R1qRASlGvECpekonyfukDk9jYKp5fxwF8Mtiz8KgDJp
         FRB0/rZyXfr6Av8HpEMOgWf3zf4r0bHcZCJ2Ieex/9NWaUwtSHoJS7JBIx45HsBFzlLn
         QgQTZtfWHWVyIRxeNfV29XrSlPcU7IDhmFkNfk0sT/kXDsuRxe19nH3/7vBuCDS0M1aj
         HmVNv7+Q8YIDbUkq6Rugx63VQZ08Uy5178wyHQh7VMGd1oyJeV0H9UA423Wlpjg03U5J
         YFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709298915; x=1709903715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7jI6YpRXYWEOJt3lCJ5FPI/CE2amSmrkBbV5C7Gjjw=;
        b=Bh/d7Wm9qTqS2WHJDZAfgEgL1Nahz9rG83nLqjj+MdqIOQM4AfRns7zSYSC0NFmwtk
         CdtkmsgsbaYqWafGOqw/xd4yYe/jnwOQl2MbeTl0dmxB6K7w5ORyFiB2xlZZQNrSBFJh
         /LHRSMYTTJPDq8L6IeAsJdbYsCl2FnT4r0Ach+OpNPQOP8vdjSL+tckwX1aBvAB0Pqv6
         kZivzvM57s0B2pWuSPpQ831y9KIgqD51WCWPdbIEgqC9xsj30esW3kFwva5dtocHnbky
         KCT4HsFBmt6xJRngt1P9RwMnBHlXh7ghrqdDxenUuO0qlfKsLnp8yay7Ph+jFNpgBK3N
         ek8w==
X-Gm-Message-State: AOJu0YyKg/kPSBGGCtbxLsdh4+Sr7RmqVARJ+avMA8trcs/DBomDv/q+
	dEkLjfyWt1crOp1tEJFhf6vV2y3BLG80474lKQeHqUtRw3lxU7NbhqA027UfhAr5X43e5znlu+S
	pPQpr55i0NK+/5BTZY3q78sLVLA==
X-Google-Smtp-Source: AGHT+IHTpTKeubzmngBLUQ8GTp71iL6yaOBt+oGP0pL3AnhAaKOa8aKmdLAvnlBLqHPMktj9rpmNWkYDOaMpmZbr2NE=
X-Received: by 2002:a05:6512:104b:b0:512:f29b:309e with SMTP id
 c11-20020a056512104b00b00512f29b309emr992425lfb.28.1709298914889; Fri, 01 Mar
 2024 05:15:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301084046.3370376-1-xin@zytor.com>
In-Reply-To: <20240301084046.3370376-1-xin@zytor.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Fri, 1 Mar 2024 08:15:03 -0500
Message-ID: <CAMzpN2j7xKcGx=+z8mu_2z2RsqjB-mpODdrOH7N1J2_OzuyEUQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] x86/fred: Fix init_task thread stack pointer initialization
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 3:41=E2=80=AFAM Xin Li (Intel) <xin@zytor.com> wrote=
:
>
> As TOP_OF_KERNEL_STACK_PADDING is defined as 0 on x86_64, no one noticed
> it's missing in the calculation of the .sp field in INIT_THREAD until it
> is defined to 16 with CONFIG_X86_FRED=3Dy.
>
> Subtract TOP_OF_KERNEL_STACK_PADDING from the .sp field of INIT_THREAD.
>
> Fixes: 65c9cc9e2c14 ("x86/fred: Reserve space for the FRED stack frame")
> Fixes: 3adee777ad0d ("x86/smpboot: Remove initial_stack on 64-bit")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202402262159.183c2a37-lkp@intel.co=
m
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
>  arch/x86/include/asm/processor.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/proc=
essor.h
> index 26620d7642a9..17fe81998ce4 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -664,8 +664,10 @@ static __always_inline void prefetchw(const void *x)
>  #else
>  extern unsigned long __end_init_task[];
>
> -#define INIT_THREAD {                                                   =
   \
> -       .sp     =3D (unsigned long)&__end_init_task - sizeof(struct pt_re=
gs), \
> +#define INIT_THREAD {                                                  \
> +       .sp     =3D (unsigned long)&__end_init_task -                    =
 \
> +                 TOP_OF_KERNEL_STACK_PADDING -                         \
> +                 sizeof(struct pt_regs),                               \
>  }
>
>  extern unsigned long KSTK_ESP(struct task_struct *task);
>

There is another spot in head_64.S that also needs this offset:

/* Set up the stack for verify_cpu() */
leaq (__end_init_task - PTREGS_SIZE)(%rip), %rsp

Brian Gerst


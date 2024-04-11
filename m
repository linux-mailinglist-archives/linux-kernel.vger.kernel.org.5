Return-Path: <linux-kernel+bounces-139745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F53A8A072B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B79A6289DC2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F7233CD2;
	Thu, 11 Apr 2024 04:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aK3RmiAQ"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6765CBD;
	Thu, 11 Apr 2024 04:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712810106; cv=none; b=Qav3Ilea6up1g/Zu9puUBt89LJfABp33RVICrxhC9oy3uRl88EV2CXOanGY/9DKbP8xLWuuSdXfZYP8trdr1JV3Remx9kF/wHBew40/VuclwFw922DNTve18lvYscuEk7DikeeowOqm/CKHsgFQ69uGfuJXXCCpapBIILIJjFAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712810106; c=relaxed/simple;
	bh=bEijAUZrp7BndJRqhsj8GrSSnt+k5XwByNdvDerSO5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUCGzruRQEi99JWhXm1SxNk94c6dMEdyMWvRl/McR48zRt2QPfHLLVHqUmON1rYfBeQgfekBc2QuPyR0q2Dg2iafWmkmtdvPPTpYRbc6zK5zpuvILMyTVqF4OmRBCS8IuVdc/KTzmsglUF3yO8sY2UH99cwyhsaEiwbUoIk+8Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aK3RmiAQ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2a2d0ca3c92so348918a91.0;
        Wed, 10 Apr 2024 21:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712810104; x=1713414904; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sEmjn6/1Suv/E32wfG8TchU/rYu06TIMqB3RylipRlQ=;
        b=aK3RmiAQ+xeZ8LlT7Geku4tNG8b2QqMzk4/wZj3cgH4dQPKd6CkBuiiolZZtZ1cp+O
         V4sWXawg3olMYFMHwZXYbYua5tTXQ11+hX12i3eoDlauLV2tAPN1AySn0emc4GegMws2
         bVKoJr+OPijiKMbZX+yyMguBmwZNpxgDqMZqBk0JgsWdRNGLV7aJUujuflnb4tvARfLI
         CcNzcQuogxU6uqorsiIx7WMvcypObx/0katTUEY/UKHIgh0f9tWFPqD2uJPqRw9bKP01
         ArFRxNZzpxgVo5wvjfTewPoQxCr3qft2H7sKkzMq+4ZyrfPTZP6tBkdM/2AGJ8BpCZKd
         mhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712810104; x=1713414904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sEmjn6/1Suv/E32wfG8TchU/rYu06TIMqB3RylipRlQ=;
        b=ugGYL24fVvTtqfyBESQLMqRKVq1+KooaFtosAgCf4CVxKR3rgTFeHhM99NZp97vh9z
         4rE1nzdtkdqL0zG0Uv0c1nlhPFDnlLs7EFKhNWduu3u2BwoVKX8cJlHhOcmHnlPTtfI8
         /9s+dT90bH+seLP424cJ6alxSKw18dS5UA8E9ozt5nnA8LQ/ZnJQDo3DVUubl8rKOTZD
         ZfzgEIVKD+HAtEXTpFHsfLRjwqu91ARy8yeOBrFdLYraAOTi0o+oVJYHoPvOCy5p5xOF
         +5oTl306i6oMQTEeNAI1gnNmmVCkxjOgw7utCt38F7zQaz7XcNc/bWWVzeTPVwOFjkdD
         hLow==
X-Forwarded-Encrypted: i=1; AJvYcCWO/rRyc37d3orFJB0MNBsyLS37fBVKYT8hh+BJYhxUsZFEin9LgeLomHfMabAlet2NNZedMpRAl2o4z19mdWUyMLKzRpqmfhNeMaMl2F12PkQvXXyFyS6YD6jQq8pohceO7WWXCr/QTfJg
X-Gm-Message-State: AOJu0Yw0WYsM10n8LKkWprMc9B4b9ogzvydNNLCZvLKOT+ZzzAnABNsb
	lGQ46WwMs4xMMF4Ht+p5dC2R/k2mrvrm32O/4tWWVkws94iIO+HZD7a7r3q7sRg5tyCMGufvEl+
	vt4b1lmRDaWlLPn2Vy6dJNbAyBEY=
X-Google-Smtp-Source: AGHT+IEjfkEIZVs55t1O1ovHEUqxfV3BR2fTc+DWjL4WhuAN5vFS92bmPWxom9Us4kImDaM/q2Nn9Txz0Uz82jDc7m4=
X-Received: by 2002:a17:90a:d507:b0:2a2:c40a:1a5 with SMTP id
 t7-20020a17090ad50700b002a2c40a01a5mr2181018pju.12.1712810103695; Wed, 10 Apr
 2024 21:35:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411-as-instr-opt-wrussq-v1-1-99b1a1a99f93@gmail.com> <CAJwJo6aBbw96uo_eiDuKP5nX4EsoSYkEmaKjdMY01_Pc2z-1DA@mail.gmail.com>
In-Reply-To: <CAJwJo6aBbw96uo_eiDuKP5nX4EsoSYkEmaKjdMY01_Pc2z-1DA@mail.gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Thu, 11 Apr 2024 05:34:52 +0100
Message-ID: <CAJwJo6bw9Fo0qVC7EpAQFMXR34-vkq+A-2woE2k-=MpwOnqD7w@mail.gmail.com>
Subject: Re: [PATCH] kbuild/x86: Use $(KBUILD_AFLAGS) in Kbuild's version of $(as-instr)
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Apr 2024 at 00:41, Dmitry Safonov <0x7f454c46@gmail.com> wrote:
>
> Please, ignore this version.
>
> the previous one was to add a helper function and that seemed to work,
> but on rework to actually use KBUILD_AFLAGS instead of adding a new
> function I certainly haven't tested it enough.
> Going to prepare version 2, sorry for the noise.

Yeah, in the end I debugged why it doesn't work, for the same machine
as in the patch message:
$ grep KBUILD_AFLAGS include/config/auto.conf.cmd
ifneq "$(KBUILD_AFLAGS)" "-D__ASSEMBLY__ -fno-PIE -m64 "

Notice the trailing space? That's the thing that doesn't match with
the $(KBUILD_AFLAGS) in top-level Makefile.

Adding some more debug:

> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -80,8 +80,10 @@ simple-targets := oldconfig allnoconfig allyesconfig allmodconfig \
>         helpnewconfig yes2modconfig mod2yesconfig mod2noconfig
>
>
>  PHONY += $(simple-targets)
> +$(info KBUILD_AFLAGS is "$(KBUILD_AFLAGS)")
>
>  $(simple-targets): $(obj)/conf
> +       $(info KBUILD_AFLAGS for $@ "$(KBUILD_AFLAGS)")
>         $(Q)$< $(silent) --$@ $(Kconfig)
>
>  PHONY += savedefconfig defconfig
> --- a/scripts/kconfig/preprocess.c
> +++ b/scripts/kconfig/preprocess.c
> @@ -79,6 +79,8 @@ static char *env_expand(const char *name)
>         if (!value)
>                 return NULL;
>
> +       fprintf(stderr, "\tvariable '%s' = '%s'\n", name, value);
> +
>         /*
>          * We need to remember all referenced environment variables.
>          * They will be written out to include/config/auto.conf.cmd

Results in
>          variable 'KBUILD_AFLAGS' = '-D__ASSEMBLY__ -fno-PIE -m64 '
(with the trailing space),
> KBUILD_AFLAGS is "-D__ASSEMBLY__ -fno-PIE -m64"
> KBUILD_AFLAGS for syncconfig "-D__ASSEMBLY__ -fno-PIE -m64 "

Ok, so the variable is actually being updated by a common rule in
> scripts/Makefile.lib:KBUILD_AFLAGS += $(subdir-asflags-y)

Which adds a trailing space to $(KBUILD_AFLAGS) and as a result breaks
the comparison in include/config/auto.conf.cmd

So, I see 3 options for the patch in the thread:
1. Simple and ugly: add ifneq to scripts/Makefile.lib and update
KBUILD_AFLAGS only if $(subdir-asflags-y) is not empty.
2. Maybe a better one: remove trailing (and potentially leading, and
duplicate) spaces for expanded variables in
scripts/kconfig/preprocess.c
3. If the issue in the patch description is not worth it: I could just
work that around in the build system.

Please, advise what's your opinion/views.

Thanks,
             Dmitry


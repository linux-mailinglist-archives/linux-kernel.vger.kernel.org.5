Return-Path: <linux-kernel+bounces-126442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE2B89381C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 07:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB6681C209DF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 05:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883BD8F51;
	Mon,  1 Apr 2024 05:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyuKNaZn"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346AD53BE
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 05:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711949911; cv=none; b=h1iVnpf96WWmuI6hDN/ipO54DUiIvN9BkKSG8Fx4WdNrt7AegYiIS9vPOoDqyA6UC84lOciNtITx3cMVfPI1ge+wjvmqYVLOnn0H5grziBS1oyNfCIXLmGMmvjBwwjGdw2odOwKosOX/rIKfPm6QRKzXUbxAs1Lzk3rREMlb7nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711949911; c=relaxed/simple;
	bh=s2ihVGbChz7AlDuT05FfcZ89KA/Djp/0NHWTTarQEc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JEynFL5gnxDPqP6caxUDVUEGYXodZ5kg2cXjudeNIbuXyOiLJ4mfe3rwsZyc+O+KdLtbg1dCjW957cqqejXFLBHbXF1gJEmQpMBEwygp3WpalEkGj+ROJM89Se5og8Jq8+4E8Z9YYX7aAVDnr4EnAnEnnta7MPGH18sAV7jjWAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyuKNaZn; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so4167590276.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 22:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711949909; x=1712554709; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DnRWyartLECyrpSWBeTf6KyP7yXwulRWQma0jRWlssE=;
        b=NyuKNaZnZjB9RY09DhfnF1TXXwGu13tlIzn/uqQ0cqxz0c9lHjPMVZIGJEriqoWsRZ
         eZEFjKPNjf5h0Kbqph537Bc+x36nNTb1Qk8THcW1pIRxSQXizvMRI+/9+WoKt9KchcLA
         x8tdyJs/sTp178QnZEuSzKMPxc/eMF6a6cCz7Jfq+PBNuamaFOHeTEzUR/Tk3Q/32aeN
         E6vykg5VoqapQjLet14xWmAHPyzpHvq4ftxX3TZ7GygpmL29NHfZwCYXhvZrHKJk8Yy5
         X7t/Wc6F3x1ZDO/vRe4GOucFq8DTAnbJWKlWWz0o3pDt5XjRkXkxmPV6JFz7WuqfZK2t
         sdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711949909; x=1712554709;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DnRWyartLECyrpSWBeTf6KyP7yXwulRWQma0jRWlssE=;
        b=a9L7vaW+oBUf7OCtmyDH4Jw+FTY934TowYq7SPAmtJazrNhgK/ybOfhQCQUYNSpD2R
         TeQWYGSLHiwWw+CLxY5TiAn7YnEJt4eOHo/IU+KXezT0ve2x0ddzUZOWsJDiZBrt9Mng
         u1h7ZTs4zyI8jlCBQE8dFo38yrfbHLJJTXjXJYYWwqS6QAxCqVGllG45vtqpeCKIYeIB
         VOVkLrrnWJNdLuMFcD2ZPCpkYDTa/H+AIrD3IvLmexNDDrDjnb+8Rl8Iw30mHgBtZPTN
         ENQTj9OhHRG+OXYLe+c1bf+wxTCGir0TkF08A91agqMMC8R7MfpaK0ZBXI+agI/Sb8S2
         LyiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYMHAcTyuwFAkEwT+8W1/I0AxJGBRf77r3AptOWXjf88ibkt8t8ttbcKuCS1Vc+AcdIp7vHhBUchOewa9joPTgoPNBv7gef/L+OVPQ
X-Gm-Message-State: AOJu0Yy2HhE0ejuVxbvC1QG1Ium6YQXBXZ/CpjqSh5FYQNo8mFccOx7d
	vNL/f9mDL4Ha3oHEfi0+NB+1obfc5WjIlh0QF3n3sb7qpZ4UWrLH+bVRVFe2RN35i/AlSYudCQJ
	nblLtvdAGy/jJk7kCtxrRJgOJcfBLZ1/g6yVYCPa5
X-Google-Smtp-Source: AGHT+IF/GvjrjIYToxWMHiwEOXeLmZmQxIx9RsaWxQcVOOLlgLob75EIB2EeGRLPwQSxPWJvr6C+jzPjO+HKLbI23co=
X-Received: by 2002:a25:bfc5:0:b0:dda:a35e:3431 with SMTP id
 q5-20020a25bfc5000000b00ddaa35e3431mr5475283ybm.16.1711949908967; Sun, 31 Mar
 2024 22:38:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240331200546.869343-1-m.younesbadr@gmail.com> <20240331202827.GAZgnHayn794X_Ubs4@fat_crate.local>
In-Reply-To: <20240331202827.GAZgnHayn794X_Ubs4@fat_crate.local>
From: Mahmoud Younes <m.younesbadr@gmail.com>
Date: Mon, 1 Apr 2024 07:38:17 +0200
Message-ID: <CAMpxDQmx45VrrdZq6couUg0gU200qYdDiYF3Q=S+Nck6g-50LQ@mail.gmail.com>
Subject: Re: [PATCH] kaslr: x86: fixes log message nokaslr
To: Borislav Petkov <bp@alien8.de>
Cc: dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks a lot for the reply. here is my thought process:


On Sun, 31 Mar 2024 at 22:28, Borislav Petkov <bp@alien8.de> wrote:
>
> On Sun, Mar 31, 2024 at 10:05:46PM +0200, Mahmoud Younes wrote:
> > Unknown kernel command line parameters nokaslr message will be printed
> > to kernel log buffer if nokaslr option exists in boot command line.
> > nokaslr gets consumed earlier and this message becomes confusing.
> > impact is that user gets confused whether kaslr is enabled or not.
>
> Well, my dmesg has here:
>
> ---
> ...
> trampoline_32bit: 0x0000000000000000
>
>
> KASLR disabled: 'nokaslr' on cmdline.
>
>
> Decompressing Linux... Parsing ELF... No relocation needed... done.
> ...
> ---
>
> so the notification for the user is there.
>

I don't think this gets printed after executing dmesg. This gets
printed to console if earlyprintks are captured to the console and the
kernel is configured with printing low level debug info. that is not
the default behavior and requires manipulating the kernel
configuration and command line to get this message. Specifically,
enabling DEBUG_LL and EARLY_PRINTK and adding "earlyprintk=ttyS0" or
whatever console in use. the message is just not visible in dmesg even
though it would exist in kernel log buffer, just the console wouldn't
be initialized at that moment. moreover, this is not visible when
booting a real hardware.

> > Signed-off-by: Mahmoud Younes <m.younesbadr@gmail.com>
> > ---
> >  arch/x86/mm/kaslr.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> > index 37db264866b6..a62cb0675e22 100644
> > --- a/arch/x86/mm/kaslr.c
> > +++ b/arch/x86/mm/kaslr.c
> > @@ -179,3 +179,9 @@ void __meminit init_trampoline_kaslr(void)
> >                       __pgd(_KERNPG_TABLE | __pa(pud_page_tramp));
> >       }
> >  }
> > +
> > +static int __init parse_nokaslr(char *_)
> > +{
> > +     return 0;
> > +}
> > +early_param("nokaslr", parse_nokaslr);
>
> This piece of code without any comments explaining why it is there is
> not less confusing to whoever stares at it.
>
> I'd prefer if print_unknown_bootoptions() would filter out those options
> which are parsed earlier and not warn about them instead of having such
> dummy stubs.
>
as far as I understand, nokaslr is not treated as any type of param.
IOW semantically it is an early param, but it will not be defined
during runtime in any of the sections specified for kernel parameters.
I am thinking of three ways to handle this issue of filtering
parameters that are parsed earlier. First way, include them in a
section (.init.setup?, __param?, new_section? the first being more
logical). Thinking about it, nokaslr is semantically an early_param
(consumed early in the boot process -- probably way too early). Hence,
it's logical to add definition for a corresponding obs_kernel_param
object for nokaslr to .init.setup via the early_param macro. The issue
is, by the time all params in this section are handled, kaslr init
code will have been executed and nokaslr won't have an effect. The not
so elegant way to handle this is the empty stub submitted and here as
well https://lore.kernel.org/linux-arm-kernel/20230412043258.397455-1-quic_pkondeti@quicinc.com/T/.
The elegant way is to define nokaslr as early_param, write a handler
that sets a boolean flag whether to enable or disable kaslr, call
parse_early_param before setup_arch (I believe this is not possible
due to the dependency; the code in early param handlers is dependent
on setup_arch being executed first) and replace the code that checks
for nokaslr in the command line with just checking the flag.
second way, provide a static array of params known to be consumed
during early boot but are not known to the kernel which does not sound
elegant to me.
Third way, leave everything as is and ignore the issue.

Since I am new to the kernel code base, I would appreciate some
guidance on how to move forward. Thank you!

Best,
M. Younes


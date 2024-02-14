Return-Path: <linux-kernel+bounces-66103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9678556E5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 223E61F273DD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4841014198B;
	Wed, 14 Feb 2024 23:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DEaA601A"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC33C13A875
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707952263; cv=none; b=haW+jDGanaJHb3o7Ip57J/NgfpD+0Lxx3x2CYPc7NoHSIcoNruynhaD15iKTqI92vX+CCi0l2wCnfd4Twl/WrsXbUITAvY9MtJPWDQMe6A5A1FbA2SrDqwwPc3oeF6NiVCnN/ur7Y6LysUAUMB3JGvgiQyo7wvs0DlDNk+SMYT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707952263; c=relaxed/simple;
	bh=UW8RGf9gZBE71QcUMtK+MfmU0jrUtwnNwb7STvh115o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqLfaLTZzHjQkZ0TchYWyyeBbOvHRKOjtkNGWzLnGwDI2Dy74EjZSlrZOwS0/fT6ktagJL+cy0xkYd2gnp+nuzJEzMiRcBbn5oGtW2ofbTE3B8QwSifCvX42XKOGbYhqQUAcQInSgAjLrK8Cavo2BVQsH5njtgeoBswkofSdva0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DEaA601A; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4120933b710so11735e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707952260; x=1708557060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFdP6RSMwEWacxovIP52kptkXcSgN4Mbf51UhpxEIDc=;
        b=DEaA601AuHQwnewbVKFA0QzUw+cjNuYf6Ma1elfxikdt33/2EalfbmoYUduRes5TV8
         P4rHdbxVUSukeDLdqo6bH4orsmz3RNlZXpu8n0CXPy7VhaJ5/KXVVDXJPcMf3MoGT2Sl
         pjXlxGysWEuCdRVXb6HLM5Dp9xwXIO9L34MkhQ11IxW/bicUxGbl1IN1WaqMnVqGJLCh
         wH9eS5j0Tb3aoru3lHoERkWLkOys1H/4aRjVVoTUjOivMwLEk6GO8SdC1dq9WPWMch8g
         pC3Gr21IZQPjglzRjxVSoXeoEk3/QFC6/PXsImnTaU08vcbbg1b2q86wMNI9WXrsVHue
         ZYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707952260; x=1708557060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFdP6RSMwEWacxovIP52kptkXcSgN4Mbf51UhpxEIDc=;
        b=nrBvRprnjf9xpzHlevyapdGCoHLemg/kqD06jlDajBSzdem63YqJOi8G3lUHvI/8/Q
         DhOEaGapbWVRkoHMFzezlrP0ifjdm+hRmcGW6BXrcGL7uhCxiuBjo3Dj7hMw+QaCwV8i
         BPsMbXsNspOJY8s34kcyWbs7+JphjeQ2nFdayW8SNWYsa+TJf9vaiL7ekFg5TlzuPmmt
         HIeL7JjfyX86CNTArfAp+Wi8TqPStMh8JXxUr/ESVgr64qjM6ZjXBA9C5fN+ey2LQQcD
         PmjY27PZvbdqJVSkPIm1HQKEG2BrXVCmxMVBx10NrkUibnrnWlIXwbD/N1tBv7m1VQCT
         KUSg==
X-Forwarded-Encrypted: i=1; AJvYcCVNQjnI+F9ng30LWnN+bImrd37ln3C6O+bv58mhzk5sJQcNdMzRAqZxrjcSxnOhUBNv7UKv12ZRTt/jsUH0t+QLU1l33S7boc6mrh8F
X-Gm-Message-State: AOJu0Yy4fYBt8RIiyCRVY86tU3g5NV8UR5a4xOpnd3WVTFnSWUWHIpLm
	vRZ6iKvnjD4Bb5UgEVTijjNUy5NvpxxHHSwYQKbvXnOMInDQuJeoKa5r5F/1J9oBu+JxfhAnYj4
	ZBHj2yf4ksIQDgDd1baBFG7YCv8isNmmTHnS1
X-Google-Smtp-Source: AGHT+IF/GMoDj0jOjVDt9C1sIgJVOb6+Nx4zE7qML7SwDzztZ+XjdTZSiyVZzroVRAotbePaXYYVUQbDyXUc8oU9ToQ=
X-Received: by 2002:a05:600c:1d93:b0:411:cdf8:f3d1 with SMTP id
 p19-20020a05600c1d9300b00411cdf8f3d1mr347227wms.0.1707952259858; Wed, 14 Feb
 2024 15:10:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214212929.3753766-1-maskray@google.com> <202402141405.0755DD4E5E@keescook>
 <CAFP8O3LWBHkbLwFJdmy7iSGD0cMSy1jczETo=N6oVapCgPY=sA@mail.gmail.com> <202402141433.AC69F2A3@keescook>
In-Reply-To: <202402141433.AC69F2A3@keescook>
From: Fangrui Song <maskray@google.com>
Date: Wed, 14 Feb 2024 15:10:46 -0800
Message-ID: <CAFP8O3JZ9=QeJR0wZwYvLYVgXKo9DYBMsaxoBS9vLJZW-U1uZw@mail.gmail.com>
Subject: Re: [PATCH] x86/build: Simplify patterns for unwanted section
To: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Nathan Chancellor <nathan@kernel.org>, Heiko Carstens <hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 2:40=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Wed, Feb 14, 2024 at 02:13:01PM -0800, Fangrui Song wrote:
> > On Wed, Feb 14, 2024 at 2:07=E2=80=AFPM Kees Cook <keescook@chromium.or=
g> wrote:
> > >
> > > On Wed, Feb 14, 2024 at 01:29:29PM -0800, Fangrui Song wrote:
> > > > A s390 patch modeling its --orphan-handling=3D after x86 [1] sparke=
d my
> > > > motivation to simplify patterns. Commit 5354e84598f2 ("x86/build: A=
dd
> > > > asserts for unwanted sections") added asserts that certain input
> > > > sections must be absent or empty. The patterns can be simplified.
> > > >
> > > > For dynamic relocations,
> > > >
> > > > *(.rela.*) is sufficient to match all dynamic relocations synthesiz=
ed by
> > > > GNU ld and LLD. .rela_* is unnecessary. --emit-relocs may create .r=
ela_*
> > > > sections for section names prefixed with _, but they are not matche=
d by
> > > > linker scripts.
> > > >
> > > > .plt instead of .plt.* is sufficient to match synthesized PLT entri=
es.
> > >
> > > Do you mean ".plt.foo" matches ".plt" ?
> >
> > I mean we just need .plt : { *(.plt) } , not .plt : { *(.plt) *(.plt.*)=
 }.
>
> But then, for example, if it gets generated, .plt.got ends up being
> reported as an orphan...
>
> >
> > The linker synthesized section for PLT entries is .plt, not suffixed.
> >
> > > > .igot and .igot.plt are for non-preemptible STT_GNU_IFUNC in GNU ld=
 (LLD
> > > > just uses .got), which the kernel does not use. In addition, if .ig=
ot or
>
> Right, the issue has been getting totally weird sections emitted by the
> linker. If you're saying you'd rather those get reported as orphan
> sections instead of being validated for being zero sized, and that works
> for all the architectures, then okay.

Thanks. I trust my judgement here:)

> > > > .igot.plt is ever non-empty, there will be .rela.* dynamic relocati=
ons
> > > > leading to an assert failure anyway.
> > >
> > > I think at the time I was dealing with avoid multiple warnings out of
> > > the linker, as I was getting orphan warnings in addition to the
> > > non-empty warnings.
> > >
> > > >
> > > > [1]: https://lore.kernel.org/all/20240207-s390-lld-and-orphan-warn-=
v1-6-8a665b3346ab@kernel.org/
> > > >
> > > > Signed-off-by: Fangrui Song <maskray@google.com>
> > >
> > > Is anything harmed by leaving all of this as-is?
> > >
> > > -Kees
> >
> > No harm. But ports adopting --orphan-handling=3D (like s390) may copy
> > the unneeded .rela_* .
> > When people read .rela_*, they might think whether the kernel does
> > anything special that
> > .rela_* needs to be matched.
>
> I added these because the were being generated. See commit d1c0272bc1c0
> ("x86/boot/compressed: Remove, discard, or assert for unwanted sections")
>
> I don't want to suddenly start generating warnings for older/broken
> linkers. (i.e. a change like this needs really careful testing, and that
> needs to be detailed in the commit log.)
>
> -Kees

I saw this commit and still believe .rela_*  is unnecessary for all
supported binutils versions.
GNU ld 2.25 does not support --orphan-handling=3Derror (2015-09
feature), but it manages to link vmlinux without any warning.

/tmp/binutils-2.25/out/release/ld/ld-new -m elf_x86_64 -z noexecstack
--emit-relocs --discard-none -z max-page-size=3D0x200000 --build-id=3Dsha1
--script=3D./arch/x86/kernel/vmlinux.lds -o vmlinux --whole-archive
vmlinux.o .vmlinux.export.o init/version-timestamp.o
--no-whole-archive --start-group --end-group .tmp_vmlinux.kallsyms2.o


> --
> Kees Cook



--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF


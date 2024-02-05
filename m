Return-Path: <linux-kernel+bounces-52707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC19849BA7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C4B21F23469
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E07E24219;
	Mon,  5 Feb 2024 13:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddD8hp5t"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F3B2374C
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 13:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707139333; cv=none; b=KDxwysjPbINPfJC2H9qcZGEJtn5QohielvGordUkv7QSvOCr5JM7zTo05G/zZMspNDUDtm0I1hefXgNbsjQBgfurC+oI0z9Ua07t80LHYjDw9Rdw0VrhnJ4BKLpkdVBCU+YuU6jsRxCqD3tPMZ43wHBDr3EmFkegy5X6G+pzDIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707139333; c=relaxed/simple;
	bh=MM5/PVuu+Ozx/sCBwUh+DYuUf420ZVMqN7zEjFxWg8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uc0YleNQA4XfXlo6EwkNNIPKSOj1utC5Mxm7ZNFgp2XJN2mo8/hBVwwG7ouo1vQdBuoNzbKDjckMUVykl6I9q3Sc2uBj5F83ykA8e/26oOHbji+NAabGfaGOZW4UuvH454BaNxlG1rQAWPZTJiHJwYVqRTcvjBeSDYm1yHCvmcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ddD8hp5t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707139330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KIOs5oLKwmUHXU8QbeznJvmgtQddL9JBz6AuSst5Dak=;
	b=ddD8hp5tqmN7OjMjl0hUzufNJlwTBdIZKQZZLg5PNzV/GU33JxuHoG8d1hoFCODEJ3ZqwN
	k1jhzKwmvr2JcEWo2xXYe+QJ6J5NkPa54UWAaeySL5pcpkKEz9f27wVqBFcPDa+Wp0qakJ
	7w7Iq4f1/muDRqP1Unf1dhasMQOOYHA=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-0M-5GVA6OB-SYzd-IHRNcA-1; Mon, 05 Feb 2024 08:22:09 -0500
X-MC-Unique: 0M-5GVA6OB-SYzd-IHRNcA-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-4677690896cso2151054137.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 05:22:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707139329; x=1707744129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIOs5oLKwmUHXU8QbeznJvmgtQddL9JBz6AuSst5Dak=;
        b=hxPpeMEEt+5fuLGmgfhl8mhkSseNpUuGGIeHOSGwVfrn7YwRa3sptYCo8hQrMrkqrH
         AclMwV3bThxL9qtTSrdpuxy3c6SElYhN0kRaQUM5dKxVfJ5CPtGV8pWdELBvw+0R8Q1R
         Zv0+9+rfB9zB424HZAl9l0kv2mRpMjq3t2ckbTYq0q8BuyPqtTFjwhwxNlrcHGZnYnT9
         v8McaY+dIQrZkJGi/vNZqPzRV1ybPXzsACuj5/CIIx8TjAWHXd3mMCP+QsvU9uWYr09z
         Laj7Qo65ei46EZQVJN5e4IHNv3YvMxh0WpPbIDyeO6GEiATJEAdwVHny4RvUUcj/b4kl
         cRKg==
X-Gm-Message-State: AOJu0YxpCTTqqB8vQDhFahBP1D2YjWasaa2vxks35q8rsHbEGtbWt74n
	3Jo1QbdsuvmktVJlQQ5mt55yclyUtk+CfkVOJzampj/OiL/JuRe4rZD+l5tZsFTsTZj0/UzWwd0
	6R6pROgcrljiDOHu0hk1gTsdaA9kyEu5tBkOB8pcrXWqLIkYPD/MXSL7fU28Gy+XeFMGqAxlc8p
	KPTrk3xxacnW0rR98aGQn4GbLfxCb2T5mFkvg0
X-Received: by 2002:a05:6102:227a:b0:46d:25b2:45ca with SMTP id v26-20020a056102227a00b0046d25b245camr2430373vsd.3.1707139328779;
        Mon, 05 Feb 2024 05:22:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTqYUjiIYeYl3PqTmLdMiBhcx1hHiK2OI7YlynV/pIuRwn3MzuIAwA1MFAoxSSU6bLHrFbZTOiRaU2u8nol5U=
X-Received: by 2002:a05:6102:227a:b0:46d:25b2:45ca with SMTP id
 v26-20020a056102227a00b0046d25b245camr2430352vsd.3.1707139328286; Mon, 05 Feb
 2024 05:22:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120232332.4100288-1-masahiroy@kernel.org>
 <CX42TU4QHS1Z.A0UUHMDAMZOL@wheely> <ZbjHTMhQ4Z9lRR6L@t14s> <87v873870m.fsf@mail.lhotse>
In-Reply-To: <87v873870m.fsf@mail.lhotse>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 5 Feb 2024 14:21:52 +0100
Message-ID: <CAASaF6w9SRoj+Kn6=UaReBNNfL_rrKo-4rvtCj=iF4Nd3Zpw-g@mail.gmail.com>
Subject: Re: [PATCH] powerpc: add crtsavres.o to always-y instead of extra-y
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 12:50=E2=80=AFPM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:
>
> Jan Stancek <jstancek@redhat.com> writes:
> > On Tue, Nov 21, 2023 at 10:51:34AM +1000, Nicholas Piggin wrote:
> >>On Tue Nov 21, 2023 at 9:23 AM AEST, Masahiro Yamada wrote:
> >>> crtsavres.o is linked to modules. However, as explained in commit
> >>> d0e628cd817f ("kbuild: doc: clarify the difference between extra-y
> >>> and always-y"), 'make modules' does not build extra-y.
> >>>
> >>> For example, the following command fails:
> >>>
> >>>   $ make ARCH=3Dpowerpc LLVM=3D1 KBUILD_MODPOST_WARN=3D1 mrproper ps3=
_defconfig modules
> >>>     [snip]
> >>>     LD [M]  arch/powerpc/platforms/cell/spufs/spufs.ko
> >>>   ld.lld: error: cannot open arch/powerpc/lib/crtsavres.o: No such fi=
le or directory
> >>>   make[3]: *** [scripts/Makefile.modfinal:56: arch/powerpc/platforms/=
cell/spufs/spufs.ko] Error 1
> >>>   make[2]: *** [Makefile:1844: modules] Error 2
> >>>   make[1]: *** [/home/masahiro/workspace/linux-kbuild/Makefile:350: _=
_build_one_by_one] Error 2
> >>>   make: *** [Makefile:234: __sub-make] Error 2
> >>>
> >>
> >>Thanks. Is this the correct Fixes tag?
> >>
> >>Fixes: d0e628cd817f ("powerpc/64: Do not link crtsavres.o in vmlinux")
> >>
> >>Hmm, looks like LLD might just do this now automatically for us
> >>too without --save-restore-funcs (https://reviews.llvm.org/D79977).
> >>But we probably still need it for older versions, so we still need
> >>your patch.
> >
> > Hi,
> >
> > I'm still seeing the error of crtsavres.o missing when building externa=
l modules
> > after "make LLVM=3D1 modules_prepare". Should it be built also in archp=
repare?
>
> Or modules_prepare?
>
> Example patch below.

I tested your patch with my setup and that works for me as well.

>
> cheers
>
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 051247027da0..82cdef40a9cd 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -59,6 +59,11 @@ ifeq ($(CONFIG_PPC64)$(CONFIG_LD_IS_BFD),yy)
>  KBUILD_LDFLAGS_MODULE +=3D --save-restore-funcs
>  else
>  KBUILD_LDFLAGS_MODULE +=3D arch/powerpc/lib/crtsavres.o
> +
> +crtsavres_prepare: scripts
> +       $(MAKE) $(build)=3Darch/powerpc/lib arch/powerpc/lib/crtsavres.o
> +
> +modules_prepare: crtsavres_prepare
>  endif
>
>  ifdef CONFIG_CPU_LITTLE_ENDIAN
>



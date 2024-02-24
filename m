Return-Path: <linux-kernel+bounces-79458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A62862284
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 04:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EED1286877
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 03:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7334B134C7;
	Sat, 24 Feb 2024 03:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7iEKudf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6681AD54
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 03:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708745896; cv=none; b=S0nVLRvDvScysCm6JZSYRs+T8cOoMmZhxrSWhrnrxpRSWoKT4YcIRXFEQeXMVDoWgkhcWUvwuC52Qo6JqBq9WcSUQg06znJWeN9/MwkSRId4whDXBqUsQvlzw2zZQSej2f+k6TX1McL0aavFVSmPdFCjeWtM/2PqARo/3wX7Xrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708745896; c=relaxed/simple;
	bh=0UyBVbjjB7xZ7/uiZ6nqYEtd67m13HSbB9f2AsarlwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e3f4IDpyInhKmZLj0LUXsxDrKgO6kdBpDtb8z5DRp58f3B3BUOVE9m+z8b7uZCCD0WjeA9k0nCH+yxt0vK3Okzf3haQWXwSMj9j6E7Gp/Uomuib0Qc3HUcUvL2Kmgv8HpX+ubfguj2Yh0kHdnb67E6KKZJ9Zl7h8otH8zttjkDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7iEKudf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2661DC43399
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 03:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708745896;
	bh=0UyBVbjjB7xZ7/uiZ6nqYEtd67m13HSbB9f2AsarlwI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f7iEKudfDaChDcQf9i96NUqzTUg9WsuvD+PUSCL2i3TAttePQa1+D563WT2unIKAd
	 FHgAqlD4l/hZAJfgdTlA8Kso8r5k+7cBrAAWORTrHxDHPwMvxJOvI6XNRp+PpydJvJ
	 UcJ6ig2DYgqgBFutktoU+mg2usQd2mY5DVkNqsWqs0CUNuRC04WFONe3buyqfXjyGg
	 E866aMbDGm4Prst2pivIoH2HsU8ZQ4sgdr8HW6AMha2tIHEiHtsX/kRnh5jGFobsUw
	 oi8K6roPY1P5BfKjDW2on+B/Ucp+bl99eVYrHtZJrR0DVP9saC1gczpEe5Rhh/6Y//
	 2QDfrupX6hk2A==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512f3e75391so14616e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 19:38:16 -0800 (PST)
X-Gm-Message-State: AOJu0Yy+sJCepNRD7UkeLBDYqAEO919T7F4fXsRGsGhZwEIlMSYsJCg2
	rGqr5zvqhA8V9U+TQdSJFfKVny0gzott5ISxTba4lcyPsOGDxLnBhqTAQa46l2o9aTn3ch0KCbn
	rNbJFQT3yiTQTPaWl+WB1/l+NpcM=
X-Google-Smtp-Source: AGHT+IF1YHlALszowlOjSXLQhJwz872+dn+dGasb9uen+19ee3lm9MCkJGP4q8NuMluRVvXYtxvnsbABpPv2bg82/A4=
X-Received: by 2002:a05:6512:1053:b0:512:bf09:624a with SMTP id
 c19-20020a056512105300b00512bf09624amr953640lfb.66.1708745894613; Fri, 23 Feb
 2024 19:38:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117125807.1058477-1-masahiroy@kernel.org> <CAK7LNAStoCja1gnoFmsKikbzGZmKTcTu+Vc7v9zg8B9hwsH+iQ@mail.gmail.com>
In-Reply-To: <CAK7LNAStoCja1gnoFmsKikbzGZmKTcTu+Vc7v9zg8B9hwsH+iQ@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 24 Feb 2024 12:37:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNATVAcj-pa_G-NGBTr9doCACGk1nKCNbxM50-M0mi9q=7w@mail.gmail.com>
Message-ID: <CAK7LNATVAcj-pa_G-NGBTr9doCACGk1nKCNbxM50-M0mi9q=7w@mail.gmail.com>
Subject: Re: [PATCH] riscv: compat_vdso: install compat_vdso.so.dbg to /lib/modules/*/vdso/
To: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping x 2 ?





On Sun, Jan 21, 2024 at 6:48=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Fri, Nov 17, 2023 at 9:58=E2=80=AFPM Masahiro Yamada <masahiroy@kernel=
org> wrote:
> >
> > 'make vdso_install' installs debug vdso files to /lib/modules/*/vdso/.
> >
> > Only for the compat vdso on riscv, the installation destination differs=
;
> > compat_vdso.so.dbg is installed to /lib/module/*/compat_vdso/.
> >
> > To follow the standard install destination and simplify the vdso_instal=
l
> > logic, change the install destination to standard /lib/modules/*/vdso/.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
>
>
> Ping?
> (in case "yet more RISC-V updates" happens)
>
>
>
>
> >
> >  arch/riscv/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > index a74be78678eb..5cbe596345c1 100644
> > --- a/arch/riscv/Makefile
> > +++ b/arch/riscv/Makefile
> > @@ -146,7 +146,7 @@ endif
> >  endif
> >
> >  vdso-install-y                 +=3D arch/riscv/kernel/vdso/vdso.so.dbg
> > -vdso-install-$(CONFIG_COMPAT)  +=3D arch/riscv/kernel/compat_vdso/comp=
at_vdso.so.dbg:../compat_vdso/compat_vdso.so
> > +vdso-install-$(CONFIG_COMPAT)  +=3D arch/riscv/kernel/compat_vdso/comp=
at_vdso.so.dbg
> >
> >  ifneq ($(CONFIG_XIP_KERNEL),y)
> >  ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_ARCH_CANAAN),yy)
> > --
> > 2.40.1
> >
>
>
> --
> Best Regards
> Masahiro Yamada



--
Best Regards
Masahiro Yamada


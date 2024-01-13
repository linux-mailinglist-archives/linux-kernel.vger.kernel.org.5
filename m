Return-Path: <linux-kernel+bounces-25268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62EA82CC3C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 11:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89934284D3C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 10:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA4520DEF;
	Sat, 13 Jan 2024 10:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3gxB+Ai"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E6220B2E;
	Sat, 13 Jan 2024 10:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08FAC433F1;
	Sat, 13 Jan 2024 10:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705143055;
	bh=P0vT5yJqXjKBVosYYPfXKfXcBExTHb01xJ00Hlt0GL0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T3gxB+AiBsxoJBBqF3GC3J6VrIfyHdAaBcQlXZASEmfJzwxhuXQpcpF8dWQoWW06W
	 ul78aXAmXcuLcobXwDvFu+rXC74b6sOQHhAk9B1nUfDnMyzn5sdmVqmXyaAIEi+WW0
	 d169wZ0mCSIHH459SjCAjKdseC9vuxCbTFkXZf3RbMiMiUKcw3j52R8Ytz11ao9hBz
	 tls4lYr25lGD/Fq+O+UJWccP2IIXs56S7fseG+JGe6uYk6qb76+ZRpiL4kaiwjAuTZ
	 6Yi6iXVibLkbMw1NDToXjKVLPFrhrwfFTlWPmI7qFYZSuOtdSqZVSCiwMrGwx91ILn
	 dAiASsAQT05Kg==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-203fb334415so4821884fac.2;
        Sat, 13 Jan 2024 02:50:55 -0800 (PST)
X-Gm-Message-State: AOJu0YwkPiedjEDo0vBB81GBaTRbZ022E2geF1IHq96+eere5RBaTwyx
	ocsAAmVbZGDEyQ8dotKcD5iU54Wz9m8956F5J9I=
X-Google-Smtp-Source: AGHT+IHdijpaZRtIjvlakGXAeOpi5qtUfyMHJiwKMpajRzbtFgzrFpjdSh7po0vkHN5D+jbrt5/oh/WaBUdksBDetUw=
X-Received: by 2002:a05:6870:37cf:b0:206:91a9:f1c5 with SMTP id
 p15-20020a05687037cf00b0020691a9f1c5mr3690978oai.18.1705143055012; Sat, 13
 Jan 2024 02:50:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228070941.3611649-1-tfiga@chromium.org> <CAK7LNASbgXSZNiwhMf8jm7511eyDm8oCqY=MzWhgWwNuVLk5Vw@mail.gmail.com>
 <CAAFQd5CRtgMUN8xZ_4BOv04KzCvXtrKHhWGQhhqgENyMCVWbKw@mail.gmail.com>
In-Reply-To: <CAAFQd5CRtgMUN8xZ_4BOv04KzCvXtrKHhWGQhhqgENyMCVWbKw@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 13 Jan 2024 19:50:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS29-KZvuHE=WE7ravvqh4e-M5Da=MZ2vh_EM7_Jo_jbw@mail.gmail.com>
Message-ID: <CAK7LNAS29-KZvuHE=WE7ravvqh4e-M5Da=MZ2vh_EM7_Jo_jbw@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Add a build target for checking current config
 for issues
To: Tomasz Figa <tfiga@chromium.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 10:15=E2=80=AFPM Tomasz Figa <tfiga@chromium.org> w=
rote:
>
> On Fri, Dec 29, 2023 at 1:11=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
org> wrote:
> >
> > On Thu, Dec 28, 2023 at 4:09=E2=80=AFPM Tomasz Figa <tfiga@chromium.org=
> wrote:
> > >
> > > The new target is called 'checkconfig' and currently is basically an
> > > alias for `listnewconfig` with KCONFIG_WARN_UNKNOWN_SYMBOLS set to tr=
ue.
> > > It can be used to validate if the current config is directly compatib=
le
> > > with the current kernel version or needs some manual adjustment.
> > >
> > > Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> >
> >
> > I rejected a new target in the past.
> >
> > https://lore.kernel.org/all/20230817012007.131868-1-senozhatsky@chromiu=
m.org/T/#m55c37e3091158f8cb008d9e0b5c6bf3f5ead225a
> >
>
> That was specifically for the unrecognized symbols warning. What I'm
> proposing is a universal target that would include any possible
> diagnostics.
>
> >
> >
> > Instead, you can run
> >
> >   KCONFIG_WARN_UNKNOWN_SYMBOLS=3D1 make listnewconfig
> >
> > or
> >
> >   make W=3Dc listnewconfig
> >
> >
>
> I can do so, because my team member implemented it and told me and
> other team members about it. But how would someone who hasn't heard
> about it be aware of the existence of this useful feature?


People are not aware of your 'checkconfig' until
they run 'make help'.

The same for W=3Dc.

'make help' explains it.


       c: extra checks in the configuration stage (Kconfig)


--=20
Best Regards
Masahiro Yamada


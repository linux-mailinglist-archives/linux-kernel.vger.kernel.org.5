Return-Path: <linux-kernel+bounces-3824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B81B817362
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F4B28970B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445901D157;
	Mon, 18 Dec 2023 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrYkAkoU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886D7129EF9;
	Mon, 18 Dec 2023 14:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34ABDC433C9;
	Mon, 18 Dec 2023 14:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702909045;
	bh=xFTUf/b5KG1UjaGYwApJDRRbExU38ClFqfnkgLIArbY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lrYkAkoUyEMqTMpXfpDLPgyQ4SlgJDxqngQRnqefEqNcN82dbNT8F/nk1ryeszDRT
	 rlleUJLI/BiXg8KDMQo2S/wQ6cKSDIUGreSmHsklQfDfqJ/V0Ib3pPgRtP4Go+f/K3
	 GgiIYAxfMylrT8hFlfuHCcPIcIbBWaSu7Dia7miGjxn3guYSL1Of5d5Wb8yVwTv5wS
	 +qc97mti+071/BowoRuTy9APAlDLhl/cXOkjo1tnySsY5ozR65W1l+9iEdDgc70pei
	 W1vCPWCd8L623IPx82onJNBQlPo0UOAjCcT2qKEKmWVR1aCBl4CrzLCm14t6SRQn0Z
	 fKKHL2p23NVBg==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1f066fc2a2aso891718fac.0;
        Mon, 18 Dec 2023 06:17:25 -0800 (PST)
X-Gm-Message-State: AOJu0YzgEQgi+NThNSdSwjnerz5ZDOipo39r18CgfO6e5BLT1oDs6lcI
	EKos2e1usE4EoOGv+7YfvBN06ngd7m1ol4ezi6Y=
X-Google-Smtp-Source: AGHT+IHp5AGoyCkJMIqarb4li7VZGZt7YTWGcrArPcGCt+OLgbkKJPTmCBrR0dacPOITl2JJuou8JJa2UHoQBl8eJ6o=
X-Received: by 2002:a05:6871:a90e:b0:1fb:75b:2b80 with SMTP id
 wn14-20020a056871a90e00b001fb075b2b80mr9048238oab.60.1702909044529; Mon, 18
 Dec 2023 06:17:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7LNAT3N82cJD3GsF+yUBEfPNOBkhzYPk37q3k0HdU7ukz9vQ@mail.gmail.com>
 <baa3224bece94220dfe7173432143a91f7612c09.1701892062.git.msuchanek@suse.de>
 <CAK7LNARdnt0QXn6TRbuS_wzzMVXTY6NrCnu9WOM6PFztnyRmuQ@mail.gmail.com>
 <20231210210859.GN9696@kitsune.suse.cz> <CAK7LNAQo1p3dmdoqQRM_JxBp78Rxj5YpVqXGzMr5Xs9K-V3BiA@mail.gmail.com>
 <20231212131219.GQ9696@kitsune.suse.cz>
In-Reply-To: <20231212131219.GQ9696@kitsune.suse.cz>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 18 Dec 2023 23:16:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNASb4Gt-pQncBv3KLG=P1UtehgHNCgY8XeaQ_vfdUuSQRg@mail.gmail.com>
Message-ID: <CAK7LNASb4Gt-pQncBv3KLG=P1UtehgHNCgY8XeaQ_vfdUuSQRg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] kbuild: rpm-pkg: Fix build with non-default MODLIB
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, 
	Lucas De Marchi <lucas.de.marchi@gmail.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 10:12=E2=80=AFPM Michal Such=C3=A1nek <msuchanek@su=
se.de> wrote:
>
> On Mon, Dec 11, 2023 at 01:33:23PM +0900, Masahiro Yamada wrote:
> > On Mon, Dec 11, 2023 at 6:09=E2=80=AFAM Michal Such=C3=A1nek <msuchanek=
@suse.de> wrote:
> > >
> > > On Mon, Dec 11, 2023 at 03:44:35AM +0900, Masahiro Yamada wrote:
> > > > On Thu, Dec 7, 2023 at 4:48=E2=80=AFAM Michal Suchanek <msuchanek@s=
use.de> wrote:
> > > > >
> > > > > The default MODLIB value is composed of three variables
> > > > >
> > > > > MODLIB =3D $(INSTALL_MOD_PATH)$(KERNEL_MODULE_DIRECTORY)/$(KERNEL=
RELEASE)
> > > > >
> > > > > However, the kernel.spec hadcodes the default value of
> > > > > $(KERNEL_MODULE_DIRECTORY), and changed value is not reflected wh=
en
> > > > > building the package.
> > > > >
> > > > > Pass KERNEL_MODULE_DIRECTORY to kernel.spec to fix this problem.
> > > > >
> > > > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > > > ---
> > > > > Build on top of the previous patch adding KERNEL_MODULE_DIRECTORY
> > > >
> > > >
> > > > The SRPM package created by 'make srcrpm-pkg' may not work
> > > > if rpmbuild is executed in a different machine.
> > >
> > > That's why there is an option to override KERNEL_MODULE_DIRECTORY?
> >
> >
> > Yes.
> > But, as I pointed out in 1/2, depmod must follow the packager's decisio=
n.
> >
> > 'make srcrpm-pkg' creates a SRPM on machine A.
> > 'rpmbuild' builds it into binary RPMs on machine B.
> >
> > If A and B disagree about kmod.pc, depmod will fail
> > because there is no code to force the decision made
> > on machine A.
>
> There is. It's the ?=3D in the top Makefile.


Nope.


Only Kbuild follows the specified KERNEL_MODULE_DIRECTORY.


depmod still uses the MODULE_DRECTORY determined
when it was compiled.


>
> Currently the test that determines the module directory uses make logic
> so it's not possible to pass on the shell magic before executing it so
> it could be executed inside the rpm spec file as well.
>
> OUtsourcing it into an external script would mean that the sources need
> to be unpacked before the script can be executed. That would require
> using dynamically generated file list in the spec file because the
> module location would not be known at spec parse time. Possible but
> convoluted.


I do not require that.


This is simple; builders must follow the packager's decision.

To make it work, depmod must follow MODULE_DIRECTORY
given from an external environment.





> In the end I do not think this is a problem that needs solving. Most
> distributions that build kernel packages would use their own packaging
> files, not rpm-pkg. That limits rpm-pkg to ad-hoc use when people want
> to build one-off test kernel. It's reasonable to do on the same
> distribution as the target system. The option to do so on a distribution
> with different module directory is available if somebody really needs
> that.
>
> Thanks
>
> Michal



--=20
Best Regards
Masahiro Yamada


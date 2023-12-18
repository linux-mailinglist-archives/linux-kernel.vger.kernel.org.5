Return-Path: <linux-kernel+bounces-3808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4381A817266
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF28C284A4F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA02C498B7;
	Mon, 18 Dec 2023 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnDmNFj2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C312498A1;
	Mon, 18 Dec 2023 14:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2874C433CD;
	Mon, 18 Dec 2023 14:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702908373;
	bh=Z96PU5W2ggJEyQ3xd3FBWcAN+FmQAsXzZYJ/t2N1glI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gnDmNFj2cEVVi/t2swX4NmCVibFEic32MKl+v3vqDnPza2McdbbYvmTNjKPlq/tE8
	 BRWhX0XU47n+oikJ4Z9JBfurdpkZUbVrq2xMo3GgZzAJEdV2MJ6I0IrYsfCbEZnBrt
	 y7gTYSZc+4mW3IMN/TGvNfhlI1pW6sJ1KzPQ5K/H8BabE57HKIM6SWkiCpgXAS9+ok
	 9Kzbq5PCE7LJJbt40U+TtHfxD/bDGUK/IpMM4j1ZfZ4KQ5EtguYwkvMJzYB8nGf0OI
	 8VK2uA6VyLaqRGsHk9LzyVqmhTpUCWA0yeiDFF+tlFqLzEWt8JDA3YgoRI90BqZVbo
	 XvA1hlBbMeN7Q==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1ef36a04931so2154500fac.2;
        Mon, 18 Dec 2023 06:06:13 -0800 (PST)
X-Gm-Message-State: AOJu0YybYixrtnI72j1CXhCvvC19iR7kLz8WKmEYHQUfKa27MFW/lCf7
	zs2TYfni8UVE7MoCz/IFl/7wVs8XLUmRvZIrgBw=
X-Google-Smtp-Source: AGHT+IFMPHHb099Ixeiferh3tHKcPmuSiilVOZQIKs6jzVfIl6knPb8Y3JK7zb9GPxBgjjSEBzLR4AG4KSl/u9yLYR4=
X-Received: by 2002:a05:6870:4597:b0:1fb:75a:c42e with SMTP id
 y23-20020a056870459700b001fb075ac42emr15603576oao.87.1702908373023; Mon, 18
 Dec 2023 06:06:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7LNAT3N82cJD3GsF+yUBEfPNOBkhzYPk37q3k0HdU7ukz9vQ@mail.gmail.com>
 <32b332af189bfca8acdb231cee294355aa4af290.1701892062.git.msuchanek@suse.de>
 <CAK7LNATPF7baHLXZVgzz=6zOhLx8maX0r0EU3DBFwAEZ6kCeww@mail.gmail.com>
 <20231210210748.GM9696@kitsune.suse.cz> <CAK7LNAQQe-fdeKe2RHd5TyYpXa95WJO_-f38o12oewGC3rFTHA@mail.gmail.com>
 <20231212130324.GP9696@kitsune.suse.cz>
In-Reply-To: <20231212130324.GP9696@kitsune.suse.cz>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 18 Dec 2023 23:05:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS8t5avO8u_3dF9Mb_W-R2AOt2ofHo-7om9eUnraogrkg@mail.gmail.com>
Message-ID: <CAK7LNAS8t5avO8u_3dF9Mb_W-R2AOt2ofHo-7om9eUnraogrkg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] depmod: Handle installing modules under a
 different directory
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, 
	Lucas De Marchi <lucas.de.marchi@gmail.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 10:03=E2=80=AFPM Michal Such=C3=A1nek <msuchanek@su=
se.de> wrote:
>
> On Mon, Dec 11, 2023 at 01:29:15PM +0900, Masahiro Yamada wrote:
> > On Mon, Dec 11, 2023 at 6:07=E2=80=AFAM Michal Such=C3=A1nek <msuchanek=
@suse.de> wrote:
> > >
> > > Hello!
> > >
> > > On Mon, Dec 11, 2023 at 03:43:44AM +0900, Masahiro Yamada wrote:
> > > > On Thu, Dec 7, 2023 at 4:48=E2=80=AFAM Michal Suchanek <msuchanek@s=
use.de> wrote:
> > > > >
> > > > > Some distributions aim at shipping all files in /usr.
> > > > >
> > > > > The path under which kernel modules are installed is hardcoded to=
 /lib
> > > > > which conflicts with this goal.
> > > > >
> > > > > When kmod provides kmod.pc, use it to determine the correct modul=
e
> > > > > installation path.
> > > > >
> > > > > With kmod that does not provide the config /lib/modules is used a=
s
> > > > > before.
> > > > >
> > > > > While pkg-config does not return an error when a variable does no=
t exist
> > > > > the kmod configure script puts some effort into ensuring that
> > > > > module_directory is non-empty. With that empty module_directory f=
rom
> > > > > pkg-config can be used to detect absence of the variable.
> > > > >
> > > > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > > > ---
> > > > > v6:
> > > > >  - use ?=3D instead of :=3D to make it easier to override the val=
ue
> > > >
> > > >
> > > > "KERNEL_MODULE_DIRECTORY=3D/local/usr/lib/modules make modules_inst=
all"
> > > > will override the install destination, but
> > > > depmod will not be not aware of it.
> > >
> > > At the same time if you know what you are doing you can build a src r=
pm
> > > for another system that uses a different location.
> > >
> > > > How to avoid the depmod error?
> > >
> > > Not override the variable?
> >
> > You are not answering my question.
> > You intentionally changed :=3D to ?=3D.
> >
> > This implies that KERNEL_MODULE_DIRECTORY is an interface to users,
> > and should be documented in Documentation/kbuild/kbuild.rst
>
> That's reasonable
>
> > However, it never works if it is overridden from the env variable
> > or make command line because there is no way to let depmod know
> > the fact that KERNEL_MODULE_DIRECTORY has been overridden.
>
> And there should not. kmod is not aware, kbuild is. That's the
> direction of information flow. kmod defines where it looks for the
> modules, and kbuild shoukld install the modules there.


Then, you cannot explain why KERNEL_MODULE_DIRECTORY should be exposed
as a user interface.



The MODULE_DIRECTORY in depmod is determined when kmod is compiled.

Kbuild takes KERNEL_MODULE_DIRECTORY from pkg-config.


If these two do not agree, it never works.





> If the user knows better (eg. possibility of building src-rpm for a
> different you brought up) they can override the autodetection.


No, it does not work.


The user has no way to override the MODULE_DIRECTORY in depmod.





> > In my understanding, depmod does not provide an option to
> > specify the module directory from a command line option, does it?
>
> No it does not.
>
> > If not, is it reasonable to add a new option to depmod?
>
> I don't think so. The module directory is intentionally in a fixed
> location. It can be set at compile time, and that's it.
>
> Then when running depmod on the target distribution either kbuild and
> kmod agree on the location or the build fails. That's the intended
> outcome.
>
> kmod recently grew the ability to use modules outside of module
> directory. For that to work internally the path to these out-of-kernel
> modules is stored as absolute path, and the path of modules that are in
> the module directory is stored relative to the module directory.
>
> Setting the module directory location dynamically still should not break
> this but I am not sure it's a great idea. In the end modprobe needs to
> find those modules, and if depmod puts the modules.dep in arbitrary
> location it will not.


That is true when modules are compiled and installed on the local machine.


If you create an SRPM with KERNEL_MODULE_DIRECTORY,
builders must follow it.





>
> > depmod provides the "-b basedir" option, but it only allows
> > adding a prefix to the default "/lib/modules/<version>".
>
> Yes, that's for installation into a staging directory, and there again
> the modules that are inside the module directory are considedred
> 'in-kernel'. Not sure how well this even works with 'out-of-kernel'
> modules.
>
> > (My original idea to provide the prefix_part, it would have worked
> > like  -b "${INSTALL_MOD_PATH}${MOD_PREFIX}", which you refused)
>
> It's not clear that adding a prefix covers all use cases. It is an
> arbitrary limitation that the module path must end with '/lib/modules'.
>
> It may allow taking some shortcuts in some places but is unnecessarily
> limiting.
>
> Thanks
>
> Michal



--=20
Best Regards
Masahiro Yamada


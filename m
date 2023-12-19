Return-Path: <linux-kernel+bounces-4900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8565818393
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 774E42861DC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1679B11CB6;
	Tue, 19 Dec 2023 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HP7l7z+Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB3813ADA;
	Tue, 19 Dec 2023 08:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF48C433CD;
	Tue, 19 Dec 2023 08:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702975088;
	bh=iCFasj7oQ8kELGDaFQzx7jdz0lyUtU1jgfLGIGZWdBc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HP7l7z+Q5SAoL9UkP6fV1d/Nd9MdPl9y/WMAT9sJLJjhqxoU2/tNDK1oVt4tcZ46j
	 4MPU6V2TYHfyBBY7u/WNWPMN/lQs6MH04sq9h5IPNY03qYTGECf7bg8Czv/LlXm+Cf
	 A4NR6luTTkuEw3nM5kz2C+aWvHCJu33cdr0phrLudGhhjvOrnVODfc+Cc4zPG0fiiJ
	 UZIkevRCbl2TSUMR4RBcF/otjNXjcoKg2RDJwv845uFbhQt/q6u4JYRhmnX5yLpt/G
	 JWS8FS0GWjdebBdt6NmiXweHQfadNeWroH6effeQSOVyNUvFSiDjjIQVQqdnehCRu+
	 vMrT6zpYlnZWw==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3ba41c956d5so1651419b6e.0;
        Tue, 19 Dec 2023 00:38:08 -0800 (PST)
X-Gm-Message-State: AOJu0YxCQg4K2uqkX9ICqPgAw0erCDkakzrpoEAd20o6Y5Tf+XIW3NiO
	bWCZqjpyARUZW6y7lLlDOZY26nzQaUh15NQ4wws=
X-Google-Smtp-Source: AGHT+IETLjoWnYRFsV+CWFf32DZKP/bSmighlfMjPM6uJIaV1VYKgHAj3H+uwNCRzkJSv5AJR1QKyOFk9Gb0t6ptcDg=
X-Received: by 2002:a05:6808:1a1d:b0:3b8:61ac:2348 with SMTP id
 bk29-20020a0568081a1d00b003b861ac2348mr332846oib.24.1702975088233; Tue, 19
 Dec 2023 00:38:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e3yow7ih6af2hxzkmjay2oan3jypmo4hda64vxvpfco66ajcew@i3zewn4nbklf>
 <cover.1699618135.git.msuchanek@suse.de> <xbgto5tttcah4mrtyjih72ubod3qb375ww6e2fd4pi342rg4eg@wipwd57q43cc>
In-Reply-To: <xbgto5tttcah4mrtyjih72ubod3qb375ww6e2fd4pi342rg4eg@wipwd57q43cc>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 19 Dec 2023 17:37:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNARYK-xjBS8puEM9xFtmjBNW6KJ2Qd6f7diZkdEEbUgVHA@mail.gmail.com>
Message-ID: <CAK7LNARYK-xjBS8puEM9xFtmjBNW6KJ2Qd6f7diZkdEEbUgVHA@mail.gmail.com>
Subject: Re: [PATCH 0/2] kmod /usr support
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Michal Suchanek <msuchanek@suse.de>, linux-modules@vger.kernel.org, 
	Takashi Iwai <tiwai@suse.com>, Lucas De Marchi <lucas.de.marchi@gmail.com>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 3:37=E2=80=AFAM Lucas De Marchi <lucas.demarchi@inte=
l.com> wrote:
>
> On Fri, Nov 10, 2023 at 01:13:53PM +0100, Michal Suchanek wrote:
> >Hello,
> >
> >This is resend of the last patch in the series that adds prefix support
> >to kernel module location together with additional patch for validating
> >the user supplied input to options that are interpreted as directories.
> >
> >Thanks
>
> applied, thanks
>
> Lucas De Marchi



If I understood this correctly, MODULE_DIRECTORY is determined
by "configure --with-module-directory=3D...", and there is no
way to change it after that.


If so, how to work with cross-building?

Cross-building is typical when building embedded Linux systems.


Consider this scenario:

- Your build machine adopts
    MODULE_DIRECTORY=3D/usr/lib/modules
- The target embedded system adopts
    MODULE_DIRECTORY=3D/lib/modules

(or vice a versa)




depmod is used also for cross-building because
it is executed as a part of "make module_install".


The counterpart patch set for Kbuild provides
KERNEL_MODULE_DIRECTORY, which only changes
the destination directory to which *.ko are copied.

You cannot change the directory where the
depmod searches for modules, as it is fixed
at the compile-time of kmod.




In this case, what we can do is to build another
instance of kmod configured for the target system,
and use it for modules_install:

1. In the kmod source directory
    ./configure --with=3Dmodule-directory=3D/lib/modules
    make

2. make modules_install INSTALL_MOD_PATH=3D<staging-dir>
     KERNEL_MODULE_DIRECTORY=3D/lib/modules
     DEPMOD=3D<new-depmod-you-has-just-built>



If you use OpenEmbedded etc., this is what you do
because host tools are built from sources.

But, should it be required all the time?
Even when the target embedded system uses
busybox-based modprobe instead of kmod?



depmod provides --basedir option, which changes
the prefix part, but there is no way to override
the stem part, MODULE_DIRECTRY.

In the review of the counter patch set,
I am suggesting an option to override MODULE_DIRECTRY
(let's say --moduledir) at least for depmod.

(Perhaps modinfo too, as it also supports --basedir)



Then, we can change scripts/depmod.sh so that
Kbuild can propagate KERNEL_MODULE_DIRECTORY
to depmod.


if  <depmod supports --moduledir>; then
    set -- "$@"  --moduledir "${KERNEL_MODULE_DIRECTORY}"
fi



Does it make sense?




--=20
Best Regards
Masahiro Yamada


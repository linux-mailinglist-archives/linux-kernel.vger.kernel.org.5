Return-Path: <linux-kernel+bounces-25198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A5A82C98E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 06:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42FA1285FDE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 05:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DDEF9EB;
	Sat, 13 Jan 2024 05:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1gsDvkj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0B0F510;
	Sat, 13 Jan 2024 05:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF29BC43390;
	Sat, 13 Jan 2024 05:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705124443;
	bh=O3ohrsXSkj1hsucv+3a30SU0eUUg7ceQUZsUsRmu5Wk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W1gsDvkjaWTsDoyZ/ZMiBsHhN2cDtribY2vxcLlSWkK3rSzdRQobfsAi660rYWqDM
	 Vr4ghxnHkRipb8TsDVrMgCWLq0IWXem0RfNzL2+WfP1UfhVy0fVy55//pYKmZxSTU1
	 2KRcYa91buX4YSNoNDNfKO2KvD5cpL5QDJ27IJlEHGJTl76fL8XoyM4/8xEOivRoB8
	 cqDC+fExvJig692MpmCOCjamUv9UrpMOFNwKZapwTb383XuOo17jHQ8Ow2dfS7kucK
	 WgCUtXNl2T/EFN9XOQ9yN0uSfxn9GowGCP4TEieO8NmX/louM/r6B/Iqyk29Upd6S1
	 Os3k/4EA5JqmA==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6dde5d308c6so2484759a34.0;
        Fri, 12 Jan 2024 21:40:43 -0800 (PST)
X-Gm-Message-State: AOJu0YwfROd//1FF4V1VbCT0b1/aD4xcfcElHxfzuUKQuIQrXXWas94T
	j1KZOoVsQcBm2LBuQ7OJLb+LrvLeI39Fgp3/NQM=
X-Google-Smtp-Source: AGHT+IHPsRlEXgHx2ZFurUp2lo7jQQOWgwageyfZGDFdYcwB35V4gpQDFM1VBA95/PyjPKIls8FwnJTBiFufQOzrCyo=
X-Received: by 2002:a05:6871:e419:b0:205:f2ad:2948 with SMTP id
 py25-20020a056871e41900b00205f2ad2948mr2733807oac.114.1705124443157; Fri, 12
 Jan 2024 21:40:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c2adb439-0dea-4de1-996e-5a0caa5c729d@alu.unizg.hr>
 <ZaALOOhEdBP70lDH@bergen.fjasle.eu> <827b5e97-a436-47a7-a097-13657bcda948@alu.unizg.hr>
In-Reply-To: <827b5e97-a436-47a7-a097-13657bcda948@alu.unizg.hr>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 13 Jan 2024 14:40:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNAToNP0hFvhzr_gYw6TXMxkJuCN4idWZvqmq3mSTNOHtSQ@mail.gmail.com>
Message-ID: <CAK7LNAToNP0hFvhzr_gYw6TXMxkJuCN4idWZvqmq3mSTNOHtSQ@mail.gmail.com>
Subject: Re: [PROBLEM] Very long .deb package build times for bindeb-pkg build target
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: Nicolas Schier <nicolas@fjasle.eu>, Mirsad Todorovac <mirsad.todorovac@alu.hr>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 7:48=E2=80=AFAM Mirsad Todorovac
<mirsad.todorovac@alu.unizg.hr> wrote:
>
> On 11. 01. 2024. 16:37, Nicolas Schier wrote:
> > Hi Mirsad,
> >
> > On Thu 11 Jan 2024 13:22:39 GMT, Mirsad Todorovac wrote:
> >> Hi,
> >>
> >> With this new release, it seems that Debian kernel build uses "xz" in =
single-
> >> threaded mode:



New release of what?




> >>
> >> Tasks: 484 total,   2 running, 481 sleeping,   0 stopped,   1 zombie
> >> %Cpu(s):  2.5 us,  2.2 sy,  6.3 ni, 85.1 id,  2.3 wa,  0.0 hi,  1.7 si=
,  0.0 st
> >> MiB Mem :  64128.3 total,    524.3 free,   5832.0 used,  58540.9 buff/=
cache
> >> MiB Swap:  32760.0 total,  32758.7 free,      1.2 used.  58296.3 avail=
 Mem
> >>
> >>     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+
> >> COMMAND
> >>
> >>  978084 marvin    30  10  112440  97792   2432 R 100.0   0.1  29:30.23=
 xz
> >>
> >>
> >> Before dpkg-deb was using up to 3200% of CPU time on a 16 core SMT CPU=
.
> >>
> >> Can it be something with dpkg-deb --thread-max=3D%n option?
> >
> > I cannot find any --thread-max option in Linux tree.  Do you call
> > dpkg-deb manually or somehow induce a thread maximum?
> >
> >> Waiting for half an hour just for the build of linux-image-...-dbg pac=
kage
> >> seems like an overkill ...
> >
> > With current v6.7 release tree I do not see the reported slow-downs
> > when building bindeb-pkg; I tested by cross-compiling for arm64 on
> > amd64 with CONFIG_MODULE_COMPRESS_XZ=3Dy and =3Dn).
> >
> > Both take roughly 5mins on my 24-core i9 system.
> >
> > Kind regards,
> > Nicolas
>
> I am perplexed too, but you can see from the top output the
> single-threaded xz with 29:30m processor time.
>
> On my laptop with the sam Ubuntu 23.10 mantic minotaur, I have
> dpkg-deb version 1.20.12 and it shows things like 400% and 3200%
> CPU time, so it is working multithreaded.
>
> On desktop machine with the same Ubuntu 23.10 and the same git
> torvalds tree, it starts single-threaded xz from dpkg-deb instead.


You built the same mainline git tree on your laptop and desktop.
The former runs xz multi-threaded, the latter single-threaded.

So, this is not about the kernel code, but about your environment,
isn't it?



You mentioned you were using Ubuntu 23.10, where
dpkg-deb version is 1.22.0


Your dpkg-deb version, 1.20.12, is too old for Ubuntu 23.10.
Is it a self-built one?





dpkg-deb usually compresses binary packages, but the default
compression type depends on the distro.
(It is determined at "./configure" time)



On Ubuntu, the default compression type for dpkg-deb is "zstd"
(while it is "xz" on Debian)


Check "man dpkg-deb" on your Ubuntu machine.


  -Zcompress=E2=80=90type
      Specify which compression type to use when building a package.
      Allowed values are gzip, xz (since dpkg 1.15.6),
      zstd (since dpkg 1.21.18) and none (default is zstd).




You are still allowed to use xz with "make KDEB_COMPRESS=3Dxz deb-pkg".
Is this your case?




Overall, your report is not sensible.


You should check what you are seeing.




> I tried things like this:
>
> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> index d7dd0d04c70c..b2319c23db34 100755
> --- a/scripts/package/builddeb
> +++ b/scripts/package/builddeb
> @@ -38,7 +38,7 @@ create_package() {
>
>         # Fix ownership and permissions
>         if [ "$DEB_RULES_REQUIRES_ROOT" =3D "no" ]; then
> -               dpkg_deb_opts=3D"--root-owner-group"
> +               dpkg_deb_opts=3D"--threads-max=3D0 --root-owner-group"
>         else
>                 chown -R root:root "$pdir"
>         fi
>
> and it didn't work either - dpkg-deb --threads-max=3D0 still spawned a
> single-threaded xz that ran 30 minutes.
>
> Then the workaround was a very simple xz shell script that adds option --=
threads=3D0
> and calls system xz:
>
> ~/bin/xz:
> ----------------------------------------------------------------
> #!/bin/bash -f
>
> /usr/bin/xz --threads=3D0 "$@"
> ----------------------------------------------------------------
>
> This finally worked, but sometimes I get:
>
> marvin@defiant:~/linux/kernel$ xz -9 --memlimit-compress=3D8000MiB linux-=
image-6.7.0-rc8-dbg_6.7.0-rc8-6_amd64.deb
> /usr/bin/xz: Reduced the number of threads from 8 to 6 to not exceed the =
memory usage limit of 8000 MiB
>
> (This is of course just an example of compressing a large file, as .deb i=
s already compressed.)
>
> I used the default Ubuntu 23.10 config, with .pems excluded, and I think =
module compression
> did not work either. I had to turn it off ...
>
> Hope this helps.
>
> Regards,
> Mirsad
>
> --
> Mirsad Goran Todorovac
> Sistem in=C5=BEenjer
> Grafi=C4=8Dki fakultet | Akademija likovnih umjetnosti
> Sveu=C4=8Dili=C5=A1te u Zagrebu
>
> System engineer
> Faculty of Graphic Arts | Academy of Fine Arts
> University of Zagreb, Republic of Croatia
> The European Union
>
> "I see something approaching fast ... Will it be friends with me?"
>
>


--=20
Best Regards
Masahiro Yamada


Return-Path: <linux-kernel+bounces-25318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C4482CD6E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 16:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E2B283DA5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 15:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79C24A2D;
	Sat, 13 Jan 2024 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxDZpnA7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CF24A22;
	Sat, 13 Jan 2024 15:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC18C43399;
	Sat, 13 Jan 2024 15:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705159024;
	bh=jttoeIzMIfmC02I5k5jvdKdfV9XrBZeuecuDeEVi+cg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JxDZpnA7Lf6afRvWEpc1hl7QSomGbV0RHeRhEu2Z3zB65/56kWoo8afIGXPDjgsyR
	 NmB3iRruqp1JVZ59Pud14e+Zwa9TejDCGOXY3YWzp8G4pYqL+yVzbrIY2Kuz4rv05s
	 Q7PiElDWc1NKb3ZDhaMqzOjFWF8vV1Kwzk19ODItl9OpeDXy6AFEPTa+ZePnnEu1Xq
	 kzItDdcP/JZglbmzJ7iwgI+jXKy/KX/lOmIgErCOenI0pHfBK5t7Qw3xqUOVA0AfQv
	 qRHf7RQ6tbdBWzLwheRIyb2Nh2hEGcElI4DZEZbE323GB+rOW0PmG/0cWBPhC5936L
	 Qa+rm8I1MW5mA==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bbd6e37a9bso6443875b6e.0;
        Sat, 13 Jan 2024 07:17:04 -0800 (PST)
X-Gm-Message-State: AOJu0YzrIu+QRrjvE/rHhv3Vm3MhCAckvTS7Ybb6vB2XUjeGdMqgoqOw
	L1ox0hfrX77CsuGxWCk3NDKR0npK8neuUpyu0xg=
X-Google-Smtp-Source: AGHT+IHNcaxsicIBxxpO9gF84K8UY3QgmILpfx3+F7UaIlYv+EvuxlDaawUpUkVuViiaJkosQQq9Kj1KwvZ/rLaasrg=
X-Received: by 2002:a05:6808:2085:b0:3bd:61dc:e787 with SMTP id
 s5-20020a056808208500b003bd61dce787mr3251663oiw.63.1705159023617; Sat, 13 Jan
 2024 07:17:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c2adb439-0dea-4de1-996e-5a0caa5c729d@alu.unizg.hr>
 <ZaALOOhEdBP70lDH@bergen.fjasle.eu> <827b5e97-a436-47a7-a097-13657bcda948@alu.unizg.hr>
 <CAK7LNAToNP0hFvhzr_gYw6TXMxkJuCN4idWZvqmq3mSTNOHtSQ@mail.gmail.com> <b83bf78d-5fb0-4069-a1bb-c6a946b7b23c@alu.unizg.hr>
In-Reply-To: <b83bf78d-5fb0-4069-a1bb-c6a946b7b23c@alu.unizg.hr>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 14 Jan 2024 00:16:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNASCuuaO9tx44dbeS=deL-1Lvgy3REyC3FsVhfCmtWdB=w@mail.gmail.com>
Message-ID: <CAK7LNASCuuaO9tx44dbeS=deL-1Lvgy3REyC3FsVhfCmtWdB=w@mail.gmail.com>
Subject: Re: [PROBLEM] Very long .deb package build times for bindeb-pkg build target
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: Nicolas Schier <nicolas@fjasle.eu>, Mirsad Todorovac <mirsad.todorovac@alu.hr>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 13, 2024 at 8:28=E2=80=AFPM Mirsad Todorovac
<mirsad.todorovac@alu.unizg.hr> wrote:
>
> On 1/13/24 06:40, Masahiro Yamada wrote:
> > On Fri, Jan 12, 2024 at 7:48=E2=80=AFAM Mirsad Todorovac
> > <mirsad.todorovac@alu.unizg.hr> wrote:
> >>
> >> On 11. 01. 2024. 16:37, Nicolas Schier wrote:
> >>> Hi Mirsad,
> >>>
> >>> On Thu 11 Jan 2024 13:22:39 GMT, Mirsad Todorovac wrote:
> >>>> Hi,
> >>>>
> >>>> With this new release, it seems that Debian kernel build uses "xz" i=
n single-
> >>>> threaded mode:
>
> Hi, Masahiro,
>
> Thank you for your reply.
>
> > New release of what?
>
> Forgive me for not being precise. It was the new release of torvalds tree=
 mainline
> kernel 6.7+ (with merge commits up-to-date). I sort of mistakenly assumed=
 that
> I wrote it, but it was declared in some mail on LKML.



When you report a regression in the kernel code in the future,
please try to do "git bisect" and pin-point an offending commit.

That is more helpful to figure out how to fix the issue.

And, you will be sure whether or not the root cause exists
in the kernel.





>
> One environment was Ubuntu 23.10 Mantic Minotaur on the desktop at work.
>
> The laptop also has Mantic Minotaur, but for some reason it spawns multit=
hreaded
> dpkg-deb when building packages, unlike desktop which spawned single-thre=
aded "xz".
>
> This is at least what the "top" displayed when turning on "H" (show threa=
ds).
>
> On one system (upgraded 23.10 from 22.04 LTS) the same dpkg-deb shows as =
multi-threaded
> dpkg-deb, while on the other it calls xz which didn't respect XT_OPT=3D-T=
0 (visible
> from the copy+paste from top output).
>
> I am perplexed myself.
>
> >>>> Tasks: 484 total,   2 running, 481 sleeping,   0 stopped,   1 zombie
> >>>> %Cpu(s):  2.5 us,  2.2 sy,  6.3 ni, 85.1 id,  2.3 wa,  0.0 hi,  1.7 =
si,  0.0 st
> >>>> MiB Mem :  64128.3 total,    524.3 free,   5832.0 used,  58540.9 buf=
f/cache
> >>>> MiB Swap:  32760.0 total,  32758.7 free,      1.2 used.  58296.3 ava=
il Mem
> >>>>
> >>>>      PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TI=
ME+
> >>>> COMMAND
> >>>>
> >>>>   978084 marvin    30  10  112440  97792   2432 R 100.0   0.1  29:30=
23 xz
> >>>>
> >>>>
> >>>> Before dpkg-deb was using up to 3200% of CPU time on a 16 core SMT C=
PU.
> >>>>
> >>>> Can it be something with dpkg-deb --thread-max=3D%n option?
> >>>
> >>> I cannot find any --thread-max option in Linux tree.  Do you call
> >>> dpkg-deb manually or somehow induce a thread maximum?
> >>>
> >>>> Waiting for half an hour just for the build of linux-image-...-dbg p=
ackage
> >>>> seems like an overkill ...
> >>>
> >>> With current v6.7 release tree I do not see the reported slow-downs
> >>> when building bindeb-pkg; I tested by cross-compiling for arm64 on
> >>> amd64 with CONFIG_MODULE_COMPRESS_XZ=3Dy and =3Dn).
> >>>
> >>> Both take roughly 5mins on my 24-core i9 system.
> >>>
> >>> Kind regards,
> >>> Nicolas
> >>
> >> I am perplexed too, but you can see from the top output the
> >> single-threaded xz with 29:30m processor time.
> >>
> >> On my laptop with the sam Ubuntu 23.10 mantic minotaur, I have
> >> dpkg-deb version 1.20.12 and it shows things like 400% and 3200%
> >> CPU time, so it is working multithreaded.
> >>
> >> On desktop machine with the same Ubuntu 23.10 and the same git
> >> torvalds tree, it starts single-threaded xz from dpkg-deb instead.
> >
> > You built the same mainline git tree on your laptop and desktop.
> > The former runs xz multi-threaded, the latter single-threaded.
> >
> > So, this is not about the kernel code, but about your environment,
> > isn't it?
>
> It should be. Somehow it doesn't behave rationally. To be true to the fac=
ts,
> one is 23.10 Mantic Minotaur upgraded from 22.04 LTS, and the other is
> fresh Mantic from install.
>
> > You mentioned you were using Ubuntu 23.10, where
> > dpkg-deb version is 1.22.0
>
> This is correct.
>
> > Your dpkg-deb version, 1.20.12, is too old for Ubuntu 23.10.
> > Is it a self-built one?
>
> Yes, it is the build from Debian 11 source package.
>
> This had the similar rationale because Ubuntu version ran single-threaded=
.
>
> dpkg-deb from Debian 11 source package worked well for months.
>
> > dpkg-deb usually compresses binary packages, but the default
> > compression type depends on the distro.
> > (It is determined at "./configure" time)
>
> I see. But the home-built dpkg-deb also resorted to running "xz", and
> xz did not recognise XZ_OPT environment variable. Very odd. :-/



It depends on the environment whether or not dpkg-deb
spawns the external 'xz' command.


With WITH_LIBLZMA defined, dpkg-deb uses internal code
to compress the data with xz.  [1]

Without WITH_LIBLZMA, dpkg-deb sparns "xz" processes. [2]


[1]: https://salsa.debian.org/dpkg-team/dpkg/-/blob/1.20.12/lib/dpkg/compre=
ss.c?ref_type=3Dtags#L412
[2]: https://salsa.debian.org/dpkg-team/dpkg/-/blob/1.20.12/lib/dpkg/compre=
ss.c?ref_type=3Dtags#L663


Since you said you saw "xz" in the "ps" command output,
I believe your case is the latter.


When dpkg-deb swarns the external "xz" command,
dpkg-deb unsets "XZ_OPT". [3]

I believe that's why you do not see XZ_OPT propagated.

[3]: https://salsa.debian.org/dpkg-team/dpkg/-/blob/1.20.12/lib/dpkg/compre=
ss.c?ref_type=3Dtags#L643




>
> > On Ubuntu, the default compression type for dpkg-deb is "zstd"
> > (while it is "xz" on Debian)
> >
> > Check "man dpkg-deb" on your Ubuntu machine.
> >
> >    -Zcompress=E2=80=90type
> >        Specify which compression type to use when building a package.
> >        Allowed values are gzip, xz (since dpkg 1.15.6),
> >        zstd (since dpkg 1.21.18) and none (default is zstd).
>
> Verified. "man dpkg-deb" confirms that.
>
> > You are still allowed to use xz with "make KDEB_COMPRESS=3Dxz deb-pkg".
> > Is this your case?
>
> Somehow, my Mantic's "xz" did not react to the environment variables. May=
be it is
> enchanted? :-/
> > Overall, your report is not sensible.
>
> > You should check what you are seeing.
>
> I was seeing exactly what I copy+pasted (top output). Give me the benefit=
 of doubt
> that I did not falsify copy+paste. Ideally, I should have submitted JPG t=
erminal
> screenshot.
>
> Home-built dpkg-deb worked well on Ubuntu 22.04 LTS and 23.10 (upgraded f=
rom 22.04).
> So it was a surprise that it started showing quirks on this new box with =
fresh 23.10
> from .iso.
>
> But I am only 16 months in the Linux kernel development, so it is probabl=
y my fault.
>
> I saw from the output of "ps xewww" that "xz" had "XZ_OPT=3D-T0", but it =
refused to obey
> the environment variable.
>
> This is probably worth digging and delving into to find the culprit, but =
eventually the
> workaround was the script manually prepending "--threads=3D0" to the para=
meter list and
> calling system xz:
>
>         /usr/bin/xz --threads=3D0 "$@"
>
> Certainly, I need to establish "normality" before building complex kernel=
s and applying
> patches or the results will be non-reproducible and useless.
>
> I did the background search on your valuable contributions to the LK, but=
 as we have this
> problem with the vanilla installation of Ubuntu, maybe we can think of so=
mething to
> optimise the LK build time?


I do not think so.

There already exists a solution to control the number of threads.



See "man dpkg-deb"

   DPKG_DEB_THREADS_MAX
       Sets the maximum number of threads allowed for compressors that
       support multi=E2=80=90threaded operations (since dpkg 1.21.9).

       The --threads-max option overrides this value.




By setting this env variable, you should be able to control the multi-threa=
ding.


However, your dpkg-deb is 1.20.12, so you need to use a newer version.



You locally hacked builddeb to add --threads-max, but it does not
work for you for the same reason; it requires dpkg 1.21.9+


  --threads-max=3Dthreads
     Sets the maximum number of threads allowed for compressors that suppor=
t
     multi=E2=80=90threaded operations (since dpkg 1.21.9).




Why do you stick to the old home-built dpkg-deb?

If you use the default dpkg-deb bundled with Ubuntu 23.10,
you will have a better experience.

Or, if you still insist on a home-built dpkg-deb,
why don't you build a newer version?








>
> To recall better from Thursday, I actually tried to prepend "XZ_OPT=3D--t=
hreads=3D0" to
> system xz, and it worked. But when called from dpkg-deb, it suddenly got =
amnesia, despite
> XZ_OPT=3D-T0 being seen in "ps xewww" output :-/
>
> I believe there should be a rational explanation rather than black or red=
 magic.
>
> Thank you again for considering this problem report and have a nice weeke=
nd!
>
> Best regards,
> Mirsad Todorovac
>
> >> I tried things like this:
> >>
> >> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> >> index d7dd0d04c70c..b2319c23db34 100755
> >> --- a/scripts/package/builddeb
> >> +++ b/scripts/package/builddeb
> >> @@ -38,7 +38,7 @@ create_package() {
> >>
> >>          # Fix ownership and permissions
> >>          if [ "$DEB_RULES_REQUIRES_ROOT" =3D "no" ]; then
> >> -               dpkg_deb_opts=3D"--root-owner-group"
> >> +               dpkg_deb_opts=3D"--threads-max=3D0 --root-owner-group"
> >>          else
> >>                  chown -R root:root "$pdir"
> >>          fi
> >>
> >> and it didn't work either - dpkg-deb --threads-max=3D0 still spawned a
> >> single-threaded xz that ran 30 minutes.
> >>
> >> Then the workaround was a very simple xz shell script that adds option=
 --threads=3D0
> >> and calls system xz:
> >>
> >> ~/bin/xz:
> >> ----------------------------------------------------------------
> >> #!/bin/bash -f
> >>
> >> /usr/bin/xz --threads=3D0 "$@"
> >> ----------------------------------------------------------------
> >>
> >> This finally worked, but sometimes I get:
> >>
> >> marvin@defiant:~/linux/kernel$ xz -9 --memlimit-compress=3D8000MiB lin=
ux-image-6.7.0-rc8-dbg_6.7.0-rc8-6_amd64.deb
> >> /usr/bin/xz: Reduced the number of threads from 8 to 6 to not exceed t=
he memory usage limit of 8000 MiB
> >>
> >> (This is of course just an example of compressing a large file, as .de=
b is already compressed.)
> >>
> >> I used the default Ubuntu 23.10 config, with .pems excluded, and I thi=
nk module compression
> >> did not work either. I had to turn it off ...
> >>
> >> Hope this helps.
> >>
> >> Regards,
> >> Mirsad
> >>
> >> --
> >> Mirsad Goran Todorovac
> >> Sistem in=C5=BEenjer
> >> Grafi=C4=8Dki fakultet | Akademija likovnih umjetnosti
> >> Sveu=C4=8Dili=C5=A1te u Zagrebu
> >>
> >> System engineer
> >> Faculty of Graphic Arts | Academy of Fine Arts
> >> University of Zagreb, Republic of Croatia
> >> The European Union
> >>
> >> "I see something approaching fast ... Will it be friends with me?"
> >>
> >>
> >
> >



--=20
Best Regards
Masahiro Yamada


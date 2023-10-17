Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9057CC2A5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbjJQMJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343592AbjJQMI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:08:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90FD1A2;
        Tue, 17 Oct 2023 05:06:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B6AC43215;
        Tue, 17 Oct 2023 12:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697544367;
        bh=U06CDS9f4LIwRTfVJyEzLTF5dNElL5hZ3yfWZBot6nY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lraECZrnmdCkHL0j2etk77n9P2wHYuunz8jYG4X9WDeRr54UZW89QpMNKoLxJrk3P
         w23tn40/XfL3BHAxS7JwZvFddGzpSJQe2HDjrGxPw35J5J71ZaZ+ztweLaUkTnjpwV
         ej0t82RoMNU7OnY8J7ycilq6MPf8oZTC0vnyqGnqV7SnTIvXB5ENojRDs3Tu9LDR8+
         2D6V9CHBT80uW5uWIM3rYmPytleDNMTqh5zii5SXAAOJh/r6j/JCVoiq4Nhb7uuyen
         TrQQXF54d5cCUhLQxRjX062qfOdxkkMj7Ompx4MfVgpOli9Vvko5+hj96IS9UXmHti
         BbQyR12YYBYkA==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6c4f1f0774dso3882789a34.2;
        Tue, 17 Oct 2023 05:06:07 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywqmu91Y3bxBBtdTjgppH9TmRYHSgcX+a8/RJMKuM4tCF9XYEZ7
        URFE+cNSywldZMxxq0itbNhhcac1QKnlaX7PA+s=
X-Google-Smtp-Source: AGHT+IGVs4SokDcSEAD+R7ZDVcysEGbmB9oWuXU+bburPF/TYbQpK+TehyQYCoai75VwBeJVsc/NHrZ9HnZHbD/rgdk=
X-Received: by 2002:a05:6870:e416:b0:1e9:87c0:a849 with SMTP id
 n22-20020a056870e41600b001e987c0a849mr2290363oag.22.1697544366378; Tue, 17
 Oct 2023 05:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231005150728.3429-1-msuchanek@suse.de> <CAK7LNAQh7vCQ859RPkL3SDr2d4ptt5OVCr66fkPKGcvxDUHtkw@mail.gmail.com>
 <20231009085208.GT6241@kitsune.suse.cz> <CAK7LNASeMEKVi5c0PEow5KSdN7rsm7UYEf2smWOSkYOhr_5fVQ@mail.gmail.com>
 <20231009140733.GV6241@kitsune.suse.cz> <CAK7LNAQQMFUt4R1m_U8kBY5=BvxD_dMuE4MD4kpd48WK1E+AGA@mail.gmail.com>
 <20231010101552.GW6241@kitsune.suse.cz> <CAK7LNASX2_-xt3Qvxie_G=Q4fuVYR6eE47QjQ5NZf7QxY-4_tQ@mail.gmail.com>
 <20231017104453.GG6241@kitsune.suse.cz>
In-Reply-To: <20231017104453.GG6241@kitsune.suse.cz>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 17 Oct 2023 21:05:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNASKPg0JK0QsLGb1Rfx2ysvHJTm3NFOvtwOpZRz4-20T8w@mail.gmail.com>
Message-ID: <CAK7LNASKPg0JK0QsLGb1Rfx2ysvHJTm3NFOvtwOpZRz4-20T8w@mail.gmail.com>
Subject: Re: [PATCH rebased] kbuild: rpm-pkg: Fix build with non-default MODLIB
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 7:44=E2=80=AFPM Michal Such=C3=A1nek <msuchanek@sus=
e.de> wrote:
>
> On Tue, Oct 17, 2023 at 07:15:50PM +0900, Masahiro Yamada wrote:
> > > >
> > > > Let me add more context to my question.
> > > >
> > > >
> > > > I am interested in the timing when
> > > > 'pkg-config --print-variables kmod | grep module_directory'
> > > > is executed.
> > > >
> > > >
> > > >
> > > > 1.  Build a SRPM on machine A
> > > >
> > > > 2.  Copy the SRPM from machine A to machine B
> > > >
> > > > 3.  Run rpmbuild on machine B to build the SRPM into a RPM
> > > >
> > > > 4.  Copy the RPM from machine B to machine C
> > > >
> > > > 5.  Install the RPM to machine C
> > >
> > > As far as I am aware the typical use case is two step:
> > >
> > > 1. run make rpm-pkg on machine A
> > > 2. install the binary rpm on machine C that might not have build tool=
s
> > >    or powerful enough CPU
> > >
> > > While it's theoretically possible to use the srpm to rebuild the bina=
ry
> > > rpm independently of the kernel git tree I am not aware of people
> > > commonly doing this.
> >
> >
> >
> > If I correctly understand commit
> > 8818039f959b2efc0d6f2cb101f8061332f0c77e,
> > those Redhat guys pack a SRPM on a local machine,
> > then send it to their build server called 'koji'.
> >
> > Otherwise, there is no reason
> > to have 'make srcrpm-pkg'.
> >
> >
> >
> > I believe "A =3D=3D B" is not always true,
> > but we can assume "distro(A) =3D=3D distro(B)" is always met
> > for simplicity.
> >
> > So, I am OK with configuration at the SRPM time.
>
> Even if the distro does not match it will likely work to configure SRPM
> for non-matching distro and then build it on the target distro but I have
> not tested it.



Your approach specifies %{MODLIB} as a fixed string
when generating kernel.spec, i.e. at the SRPM time.


 %files
 %defattr (-, root, root)
-/lib/modules/%{KERNELRELEASE}
-%exclude /lib/modules/%{KERNELRELEASE}/build
+%{MODLIB}
+%exclude %{MODLIB}/build
 /boot/*


Then, how to change the path later?






I do not know if the relocatable package
is a sensible solution because the kernel package has /boot/

http://ftp.rpm.org/api/4.4.2.2/relocatable.html


We might be able to tweak installation paths in %post section.

Or perhaps, %{shell } can defer the module path detection
until building RPM.

%define MOD_PREFIX    %{shell pkg-config --variable=3Dmodule_prefix
libkmod 2>/dev/null}


Overall, I did not find a cool solution.



>
> > > If rebuilding the source rpm on a different machine from where the gi=
t
> > > tree is located, and possibly on a different distribution is desirabl=
e
> > > then the detection of the KERNEL_MODULE_DIRECTORY should be added in =
the
> > > rpm spec file as well.
> > >
> > > > Of course, we are most interested in the module path
> > > > of machine C, but it is difficult/impossible to
> > > > guess it at the time of building.
> > > >
> > > > We can assume machine B =3D=3D machine C.
> > > >
> > > > We are the second most interested in the module
> > > > path on machine B.
> > > >
> > > > The module path of machine A is not important.
> > > >
> > > > So, I am asking where you would inject
> > > > 'pkg-config --print-variables kmod | grep module_directory'.
> > >
> > > I don't. I don't think there will be a separate machine B.
> > >
> > > And I can't really either - so far any attempt at adding support for
> > > this has been rejected.
> > >
> > > Technically the KERNEL_MODULE_DIRECTORY could be set in two steps - o=
ne
> > > giving the script to run, and one running it, and then it could be ru=
n
> > > independently in the SRPM as well.
> >
> >
> > At first, I thought your patch [1] was very ugly,
> > but I do not think it is so ugly if cleanly implemented.
> >
> > It won't hurt to allow users to specify the middle part of MODLIB.
> >
> >
> > There are two options.
> >
> >
> > [A]  Add 'MOD_PREFIX' to specify the middle part of MODLIB
> >
> >
> > The top Makefile will look as follows:
> >
> >
> > MODLIB =3D $(INSTALL_MOD_PATH)$(MOD_PREFIX)/lib/modules/$(KERNELRELEASE=
)
> > export MODLIB
> >
> >
> > It is easier than specifying the entire MODLIB, but you still need
> > to manually pass "MOD_PREFIX=3D/usr" from an env variable or
> > the command line.
> >
> > If MOD_PREFIX is not given, MODLIB is the same as the current one.
> >
> > [B] Support a dynamic configuration as well
> >
> >
> > MOD_PREFIX ?=3D $(shell pkg-config --variable=3Dmodule_prefix libkmod 2=
>/dev/null)
> > export MOD_PREFIX
> >
> > MODLIB =3D $(INSTALL_MOD_PATH)$(MOD_PREFIX)/lib/modules/$(KERNELRELEASE=
)
> > export MODLIB
>
> That's basically the same thing as the patch that has been rejected.
>
> I used :=3D to prevent calling pkg-config every time MODLIB is used but i=
t
> might not be the most flexible wrt overrides.




That's good you care about the cost of $(shell ) invocations.

:=3D is evaluated one time at maximum, but one time at minimum.

$(shell ) is always invoked for non-build targets as
"make clean", "make help", etc.
That is what I care about.


?=3D is a recursive variable.

The workaround for one-time evaluation is here,
https://savannah.gnu.org/bugs/index.php?64746#comment2

However, that is not a problem because I can do it properly somehow,
for example, with "private export".







>
> > If MOD_PREFIX is given from an env variable or from the command line,
> > it is respected.
> >
> > If "pkg-config --variable=3Dmodule_prefix libkmod" works,
> > that configuration is applied.
> >
> > Otherwise, MOD_PREFIX is empty, i.e. fall back to the current behavior.
> >
> >
> > I prefer 'MOD_PREFIX' to 'KERNEL_MODULE_DIRECTORY' in your patch [1]
> > because "|| echo /lib/modules" can be omitted.
> >
> > I do not think we will have such a crazy distro that
> > installs modules under /opt/ directory.
>
> However, I can easily imagine a distribution that would want to put
> modules in /usr/lib-amd64-linux/modules.


Sorry, it is not easy for me.

What is the background of your thought?



>
> > I could not understand why you inserted
> > "--print-variables kmod 2>/dev/null | grep '^module_directory$$' >/dev/=
null"
> > but I guess the reason is the same.
> > "pkg-config --variable=3Dmodule_directory kmod" always succeeds,
> > so "|| echo /lib/modules" is never processed.
>
> Yes, that's the semantics of the tool. The jq version was slightly less
> convoluted but required additional tool for building the kernel.


It IS convoluted.



>
> > I do not know why you parsed kmod.pc instead of libkmod.pc [2]
>
> Because it's kmod property, not libkmod property.
>
> Distributions would install libkmod.pc only with development files
> whereas the kmod.pc should be installed with the binaries.


This is up to the kmod maintainer.

If they agree, I do not mind where the configuration comes from.








> Thanks
>
> Michal
>
> >
> >
> > [1] https://lore.kernel.org/linux-kbuild/20230718120348.383-1-msuchanek=
@suse.de/
> > [2] https://github.com/kmod-project/kmod/blob/v31/configure.ac#L295



--=20
Best Regards
Masahiro Yamada

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF607BE45C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377791AbjJIPPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377709AbjJIPPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:15:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF58A11C;
        Mon,  9 Oct 2023 08:14:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11812C43391;
        Mon,  9 Oct 2023 15:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696864479;
        bh=+ZfZqRjLTizvALSqDqCC1fwDOV+CINpIZmqOtUE1B8Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JpLYQDwIItDww8h1Oe0EKmYLQKZ9gPJ/nBfhUZINrjzcK44E2pH9LbGq4M801/Z7a
         EpX6F2QfjDIUYddDEH9f24QebJYEInngy55wVMc+zpv9VLkf2UrCmv1UmEO6PFEN55
         kUpIEhwl+m/phMPOci7nM8DQs/OpMVks0WW7aKz5kVqZNIOQ8teScG2AeZ7LNJYLLi
         1M0Bp0eB9f6v9ufohRq9MDSevU5v0j35GtKY1hDHZYceh2oSVbLPQDAd9TFg1UCyc8
         8Xu4CglL2wJfuQjMtlS84+hmS9P5xGqnzFkormcIMpcJ21NLOtO4qEwQR4cJntEBzm
         lJ/sFKghG7A/w==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6c615df24c0so3159510a34.1;
        Mon, 09 Oct 2023 08:14:39 -0700 (PDT)
X-Gm-Message-State: AOJu0YweTN9MurDpLcikIUZpSZLvShTOvZZ225AZ6ms/ljgYe5ldyvYw
        yV6Almplgogud/+wQ2cTsopdqMsib5J09i2SpVg=
X-Google-Smtp-Source: AGHT+IFWiJL28KGTKjTzlxHEVuLFAoHmaycE0erMI3hDmoMBOsY3re/CsPHC2i9FwjOYUVcg7eEs5kO7VC+z4HgeVhQ=
X-Received: by 2002:a05:6870:e307:b0:1bb:a227:7008 with SMTP id
 z7-20020a056870e30700b001bba2277008mr17284004oad.3.1696864478369; Mon, 09 Oct
 2023 08:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231005150728.3429-1-msuchanek@suse.de> <CAK7LNAQh7vCQ859RPkL3SDr2d4ptt5OVCr66fkPKGcvxDUHtkw@mail.gmail.com>
 <20231009085208.GT6241@kitsune.suse.cz> <CAK7LNASeMEKVi5c0PEow5KSdN7rsm7UYEf2smWOSkYOhr_5fVQ@mail.gmail.com>
 <20231009140733.GV6241@kitsune.suse.cz>
In-Reply-To: <20231009140733.GV6241@kitsune.suse.cz>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 10 Oct 2023 00:14:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQQMFUt4R1m_U8kBY5=BvxD_dMuE4MD4kpd48WK1E+AGA@mail.gmail.com>
Message-ID: <CAK7LNAQQMFUt4R1m_U8kBY5=BvxD_dMuE4MD4kpd48WK1E+AGA@mail.gmail.com>
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

On Mon, Oct 9, 2023 at 11:07=E2=80=AFPM Michal Such=C3=A1nek <msuchanek@sus=
e.de> wrote:
>
> On Mon, Oct 09, 2023 at 09:34:10PM +0900, Masahiro Yamada wrote:
> > On Mon, Oct 9, 2023 at 5:52=E2=80=AFPM Michal Such=C3=A1nek <msuchanek@=
suse.de> wrote:
> > >
> > > Hello,
> > >
> > > On Mon, Oct 09, 2023 at 05:31:02PM +0900, Masahiro Yamada wrote:
> > > > On Fri, Oct 6, 2023 at 12:49=E2=80=AFAM Michal Suchanek <msuchanek@=
suse.de> wrote:
> > > > >
> > > > > The default MODLIB value is composed of two variables and the har=
dcoded
> > > > > string '/lib/modules/'.
> > > > >
> > > > > MODLIB =3D $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
> > > > >
> > > > > Defining this middle part as a variable was rejected on the basis=
 that
> > > > > users can pass the whole MODLIB to make, such as
> > > >
> > > >
> > > > In other words, do you want to say
> > > >
> > > > "If defining this middle part as a variable had been accepted,
> > > > this patch would have been unneeded." ?
> > >
> > > If it were accepted I would not have to guess what the middle part is=
,
> > > and could use the variable that unambiguosly defines it instead.
> >
> >
> > How?
> >
> > scripts/package/kernel.spec hardcodes 'lib/modules'
> > in a couple of places.
> >
> > I am asking how to derive the module path.
>
> Not sure what you are asking here. The path is hardcoded, everywhere.
>
> The current Makefile has
>
> MODLIB  =3D $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
>
> and there is no reliable way to learn what the middle part was after the
> fact - $(INSTALL_MOD_PATH) can be non-empty.
>
> The rejected patch was changing this to a variable, and also default to
> adjusting the content to what kmod exports in pkgconfig after applying a
> proposed patch to make this hardcoded part configurable:
>
> export KERNEL_MODULE_DIRECTORY :=3D $(shell pkg-config --print-variables =
kmod 2>/dev/null | grep '^module_directory$$' >/dev/null && pkg-config --va=
riable=3Dmodule_directory kmod || echo /lib/modules)
>
> MODLIB  =3D $(INSTALL_MOD_PATH)$(KERNEL_MODULE_DIRECTORY)/$(KERNELRELEASE=
)
>
> It would be completely posible to only define the middle part as a
> variable that could then be used in rpm-pkg:
>
> export KERNEL_MODULE_DIRECTORY :=3D /lib/modules
>
> MODLIB  =3D $(INSTALL_MOD_PATH)$(KERNEL_MODULE_DIRECTORY)/$(KERNELRELEASE=
)
>
> Thanks
>
> Michal
>
>


Let me add more context to my question.


I am interested in the timing when
'pkg-config --print-variables kmod | grep module_directory'
is executed.



1.  Build a SRPM on machine A

2.  Copy the SRPM from machine A to machine B

3.  Run rpmbuild on machine B to build the SRPM into a RPM

4.  Copy the RPM from machine B to machine C

5.  Install the RPM to machine C


Of course, we are most interested in the module path
of machine C, but it is difficult/impossible to
guess it at the time of building.

We can assume machine B =3D=3D machine C.

We are the second most interested in the module
path on machine B.

The module path of machine A is not important.


So, I am asking where you would inject
'pkg-config --print-variables kmod | grep module_directory'.


--=20
Best Regards
Masahiro Yamada

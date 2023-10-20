Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4521F7D0927
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 09:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376384AbjJTHDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 03:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376326AbjJTHDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 03:03:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C0998;
        Fri, 20 Oct 2023 00:03:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D80C433C9;
        Fri, 20 Oct 2023 07:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697785424;
        bh=OkduzFsQrql4vaQN1hI4ttHMuV3cQxeu0vcbumIU/YQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hqR6eY9HqplSVmgpVrsg/pSkDw62/zAbF0f+qFRka5bz/yojBeZdRWyUTVzOs9/Cx
         ooV+wCVycPSJmQEvXzBpgpcKSM5nv9yCblY2VcpvPJc6PEFM7I2t+foqkoH7rpj3eK
         MTKS3soeVyjSuaVoWwJLIimsfdDfSbnxo0o0AXCYz3vhDF5xoCLBBmY5qT+7tOPT+Z
         q41KNTB6Mn9vHd398z4IHhs26g23y4qzEBYeSaaCIDe0JgZ6PxT9soxjm/iKrSjosn
         mJHcec+v1gxQsfQRNHDEGwikEXJIaq0YKk8Bm5Y8v5kJoTEPnsvDTnoGBRV2B9620y
         NlsfWtmG1Yqjg==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ce37d0f1a9so149799a34.0;
        Fri, 20 Oct 2023 00:03:44 -0700 (PDT)
X-Gm-Message-State: AOJu0YyXcrvL6cALJiHZe3ciRnu52hc1kyE1nmArRdOe316vtCj5NwDk
        PI/f+jBWYlg9BE2jI7APRF+lWwwMDT+pJVrGO98=
X-Google-Smtp-Source: AGHT+IHN0w7kBf0+HBio2x3W554zUTb5zy2/0fI+q2GVGnmytcQr57G3zxy8R7UNLJtf2+dwNbxg8mC6Ev0mJcXlEh8=
X-Received: by 2002:a05:6870:5d8d:b0:1e9:fc32:9887 with SMTP id
 fu13-20020a0568705d8d00b001e9fc329887mr1459108oab.13.1697785423969; Fri, 20
 Oct 2023 00:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231018151950.205265-1-masahiroy@kernel.org> <20231018151950.205265-4-masahiroy@kernel.org>
 <ZTDlrkTXnkVN1cff@krava> <CAEf4BzZm4h4q6k9ZhuT5qiWC9PYA+c7XwVFd68iAq4mtMJ-qhw@mail.gmail.com>
In-Reply-To: <CAEf4BzZm4h4q6k9ZhuT5qiWC9PYA+c7XwVFd68iAq4mtMJ-qhw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 20 Oct 2023 16:03:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR2kKwbzdFxfVXDxsy8pfyQDCR-BN=zpbcZg0JS9RpsKQ@mail.gmail.com>
Message-ID: <CAK7LNAR2kKwbzdFxfVXDxsy8pfyQDCR-BN=zpbcZg0JS9RpsKQ@mail.gmail.com>
Subject: Re: [bpf-next PATCH v2 4/4] kbuild: refactor module BTF rule
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, bpf@vger.kernel.org
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

On Fri, Oct 20, 2023 at 7:55=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Oct 19, 2023 at 1:15=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wr=
ote:
> >
> > On Thu, Oct 19, 2023 at 12:19:50AM +0900, Masahiro Yamada wrote:
> > > newer_prereqs_except and if_changed_except are ugly hacks of the
> > > newer-prereqs and if_changed in scripts/Kbuild.include.
> > >
> > > Remove.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > > Changes in v2:
> > >   - Fix if_changed_except to if_changed
> > >
> > >  scripts/Makefile.modfinal | 25 ++++++-------------------
> > >  1 file changed, 6 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> > > index 9fd7a26e4fe9..fc07854bb7b9 100644
> > > --- a/scripts/Makefile.modfinal
> > > +++ b/scripts/Makefile.modfinal
> > > @@ -19,6 +19,9 @@ vmlinux :=3D
> > >  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> > >  ifneq ($(wildcard vmlinux),)
> > >  vmlinux :=3D vmlinux
> > > +cmd_btf =3D ; \
> > > +     LLVM_OBJCOPY=3D"$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --btf_=
base vmlinux $@; \
> > > +     $(RESOLVE_BTFIDS) -b vmlinux $@
> > >  else
> > >  $(warning Skipping BTF generation due to unavailability of vmlinux)
> > >  endif
> > > @@ -41,27 +44,11 @@ quiet_cmd_ld_ko_o =3D LD [M]  $@
> > >        cmd_ld_ko_o +=3D                                              =
   \
> > >       $(LD) -r $(KBUILD_LDFLAGS)                                     =
 \
> > >               $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)             =
 \
> > > -             -T scripts/module.lds -o $@ $(filter %.o, $^)
> > > +             -T scripts/module.lds -o $@ $(filter %.o, $^)          =
 \
> > > +     $(cmd_btf)
> > >
> > > -quiet_cmd_btf_ko =3D BTF [M] $@
> >
> > nit not sure it's intentional but we no longer display 'BTF [M] ...ko' =
lines,
> > I don't mind not displaying that, but we should mention that in changel=
og
> >
>
> Thanks for spotting this! I think those messages are useful and
> important to keep. Masahiro, is it possible to preserve them?



No, I do not think so.

Your code is wrong.


To clarify this is a fix,
I will replace the commit as follows:




------------------->8----------------------
kbuild: detect btf command change for modules

Currently, the command change in cmd_btf_ko does not cause to rebuild
the modules because it is not passed to if_changed.

Pass everything to if_change so that the btf command is also recorded
in the .*.cmd files. This removes the hacky newer_prereqs_except and
if_changed_except macros too.
------------------->8----------------------




--
Best Regards

Masahiro Yamada

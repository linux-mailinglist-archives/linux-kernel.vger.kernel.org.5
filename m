Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051DE7CE0ED
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjJRPQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjJRPQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:16:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998E3F7;
        Wed, 18 Oct 2023 08:16:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36980C433C9;
        Wed, 18 Oct 2023 15:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697642214;
        bh=zILWbUZWgWvkjL/qoUZPxk2/UcFo9fmw3gWAn9a6ZO8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FoCb92EQBPiCsDe0inxUw3yngrrSRrhveSk+kjQUZt3uFl+z1NQC9hOtN6oX2rWDq
         2dMEdjWCMqD+cpbFWCXUJTlRTUf8hx+Tl7V5CvZenjkRbN+5NJSXwbgTjCCNZ0wjjJ
         WBxi8886bypvtSXkrmJO4sHK/35tSYx6qwEgVrgZVVTE5ipfofWS2YkTF2R24NCY33
         b6V/apLHxxv6v1I5opkeFbU39xjqP9NpzLHMlbRX6gMppwBEyUu5ZHYMFOdGiTvXvU
         KRyqch8fdify8JALt2Bt5aP6XzxkmmfpZPYU5vFUOhW/XWVWqPd+4rHs5L0IOfoXDj
         Y+1aGsG6kyVsg==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6c49f781855so4564492a34.3;
        Wed, 18 Oct 2023 08:16:54 -0700 (PDT)
X-Gm-Message-State: AOJu0YwTKp2AW9dNxVSar5ypJTfy7vkk8ZOojLKvYCElZ7rj/5BzIvH3
        y4zeP919OE3Wd2w5L6nETzrKPX82g5QIswluS+w=
X-Google-Smtp-Source: AGHT+IFsaVG/7I++liIoklqxvT40qhKnXCBD3ySPvbVE3LZUDsYsWhwBfvFxWLiEONQpuz+pflh2GaHm59+oRBBziJI=
X-Received: by 2002:a05:6870:5cc9:b0:1e9:8d44:a5cf with SMTP id
 et9-20020a0568705cc900b001e98d44a5cfmr6090062oab.17.1697642213580; Wed, 18
 Oct 2023 08:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231017103742.130927-1-masahiroy@kernel.org> <20231017103742.130927-4-masahiroy@kernel.org>
 <ZS6E3EA68GOjonB8@buildd.core.avm.de>
In-Reply-To: <ZS6E3EA68GOjonB8@buildd.core.avm.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 19 Oct 2023 00:16:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS4x3DmozW0dhejyL3rt+YATHyVC5Ew_8Je89HMivci9A@mail.gmail.com>
Message-ID: <CAK7LNAS4x3DmozW0dhejyL3rt+YATHyVC5Ew_8Je89HMivci9A@mail.gmail.com>
Subject: Re: [PATCH 4/4] kbuild: refactor module BTF rule
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 9:58=E2=80=AFPM Nicolas Schier <n.schier@avm.de> wr=
ote:
>
> On Tue, Oct 17, 2023 at 07:37:42PM +0900, Masahiro Yamada wrote:
> > newer_prereqs_except and if_changed_except are ugly hacks of the
> > newer_prereqs and if_changed in scripts/Kbuild.include.
>
> newer-prereqs

Yes.


>
> >
> > Remove.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/Makefile.modfinal | 23 +++++------------------
> >  1 file changed, 5 insertions(+), 18 deletions(-)
> >
> > diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> > index 9fd7a26e4fe9..6ab10dba05c7 100644
> > --- a/scripts/Makefile.modfinal
> > +++ b/scripts/Makefile.modfinal
> > @@ -19,6 +19,9 @@ vmlinux :=3D
> >  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> >  ifneq ($(wildcard vmlinux),)
> >  vmlinux :=3D vmlinux
> > +cmd_btf =3D ; \
>
> while reading, I stumpled over this semicolon, but probably it's a good
> reminder that cmd_btf is only a cmd extension.


A semicolon is needed as a command separator, but
the trailing semicolon after the last command.

I usually prepend a semicolon to conditional commands.


>
> > +     LLVM_OBJCOPY=3D"$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --btf_ba=
se vmlinux $@; \
> > +     $(RESOLVE_BTFIDS) -b vmlinux $@
> >  else
> >  $(warning Skipping BTF generation due to unavailability of vmlinux)
> >  endif
> > @@ -41,27 +44,11 @@ quiet_cmd_ld_ko_o =3D LD [M]  $@
> >        cmd_ld_ko_o +=3D                                                =
 \
> >       $(LD) -r $(KBUILD_LDFLAGS)                                      \
> >               $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)              \
> > -             -T scripts/module.lds -o $@ $(filter %.o, $^)
> > +             -T scripts/module.lds -o $@ $(filter %.o, $^)           \
> > +     $(cmd_btf)
> >
> > -quiet_cmd_btf_ko =3D BTF [M] $@
> > -      cmd_btf_ko =3D                                                  =
 \
> > -             LLVM_OBJCOPY=3D"$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) =
--btf_base vmlinux $@; \
> > -             $(RESOLVE_BTFIDS) -b vmlinux $@
> > -
> > -# Same as newer-prereqs, but allows to exclude specified extra depende=
ncies
> > -newer_prereqs_except =3D $(filter-out $(PHONY) $(1),$?)
> > -
> > -# Same as if_changed, but allows to exclude specified extra dependenci=
es
> > -if_changed_except =3D $(if $(call newer_prereqs_except,$(2))$(cmd-chec=
k),      \
> > -     $(cmd);                                                          =
    \
> > -     printf '%s\n' 'savedcmd_$@ :=3D $(make-cmd)' > $(dot-target).cmd,=
 @:)
> > -
> > -# Re-generate module BTFs if either module's .ko or vmlinux changed
> >  %.ko: %.o %.mod.o scripts/module.lds $(vmlinux) FORCE
> >       +$(call if_changed_except,ld_ko_o,vmlinux)
>
> This should probably be:
>
>   +$(call if_changed,ld_ko_o)


Right. Thanks for catching it.


>
> > -ifdef vmlinux
> > -     +$(if $(newer-prereqs),$(call cmd,btf_ko))
> > -endif
> >
> >  targets +=3D $(modules:%.o=3D%.ko) $(modules:%.o=3D%.mod.o)
> >
> > --
> > 2.40.1
> >



--=20
Best Regards
Masahiro Yamada

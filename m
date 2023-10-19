Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100DF7D052A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 00:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbjJSWzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 18:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjJSWz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 18:55:29 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFA9D7B;
        Thu, 19 Oct 2023 15:55:05 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507c5249d55so230130e87.3;
        Thu, 19 Oct 2023 15:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697756103; x=1698360903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JApUBgje4/9HqvVQBNMwp81U0zX95uW/eEb26z4ZagE=;
        b=f6is3Dx4TZI/xQPEvd+ufXJhrY70v+bmF2Hd1YxXjRqpsDaEd0BHthLCR+wTwMx0xS
         3xyzj4VReKfy937A+nhL+svxqvQnAVvhkcIH1t2edJ31muFoeJJSNHoC+7zf6S+aPhwJ
         lkQKYTw/QOcki0npLKIeEgLvogOoaLTcY9lzF4ElZ9busE92jBNOl1qfd5UWLHmh//gP
         MdYeBq8namvOPimEGIPiP5T0ZirInEgc73Y5jiaq6FuetSzjhAbvDDD+QtuDyVsSm28h
         vG/BLJnUc+oR0T/jXeN3thpi46WpOD/tttsZaYRK/m4ET8l/TLhoBQbJFDV7igr5pgY6
         5bhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697756103; x=1698360903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JApUBgje4/9HqvVQBNMwp81U0zX95uW/eEb26z4ZagE=;
        b=ZH0XnSwvqZuz1a+Zez07OKEQeIzOLm9F3gFIJLLlh9eJ0jbT4Kq9Pg7ZuWjr0930vI
         py/G8XHPtFFucTCtwnQBjvis8RSTOAUZE2XdnWaJxRMHNFTR973uo1+JZL7bMDYtbNlE
         0bA/Wzz4fhcyxZwhD21D2MLPrd+f1sPPXlLDGMuWGS5FAy2kbJVl19WS28EY5atT+9Tf
         ZuQfzrjQCup17xdZBExVSmeY/CK1uceAb6bMboL5hxCaLyhtygfRp2kaMBiD1xVjooHP
         +LOhFOjR4DhFUyfhnbCV4yod3XXmvPWppFJW7e6j2vgIz4JbVn8UeNFnFy67rTLMJvCM
         /8Iw==
X-Gm-Message-State: AOJu0YxomacM/XoWlqt9sFnKypxJXOjnxQcS+WYsBWtjXtAkXPl0hM2P
        7ffw6qEl/LJD6D3577y0U4Sh6yZBxegQAbjPOUd8n21j
X-Google-Smtp-Source: AGHT+IEa1lO4OJKdWw8PpX3iZxSF60jEeW/H6lB2eXd2bt30WvJr+KnKcsrTMmrc8gLeWBj5C/8MHwnnEsc1rvwnRs8=
X-Received: by 2002:ac2:5458:0:b0:503:333e:b387 with SMTP id
 d24-20020ac25458000000b00503333eb387mr56656lfn.41.1697756103345; Thu, 19 Oct
 2023 15:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231018151950.205265-1-masahiroy@kernel.org> <20231018151950.205265-4-masahiroy@kernel.org>
 <ZTDlrkTXnkVN1cff@krava>
In-Reply-To: <ZTDlrkTXnkVN1cff@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 19 Oct 2023 15:54:52 -0700
Message-ID: <CAEf4BzZm4h4q6k9ZhuT5qiWC9PYA+c7XwVFd68iAq4mtMJ-qhw@mail.gmail.com>
Subject: Re: [bpf-next PATCH v2 4/4] kbuild: refactor module BTF rule
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 1:15=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Oct 19, 2023 at 12:19:50AM +0900, Masahiro Yamada wrote:
> > newer_prereqs_except and if_changed_except are ugly hacks of the
> > newer-prereqs and if_changed in scripts/Kbuild.include.
> >
> > Remove.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> > Changes in v2:
> >   - Fix if_changed_except to if_changed
> >
> >  scripts/Makefile.modfinal | 25 ++++++-------------------
> >  1 file changed, 6 insertions(+), 19 deletions(-)
> >
> > diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> > index 9fd7a26e4fe9..fc07854bb7b9 100644
> > --- a/scripts/Makefile.modfinal
> > +++ b/scripts/Makefile.modfinal
> > @@ -19,6 +19,9 @@ vmlinux :=3D
> >  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> >  ifneq ($(wildcard vmlinux),)
> >  vmlinux :=3D vmlinux
> > +cmd_btf =3D ; \
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
>
> nit not sure it's intentional but we no longer display 'BTF [M] ...ko' li=
nes,
> I don't mind not displaying that, but we should mention that in changelog
>

Thanks for spotting this! I think those messages are useful and
important to keep. Masahiro, is it possible to preserve them?


> jirka
>
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
> > -     +$(call if_changed_except,ld_ko_o,vmlinux)
> > -ifdef vmlinux
> > -     +$(if $(newer-prereqs),$(call cmd,btf_ko))
> > -endif
> > +     +$(call if_changed,ld_ko_o)
> >
> >  targets +=3D $(modules:%.o=3D%.ko) $(modules:%.o=3D%.mod.o)
> >
> > --
> > 2.40.1
> >
> >
>

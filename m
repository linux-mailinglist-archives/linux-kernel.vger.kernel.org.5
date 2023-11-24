Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5407F6A60
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 03:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjKXCCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 21:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKXCCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 21:02:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B058D71
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 18:02:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CF9C433C8;
        Fri, 24 Nov 2023 02:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700791358;
        bh=vAEaSRrrunnPXOVy4bsXVdIwG/ogF59c2LODwnQzEt4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=saHSp2NGZSUTai55h6E/zojAAH5KLgETopqUR4weaJMLSG1LQs6NF2IAs0s2/i+22
         UZhSNjk6pzb4sMzNkRdhAVD80mbjyzuOb3IhXglsfSkTeoN9dMBVjV5iFOD9wTYXTP
         gdXoCE1zMrq6Rcz5gQxj0oa+h47Wkyqa7LSuUHwLfMcfG2VUzEYxtQ6ROoaoKcdVR0
         C/K9deOrEhsRI4X5q11x6H4iynQWFHIJuwnonWC8rHjmL9aonwEFNDRT03QgwMDTAT
         3qmptPLoTpSBJhqAV22y3xQToV3Px8XDPGqHx8Wba2nKyXObCQ8DMwrvZPrpWjSAaH
         RNJ66RSsAx2XA==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1f94b07b6b3so934079fac.2;
        Thu, 23 Nov 2023 18:02:37 -0800 (PST)
X-Gm-Message-State: AOJu0Yye6WyQZ+4bEOLdrYylxd/AxbeKVsFGHmEAYQsiK+YABYVONZDr
        /JdBBRdYGRqvecvugjWzbzpJdsx7C1tVuDj+UI0=
X-Google-Smtp-Source: AGHT+IEXLhrYz62zQkNtoO8dCJ28Tw410tNLUfxQpIU86fcJ/umAfhAjdKaOzRXZpNtKM8MrERktOT0JcgBObXR6rrw=
X-Received: by 2002:a05:6870:658d:b0:1f5:c6f9:f4a5 with SMTP id
 fp13-20020a056870658d00b001f5c6f9f4a5mr1266436oab.25.1700791357395; Thu, 23
 Nov 2023 18:02:37 -0800 (PST)
MIME-Version: 1.0
References: <20231122235527.180507-1-kent.overstreet@linux.dev>
In-Reply-To: <20231122235527.180507-1-kent.overstreet@linux.dev>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 24 Nov 2023 11:02:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNASQ+btvNOZ8yU6JLXBHVzPaEwj-7z0_dFouw2EUKd=3uA@mail.gmail.com>
Message-ID: <CAK7LNASQ+btvNOZ8yU6JLXBHVzPaEwj-7z0_dFouw2EUKd=3uA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Allow gcov to be enabled on the command line
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 8:55=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> This allows gcov to be enabled for a particular kernel source
> subdirectory on the command line, without editing makefiles, like so:
>
>   make GCOV_PROFILE_fs_bcachefs=3Dy
>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> Cc: linux-kbuild@vger.kernel.org
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  scripts/Kbuild.include | 10 ++++++++++
>  scripts/Makefile.lib   |  2 +-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index 7778cc97a4e0..5341736f2e30 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -277,3 +277,13 @@ ifneq ($(and $(filter notintermediate, $(.FEATURES))=
,$(filter-out 4.4,$(MAKE_VER
>  else
>  .SECONDARY:
>  endif
> +
> + # expand_parents(a/b/c) =3D a/b/c a/b a
> +expand_parents2 =3D $(if $(subst .,,$(1)),$(call expand_parents,$(1)),)
> +expand_parents  =3D $(1) $(call expand_parents2,$(patsubst %/,%,$(dir $(=
1))))
> +
> +# flatten_dirs(a/b/c) =3D a_b_c a_b a
> +flatten_dirs =3D $(subst /,_,$(call expand_parents,$(1)))
> +
> +# eval_vars(X_,a/b/c) =3D $(X_a_b_c) $(X_a_b) $(X_a)
> +eval_vars =3D $(foreach var,$(call flatten_dirs,$(2)),$($(1)$(var)))



I do not like tricky code like this.

Also, with "fs_bcachefs", it is unclear which directory
is enabled.




How about this?



[1] Specify the list of directories by GCOV_PROFILE_DIRS


diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 1a965fe68e01..286a569556b3 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -147,8 +147,12 @@ _cpp_flags     =3D $(KBUILD_CPPFLAGS) $(cppflags-y)
$(CPPFLAGS_$(target-stem).lds)
 # (in this order)
 #
 ifeq ($(CONFIG_GCOV_KERNEL),y)
+ifneq ($(filter $(obj),$(GCOV_PROFILE_DIRS)),)
+export GCOV_PROFILE_SUBDIR :=3D y
+endif
+
 _c_flags +=3D $(if $(patsubst n%,, \
-
$(GCOV_PROFILE_$(basetarget).o)$(GCOV_PROFILE)$(CONFIG_GCOV_PROFILE_ALL)),
\
+
$(GCOV_PROFILE_$(basetarget).o)$(GCOV_PROFILE)$(GCOV_PROFILE_SUBDIR)$(CONFI=
G_GCOV_PROFILE_ALL)),
\
                $(CFLAGS_GCOV))
 endif



Usage:

  $ make GCOV_PROFILE_DIRS=3Dfs/bcachefs

   ->  enable GCOV in fs/bachefs and its subdirectories.

or

  $ make GCOV_PROFILE_DIRS=3D"drivers/gpio drivers/pinctrl"

   -> enable GCOV in drivers/gpio, drivers/pinctrl, and their subdirectorie=
s.




[2] Do equivalent, but from a CONFIG option


config GCOV_PROFILE_DIRS
      string "Directories to enable GCOV"


Then, you can set CONFIG_GCOV_PROFILE_DIRS=3D"fs/bcachefs"


This might be a more natural approach because we already have
CONFIG_GCOV_PROFILE_ALL, although it might eventually go away
because CONFIG_GCOV_PROFILE_ALL=3Dy is almost equivalent to
CONFIG_GCOV_PROFILE_DIRS=3D"."




diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 1a965fe68e01..286a569556b3 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -147,8 +147,12 @@ _cpp_flags     =3D $(KBUILD_CPPFLAGS) $(cppflags-y)
$(CPPFLAGS_$(target-stem).lds)
 # (in this order)
 #
 ifeq ($(CONFIG_GCOV_KERNEL),y)
+ifneq ($(filter $(obj),$(CONFIG_GCOV_PROFILE_DIRS)),)
+export GCOV_PROFILE_SUBDIR :=3D y
+endif
+
 _c_flags +=3D $(if $(patsubst n%,, \
-
$(GCOV_PROFILE_$(basetarget).o)$(GCOV_PROFILE)$(CONFIG_GCOV_PROFILE_ALL)),
\
+
$(GCOV_PROFILE_$(basetarget).o)$(GCOV_PROFILE)$(GCOV_PROFILE_SUBDIR)$(CONFI=
G_GCOV_PROFILE_ALL)),
\
                $(CFLAGS_GCOV))
 endif







> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 1a965fe68e01..0b4581a8bc33 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -148,7 +148,7 @@ _cpp_flags     =3D $(KBUILD_CPPFLAGS) $(cppflags-y) $=
(CPPFLAGS_$(target-stem).lds)
>  #
>  ifeq ($(CONFIG_GCOV_KERNEL),y)
>  _c_flags +=3D $(if $(patsubst n%,, \
> -               $(GCOV_PROFILE_$(basetarget).o)$(GCOV_PROFILE)$(CONFIG_GC=
OV_PROFILE_ALL)), \
> +               $(GCOV_PROFILE_$(basetarget).o)$(call eval_vars,GCOV_PROF=
ILE_,$(src))$(GCOV_PROFILE)$(CONFIG_GCOV_PROFILE_ALL)), \
>                 $(CFLAGS_GCOV))
>  endif
>
> --
> 2.42.0
>


--
Best Regards
Masahiro Yamada

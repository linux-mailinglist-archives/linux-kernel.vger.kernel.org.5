Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70057F8E40
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 20:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjKYT4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 14:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKYT4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 14:56:19 -0500
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [IPv6:2001:41d0:1004:224b::aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242DAD3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 11:56:25 -0800 (PST)
Date:   Sat, 25 Nov 2023 14:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700942183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yo+m6dTGrzcH0zVhx/EUgCNWh3lQ29xIfd4T/sQd3P0=;
        b=Nzd82LseHWt2CYxnwyxSxGn1BUyNx/pIL4cFvsZAMp8gLj333tj6FiUJqXdPn2GNnzYP0v
        Tcl4sV1BGZLWU0bYPHKpAoTvVOx+FYH5nVQQoDfC0QbjSdxoQOhj3bH2EIWalBxjT/Za0G
        smobkRXnG6VMGemRkjzlIXLHXGiNkRE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] kbuild: Allow gcov to be enabled on the command line
Message-ID: <20231125195620.rjgkooixugucv2vp@moria.home.lan>
References: <20231122235527.180507-1-kent.overstreet@linux.dev>
 <CAK7LNASQ+btvNOZ8yU6JLXBHVzPaEwj-7z0_dFouw2EUKd=3uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNASQ+btvNOZ8yU6JLXBHVzPaEwj-7z0_dFouw2EUKd=3uA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 11:02:00AM +0900, Masahiro Yamada wrote:
> On Thu, Nov 23, 2023 at 8:55 AM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > This allows gcov to be enabled for a particular kernel source
> > subdirectory on the command line, without editing makefiles, like so:
> >
> >   make GCOV_PROFILE_fs_bcachefs=y
> >
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Nicolas Schier <nicolas@fjasle.eu>
> > Cc: linux-kbuild@vger.kernel.org
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > ---
> >  scripts/Kbuild.include | 10 ++++++++++
> >  scripts/Makefile.lib   |  2 +-
> >  2 files changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> > index 7778cc97a4e0..5341736f2e30 100644
> > --- a/scripts/Kbuild.include
> > +++ b/scripts/Kbuild.include
> > @@ -277,3 +277,13 @@ ifneq ($(and $(filter notintermediate, $(.FEATURES)),$(filter-out 4.4,$(MAKE_VER
> >  else
> >  .SECONDARY:
> >  endif
> > +
> > + # expand_parents(a/b/c) = a/b/c a/b a
> > +expand_parents2 = $(if $(subst .,,$(1)),$(call expand_parents,$(1)),)
> > +expand_parents  = $(1) $(call expand_parents2,$(patsubst %/,%,$(dir $(1))))
> > +
> > +# flatten_dirs(a/b/c) = a_b_c a_b a
> > +flatten_dirs = $(subst /,_,$(call expand_parents,$(1)))
> > +
> > +# eval_vars(X_,a/b/c) = $(X_a_b_c) $(X_a_b) $(X_a)
> > +eval_vars = $(foreach var,$(call flatten_dirs,$(2)),$($(1)$(var)))
> 
> 
> 
> I do not like tricky code like this.
> 
> Also, with "fs_bcachefs", it is unclear which directory
> is enabled.

It's consistent with how we can specify options in makefiles for a
particular file.

I suppose CONFIG_GCOV_PROFILE_DIRS would be fine, but your patch isn't
complete so I can't test it.


> 
> 
> 
> 
> How about this?
> 
> 
> 
> [1] Specify the list of directories by GCOV_PROFILE_DIRS
> 
> 
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 1a965fe68e01..286a569556b3 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -147,8 +147,12 @@ _cpp_flags     = $(KBUILD_CPPFLAGS) $(cppflags-y)
> $(CPPFLAGS_$(target-stem).lds)
>  # (in this order)
>  #
>  ifeq ($(CONFIG_GCOV_KERNEL),y)
> +ifneq ($(filter $(obj),$(GCOV_PROFILE_DIRS)),)
> +export GCOV_PROFILE_SUBDIR := y
> +endif
> +
>  _c_flags += $(if $(patsubst n%,, \
> -
> $(GCOV_PROFILE_$(basetarget).o)$(GCOV_PROFILE)$(CONFIG_GCOV_PROFILE_ALL)),
> \
> +
> $(GCOV_PROFILE_$(basetarget).o)$(GCOV_PROFILE)$(GCOV_PROFILE_SUBDIR)$(CONFIG_GCOV_PROFILE_ALL)),
> \
>                 $(CFLAGS_GCOV))
>  endif
> 
> 
> 
> Usage:
> 
>   $ make GCOV_PROFILE_DIRS=fs/bcachefs
> 
>    ->  enable GCOV in fs/bachefs and its subdirectories.
> 
> or
> 
>   $ make GCOV_PROFILE_DIRS="drivers/gpio drivers/pinctrl"
> 
>    -> enable GCOV in drivers/gpio, drivers/pinctrl, and their subdirectories.
> 
> 
> 
> 
> [2] Do equivalent, but from a CONFIG option
> 
> 
> config GCOV_PROFILE_DIRS
>       string "Directories to enable GCOV"
> 
> 
> Then, you can set CONFIG_GCOV_PROFILE_DIRS="fs/bcachefs"
> 
> 
> This might be a more natural approach because we already have
> CONFIG_GCOV_PROFILE_ALL, although it might eventually go away
> because CONFIG_GCOV_PROFILE_ALL=y is almost equivalent to
> CONFIG_GCOV_PROFILE_DIRS="."
> 
> 
> 
> 
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 1a965fe68e01..286a569556b3 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -147,8 +147,12 @@ _cpp_flags     = $(KBUILD_CPPFLAGS) $(cppflags-y)
> $(CPPFLAGS_$(target-stem).lds)
>  # (in this order)
>  #
>  ifeq ($(CONFIG_GCOV_KERNEL),y)
> +ifneq ($(filter $(obj),$(CONFIG_GCOV_PROFILE_DIRS)),)
> +export GCOV_PROFILE_SUBDIR := y
> +endif
> +
>  _c_flags += $(if $(patsubst n%,, \
> -
> $(GCOV_PROFILE_$(basetarget).o)$(GCOV_PROFILE)$(CONFIG_GCOV_PROFILE_ALL)),
> \
> +
> $(GCOV_PROFILE_$(basetarget).o)$(GCOV_PROFILE)$(GCOV_PROFILE_SUBDIR)$(CONFIG_GCOV_PROFILE_ALL)),
> \
>                 $(CFLAGS_GCOV))
>  endif
> 
> 
> 
> 
> 
> 
> 
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 1a965fe68e01..0b4581a8bc33 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -148,7 +148,7 @@ _cpp_flags     = $(KBUILD_CPPFLAGS) $(cppflags-y) $(CPPFLAGS_$(target-stem).lds)
> >  #
> >  ifeq ($(CONFIG_GCOV_KERNEL),y)
> >  _c_flags += $(if $(patsubst n%,, \
> > -               $(GCOV_PROFILE_$(basetarget).o)$(GCOV_PROFILE)$(CONFIG_GCOV_PROFILE_ALL)), \
> > +               $(GCOV_PROFILE_$(basetarget).o)$(call eval_vars,GCOV_PROFILE_,$(src))$(GCOV_PROFILE)$(CONFIG_GCOV_PROFILE_ALL)), \
> >                 $(CFLAGS_GCOV))
> >  endif
> >
> > --
> > 2.42.0
> >
> 
> 
> --
> Best Regards
> Masahiro Yamada

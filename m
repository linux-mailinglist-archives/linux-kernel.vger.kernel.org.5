Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE43750DCC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjGLQPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjGLQPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:15:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E292113;
        Wed, 12 Jul 2023 09:15:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A69BA21BF6;
        Wed, 12 Jul 2023 16:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689178516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f+VBw2m9h9l7vvxNuxZsgOqUhypJ0WlLLP87GhZA5AE=;
        b=YSLsdtwZOTkfjqynfuSJKj0gvd2emXLtxf244R7bExDlFjBODop+V8pZdCoMtk800ot5y1
        IGAvjy7xx0LDVfROul9MHc86uhCeGeOVSAjpJXts4n94xNKWkujab22FoWM4Ca8MYoluC9
        Ef0qK/McyteLSd3OpzeyQQ3kNOnMbQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689178516;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f+VBw2m9h9l7vvxNuxZsgOqUhypJ0WlLLP87GhZA5AE=;
        b=AcDoY21OwDC41DctUXzxwi968x4MBiI1tUbqoCeoJ+0xifX83UAemuQdYknb8NdNbQLf4n
        wR+GMtS7/uRYYCBw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 37BFD2C142;
        Wed, 12 Jul 2023 16:15:16 +0000 (UTC)
Date:   Wed, 12 Jul 2023 18:15:15 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2--to=linux-modules@vger.kernel.org] depmod: Handle
 installing modules under a prefix
Message-ID: <20230712161515.GH9196@kitsune.suse.cz>
References: <da2fdd15-fae1-2bf6-04e7-568c715372ce@kernel.org>
 <20230712134533.4419-1-msuchanek@suse.de>
 <CAK7LNATRikmr5bO9WvWAvqHFmkv1sqAPY_WouXb4+6HCTj56MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNATRikmr5bO9WvWAvqHFmkv1sqAPY_WouXb4+6HCTj56MQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 11:14:33PM +0900, Masahiro Yamada wrote:
> On Wed, Jul 12, 2023 at 10:45 PM Michal Suchanek <msuchanek@suse.de> wrote:
> >
> > Some distributions aim at not shipping any files in / ustside of usr.
> >
> > The path under which kernel modules are instaleld is hardcoded to /lib
> > which conflicts with this goal.
> >
> > When kmod provides the config command use it to determine the correct
> > module installation prefix.
> >
> > On kmod that does not provide the command / is used as before.
> >
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> > v2: Avoid error on systems with kmod that does not support config
> > command
> > ---
> >  Makefile          | 4 +++-
> >  scripts/depmod.sh | 8 ++++----
> >  2 files changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 47690c28456a..b1fea135bdec 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1165,7 +1165,9 @@ export INSTALL_DTBS_PATH ?= $(INSTALL_PATH)/dtbs/$(KERNELRELEASE)
> >  # makefile but the argument can be passed to make if needed.
> >  #
> >
> > -MODLIB = $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
> > +export KERNEL_MODULE_PREFIX := $(shell kmod config &> /dev/null && kmod config | jq -r .module_prefix)
> > +
> > +MODLIB = $(INSTALL_MOD_PATH)$(KERNEL_MODULE_PREFIX)/lib/modules/$(KERNELRELEASE)
> 
> You can do "make modules_install INSTALL_MOD_PATH=/usr/what/ever/prefix"
> 
> This patch is unneeded.

It's very much needed.

INSTALL_MOD_PATH is temporary staging location, KERNEL_MODULE_PREFIX is
permanent prefix under which modules are searched.

Note that depmod.sh does not use INSTALL_MOD_PATH but uses
KERNEL_MODULE_PREFIX.

Support for this is added by the corresponding kmod patchset.

Thanks

Michal

> >  export MODLIB
> >
> >  PHONY += prepare0
> > diff --git a/scripts/depmod.sh b/scripts/depmod.sh
> > index 3643b4f896ed..88ac79056153 100755
> > --- a/scripts/depmod.sh
> > +++ b/scripts/depmod.sh
> > @@ -27,16 +27,16 @@ fi
> >  # numbers, so we cheat with a symlink here
> >  depmod_hack_needed=true
> >  tmp_dir=$(mktemp -d ${TMPDIR:-/tmp}/depmod.XXXXXX)
> > -mkdir -p "$tmp_dir/lib/modules/$KERNELRELEASE"
> > +mkdir -p "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELEASE"
> >  if "$DEPMOD" -b "$tmp_dir" $KERNELRELEASE 2>/dev/null; then
> > -       if test -e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep" -o \
> > -               -e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep.bin"; then
> > +       if test -e "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELEASE/modules.dep" -o \
> > +               -e "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELEASE/modules.dep.bin"; then
> >                 depmod_hack_needed=false
> >         fi
> >  fi
> >  rm -rf "$tmp_dir"
> >  if $depmod_hack_needed; then
> > -       symlink="$INSTALL_MOD_PATH/lib/modules/99.98.$KERNELRELEASE"
> > +       symlink="$INSTALL_MOD_PATH$KERNEL_MODULE_PREFIX/lib/modules/99.98.$KERNELRELEASE"
> >         ln -s "$KERNELRELEASE" "$symlink"
> >         KERNELRELEASE=99.98.$KERNELRELEASE
> >  fi
> > --
> > 2.41.0
> >
> 
> 
> -- 
> Best Regards
> Masahiro Yamada

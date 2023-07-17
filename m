Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04987755FE1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjGQJzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjGQJzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:55:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D7FA4;
        Mon, 17 Jul 2023 02:55:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BB7151FDA3;
        Mon, 17 Jul 2023 09:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689587707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ub6zKftxyswbzUc6/AnmLN/Hbu+WZuoH0MTrKz0mak=;
        b=C+RQa/Wpb5MZ0ITVMY9apHJMpsYZ5j7/fv27fsG/q29wKfB/jQxnJqbpCkauWdY7zAPd8S
        MCBy8Ho0qR35qW4degM1QF/mIkHp7AHBVhiXAEenZ6HVf273fErNAIUFMXMGIIyHQ+8fgB
        xLLTIJ+8PhEk2ldSGK7hiQXdBttlwiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689587707;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ub6zKftxyswbzUc6/AnmLN/Hbu+WZuoH0MTrKz0mak=;
        b=7QoGk6MWMVh2glt+niGVtmrZ0c3GtqZR5hFAGtxRcNvnZPDJTiK23DcK5w9I7peNTL5rIZ
        QveiqDjo1W/GyzAQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 729DC2C142;
        Mon, 17 Jul 2023 09:55:07 +0000 (UTC)
Date:   Mon, 17 Jul 2023 11:55:06 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal =?utf-8?B?S291dG7vv70=?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] depmod: Handle installing modules under a prefix
Message-ID: <20230717095506.GR9196@kitsune.suse.cz>
References: <20230714143002.GL9196@kitsune.suse.cz>
 <ZLFhuf95srX2wvJc@fjasle.eu>
 <20230714151042.GN9196@kitsune.suse.cz>
 <ZLGj4Bl9bsQ1g1Cu@fjasle.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZLGj4Bl9bsQ1g1Cu@fjasle.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 09:37:04PM +0200, Nicolas Schier wrote:
> On Fri, Jul 14, 2023 at 05:10:42PM +0200 Michal Suchánek wrote:
> > On Fri, Jul 14, 2023 at 04:54:49PM +0200, Nicolas Schier wrote:
> > > On Fri, Jul 14, 2023 at 04:30:02PM +0200, Michal Such�nek wrote:
> > > > Hello,
> > > > 
> > > > On Fri, Jul 14, 2023 at 04:05:10PM +0200, Nicolas Schier wrote:
> > > > > On Fri, Jul 14, 2023 at 02:21:08PM +0200 Michal Suchanek wrote:
> > > > > > Some distributions aim at not shipping any files in / outside of usr.
> > > > > 
> > > > > For me, preventing negation often makes things easier, e.g.: "... aim at
> > > > > shipping files only below /usr".
> > > > > 
> > > > > > 
> > > > > > The path under which kernel modules are installed is hardcoded to /lib
> > > > > > which conflicts with this goal.
> > > > > > 
> > > > > > When kmod provides the config command, use it to determine the correct
> > > > > > module installation prefix.
> > > > > > 
> > > > > > This is a prefix under which the modules are searched by kmod on the
> > > > > > system, and is separate from the temporary staging location already
> > > > > > supported by INSTALL_MOD_PATH.
> > > > > > 
> > > > > > With kmod that does not provide the config command empty prefix is used
> > > > > > as before.
> > > > > > 
> > > > > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > > > > ---
> > > > > > v2: Avoid error on systems with kmod that does not support config
> > > > > > command
> > > > > > v3: More verbose commit message
> > > > > > ---
> > > > > >  Makefile          | 4 +++-
> > > > > >  scripts/depmod.sh | 8 ++++----
> > > > > >  2 files changed, 7 insertions(+), 5 deletions(-)
> > > > > > 
> > > > > > diff --git a/Makefile b/Makefile
> > > > > > index 47690c28456a..b1fea135bdec 100644
> > > > > > --- a/Makefile
> > > > > > +++ b/Makefile
> > > > > > @@ -1165,7 +1165,9 @@ export INSTALL_DTBS_PATH ?= $(INSTALL_PATH)/dtbs/$(KERNELRELEASE)
> > > > > >  # makefile but the argument can be passed to make if needed.
> > > > > >  #
> > > > > >  
> > > > > > -MODLIB	= $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
> > > > > > +export KERNEL_MODULE_PREFIX := $(shell kmod config &> /dev/null && kmod config | jq -r .module_prefix)
> 
> oh, should this be 'jq -r .prefix' (w/o ".module") to match your other patches?

No, this aligns perfectly fine, prefix is where kmod is installed.

> 
> > > > > 
> > > > > All other calls of `jq` that I could find are located at tools/; as this here
> > > > > is evaluated on each invocation, this should probably be documented in
> > > > > Documentation/process/changes.rst?
> > > > > 
> > > > > (Absence of `jq` will cause error messages, even with CONFIG_MODULES=n.)
> > > > 
> > > > That's a good point.
> > > > 
> > > > > 
> > > > > > +
> > > > > > +MODLIB	= $(INSTALL_MOD_PATH)$(KERNEL_MODULE_PREFIX)/lib/modules/$(KERNELRELEASE)
> > > > > >  export MODLIB
> > > > > >  
> > > > > >  PHONY += prepare0
> > > > > > diff --git a/scripts/depmod.sh b/scripts/depmod.sh
> > > > > > index 3643b4f896ed..88ac79056153 100755
> > > > > > --- a/scripts/depmod.sh
> > > > > > +++ b/scripts/depmod.sh
> > > > > > @@ -27,16 +27,16 @@ fi
> > > > > >  # numbers, so we cheat with a symlink here
> > > > > >  depmod_hack_needed=true
> > > > > >  tmp_dir=$(mktemp -d ${TMPDIR:-/tmp}/depmod.XXXXXX)
> > > > > > -mkdir -p "$tmp_dir/lib/modules/$KERNELRELEASE"
> > > > > > +mkdir -p "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELEASE"
> > > > > >  if "$DEPMOD" -b "$tmp_dir" $KERNELRELEASE 2>/dev/null; then
> > > > > > -	if test -e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep" -o \
> > > > > > -		-e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep.bin"; then
> > > > > > +	if test -e "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELEASE/modules.dep" -o \
> > > > > > +		-e "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELEASE/modules.dep.bin"; then
> > > > > >  		depmod_hack_needed=false
> > > > > >  	fi
> > > > > >  fi
> > > > > 
> > > > > I'd like to come back to the statement from Masahiro: Is the check above,
> > > > > against some very old versions of depmod [1], the only reason for this patch?  
> > > > > 
> > > > > If we could remove that, would
> > > > > 
> > > > >     make INSTALL_MOD_PATH="$(kmod config | jq -r .module_prefix)" modules_install
> > > > > 
> > > > > be sufficient?
> > > > 
> > > > No, the INSTALL_MOD_PATH is passed as the -b argument to depmod while
> > > > the newly added part is not because it's integral part of where the
> > > > modules are installed on the system, and not the staging area path.
> > > 
> > > Ah, thanks.  So just for my understanding, could this be a (non-gentle)
> > > alternative version of your patch, w/o modifying top-level Makefile?
> > > 
> > > diff --git a/scripts/depmod.sh b/scripts/depmod.sh
> > > index 3643b4f896ed..72c819de0669 100755
> > > --- a/scripts/depmod.sh
> > > +++ b/scripts/depmod.sh
> > > @@ -1,4 +1,4 @@
> > > -#!/bin/sh
> > > +#!/bin/bash
> > >  # SPDX-License-Identifier: GPL-2.0
> > >  #
> > >  # A depmod wrapper used by the toplevel Makefile
> > > @@ -23,6 +23,8 @@ if [ -z $(command -v $DEPMOD) ]; then
> > >         exit 0
> > >  fi
> > >  
> > > +kmod_version=$(( $(kmod --version | sed -rne 's/^kmod version ([0-9]+).*$/\1/p') ))
> > > +
> > >  # older versions of depmod require the version string to start with three
> > >  # numbers, so we cheat with a symlink here
> > >  depmod_hack_needed=true
> > > @@ -35,6 +37,13 @@ if "$DEPMOD" -b "$tmp_dir" $KERNELRELEASE 2>/dev/null; then
> > >         fi
> > >  fi
> > >  rm -rf "$tmp_dir"
> > > +
> > > +if [ "${kmod_version}" -gt 32 ]; then
> > > +       kmod_prefix="$(kmod config | jq -r .module_prefix)"
> > > +       INSTALL_MOD_PATH="${INSTALL_MOD_PATH#${kmod_prefix}"
> > > +       depmod_hack_needed=false
> > > +fi
> > > +
> > >  if $depmod_hack_needed; then
> > >         symlink="$INSTALL_MOD_PATH/lib/modules/99.98.$KERNELRELEASE"
> > >         ln -s "$KERNELRELEASE" "$symlink"
> > > 
> > > (untested, and assuming that kmod module prefix is in kmod >= 32)
> > 
> > It can be detected by running the 'kmod config' command first and
> > ignoring the output when it fails which the above patch already did.
> > The version check does not sound very reliable.
> > 
> > > Or are I am still missing something?
> > 
> > MODLIB still needs to include the extra prefix so that files are
> > installed in the correct location. And that's defined in the toplevel
> > Makefile.
> 
> Well, I think that depends.  Technically, you are right; and if we want
> to support system with a non-empty kmod prefix fully transparently, then
> patching top-level Makefile will probably be necessary.  
> 
> As for me, I am not convinced yet, that the fully transparent way to support
> PREFIX/lib/modules/ is the best way forward.  I think it might be better to
> first only make script/depmod.sh fit for a kmod prefix and require an adjusted
> INSTALL_MOD_PATH for modules_install.

Nevermind, I will update the patch to change the whole path. That will
make it crystal clear that no amount of fiddling with INSTALL_MOD_PATH
will work.

> Which concrete distributions did you have in mind while composing the patches?

If you STFW for usrmerge you can find that a number of distributions is
in different stages of experimenting with packing all shipped files into
/usr.

In the early experiment stages when the distribution is built with /lib
/bin, and /sbin in place and massaged after the fact to remove these
directories it does not matter much where files were installed
initially.

In later stages when the distribution is built without these extra
directories they are missing in the staging area for building packages,
and creating them is an error because files in these directories are not
to be shipped in packages. At this point the kernel insisting that
modules must be in /lib is sticking out like a sore thumb, it's on every
system.

Sure, there is a number of hacks that can be used to work around the
problem. Still it's a problem the needs to be addressed for usrmerge to
fully work.

openSUSE is maybe 75% there - it's nowhere near complete but the
packages that insist on using these directories outside of /usr are
becoming problematic.

Thanks

Michal

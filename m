Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC98753D75
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbjGNObC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbjGNOax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:30:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A917D30EA;
        Fri, 14 Jul 2023 07:30:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1C6D51F86B;
        Fri, 14 Jul 2023 14:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689345004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y14rSYrst8SWS4wBVC5PpuZDd39vrZwzRhMWnB9wDeY=;
        b=KV7DaU4ndwCCQDDq9fydyZw+cqcUGm8lQUTWzXxBHF1P5Qp61uiuA0kdVjGyI5Yz2gQIec
        MacCyRtK2I50K86ahYDlTocAxFnk4E8bAQrzzKQTH88oTY+Eq5Z211YmAN7Jv0wYa2KsMW
        3UAsHBeePqPxlS9SenPa6e//84/v9Wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689345004;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y14rSYrst8SWS4wBVC5PpuZDd39vrZwzRhMWnB9wDeY=;
        b=55BwZG76jtRILoZddAJb4ICMqiaB0/z1VqBgGPVXiPAfahcdxIEbKjaBnlAl9jo7BmIlDy
        59mIZHTXlcmZR5AA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CC4E02C142;
        Fri, 14 Jul 2023 14:30:03 +0000 (UTC)
Date:   Fri, 14 Jul 2023 16:30:02 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] depmod: Handle installing modules under a prefix
Message-ID: <20230714143002.GL9196@kitsune.suse.cz>
References: <30d8c675-e769-e567-a81f-c1b59c66ad67@suse.com>
 <20230714122111.7528-1-msuchanek@suse.de>
 <ZLFWFoDHcvLGoUuv@fjasle.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLFWFoDHcvLGoUuv@fjasle.eu>
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

Hello,

On Fri, Jul 14, 2023 at 04:05:10PM +0200, Nicolas Schier wrote:
> On Fri, Jul 14, 2023 at 02:21:08PM +0200 Michal Suchanek wrote:
> > Some distributions aim at not shipping any files in / outside of usr.
> 
> For me, preventing negation often makes things easier, e.g.: "... aim at
> shipping files only below /usr".
> 
> > 
> > The path under which kernel modules are installed is hardcoded to /lib
> > which conflicts with this goal.
> > 
> > When kmod provides the config command, use it to determine the correct
> > module installation prefix.
> > 
> > This is a prefix under which the modules are searched by kmod on the
> > system, and is separate from the temporary staging location already
> > supported by INSTALL_MOD_PATH.
> > 
> > With kmod that does not provide the config command empty prefix is used
> > as before.
> > 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> > v2: Avoid error on systems with kmod that does not support config
> > command
> > v3: More verbose commit message
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
> > -MODLIB	= $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
> > +export KERNEL_MODULE_PREFIX := $(shell kmod config &> /dev/null && kmod config | jq -r .module_prefix)
> 
> All other calls of `jq` that I could find are located at tools/; as this here
> is evaluated on each invocation, this should probably be documented in
> Documentation/process/changes.rst?
> 
> (Absence of `jq` will cause error messages, even with CONFIG_MODULES=n.)

That's a good point.

> 
> > +
> > +MODLIB	= $(INSTALL_MOD_PATH)$(KERNEL_MODULE_PREFIX)/lib/modules/$(KERNELRELEASE)
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
> > -	if test -e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep" -o \
> > -		-e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep.bin"; then
> > +	if test -e "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELEASE/modules.dep" -o \
> > +		-e "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELEASE/modules.dep.bin"; then
> >  		depmod_hack_needed=false
> >  	fi
> >  fi
> 
> I'd like to come back to the statement from Masahiro: Is the check above,
> against some very old versions of depmod [1], the only reason for this patch?  
> 
> If we could remove that, would
> 
>     make INSTALL_MOD_PATH="$(kmod config | jq -r .module_prefix)" modules_install
> 
> be sufficient?

No, the INSTALL_MOD_PATH is passed as the -b argument to depmod while
the newly added part is not because it's integral part of where the
modules are installed on the system, and not the staging area path.

> 
> Kind regards,
> Nicolas
> 
> 
> [1]: https://lore.kernel.org/linux-kbuild/1307631448-29848-5-git-send-email-mmarek@suse.cz/

Was busybox ever fixed to not require the hack?

Thanks

Michal

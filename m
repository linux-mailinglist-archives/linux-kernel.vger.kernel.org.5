Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B1C753D96
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236051AbjGNOfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236075AbjGNOfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:35:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3734330F8;
        Fri, 14 Jul 2023 07:34:48 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EAEA01F747;
        Fri, 14 Jul 2023 14:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689345286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1XAhxBqyavPKKiCIsZyWgV67fhIxl0ST4aikj1J+tkI=;
        b=ZsM4+BcFWVLl/wAs4b/YLl068yXfKEFNzT435VUO9+J1i4LePJoLWQHjfLAI4pyN2kVqzb
        lozi3PZ+MfAmK4vzdRJL0uwX1gIsKRuTHcxahecc0AoHAukPkhzQJo2rMCQZxa3ODgiJEP
        O1Fec9Yb9F6Wj0Bxtf8YBe9Fk4UrPcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689345286;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1XAhxBqyavPKKiCIsZyWgV67fhIxl0ST4aikj1J+tkI=;
        b=s7HPsZbFrKx5gTQ3CHN/4oZJwqknSsvrsIMSLPA27f7S7lna7b9W/b9ATcCMj74lopGI1C
        HxVexwa8tm3OChDw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AC53A2C142;
        Fri, 14 Jul 2023 14:34:46 +0000 (UTC)
Date:   Fri, 14 Jul 2023 16:34:45 +0200
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
Subject: Re: [PATCH kmod v2 2/4] libkmod, depmod: Load modprobe.d, depmod.d
 from $prefix/lib.
Message-ID: <20230714143445.GM9196@kitsune.suse.cz>
References: <20230711153126.28876-1-msuchanek@suse.de>
 <20230712140103.5468-2-msuchanek@suse.de>
 <ZLFYzDyjP8sQPQOy@fjasle.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLFYzDyjP8sQPQOy@fjasle.eu>
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

On Fri, Jul 14, 2023 at 04:16:44PM +0200, Nicolas Schier wrote:
> On Wed, Jul 12, 2023 at 04:00:46PM +0200 Michal Suchanek wrote:
> > There is an ongoing effort to limit use of files outside of /usr (or
> > $prefix on general). Currently all modprobe.d paths are hardcoded to
> > outside of $prefix. Teach kmod to load modprobe.d from $prefix/lib.
> > 
> > On some distributions /usr/lib and /lib are the same directory because
> > of a compatibility symlink, and it is possible to craft configuration
> > files with sideeffects that would behave differently when loaded twice.
> > However, the override semantic ensures that one 'overrides' the other,
> > and only one configuration file of the same name is loaded from any of
> > the search directories.
> > 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> > v2: Fix commit message typo
> > ---
> >  Makefile.am        | 1 +
> >  libkmod/libkmod.c  | 3 ++-
> >  man/Makefile.am    | 9 +++++++--
> >  man/depmod.d.xml   | 1 +
> >  man/modprobe.d.xml | 1 +
> >  tools/depmod.c     | 1 +
> >  6 files changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Makefile.am b/Makefile.am
> > index 8ba85c91a0f3..7aa5bfa5638d 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -19,6 +19,7 @@ AM_CPPFLAGS = \
> >  	-include $(top_builddir)/config.h \
> >  	-I$(top_srcdir) \
> >  	-DSYSCONFDIR=\""$(sysconfdir)"\" \
> > +	-DPREFIX=\""$(prefix)"\" \
> >  	${zlib_CFLAGS}
> >  
> >  AM_CFLAGS = $(OUR_CFLAGS)
> > diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
> > index 2670f9a4611a..13c82b069e84 100644
> > --- a/libkmod/libkmod.c
> > +++ b/libkmod/libkmod.c
> > @@ -65,6 +65,7 @@ static const char *const default_config_paths[] = {
> >  	SYSCONFDIR "/modprobe.d",
> >  	"/run/modprobe.d",
> >  	"/usr/local/lib/modprobe.d",
> > +	PREFIX "/lib/modprobe.d",
> >  	"/lib/modprobe.d",
> >  	NULL
> >  };
> > @@ -237,7 +238,7 @@ static char *get_kernel_release(const char *dirname)
> >   *                to load from user-defined configuration parameters such as
> >   *                alias, blacklists, commands (install, remove). If NULL
> >   *                defaults to /etc/modprobe.d, /run/modprobe.d,
> > - *                /usr/local/lib/modprobe.d and /lib/modprobe.d. Give an empty
> > + *                /usr/local/lib/modprobe.d and PREFIX/lib/modprobe.d. Give an empty
> 
> In the chunk above, there still is /lib/modprobe.d included in the
> default_config_paths array.

Indeed, if this is rendered as documentation somewhere this would be
misleading.

Thanks

Michal

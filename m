Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6031E757942
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjGRKaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjGRKaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:30:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F831A8;
        Tue, 18 Jul 2023 03:30:02 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C64241FDBD;
        Tue, 18 Jul 2023 10:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689676200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mc7MYWCMdjDk82AAtNUDHoR9pgSZ/a28mairNor7U38=;
        b=c4ounMS2WnnLyLMS4AYpwPWy9xDfyGDL6TPP69XVV4rE/L+jCDp6yzJWcv87HGEvauNYLP
        2uTAVfxxIr5AlQI5UYVrMqamHJVh2jDQIro8tnQrRQkRaztokMh2eCrT+l9es+jVywjlGE
        tX+nEsQWHmQB33K5helobLrAT3+vjNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689676200;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mc7MYWCMdjDk82AAtNUDHoR9pgSZ/a28mairNor7U38=;
        b=Ch8ztUIaKOf8m7xsAk2F9NJUimRMoOZOtDivQyFsh6l8riXlOqLgDTgCNTHtE2uV+TbSl7
        6iOKIjpV7fwt+LCg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4316F2C142;
        Tue, 18 Jul 2023 10:30:00 +0000 (UTC)
Date:   Tue, 18 Jul 2023 12:29:59 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kmod v4 4/4] libkmod, depmod, modprobe: Make directory
 for kernel modules configurable
Message-ID: <20230718102958.GW9196@kitsune.suse.cz>
References: <20230711153126.28876-1-msuchanek@suse.de>
 <cover.1689589902.git.msuchanek@suse.de>
 <cc04472084dc016679598fcffafc788bbb6d9c0f.1689589902.git.msuchanek@suse.de>
 <76o21q7n-8qo8-37p6-oqno-q08nqpos471@vanv.qr>
 <20230718084300.GU9196@kitsune.suse.cz>
 <81n281ns-s8on-rsrn-pp61-q28pn42ns531@vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81n281ns-s8on-rsrn-pp61-q28pn42ns531@vanv.qr>
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

On Tue, Jul 18, 2023 at 11:41:32AM +0200, Jan Engelhardt wrote:
> 
> On Tuesday 2023-07-18 10:43, Michal Suchánek wrote:
> >> >With this distributions that do not want to ship files in /lib can also
> >> >move kernel modules to /usr while others can keep them in /lib.
> >> 
> >> This patch breaks kernel builds/installation / bisecting [when the
> >> system has a kmod ./configure'd --with-module-directory=/usr/lib/modules]
> >
> >It might be nice to provide backwads compatibility with earlier
> >configurations.
> >
> >However, if it comes at the cost of making the implementation more
> >complex and future maintenance more difficult it might not be such a
> >great idea. So far I have not seen a proposal how to do it nicely.
> 
> 
> 
> diff --git a/configure.ac b/configure.ac
> index a195c8e..7fde927 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -84,11 +84,7 @@ AC_ARG_WITH([rootlibdir],
>          [], [with_rootlibdir=$libdir])
>  AC_SUBST([rootlibdir], [$with_rootlibdir])
>  
> -# Ideally this would be $prefix/lib/modules but default to /lib/modules for compatibility with earlier versions
> -AC_ARG_WITH([module_directory],
> -        AS_HELP_STRING([--with-module-directory=DIR], [directory in which to look for kernel modules - typically '/lib/modules' or '${prefix}/lib/modules']),
> -        [], [with_module_directory=/lib/modules])
> -AC_SUBST([module_directory], [$with_module_directory])
> +AC_SUBST([module_directory], [/lib/modules])
>  
>  AC_ARG_WITH([zstd],
>  	AS_HELP_STRING([--with-zstd], [handle Zstandard-compressed modules @<:@default=disabled@:>@]),
> diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
> index 4a4af58..e2f9c95 100644
> --- a/libkmod/libkmod-internal.h
> +++ b/libkmod/libkmod-internal.h
> @@ -199,3 +199,5 @@ void kmod_module_signature_info_free(struct kmod_signature_info *sig_info) __att
>  
>  /* libkmod-builtin.c */
>  ssize_t kmod_builtin_get_modinfo(struct kmod_ctx *ctx, const char *modname, char ***modinfo) __attribute__((nonnull(1, 2, 3)));
> +
> +extern const char *dirname_default_prefix;
> diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
> index d2ed874..b426cde 100644
> --- a/libkmod/libkmod.c
> +++ b/libkmod/libkmod.c
> @@ -209,7 +209,7 @@ static int log_priority(const char *priority)
>  	return 0;
>  }
>  
> -static const char *dirname_default_prefix = MODULE_DIRECTORY;
> +const char *dirname_default_prefix = MODULE_DIRECTORY;
>  
>  static char *get_kernel_release(const char *dirname)
>  {
> diff --git a/tools/depmod.c b/tools/depmod.c
> index 22bc1d8..929060f 100644
> --- a/tools/depmod.c
> +++ b/tools/depmod.c
> @@ -65,6 +65,7 @@ static const struct option cmdopts[] = {
>  	{ "quick", no_argument, 0, 'A' },
>  	{ "basedir", required_argument, 0, 'b' },
>  	{ "outdir", required_argument, 0, 'o' },
> +	{ "modulesdir", required_argument, 0, 'M' },
>  	{ "config", required_argument, 0, 'C' },
>  	{ "symvers", required_argument, 0, 'E' },
>  	{ "filesyms", required_argument, 0, 'F' },
> @@ -2943,6 +2944,9 @@ static int do_depmod(int argc, char *argv[])
>  				free(out_root);
>  			out_root = path_make_absolute_cwd(optarg);
>  			break;
> +		case 'M':
> +			dirname_default_prefix = optarg;
> +			break;
>  		case 'C': {
>  			size_t bytes = sizeof(char *) * (n_config_paths + 2);
>  			void *tmp = realloc(config_paths, bytes);

That breaks kmod for the usrmerged distributions, though.

It might be fine to provide an option to override the build-time
default. Still the build-time default has to match where the modules are
placed in the distribution for things to work correctly out of the box.

Note: it will work either way at the times the module directory can be
accessed through the lib -> usr/lib compatibility symlink. The default
needs to be correct for the cases when the symlink is not provided.

So you could do

make DEPMOD='depmod -M /lib/modules'

to build an old kernel but you could equally do

make DEPMOD='/path/to/special/depmod'

If you needed

make DEPMOD='depmod -M /usr/lib/modules'

to build an usrmerged kernel on usrmerged distribution then this whole
exercise is pointless. kmod cannot find the usrmerged modules then.

Thanks

Michal

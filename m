Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EEE757694
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjGRIcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjGRIcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:32:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068E3E4F;
        Tue, 18 Jul 2023 01:32:14 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D353A1FDBD;
        Tue, 18 Jul 2023 08:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689669132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eXnDRjq3rZ7qAZq+UqMms/Y0vqQUc265PT2KDbm8KQw=;
        b=CYgAngJubicG3ekIqAcCjNcLsdJ77sSkFXuowyNksZI3JcdtCG5NIhlC2aT4zgIkgMR2hG
        VXTS+XRKHz1d/oJZvixClBSkifH3XSU6SorvDR4JXs//9gwuUUEjyQNcqf8AKcei9dGiKn
        Td5BkfSlnJN8ell9QxxgKWPXBMjO+1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689669132;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eXnDRjq3rZ7qAZq+UqMms/Y0vqQUc265PT2KDbm8KQw=;
        b=RsMobXwCvjADUzioLz5t3PXYLHB1kwTTNuEpWAF9wdF1fXZCQNaL1OXC9uEg75/F/Bs+9J
        MXee/YrI/cIY9MAQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 64D4C2C142;
        Tue, 18 Jul 2023 08:32:12 +0000 (UTC)
Date:   Tue, 18 Jul 2023 10:32:11 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kmod v4 4/4] libkmod, depmod, modprobe: Make directory
 for kernel modules configurable
Message-ID: <20230718083211.GT9196@kitsune.suse.cz>
References: <20230711153126.28876-1-msuchanek@suse.de>
 <cover.1689589902.git.msuchanek@suse.de>
 <cc04472084dc016679598fcffafc788bbb6d9c0f.1689589902.git.msuchanek@suse.de>
 <e3aeajf2zmmrbitvwhursyqp7i2j72o4it2xqcvvjiz7j5ay22@4yrg2rfcq2z2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3aeajf2zmmrbitvwhursyqp7i2j72o4it2xqcvvjiz7j5ay22@4yrg2rfcq2z2>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jul 17, 2023 at 05:12:59PM -0300, Lucas De Marchi wrote:
> On Mon, Jul 17, 2023 at 12:39:53PM +0200, Michal Suchanek wrote:
> > modprobe.d is now searched under ${prefix}/lib, add ${module_directory} to
> > specify the directory where to search for kernel modules.
> 
> I was failing to see the relation of modprobe.d with the module
> directory. Maybe reword this slightly?
> 
> Now that modprobe.d is searched under ${prefix}/lib, allow a complete
> transition to files only under ${prefix} by adding a ${module_directory}
> configuration. This specifies the directory where to search for kernel
> modules and should match the location where the kernel/distro installs
> them.
> 
> > 
> > With this distributions that do not want to ship files in /lib can also
> > move kernel modules to /usr while others can keep them in /lib.
> > 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> > v4: Make the whole path configurable
> > ---
> > Makefile.am                          |   3 +-
> > configure.ac                         |   7 ++
> > libkmod/libkmod.c                    |   4 +-
> > man/Makefile.am                      |   1 +
> > man/depmod.d.xml                     |   6 +-
> > man/depmod.xml                       |   4 +-
> > man/modinfo.xml                      |   2 +-
> > man/modprobe.xml                     |   2 +-
> > man/modules.dep.xml                  |   6 +-
> > testsuite/module-playground/Makefile |   2 +-
> > testsuite/setup-rootfs.sh            | 109 +++++++++++++++------------
> > testsuite/test-depmod.c              |  16 ++--
> > testsuite/test-testsuite.c           |   8 +-
> > tools/depmod.c                       |   6 +-
> > tools/kmod.c                         |   1 +
> > tools/modinfo.c                      |   4 +-
> > tools/modprobe.c                     |   4 +-
> > tools/static-nodes.c                 |   6 +-
> > 18 files changed, 107 insertions(+), 84 deletions(-)
> > 
> > diff --git a/Makefile.am b/Makefile.am
> > index 7aa5bfa5638d..981574558c93 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -20,6 +20,7 @@ AM_CPPFLAGS = \
> > 	-I$(top_srcdir) \
> > 	-DSYSCONFDIR=\""$(sysconfdir)"\" \
> > 	-DPREFIX=\""$(prefix)"\" \
> > +	-DMODULE_DIRECTORY=\""$(module_directory)"\" \
> > 	${zlib_CFLAGS}
> > 
> > AM_CFLAGS = $(OUR_CFLAGS)
> > @@ -220,7 +221,7 @@ EXTRA_DIST += testsuite/setup-rootfs.sh
> > MODULE_PLAYGROUND = testsuite/module-playground
> > ROOTFS = testsuite/rootfs
> > ROOTFS_PRISTINE = $(top_srcdir)/testsuite/rootfs-pristine
> > -CREATE_ROOTFS = $(AM_V_GEN) $(top_srcdir)/testsuite/setup-rootfs.sh $(ROOTFS_PRISTINE) $(ROOTFS) $(MODULE_PLAYGROUND) $(top_builddir)/config.h $(sysconfdir)
> > +CREATE_ROOTFS = $(AM_V_GEN) MODULE_DIRECTORY=$(module_directory) $(top_srcdir)/testsuite/setup-rootfs.sh $(ROOTFS_PRISTINE) $(ROOTFS) $(MODULE_PLAYGROUND) $(top_builddir)/config.h $(sysconfdir)
> > 
> > build-module-playground:
> > 	$(AM_V_GEN)if test "$(top_srcdir)" != "$(top_builddir)"; then \
> > diff --git a/configure.ac b/configure.ac
> > index 6064dee77ae6..a195c8e6b554 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -84,6 +84,12 @@ AC_ARG_WITH([rootlibdir],
> >         [], [with_rootlibdir=$libdir])
> > AC_SUBST([rootlibdir], [$with_rootlibdir])
> > 
> > +# Ideally this would be $prefix/lib/modules but default to /lib/modules for compatibility with earlier versions
> > +AC_ARG_WITH([module_directory],
> > +        AS_HELP_STRING([--with-module-directory=DIR], [directory in which to look for kernel modules - typically '/lib/modules' or '${prefix}/lib/modules']),
> > +        [], [with_module_directory=/lib/modules])
> > +AC_SUBST([module_directory], [$with_module_directory])
> > +
> > AC_ARG_WITH([zstd],
> > 	AS_HELP_STRING([--with-zstd], [handle Zstandard-compressed modules @<:@default=disabled@:>@]),
> > 	[], [with_zstd=no])
> > @@ -304,6 +310,7 @@ AC_MSG_RESULT([
> > 	$PACKAGE $VERSION
> > 	=======
> > 
> > +	module_directory:	${module_directory}
> > 	prefix:			${prefix}
> > 	sysconfdir:		${sysconfdir}
> > 	libdir:			${libdir}
> > diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
> > index f3139c1cef97..d2ed8748c833 100644
> > --- a/libkmod/libkmod.c
> > +++ b/libkmod/libkmod.c
> > @@ -209,7 +209,7 @@ static int log_priority(const char *priority)
> > 	return 0;
> > }
> > 
> > -static const char *dirname_default_prefix = "/lib/modules";
> > +static const char *dirname_default_prefix = MODULE_DIRECTORY;
> > 
> > static char *get_kernel_release(const char *dirname)
> > {
> > @@ -231,7 +231,7 @@ static char *get_kernel_release(const char *dirname)
> > /**
> >  * kmod_new:
> >  * @dirname: what to consider as linux module's directory, if NULL
> > - *           defaults to /lib/modules/`uname -r`. If it's relative,
> > + *           defaults to ${module_prefix}/lib/modules/`uname -r`. If it's relative,
> >  *           it's treated as relative to the current working directory.
> >  *           Otherwise, give an absolute dirname.
> >  * @config_paths: ordered array of paths (directories or files) where
> > diff --git a/man/Makefile.am b/man/Makefile.am
> > index ad07c30bbd24..25c2cc6fdf13 100644
> > --- a/man/Makefile.am
> > +++ b/man/Makefile.am
> > @@ -22,6 +22,7 @@ CLEANFILES = $(dist_man_MANS)
> > 	else \
> > 		sed -e '/@PREFIX@/d' $< ; \
> > 	fi | \
> > +	sed -e 's|@MODULE_DIRECTORY@|$(module_directory)|g' | \
> > 	$(XSLT) \
> > 		-o $@ \
> > 		--nonet \
> > diff --git a/man/depmod.d.xml b/man/depmod.d.xml
> > index 431ebca6654b..676977c69a4f 100644
> > --- a/man/depmod.d.xml
> > +++ b/man/depmod.d.xml
> > @@ -70,7 +70,7 @@
> >         </term>
> >         <listitem>
> >           <para>
> > -            This allows you to specify the order in which /lib/modules
> > +            This allows you to specify the order in which @MODULE_DIRECTORY@
> >             (or other configured module location) subdirectories will
> >             be processed by <command>depmod</command>. Directories are
> >             listed in order, with the highest priority given to the
> > @@ -101,7 +101,7 @@
> >             <command>depmod</command> command. It is possible to
> >             specify one kernel or all kernels using the * wildcard.
> >             <replaceable>modulesubdirectory</replaceable> is the
> > -            name of the subdirectory under /lib/modules (or other
> > +            name of the subdirectory under @MODULE_DIRECTORY@ (or other
> >             module location) where the target module is installed.
> >           </para>
> >           <para>
> > @@ -110,7 +110,7 @@
> >             specifying the following command: "override kmod * extra".
> >             This will ensure that any matching module name installed
> >             under the <command>extra</command> subdirectory within
> > -            /lib/modules (or other module location) will take priority
> > +            @MODULE_DIRECTORY@ (or other module location) will take priority
> >             over any likenamed module already provided by the kernel.
> >           </para>
> >         </listitem>
> > diff --git a/man/depmod.xml b/man/depmod.xml
> > index 3b0097184fd7..fce2a4a67a89 100644
> > --- a/man/depmod.xml
> > +++ b/man/depmod.xml
> > @@ -80,7 +80,7 @@
> >     </para>
> >     <para> <command>depmod</command> creates a list of module dependencies by
> >       reading each module under
> > -      <filename>/lib/modules/</filename><replaceable>version</replaceable> and
> > +      <filename>@MODULE_DIRECTORY@/</filename><replaceable>version</replaceable> and
> >       determining what symbols it exports and what symbols it needs.  By
> >       default, this list is written to <filename>modules.dep</filename>, and a
> >       binary hashed version named <filename>modules.dep.bin</filename>, in the
> > @@ -141,7 +141,7 @@
> >         <listitem>
> >           <para>
> >             If your modules are not currently in the (normal) directory
> > -            <filename>/lib/modules/</filename><replaceable>version</replaceable>,
> > +            <filename>@MODULE_DIRECTORY@/</filename><replaceable>version</replaceable>,
> >             but in a staging area, you can specify a
> >             <replaceable>basedir</replaceable> which is prepended to the
> >             directory name.  This <replaceable>basedir</replaceable> is
> > diff --git a/man/modinfo.xml b/man/modinfo.xml
> > index 9fe0324a2527..b6c4d6045829 100644
> > --- a/man/modinfo.xml
> > +++ b/man/modinfo.xml
> > @@ -54,7 +54,7 @@
> >       <command>modinfo</command> extracts information from the Linux Kernel
> >       modules given on the command line.  If the module name is not a filename,
> >       then the
> > -      <filename>/lib/modules/</filename><replaceable>version</replaceable>
> > +      <filename>@MODULE_DIRECTORY@/</filename><replaceable>version</replaceable>
> >       directory is searched, as is also done by
> >       <citerefentry><refentrytitle>modprobe</refentrytitle><manvolnum>8</manvolnum></citerefentry>
> >       when loading kernel modules.
> > diff --git a/man/modprobe.xml b/man/modprobe.xml
> > index 91f9e27997cd..4d1fd59c000b 100644
> > --- a/man/modprobe.xml
> > +++ b/man/modprobe.xml
> > @@ -78,7 +78,7 @@
> >       is no difference between _ and - in module names (automatic
> >       underscore conversion is performed).
> >       <command>modprobe</command> looks in the module directory
> > -      <filename>/lib/modules/`uname -r`</filename> for all
> > +      <filename>@MODULE_DIRECTORY@/`uname -r`</filename> for all
> >       the modules and other files, except for the optional
> >       configuration files in the
> >       <filename>/etc/modprobe.d</filename> directory
> > diff --git a/man/modules.dep.xml b/man/modules.dep.xml
> > index ed633694ec9e..8ef6d8b3536e 100644
> > --- a/man/modules.dep.xml
> > +++ b/man/modules.dep.xml
> > @@ -34,8 +34,8 @@
> >   </refnamediv>
> > 
> >   <refsynopsisdiv>
> > -    <para><filename>/lib/modules/modules.dep</filename></para>
> > -    <para><filename>/lib/modules/modules.dep.bin</filename></para>
> > +    <para><filename>@MODULE_DIRECTORY@/modules.dep</filename></para>
> > +    <para><filename>@MODULE_DIRECTORY@/modules.dep.bin</filename></para>
> >   </refsynopsisdiv>
> > 
> >   <refsect1><title>DESCRIPTION</title>
> > @@ -43,7 +43,7 @@
> >       <filename>modules.dep.bin</filename> is a binary file generated by
> >       <command>depmod</command> listing the dependencies for
> >       every module in the directories under
> > -      <filename>/lib/modules/</filename><replaceable>version</replaceable>.
> > +      <filename>@MODULE_DIRECTORY@/</filename><replaceable>version</replaceable>.
> >       It is used by kmod tools such as <command>modprobe</command> and
> >       libkmod.
> >     </para>
> > diff --git a/testsuite/module-playground/Makefile b/testsuite/module-playground/Makefile
> > index e6045b0dd932..a7ab09bea2bf 100644
> > --- a/testsuite/module-playground/Makefile
> > +++ b/testsuite/module-playground/Makefile
> > @@ -47,7 +47,7 @@ endif
> > 
> > else
> > # normal makefile
> > -KDIR ?= /lib/modules/`uname -r`/build
> > +KDIR ?= $(module_prefix)/lib/modules/`uname -r`/build
> > KVER ?= `uname -r`
> > ifeq ($(FAKE_BUILD),)
> >     FAKE_BUILD=0
> > diff --git a/testsuite/setup-rootfs.sh b/testsuite/setup-rootfs.sh
> > index 4440ddcd6b4d..a780f9381b3c 100755
> > --- a/testsuite/setup-rootfs.sh
> > +++ b/testsuite/setup-rootfs.sh
> > @@ -16,6 +16,19 @@ create_rootfs() {
> > 	cp -r "$ROOTFS_PRISTINE" "$ROOTFS"
> > 	find "$ROOTFS" -type d -exec chmod +w {} \;
> > 	find "$ROOTFS" -type f -name .gitignore -exec rm -f {} \;
> > +	if [ "$MODULE_DIRECTORY" != "/lib/modules" ] ; then
> > +		sed -i -e "s|/lib/modules|$MODULE_DIRECTORY|g" $(find "$ROOTFS" -name \*.txt -o -name \*.conf -o -name \*.dep)
> > +		sed -i -e "s|$MODULE_DIRECTORY/external|/lib/modules/external|g" $(find "$ROOTFS" -name \*.txt -o -name \*.conf -o -name \*.dep)
> 
> why this second sed?

These are 'external' modules not part of a kernel, the absolute path is
used in modules.dep and reported in outputs.

Moving these breaks the tests, and is beside the point.

Thanks

Michal

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C5075784B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjGRJlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjGRJlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:41:42 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4908AE55;
        Tue, 18 Jul 2023 02:41:34 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 11FCF596EFC02; Tue, 18 Jul 2023 11:41:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 0D80360E5C62B;
        Tue, 18 Jul 2023 11:41:32 +0200 (CEST)
Date:   Tue, 18 Jul 2023 11:41:32 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
cc:     linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kmod v4 4/4] libkmod, depmod, modprobe: Make directory
 for kernel modules configurable
In-Reply-To: <20230718084300.GU9196@kitsune.suse.cz>
Message-ID: <81n281ns-s8on-rsrn-pp61-q28pn42ns531@vanv.qr>
References: <20230711153126.28876-1-msuchanek@suse.de> <cover.1689589902.git.msuchanek@suse.de> <cc04472084dc016679598fcffafc788bbb6d9c0f.1689589902.git.msuchanek@suse.de> <76o21q7n-8qo8-37p6-oqno-q08nqpos471@vanv.qr>
 <20230718084300.GU9196@kitsune.suse.cz>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tuesday 2023-07-18 10:43, Michal Suchánek wrote:
>> >With this distributions that do not want to ship files in /lib can also
>> >move kernel modules to /usr while others can keep them in /lib.
>> 
>> This patch breaks kernel builds/installation / bisecting [when the
>> system has a kmod ./configure'd --with-module-directory=/usr/lib/modules]
>
>It might be nice to provide backwads compatibility with earlier
>configurations.
>
>However, if it comes at the cost of making the implementation more
>complex and future maintenance more difficult it might not be such a
>great idea. So far I have not seen a proposal how to do it nicely.



diff --git a/configure.ac b/configure.ac
index a195c8e..7fde927 100644
--- a/configure.ac
+++ b/configure.ac
@@ -84,11 +84,7 @@ AC_ARG_WITH([rootlibdir],
         [], [with_rootlibdir=$libdir])
 AC_SUBST([rootlibdir], [$with_rootlibdir])
 
-# Ideally this would be $prefix/lib/modules but default to /lib/modules for compatibility with earlier versions
-AC_ARG_WITH([module_directory],
-        AS_HELP_STRING([--with-module-directory=DIR], [directory in which to look for kernel modules - typically '/lib/modules' or '${prefix}/lib/modules']),
-        [], [with_module_directory=/lib/modules])
-AC_SUBST([module_directory], [$with_module_directory])
+AC_SUBST([module_directory], [/lib/modules])
 
 AC_ARG_WITH([zstd],
 	AS_HELP_STRING([--with-zstd], [handle Zstandard-compressed modules @<:@default=disabled@:>@]),
diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
index 4a4af58..e2f9c95 100644
--- a/libkmod/libkmod-internal.h
+++ b/libkmod/libkmod-internal.h
@@ -199,3 +199,5 @@ void kmod_module_signature_info_free(struct kmod_signature_info *sig_info) __att
 
 /* libkmod-builtin.c */
 ssize_t kmod_builtin_get_modinfo(struct kmod_ctx *ctx, const char *modname, char ***modinfo) __attribute__((nonnull(1, 2, 3)));
+
+extern const char *dirname_default_prefix;
diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
index d2ed874..b426cde 100644
--- a/libkmod/libkmod.c
+++ b/libkmod/libkmod.c
@@ -209,7 +209,7 @@ static int log_priority(const char *priority)
 	return 0;
 }
 
-static const char *dirname_default_prefix = MODULE_DIRECTORY;
+const char *dirname_default_prefix = MODULE_DIRECTORY;
 
 static char *get_kernel_release(const char *dirname)
 {
diff --git a/tools/depmod.c b/tools/depmod.c
index 22bc1d8..929060f 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -65,6 +65,7 @@ static const struct option cmdopts[] = {
 	{ "quick", no_argument, 0, 'A' },
 	{ "basedir", required_argument, 0, 'b' },
 	{ "outdir", required_argument, 0, 'o' },
+	{ "modulesdir", required_argument, 0, 'M' },
 	{ "config", required_argument, 0, 'C' },
 	{ "symvers", required_argument, 0, 'E' },
 	{ "filesyms", required_argument, 0, 'F' },
@@ -2943,6 +2944,9 @@ static int do_depmod(int argc, char *argv[])
 				free(out_root);
 			out_root = path_make_absolute_cwd(optarg);
 			break;
+		case 'M':
+			dirname_default_prefix = optarg;
+			break;
 		case 'C': {
 			size_t bytes = sizeof(char *) * (n_config_paths + 2);
 			void *tmp = realloc(config_paths, bytes);



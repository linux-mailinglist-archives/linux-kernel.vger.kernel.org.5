Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84469753C3C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbjGNNy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbjGNNy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:54:57 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B19226B2;
        Fri, 14 Jul 2023 06:54:55 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id A5FC258750830; Fri, 14 Jul 2023 15:54:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id A3CC360C22668;
        Fri, 14 Jul 2023 15:54:53 +0200 (CEST)
Date:   Fri, 14 Jul 2023 15:54:53 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Michal Suchanek <msuchanek@suse.de>
cc:     linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kmod v2 4/4] libkmod, depmod, modprobe: Search for kernel
 modules under ${module_prefix}
In-Reply-To: <20230712140103.5468-4-msuchanek@suse.de>
Message-ID: <r9ponpq-6o2o-2252-r5nq-5090192nn05q@vanv.qr>
References: <20230711153126.28876-1-msuchanek@suse.de> <20230712140103.5468-4-msuchanek@suse.de>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wednesday 2023-07-12 16:00, Michal Suchanek wrote:

>modprobe.d is now searched under ${prefix}/lib, add ${module_prefix} to
>specify the directory where to search for kernel modules.
>
>With this distributions that do not want to ship files in /lib can also
>move kernel modules to /usr while others can keep them in /lib.

>+# Ideally this would be $prefix but default to empty for compatibility with earlier versions
>+AC_ARG_WITH([module_prefix],
>+        AS_HELP_STRING([--with-module-prefix=DIR], [directory in which to look for /lib/modules directory with kernel modules - typically '' or ${prefix}]),
>+        [], [with_module_prefix=])
>+AC_SUBST([module_prefix], [$with_module_prefix])

Why stop there, let's make it fully configurable such that

 ./configure --with-module-prefix=/usr/lib/modules

works. Then one can specify arbitrary paths without fearing of getting a
/lib/modules tacked on anywhere down the line.

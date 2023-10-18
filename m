Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C657CD1CC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 03:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344378AbjJRBZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 21:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjJRBZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 21:25:22 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AB6B0;
        Tue, 17 Oct 2023 18:25:20 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 53DEC587264CA; Wed, 18 Oct 2023 03:25:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 518F760C40E07;
        Wed, 18 Oct 2023 03:25:19 +0200 (CEST)
Date:   Wed, 18 Oct 2023 03:25:19 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
cc:     Michal Suchanek <msuchanek@suse.de>, linux-modules@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kmod v5 5/5] libkmod, depmod, modprobe: Make directory
 for kernel modules configurable
In-Reply-To: <e3yow7ih6af2hxzkmjay2oan3jypmo4hda64vxvpfco66ajcew@i3zewn4nbklf>
Message-ID: <o6n5s896-ppro-qs00-71q8-3s657s3190s9@vanv.qr>
References: <cover.1689589902.git.msuchanek@suse.de> <cover.1689681454.git.msuchanek@suse.de> <b878a01f09e250bb24dbaede71cc776217a8f862.1689681454.git.msuchanek@suse.de> <e3yow7ih6af2hxzkmjay2oan3jypmo4hda64vxvpfco66ajcew@i3zewn4nbklf>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 2023-10-17 19:50, Lucas De Marchi wrote:
>> +AC_ARG_WITH([module_directory],
>> +        AS_HELP_STRING([--with-module-directory=DIR], [directory in which to
>> look for kernel modules - typically '/lib/modules' or
>> '${prefix}/lib/modules']),
>> +        [], [with_module_directory=/lib/modules])
>> +AC_SUBST([module_directory], [$with_module_directory])
>
> we will probably have "fun" results if we accept a relative path here.

$ ./configure --prefix=/usr --bindir=../bin
configure: error: expected an absolute directory name for --bindir: ../bin

While such check does not exist for --with-module-directory, everyone
has likely been well-trained not to use relative paths. Even if, say,
cmake/meson *could* do it, it just would have never occurred to me to
actually *utilize* it, because it is just too ambiguous and
potentially dangerous.

Just think of all the fun you could have with LD_LIBRARY_PATH=".."


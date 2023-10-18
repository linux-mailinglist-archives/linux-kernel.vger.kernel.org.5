Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0927CD1AF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 03:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344308AbjJRBMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 21:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbjJRBMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 21:12:45 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61150B6;
        Tue, 17 Oct 2023 18:12:43 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 9A553587264CA; Wed, 18 Oct 2023 03:12:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 97A2B60C40E07;
        Wed, 18 Oct 2023 03:12:41 +0200 (CEST)
Date:   Wed, 18 Oct 2023 03:12:41 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH rebased] kbuild: rpm-pkg: Fix build with non-default
 MODLIB
In-Reply-To: <20231017151050.GJ6241@kitsune.suse.cz>
Message-ID: <p86sq573-s32q-6792-4978-43s1pn91r027@vanv.qr>
References: <20231009085208.GT6241@kitsune.suse.cz> <CAK7LNASeMEKVi5c0PEow5KSdN7rsm7UYEf2smWOSkYOhr_5fVQ@mail.gmail.com> <20231009140733.GV6241@kitsune.suse.cz> <CAK7LNAQQMFUt4R1m_U8kBY5=BvxD_dMuE4MD4kpd48WK1E+AGA@mail.gmail.com> <20231010101552.GW6241@kitsune.suse.cz>
 <CAK7LNASX2_-xt3Qvxie_G=Q4fuVYR6eE47QjQ5NZf7QxY-4_tQ@mail.gmail.com> <20231017104453.GG6241@kitsune.suse.cz> <CAK7LNASKPg0JK0QsLGb1Rfx2ysvHJTm3NFOvtwOpZRz4-20T8w@mail.gmail.com> <20231017122747.GH6241@kitsune.suse.cz> <CAK7LNAT3N82cJD3GsF+yUBEfPNOBkhzYPk37q3k0HdU7ukz9vQ@mail.gmail.com>
 <20231017151050.GJ6241@kitsune.suse.cz>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 2023-10-17 17:10, Michal Suchánek wrote:
>
>> In my system (Ubuntu), I see the directory paths
>> 
>> /usr/aarch64-linux-gnu/lib/
>> /usr/i686-linux-gnu/lib/
>> /usr/x86_64-linux-gnu/lib/
>> 
>> If there were such a crazy distro that supports multiple kernel arches
>> within a single image, modules might be installed:
>> /usr/x86_64-linux-gnu/lib/module/<version>/
>
>For me it's /usr/lib/i386-linux-gnu/.
>
>Did they change the scheme at some point?

It's a complicated mumble-jumble. Prior art exists as in:

 /opt/vendorThing/bin/...
 /usr/X11R6/lib/libXi.so.6 [host binary]
 /usr/x86_64-w64-mingw32/bin/as [host binary]
 /usr/x86_64-w64-mingw32/sys-root/mingw/bin/as.exe [foreign binary]
 /usr/platform/SUNW,Ultra-2/lib/libprtdiag_psr.so.1 [looks foreign]

The use of suffix-based naming must have been established sometime
near the end of the 90s or the start of 2000s as the first biarch
Linux distros emerged. Probably in gcc or glibc sources one will find
the root of where the use of suffix identifiers like /usr/lib64
started. Leaves the question open "why".

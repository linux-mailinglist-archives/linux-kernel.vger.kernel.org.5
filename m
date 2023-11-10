Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4147E8299
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbjKJT2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbjKJT2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:28:19 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7A269926;
        Fri, 10 Nov 2023 09:57:53 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 99D8C58726689; Fri, 10 Nov 2023 18:57:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 9220D60D2EA0B;
        Fri, 10 Nov 2023 18:57:48 +0100 (CET)
Date:   Fri, 10 Nov 2023 18:57:48 +0100 (CET)
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
In-Reply-To: <20231110174422.GY6241@kitsune.suse.cz>
Message-ID: <9924rs47-0029-0227-p927-980rs881126p@vanv.qr>
References: <20231009140733.GV6241@kitsune.suse.cz> <CAK7LNAQQMFUt4R1m_U8kBY5=BvxD_dMuE4MD4kpd48WK1E+AGA@mail.gmail.com> <20231010101552.GW6241@kitsune.suse.cz> <CAK7LNASX2_-xt3Qvxie_G=Q4fuVYR6eE47QjQ5NZf7QxY-4_tQ@mail.gmail.com> <20231017104453.GG6241@kitsune.suse.cz>
 <CAK7LNASKPg0JK0QsLGb1Rfx2ysvHJTm3NFOvtwOpZRz4-20T8w@mail.gmail.com> <20231017122747.GH6241@kitsune.suse.cz> <CAK7LNAT3N82cJD3GsF+yUBEfPNOBkhzYPk37q3k0HdU7ukz9vQ@mail.gmail.com> <20231017151050.GJ6241@kitsune.suse.cz> <p86sq573-s32q-6792-4978-43s1pn91r027@vanv.qr>
 <20231110174422.GY6241@kitsune.suse.cz>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Friday 2023-11-10 18:44, Michal Suchánek wrote:
>> It's a complicated mumble-jumble. Prior art exists as in:
>> 
>>  /opt/vendorThing/bin/...
>>  /usr/X11R6/lib/libXi.so.6 [host binary]
>>  /usr/x86_64-w64-mingw32/bin/as [host binary]
>>  /usr/x86_64-w64-mingw32/sys-root/mingw/bin/as.exe [foreign binary]
>>  /usr/platform/SUNW,Ultra-2/lib/libprtdiag_psr.so.1 [looks foreign]
>> 
>> The use of suffix-based naming must have been established sometime
>> near the end of the 90s or the start of 2000s as the first biarch
>> Linux distros emerged. Probably in gcc or glibc sources one will find
>> the root of where the use of suffix identifiers like /usr/lib64
>> started. Leaves the question open "why".
>
>That's pretty clear: to be able to install libraries for multiple
>architectures at the same time.

Well, what I tried to express or imply was something like:

“ we could (should?) have used /usr/<triplet>/lib rather than
  /usr/lib<suffixortriplet> all along, because at some point, there *will* be
  someone who wants to provide not only arch-different libraries, but *also*
  arch-different binaries (for whatever reason).

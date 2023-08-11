Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15368779781
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 21:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbjHKTFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 15:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjHKTFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 15:05:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C105219A5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 12:05:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5165D63311
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 19:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBC0C433C8;
        Fri, 11 Aug 2023 19:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691780728;
        bh=Iu/6JyTKZAcWtIyDZiIJjyB72dUpwNi0RC+cpyo64zU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bnF9oyE6bpNSvNl0b4poM+UYLrc6CQNLRSuZlOmg92Ub/+5yzmBgVDItITihXTliP
         cqkImR+YsyrIa8Iv5IsedovuGIgMTFp7CR9bQ1WJ7ojUmxZYa5hjJ21y5ro6Eo8tiz
         ZWwttTULYH8YWgFCSTg5AUDwXk+rXkq10TOhFnt9Fj64voegf2MBcaNEf9JQ+40v+p
         qtVrLeH0XEpUs78SXx8Q5PHFxl8u1qr9tOqPMpaotXXim03Vm01sSPo7RPaYpj6Oyg
         WZrBG4+BXvPT2Ycm3FzZ3+B+fR8MofRrBTdzMTlv0gGo6UEUQdU7WmKwVugisd0Crr
         DNz1RanwvSlxw==
Received: by pali.im (Postfix)
        id 557FB677; Fri, 11 Aug 2023 21:05:25 +0200 (CEST)
Date:   Fri, 11 Aug 2023 21:05:25 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kees Cook <kees@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: binfmt_misc & different PE binaries
Message-ID: <20230811190525.hustdrwlgc232dmx@pali>
References: <20230706115550.sqyh3k26e2glz2lu@pali>
 <20230806162346.v7gjoev2nepxlcox@pali>
 <C636CC6D-9504-4B81-8B47-2734C70F20C2@kernel.org>
 <20230807170852.yefmkcqwum6gdao6@pali>
 <202308101323.F17474FEB6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202308101323.F17474FEB6@keescook>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 August 2023 13:24:55 Kees Cook wrote:
> On Mon, Aug 07, 2023 at 07:08:52PM +0200, Pali Rohár wrote:
> > On Monday 07 August 2023 07:45:08 Kees Cook wrote:
> > > On August 6, 2023 9:23:46 AM PDT, "Pali Rohár" <pali@kernel.org> wrote:
> > > >Hello, I would like to remind this email about binfmt_misc for PE.
> > > >
> > > >On Thursday 06 July 2023 13:55:50 Pali Rohár wrote:
> > > >> Hello,
> > > >> 
> > > >> I would like to ask how to properly register binfmt_misc for different
> > > >> PE binaries, so kernel could execute the correct loader for them.
> > > >> 
> > > >> I mean, how to register support for Win32 (console/gui) PE binaries and
> > > >> also for CLR PE binaries (dotnet). Win32 needs to be executed under wine
> > > >> and CLR ideally under dotnet core (or mono).
> > > >> 
> > > >> I have read kernel documentation files admin-guide/binfmt-misc.rst
> > > >> and admin-guide/mono.rst. But seems that they are in conflicts as both
> > > >> wants to registers its own handler for the same magic:
> > > >> 
> > > >>   echo ':DOSWin:M::MZ::/usr/local/bin/wine:' > register
> > > >> 
> > > >>   echo ':CLR:M::MZ::/usr/bin/mono:' > /proc/sys/fs/binfmt_misc/register
> > > >> 
> > > >> Not mentioning the fact that they register DOS MZ handler, which matches
> > > >> not only all PE binaries (including EFI, libraries, other processors),
> > > >> but also all kind of other NE/LE/LX binaries and different DOS extenders.
> > > >> 
> > > >> From documentation it looks like that even registering PE binaries is
> > > >> impossible by binfmt_misc as PE is detected by checking that indirect
> > > >> reference from 0x3C is PE\0\0. And distinguish between Win32 and CLR
> > > >> needs to parse PE COM descriptor directory.
> > > >> 
> > > >> Or it is possible to write binfmt_misc pattern match based on indirect
> > > >> offset?
> > > 
> > > Normally a single userspace program will be registered and it can do whatever it needs to do to further distinguish the binary and hand it off to the appropriate loader.
> > 
> > Ok, so you are saying that there should be one userspace program which
> > distinguish between DOS, CLR and Win32 and then exec the correct
> > "runtime" loader? Is there such one? Also it would be nice to mention it
> > in the documentation.
> 
> I've not spent much time with it, but I think Wine can be set up to
> do this?

Hm... I have not figured out how. Quick look into wine source code and
it looks like that for dos executables has wine hardcoded spawning of
dosbox binary with prepared command line and config file. And for dotnet
it executes wine's version of mono which has to be installed separately.
Which is not really suitable for CLR/C# applications not dependent on
Win32 API and also not very useful for modern dotnet / C# applications
which should be run under native Linux dotnet runtime and which mono
cannot execute. But I agree that this it is useful for C# applications
which use Win32 API (as it is the wine who implements Win32).

So I have feeling that there is no ideal solution.

I will try to prepare some small deciding program which can act as MZ
loader for binfmt_misc and which just exec the correct loader for binary
after their MZ and PE headers.

> Anyway, I'm happy to apply Documentation patches, if you want to send
> changes that would make things more clear. :)

Saying something that due to difficulty in parsing of MZ/PE binaries it
is not possible distinguish between Win32 and CLR PE application in
binfmt_misc module and that current manuals describe how to run all
executables with dos header either under wine or mono (not both).
I can prepare something. But I'm not sure when was this documentation
last time read as it looks like that nobody asked such question.

> -Kees
> 
> -- 
> Kees Cook

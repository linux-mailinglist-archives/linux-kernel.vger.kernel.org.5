Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5EA772C17
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjHGRJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjHGRI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:08:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048051A4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:08:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 841C261FD6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 17:08:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA20C433C7;
        Mon,  7 Aug 2023 17:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691428134;
        bh=/dradSX2yLZH6YySu9JzmAAMU7c5OndtP3GUWy7HcxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MQYtzJaUhVlDKiJAUcM1/TvdWybqf979ld58eWe9VivXxuOTBFm2wYowMDfCYCEnV
         A0Esa0Xuqqom/p3IfotPGySl6yxwbva4OIGKxKU5lPNbsQR6ucc0Xzk9meqaB4ycFR
         05nMIHDTIiRTd6XsrpIiaFl8jVn4Obdaz2FohJwKNSRVXBO+OvO6jc3dez4k3IdE05
         IWDfr9gKgSrwVK87aTqJrDTJCajGkh+mcSp143BAw/HeJSrXObZFtohKEwW0ONOo2t
         TwAwFHTEnjXN8riyih8OJU4ZO3ocspNzFPPajuGkrfrl9qeZkk/k+vXHrriiCUdatL
         Kc4CqUFVBj2ig==
Received: by pali.im (Postfix)
        id 3B93F820; Mon,  7 Aug 2023 19:08:52 +0200 (CEST)
Date:   Mon, 7 Aug 2023 19:08:52 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kees Cook <kees@kernel.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: binfmt_misc & different PE binaries
Message-ID: <20230807170852.yefmkcqwum6gdao6@pali>
References: <20230706115550.sqyh3k26e2glz2lu@pali>
 <20230806162346.v7gjoev2nepxlcox@pali>
 <C636CC6D-9504-4B81-8B47-2734C70F20C2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C636CC6D-9504-4B81-8B47-2734C70F20C2@kernel.org>
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

On Monday 07 August 2023 07:45:08 Kees Cook wrote:
> On August 6, 2023 9:23:46 AM PDT, "Pali Rohár" <pali@kernel.org> wrote:
> >Hello, I would like to remind this email about binfmt_misc for PE.
> >
> >On Thursday 06 July 2023 13:55:50 Pali Rohár wrote:
> >> Hello,
> >> 
> >> I would like to ask how to properly register binfmt_misc for different
> >> PE binaries, so kernel could execute the correct loader for them.
> >> 
> >> I mean, how to register support for Win32 (console/gui) PE binaries and
> >> also for CLR PE binaries (dotnet). Win32 needs to be executed under wine
> >> and CLR ideally under dotnet core (or mono).
> >> 
> >> I have read kernel documentation files admin-guide/binfmt-misc.rst
> >> and admin-guide/mono.rst. But seems that they are in conflicts as both
> >> wants to registers its own handler for the same magic:
> >> 
> >>   echo ':DOSWin:M::MZ::/usr/local/bin/wine:' > register
> >> 
> >>   echo ':CLR:M::MZ::/usr/bin/mono:' > /proc/sys/fs/binfmt_misc/register
> >> 
> >> Not mentioning the fact that they register DOS MZ handler, which matches
> >> not only all PE binaries (including EFI, libraries, other processors),
> >> but also all kind of other NE/LE/LX binaries and different DOS extenders.
> >> 
> >> From documentation it looks like that even registering PE binaries is
> >> impossible by binfmt_misc as PE is detected by checking that indirect
> >> reference from 0x3C is PE\0\0. And distinguish between Win32 and CLR
> >> needs to parse PE COM descriptor directory.
> >> 
> >> Or it is possible to write binfmt_misc pattern match based on indirect
> >> offset?
> 
> Normally a single userspace program will be registered and it can do whatever it needs to do to further distinguish the binary and hand it off to the appropriate loader.
> 
> 
> 
> -- 
> Kees Cook

Ok, so you are saying that there should be one userspace program which
distinguish between DOS, CLR and Win32 and then exec the correct
"runtime" loader? Is there such one? Also it would be nice to mention it
in the documentation.

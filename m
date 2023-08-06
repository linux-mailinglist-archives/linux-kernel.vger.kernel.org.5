Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C8877160C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 18:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjHFQXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 12:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHFQXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 12:23:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA375113
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 09:23:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 350B461035
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 16:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5B4C433C8;
        Sun,  6 Aug 2023 16:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691339029;
        bh=WvFbeGSja2fHMrxL2gi9+8yw0glACJgkp0g0wx3S3X8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lHl824MQUgGjsskvmnR12XTxpi0jiVMNlZjh7ntIn+BFtzVz4rfT9hNRdDqe/67GC
         Nu5jkNTL2uDrLtaDP/76/Zt7JxzfmNci3FeVjPWCCqBS3KRoLaoI9kxfx1fWRe1bDq
         7uoCewZ2DQUQjTcTxHBFUicazxePi7Sovf0xGlvr+t+nR1lEWTptBFwwbyVnryWRoJ
         /sXh1HGB21hosXGkSWH/ZGFUskEFrEyetxv+x7FqKym2lM5jroFn+Kx5jTgHHm/5aN
         5U72pnwST8yHaIMxpERNWpZXGbe7LWd0hKE8iw0qrsIS6NdVjw9IunBXd9ZnSv7HG7
         rcgfdE6bHGMUw==
Received: by pali.im (Postfix)
        id EB6E280E; Sun,  6 Aug 2023 18:23:46 +0200 (CEST)
Date:   Sun, 6 Aug 2023 18:23:46 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: binfmt_misc & different PE binaries
Message-ID: <20230806162346.v7gjoev2nepxlcox@pali>
References: <20230706115550.sqyh3k26e2glz2lu@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230706115550.sqyh3k26e2glz2lu@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I would like to remind this email about binfmt_misc for PE.

On Thursday 06 July 2023 13:55:50 Pali Rohár wrote:
> Hello,
> 
> I would like to ask how to properly register binfmt_misc for different
> PE binaries, so kernel could execute the correct loader for them.
> 
> I mean, how to register support for Win32 (console/gui) PE binaries and
> also for CLR PE binaries (dotnet). Win32 needs to be executed under wine
> and CLR ideally under dotnet core (or mono).
> 
> I have read kernel documentation files admin-guide/binfmt-misc.rst
> and admin-guide/mono.rst. But seems that they are in conflicts as both
> wants to registers its own handler for the same magic:
> 
>   echo ':DOSWin:M::MZ::/usr/local/bin/wine:' > register
> 
>   echo ':CLR:M::MZ::/usr/bin/mono:' > /proc/sys/fs/binfmt_misc/register
> 
> Not mentioning the fact that they register DOS MZ handler, which matches
> not only all PE binaries (including EFI, libraries, other processors),
> but also all kind of other NE/LE/LX binaries and different DOS extenders.
> 
> From documentation it looks like that even registering PE binaries is
> impossible by binfmt_misc as PE is detected by checking that indirect
> reference from 0x3C is PE\0\0. And distinguish between Win32 and CLR
> needs to parse PE COM descriptor directory.
> 
> Or it is possible to write binfmt_misc pattern match based on indirect
> offset?

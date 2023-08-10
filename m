Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11522777BA6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbjHJPHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbjHJPHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:07:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55DE2686
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:07:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5241265F85
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 15:07:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57933C433BB;
        Thu, 10 Aug 2023 15:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691680028;
        bh=SedsBJA7SDym526YfYO6tDp0uAlB3IbI+3hK27IRyn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vh2iW70QikbFOmOMjfuRuJ82L+EQsQ7E2UItOn6c8tGPwj+E527RBDc9QNoRPQ0Cr
         AMGUQxSCCaagQqYpnTzurzo3bEYvDmkOxeqBh2jVkOzITP/9U/EIAA7pmXPJ2uQbPT
         1ml0UXYb5/s7ZdVrMsmlsPCj5G9/7MP9Gq6blwPIhIC+JV5o3ziGW9j6Q2Tg14Jitv
         QzhiPWCSjlGKq7oUO7UxI/VtrEr6V5GFWZf0dRk90aWzSi7tMkfROxmjeiybrI+6HO
         lBETbgyVLF4PvUFcsxXqDE5LJ/qpkEgn5PsTsA19/9azcBlaRy1lwHVvQmTFDbQ3Cl
         4wjr2NZlPpKrg==
Date:   Thu, 10 Aug 2023 08:07:06 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: Hang when booting guest kernels compiled with clang after SRSO
 mitigations
Message-ID: <20230810150706.GA42856@dev-arch.thelio-3990X>
References: <20230810013334.GA5354@dev-arch.thelio-3990X>
 <20230810081038.GAZNSbftb6DOgg/U7e@fat_crate.local>
 <20230810090835.GBZNSpE6tCw+Ci+9yh@fat_crate.local>
 <20230810101649.GA1795474@dev-arch.thelio-3990X>
 <20230810125122.GIZNTdSuFvA3Cjfexq@fat_crate.local>
 <20230810132706.GA3805855@dev-arch.thelio-3990X>
 <20230810133216.GKZNTm4KpohRR4gVsT@fat_crate.local>
 <20230810134056.GA130730@dev-arch.thelio-3990X>
 <20230810144344.GLZNT3oM6MLVdzGlyd@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810144344.GLZNT3oM6MLVdzGlyd@fat_crate.local>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 04:43:44PM +0200, Borislav Petkov wrote:
> On Thu, Aug 10, 2023 at 06:40:56AM -0700, Nathan Chancellor wrote:
> Linux version 6.5.0-rc5+ (root@vh) (gcc (Debian 10.2.1-3) 10.2.1 20201224, GNU ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Thu Aug 10 16:13:54 CEST 2023
> 
> ...
> 
> [    0.083541] Speculative Return Stack Overflow: Mitigation: safe RET

I just tried

  Linux version 6.5.0-rc5-00039-g138bcddb86d8 (nathan@dev-arch.thelio-3990X) (x86_64-linux-gcc (GCC) 10.4.0, GNU ld (GNU Binutils) 2.39) #1 SMP PREEMPT_DYNAMIC Thu Aug 10 07:48:28 MST 2023

  [    0.000259] Speculative Return Stack Overflow: Mitigation: safe RET

on the host...

> [    0.000000] Linux version 6.5.0-rc5 (root@vh) (Debian clang version 14.0.6, GNU ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Thu Aug 10 13:22:30 CEST 2023

with

  [    0.000000] Linux version 6.5.0-rc5 (nathan@distrobox-6Sw1jticKJ.thelio-3990X) (Debian clang version 14.0.6, GNU ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Thu Aug 10 07:58:56 MST 2023

in the guest and I see the same problem.

> Guest and host are up and running.
> 
> There's something else missing.

Configuration difference? Here is the one from the most recent build:

https://gist.github.com/nathanchance/2d7ad0b9440a6a2ec5ba0b88e3e673a9

Is there any other information that could be relevant here? My microcode
version according to dmesg, in case that matters.

  [    2.408527] microcode: microcode updated early to new patch_level=0x0830107a

Is that machine Zen 2? I see this issue on my Ryzen 3 4300G as well,
which is also Zen 2.

> Your host gcc is 13, maybe I should update...

Seems like I can reproduce it with earlier versions of GCC (and I could
reproduce it with clang) so it does not seem like it is toolchain
related on the host side but might be interesting to test.

I just use https://mirrors.edge.kernel.org/pub/tools/crosstool/ for easy
access to multiple versions.

Cheers,
Nathan

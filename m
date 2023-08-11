Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E9877866B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 06:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbjHKENs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 00:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjHKENq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 00:13:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68491E7F;
        Thu, 10 Aug 2023 21:13:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D84B16467C;
        Fri, 11 Aug 2023 04:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A10C433C8;
        Fri, 11 Aug 2023 04:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691727223;
        bh=0nMtbzOF+FHXauK0+1lynfoqJs/CmuWuApidsAPL4Yg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QZEPlKVXnMT6PdNqCejEdN8xt8B7ZnRZoyuyAcA5iByxOs2UZyPF0VfY98bo7fvtJ
         pwHJpZH7FX6SBz8xgixVRkwWqNZaw8RSEeHkWODws0kwWFG9JV7q61aTb9lJSBC58k
         FMuzriXzy/bNzj6kDXPCMk5a46LuWZBSE3m1Zm75fHNq4LjY/gFZKzDo/KaHUkHsRJ
         dkuFTt8qQrPepxna1jsNlcBDqVAh6Xp6vWG/cT6F9tdSSsNYyqPJJrTl6dsJ758bud
         0L2OX52rG/AB1EA2jfGVfpXRqJbXMTHuAMg5DddCcix1vfatC3DILt9EFnY+4+3O6t
         Tp38pzAMu5E/A==
Date:   Thu, 10 Aug 2023 21:13:39 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        clang-built-linux <llvm@lists.linux.dev>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sven Volkinsfeld <thyrc@gmx.net>,
        Daniel Kolesa <daniel@octaforge.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH 6.1 000/127] 6.1.45-rc1 review
Message-ID: <20230811041339.GA193223@dev-arch.thelio-3990X>
References: <20230809103636.615294317@linuxfoundation.org>
 <CA+G9fYvQdQqTqCgbS4sit_Y2AtKtDiWMOkGZjoeSEFhc=M_jKw@mail.gmail.com>
 <078d6e3d-9572-a624-2c5a-e2d58473e6d0@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <078d6e3d-9572-a624-2c5a-e2d58473e6d0@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 08:41:42PM -0700, Guenter Roeck wrote:
> On 8/10/23 20:22, Naresh Kamboju wrote:
> > Build errors:
> > -----
> > ld.lld: error: ./arch/x86/kernel/vmlinux.lds:193: at least one side of
> > the expression must be absolute
> > make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
> > 
> 
> We see that with v5.10.y, v5.15.y, and v6.1.y when building ChromeOS images with
> clang/lld. There are additional problems with LTO and the built-in assembler. See
> https://www.linuxquestions.org/questions/slackware-14/error-building-kernel-6-1-44-on-current-with-clang-4175727865/
> for a summary.

Yup, we have issues open for all of those:

https://github.com/ClangBuiltLinux/linux/issues/1907
https://github.com/ClangBuiltLinux/linux/issues/1909
https://github.com/ClangBuiltLinux/linux/issues/1911

1907 is fixed in -tip and I am sure it will make -rc6 [1].

1909 is fixed with [2] but it is sitting in x86/core (i.e., slated for
next merge window). I am guessing at the time it was picked up, it was
not fixing a noticeable issue, which is obviously not the case now. Nick
reached out to the -tip folks on IRC to inquire about getting that
applied to a branch that is going to Linus soon, as it is more of a
process issue since it has conflicts with SRSO and an separate issue
that was pointed out post-acceptance (which I addressed and pushed to
[3] for testing). I never saw a response there (which is understandable,
it is a busy time...) so looping the -tip folks in now, just to make
sure it does not get lost (apologies if this is noise).

1911 is still being investigated (some additional eyes on it would not
hurt).

[1]: https://git.kernel.org/tip/cbe8ded48b939b9d55d2c5589ab56caa7b530709
[2]: https://git.kernel.org/tip/973ab2d61f33dc85212c486e624af348c4eeb5c9
[3]: https://github.com/ClangBuiltLinux/linux/commit/150c42407f87463c27a2459e06845965291d9973

> As far as I can see none of those problems has been fixed in the upstream kernel.

Indeed, embargos are fun... :)

Cheers,
Nathan

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0959C80EAF7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346392AbjLLLzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbjLLLzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:55:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF587C3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:55:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08B9C433C7;
        Tue, 12 Dec 2023 11:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702382123;
        bh=ELkMM3xL8H6CR/+VuM2URI6u+FZWIT3tz2dGjfDVmtY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yEkZ70v4HQPvJ4mjAZ2LGFeiDgGbm/hcMWhps260aLGNJzoQJmGybkqfTvclnskK2
         w8yV9r7Ng4eJ4odjOqFyv1lOIcDeWcB/V8X0TfTh43OT/BFPEM+p5kUgdRB/aYP0Sw
         HW/atx8BAYSue1yklfCTmGE6eRGENF2vB3itO1No=
Date:   Tue, 12 Dec 2023 12:55:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com, arnd@arndb.de
Subject: Re: [PATCH 5.15 000/141] 5.15.143-rc1 review
Message-ID: <2023121254-reoccur-shorty-cfb2@gregkh>
References: <20231211182026.503492284@linuxfoundation.org>
 <a2fbbaa2-51d2-4a8c-b032-5331e72cd116@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2fbbaa2-51d2-4a8c-b032-5331e72cd116@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 09:38:39PM -0600, Daniel Díaz wrote:
> Hello!
> 
> On 11/12/23 12:20 p. m., Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.15.143 release.
> > There are 141 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.143-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> We're seeing new warnings with GCC-8 and failures with GCC-12 on x86/i386:
> 
> -----8<-----
>   In file included from /builds/linux/drivers/gpu/drm/i915/gem/i915_gem_context.c:2291:
>   /builds/linux/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c: In function '__igt_ctx_sseu':
>   /builds/linux/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c:1284:9: error: left shift of negative value [-Werror=shift-negative-value]
>       ~(~0 << (hweight32(engine->sseu.subslice_mask) / 2));
>            ^~
>   cc1: all warnings being treated as errors
>   make[5]: *** [/builds/linux/scripts/Makefile.build:289: drivers/gpu/drm/i915/gem/i915_gem_context.o] Error 1
>   /builds/linux/drivers/gpu/drm/i915/i915_perf.c: In function 'get_default_sseu_config':
>   /builds/linux/drivers/gpu/drm/i915/i915_perf.c:2817:9: error: left shift of negative value [-Werror=shift-negative-value]
>       ~(~0 << (hweight8(out_sseu->subslice_mask) / 2));
>            ^~
>   cc1: all warnings being treated as errors
>   make[5]: *** [/builds/linux/scripts/Makefile.build:289: drivers/gpu/drm/i915/i915_perf.o] Error 1
> ----->8-----
> 
> Bisection points to:
> 
>   commit 09ebdc1b3dfacc275d5eec3f1dcf632f18bbf5a8
>   Author: Arnd Bergmann <arnd@arndb.de>
>   Date:   Tue Mar 8 22:56:14 2022 +0100
> 
>       Kbuild: move to -std=gnu11
>       [ Upstream commit e8c07082a810fbb9db303a2b66b66b8d7e588b53 ]
> 
> 
> For GCC-12 it's allmodconfig failing, for GCC-8 it's defconfig (i386_defconfig, x86_64_defconfig) just reporting new warnings.
> 
> Some reproducers:
> 
>   tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-8 --kconfig x86_64_defconfig
> 
>   tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-12 --kconfig allmodconfig
> 
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Ok, let me go drop this change and fix up the original commit that
required this language change to happen as we aren't quite ready for it
yet...

thanks,

greg k-h

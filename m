Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FC58041DC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbjLDWvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjLDWvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:51:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A489A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 14:51:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36750C433C8;
        Mon,  4 Dec 2023 22:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701730310;
        bh=iEzFzN5srKwj/pYZXDgnZDTQQKCpoB6GASU+Xqwa6mA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a3ZDkyh2bpKh8JseA3+i4SgPk6H55RJtemW2I8wAl/DDAcD0k8Ll0HTFlUfOpoFvr
         TB+0MNI6D0/MUnNnnAAgy+2ayR4GR3ToHJqxq3oWovx1ydNXaQYIR0SRBKStNahx07
         Z+VZSMMXsyqIctUJmjd+xYexdydciiUA3Ye4g34rJSwW8FNSNjW2NxVHjjliHTkxtX
         FFiY+2kWoTXi8GCQBdeIQcohSENyHAT6wIPTzx+0HIyOmw7bnPGYiwxosglBskw4MW
         linlPJ6rqbrTMUt3V5n9SJCRc8ZZOghTgxEG+oWAU4IggFfsSEK46snit6VbAuRAAW
         Wyre5rfD+oHAg==
Date:   Mon, 4 Dec 2023 15:51:48 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sylvestre Ledru <sylvestre@debian.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        lkft-triage@lists.linaro.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: clang-nightly: vdso/compat_gettimeofday.h:152:15: error:
 instruction variant requires ARMv6 or later
Message-ID: <20231204225148.GA2094126@dev-arch.thelio-3990X>
References: <CA+G9fYvD72Vpfs2g8R+OJ6L8w9p_uaWbXpWMvnGAx_AOLabatw@mail.gmail.com>
 <20231204181304.GA2043538@dev-arch.thelio-3990X>
 <20231204223317.GA2053629@dev-arch.thelio-3990X>
 <c61f61c9-3bfb-4ffd-adaf-1313965b3037@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c61f61c9-3bfb-4ffd-adaf-1313965b3037@debian.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 11:42:02PM +0100, Sylvestre Ledru wrote:
> Hello,
> 
> 
> Le 04/12/2023 à 23:33, Nathan Chancellor a écrit :
> > On Mon, Dec 04, 2023 at 11:13:04AM -0700, Nathan Chancellor wrote:
> > > Hi Naresh,
> > > 
> > > On Mon, Dec 04, 2023 at 05:33:26PM +0530, Naresh Kamboju wrote:
> > > > Following build errors noticed on Linux next-20231204 tag with clang-nightly
> > > > for arm and arm64.
> > > > 
> > > > ## Test Regressions (compared to next-20231201)
> > > > * arm64, build
> > > >    - clang-nightly-defconfig
> > > >    - clang-nightly-defconfig-40bc7ee5
> > > >    - clang-nightly-lkftconfig
> > > >    - clang-nightly-lkftconfig-kselftest
> > > > 
> > > > * arm, build
> > > >    - clang-nightly-allnoconfig
> > > >    - clang-nightly-axm55xx_defconfig
> > > >    - clang-nightly-bcm2835_defconfig
> > > >    - clang-nightly-clps711x_defconfig
> > > >    - clang-nightly-defconfig
> > > >    - clang-nightly-exynos_defconfig
> > > >    - clang-nightly-imx_v6_v7_defconfig
> > > >    - clang-nightly-keystone_defconfig
> > > >    - clang-nightly-lkftconfig
> > > >    - clang-nightly-lkftconfig-kselftest
> > > >    - clang-nightly-omap2plus_defconfig
> > > >    - clang-nightly-pxa910_defconfig
> > > >    - clang-nightly-s3c6400_defconfig
> > > >    - clang-nightly-s5pv210_defconfig
> > > >    - clang-nightly-sama5_defconfig
> > > >    - clang-nightly-shmobile_defconfig
> > > >    - clang-nightly-tinyconfig
> > > >    - clang-nightly-u8500_defconfig
> > > >    - clang-nightly-vexpress_defconfig
> > > > 
> > > > 
> > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > > 
> > > > 
> > > > Build log on arm64:
> > > > ---------
> > > > In file included from lib/vdso/gettimeofday.c:5:
> > > > In file included from include/vdso/datapage.h:135:
> > > > arch/arm64/include/asm/vdso/compat_gettimeofday.h:152:15: error:
> > > > instruction variant requires ARMv6 or later
> > > >    152 |         asm volatile("mov %0, %1" : "=r"(ret) : "r"(_vdso_data));
> > > >        |                      ^
> > > > <inline asm>:1:2: note: instantiated into assembly here
> > > >      1 |         mov r4, r1
> > > >        |         ^
> > > > In file included from <built-in>:3:
> > > > lib/vdso/gettimeofday.c:139:3: error: invalid instruction
> > > >    139 |                 smp_rmb();
> > > >        |                 ^
> > > > 
> > > > Build log on arm:
> > > > ---------
> > > > In file included from arch/arm/vfp/vfpmodule.c:23:
> > > > arch/arm/include/asm/cp15.h:101:2: error: instruction requires: data-barriers
> > > >    101 |         isb();
> > > >        |         ^
> > > This is caused by a change to Debian's LLVM that changes the internal
> > > defaults of the arm-linux-gnueabi and arm-linux-gnueabihf tuples:
> > > 
> > > https://salsa.debian.org/pkg-llvm-team/llvm-toolchain/-/commit/907baf024b9a5a1626893d9e731b6c79ccf45c87
> > > 
> > > We use arm-linux-gnueabi for the kernel (see scripts/Makefile.clang) so
> > > now we have a hardcoded armv5te CPU, even if we are building for armv7
> > > or such.
> > > 
> > > I am still investigating into what (if anything) can be done to resolve
> > > this on the kernel side. We could potentially revert commit
> > > ddc72c9659b5 ("kbuild: clang: do not use CROSS_COMPILE for target
> > > triple") but I am not sure that will save us from that change, as
> > > tuxmake's CROSS_COMPILE=arm-linux-gnueabihf will cause us to have an
> > > armv7 CPU even though we may not be building for armv7.
> > Okay, this is a pretty awful situation the more I look into it :(
> > 
> > The arm64 compat vDSO build is easy enough to fix because we require use
> > of the integrated assembler, which means we can add '-mcpu=generic' (the
> > default in LLVM for those files based on my debugging) to those files
> > and be done with it:
> > 
> > diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> > index 1f911a76c5af..5f5cb722cfc2 100644
> > --- a/arch/arm64/kernel/vdso32/Makefile
> > +++ b/arch/arm64/kernel/vdso32/Makefile
> > @@ -9,6 +9,10 @@ include $(srctree)/lib/vdso/Makefile
> >   ifeq ($(CONFIG_CC_IS_CLANG), y)
> >   CC_COMPAT ?= $(CC)
> >   CC_COMPAT += --target=arm-linux-gnueabi
> > +# Some distributions (such as Debian) change the default CPU for the
> > +# arm-linux-gnueabi target triple, which can break the build. Explicitly set
> > +# the CPU to generic, which is the default for Linux in LLVM.
> > +CC_COMPAT += -mcpu=generic
> >   else
> >   CC_COMPAT ?= $(CROSS_COMPILE_COMPAT)gcc
> >   endif
> > 
> > The failures for all the ARCH=arm configurations appear to be much more
> > difficult to fix because the default CPU value changes based on the
> > '-march' value, which basically means that we would have to hardcode
> > LLVM's default CPU logic into the kernel's Makefile, which is just not
> > maintainable in my opinion. Just doing a multi_v7_defconfig build of
> > arch/arm/ shows the value returned from ARM::getARMCPUForArch() in
> > llvm/lib/TargetParser/ARMTargetParser.cpp can vary between "arm7tdmi" or
> > "generic". Supplying '-mcpu=generic' explicitly won't work with
> > LLVM_IAS=0 because GNU as does not support it and clang just happily
> > passes it along, even though it does not do that in the implicit default
> > case.
> > 
> > Sylvestre, I strongly believe you should consider reverting that change
> > or give us some compiler flag that allows us to fallback to upstream
> > LLVM's default CPU selection logic. I think that hardcoding Debian's
> > architecture defintions based on the target triple into the compiler
> > could cause issues for other projects as well. For example,
> > '--target=arm-linux-gnueabi -march=armv7-a' won't actually target ARMv7:
> > 
> >    $ echo 'int main(void) { asm("dsb"); return 0; }' | \
> >          clang --target=arm-linux-gnueabi -march=armv7-a \
> >          -x c -c -o /dev/null -v -
> >    ...
> >     "/usr/bin/clang-17" -cc1 -triple armv7-unknown-linux-gnueabi ...
> >    ...
> > 
> > vs.
> > 
> >    $ echo 'int main(void) { asm("dsb"); return 0; }' | \
> >          clang --target=arm-linux-gnueabi -march=armv7-a \
> >          -x c -c -o /dev/null -v -
> >    ...
> >    "<prefix>/bin/clang-18" -cc1 -triple armv5e-unknown-linux-gnueabi ...
> >    ...
> > 
> I guess it is this patch, right?
> 
> https://salsa.debian.org/pkg-llvm-team/llvm-toolchain/-/commit/97633b6d51ebc8579c5dbecd12a02fb933620620

Right, I should have made that clearer when bringing you in (I linked to
the snapshot version of that change further up in the thread).

> if so, do you want me to revert it?

Yes, I think it should be reverted.

Cheers,
Nathan

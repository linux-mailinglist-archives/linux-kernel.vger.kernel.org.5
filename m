Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17131805BFB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345998AbjLERVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345550AbjLERVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:21:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1ADBA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:21:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9187CC433C8;
        Tue,  5 Dec 2023 17:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701796896;
        bh=qQhFD5km7iam6ql60v2yvQ1cEjm2HjSDpoeTEUpsrRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SVvOED5TQV7w6aix5CSUmAgTtyEnO62rBkggKujtvoSWaIHBF/KbD6e14Hk2JPqz6
         3jXmvJUZek6eE5B+WZSrqApTnf1DIlnTzGjhSMK2NoICzENS/IKes8mJEFE1Wxoha8
         qR+IyfxpQ1Faqi/sTdJ2HjSERHq0z1khOYRmfF8y/go/CicJFNQrVVx8vTzPsfDurZ
         2lWey7UGuMC2z1W9gPskSHANViFPfSn8Dd/DWwCQIRZc0AYMthmCCwGeREnKHRcVgp
         nlIIWKz6cR+Tc2xLEuqggbwBVW7MLF1jZm0aBfqAfPSPj7M9cRhbPBuUIV2Uw4xwO5
         4KG2CE7WvT/ww==
Date:   Tue, 5 Dec 2023 10:21:33 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sylvestre Ledru <sylvestre@debian.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        lkft-triage@lists.linaro.org, Russell King <linux@armlinux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Klose <doko@debian.org>
Subject: Re: clang-nightly: vdso/compat_gettimeofday.h:152:15: error:
 instruction variant requires ARMv6 or later
Message-ID: <20231205172133.GA462711@dev-arch.thelio-3990X>
References: <CA+G9fYvD72Vpfs2g8R+OJ6L8w9p_uaWbXpWMvnGAx_AOLabatw@mail.gmail.com>
 <20231204181304.GA2043538@dev-arch.thelio-3990X>
 <20231204223317.GA2053629@dev-arch.thelio-3990X>
 <36a25113-731c-4b28-a695-f3fbb0996d6e@app.fastmail.com>
 <20231205150417.GA349053@dev-arch.thelio-3990X>
 <3523ca62-be8b-4b08-8d0c-5b97ece9aad8@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3523ca62-be8b-4b08-8d0c-5b97ece9aad8@debian.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 04:13:29PM +0100, Sylvestre Ledru wrote:
> Le 05/12/2023 à 16:04, Nathan Chancellor a écrit :
> > On Tue, Dec 05, 2023 at 07:34:40AM +0100, Arnd Bergmann wrote:
> > > On Mon, Dec 4, 2023, at 23:33, Nathan Chancellor wrote:
> > > > On Mon, Dec 04, 2023 at 11:13:04AM -0700, Nathan Chancellor wrote:
> > > > 
> > > > > I am still investigating into what (if anything) can be done to resolve
> > > > > this on the kernel side. We could potentially revert commit
> > > > > ddc72c9659b5 ("kbuild: clang: do not use CROSS_COMPILE for target
> > > > > triple") but I am not sure that will save us from that change, as
> > > > > tuxmake's CROSS_COMPILE=arm-linux-gnueabihf will cause us to have an
> > > > > armv7 CPU even though we may not be building for armv7.
> > > > 
> > > > Okay, this is a pretty awful situation the more I look into it :(
> > > > 
> > > > The arm64 compat vDSO build is easy enough to fix because we require use
> > > > of the integrated assembler, which means we can add '-mcpu=generic' (the
> > > > default in LLVM for those files based on my debugging) to those files
> > > > and be done with it:
> > > > 
> > > > diff --git a/arch/arm64/kernel/vdso32/Makefile
> > > > b/arch/arm64/kernel/vdso32/Makefile
> > > > index 1f911a76c5af..5f5cb722cfc2 100644
> > > > --- a/arch/arm64/kernel/vdso32/Makefile
> > > > +++ b/arch/arm64/kernel/vdso32/Makefile
> > > > @@ -9,6 +9,10 @@ include $(srctree)/lib/vdso/Makefile
> > > >   ifeq ($(CONFIG_CC_IS_CLANG), y)
> > > >   CC_COMPAT ?= $(CC)
> > > >   CC_COMPAT += --target=arm-linux-gnueabi
> > > > +# Some distributions (such as Debian) change the default CPU for the
> > > > +# arm-linux-gnueabi target triple, which can break the build.
> > > > Explicitly set
> > > > +# the CPU to generic, which is the default for Linux in LLVM.
> > > > +CC_COMPAT += -mcpu=generic
> > > >   else
> > > >   CC_COMPAT ?= $(CROSS_COMPILE_COMPAT)gcc
> > > >   endif
> > > 
> > > I'm still trying to follow what is actually going on. I
> > > see that we pass
> > > 
> > > VDSO_CAFLAGS += -march=armv8-a
> > > 
> > > which is meant to tell the compiler that we want it to
> > > use ARMv8 compatible instructions. Is the problem that
> > > clang ignores this flag, or do we not pass it correctly?
> > > 
> > > I would have expected -march=armv8-a to be better than
> > > -mcpu=generic here, as it allows the compiler to use
> > > a wider set of instructions that is still guaranteed to
> > > be available on everything it will run on.
> > 
> > I should have made it clearer in that message that adding
> > '-mcpu=generic' was only to avoid the logic added by that Debian LLVM
> > change, not because I believe the kernel is doing something incorrectly
> > now. From what I could tell following through LLVM's code, '-march='
> > determines the default CPU, which is then used to further inform the
> > full target triple and by overriding the CPU where that patch did, it
> > was just blowing away the user's request. By providing an '-mcpu='
> > option explicitly, it would avoid the default selection logic and we
> > would get what we asked for.
> > 
> > > > Sylvestre, I strongly believe you should consider reverting that change
> > > > or give us some compiler flag that allows us to fallback to upstream
> > > > LLVM's default CPU selection logic. I think that hardcoding Debian's
> > > > architecture defintions based on the target triple into the compiler
> > > > could cause issues for other projects as well. For example,
> > > > '--target=arm-linux-gnueabi -march=armv7-a' won't actually target ARMv7:
> > > > 
> > > >    $ echo 'int main(void) { asm("dsb"); return 0; }' | \
> > > >          clang --target=arm-linux-gnueabi -march=armv7-a \
> > > >          -x c -c -o /dev/null -v -
> > > >    ...
> > > >     "/usr/bin/clang-17" -cc1 -triple armv7-unknown-linux-gnueabi ...
> > > >    ...
> > > > 
> > > > vs.
> > > > 
> > > >    $ echo 'int main(void) { asm("dsb"); return 0; }' | \
> > > >          clang --target=arm-linux-gnueabi -march=armv7-a \
> > > >          -x c -c -o /dev/null -v -
> > > >    ...
> > > >    "<prefix>/bin/clang-18" -cc1 -triple armv5e-unknown-linux-gnueabi ...
> > > >    ...
> > > 
> > > Right, the kernel definitely relies on -march= taking
> > > precedence over the default CPU, the same way that we
> > > tell the compiler to pick a non-default endianess or ABI.
> > 
> > Agreed, I have yet to test the new version of the patch but I see you
> > and Ard have given input on it, so hopefully it does not have any
> > problems like this.
> 
> Matthias, as cc, pushed a potential fix for debian/ubuntu packages!
> https://salsa.debian.org/pkg-llvm-team/llvm-toolchain/-/commit/01a06b481e5a2610c7387149b58978c3ec281f2c

Thanks, that version survives my basic testing of both ARCH=arm and
ARCH=arm64 defconfig. I'll holler if our full matrix explodes later (we
have another regression in LLVM right now so we are not testing the
snapshots daily at the moment).

Cheers,
Nathan

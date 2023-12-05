Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E27C805C27
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442354AbjLEPEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442352AbjLEPEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:04:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61E4A9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:04:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6F8C433C7;
        Tue,  5 Dec 2023 15:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701788660;
        bh=e8q7+35/iVX1elBCHB500XRbravlaCnerL4Y9qT4K8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VMvZ5dfO0erFqqjsjz04m6e1D3O7dSzlKfEix3OFQmcThSr6rfVE3Gb7pPV9suXOF
         O5Lr3rhiq2N0oT2LtOBOSfBmWc3N5tLFyYNdbGbeaSCKkyPQnG07umFycCcyNRDz8u
         Azr7ljg9RaFfxtCO78IlQpRsH6q4pUC3lbnYZrClFWdmWSkB8MCJuWzIvcXR7ZbM4H
         yZEPLrmVBQQ8y1lD0JTPJgAXPnoF8dBCteYVriMrPPOy3sll8b4UJCUAz0vd2m0Dka
         eK8TX2QI/QdhZNcMgMo5uKU1SAtx42iovyaElrGyBF7QE/TddfYKmdotKCt3fuP6va
         mq5Kvod0WQhfg==
Date:   Tue, 5 Dec 2023 08:04:17 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        lkft-triage@lists.linaro.org, Russell King <linux@armlinux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sylvestre Ledru <sylvestre@debian.org>
Subject: Re: clang-nightly: vdso/compat_gettimeofday.h:152:15: error:
 instruction variant requires ARMv6 or later
Message-ID: <20231205150417.GA349053@dev-arch.thelio-3990X>
References: <CA+G9fYvD72Vpfs2g8R+OJ6L8w9p_uaWbXpWMvnGAx_AOLabatw@mail.gmail.com>
 <20231204181304.GA2043538@dev-arch.thelio-3990X>
 <20231204223317.GA2053629@dev-arch.thelio-3990X>
 <36a25113-731c-4b28-a695-f3fbb0996d6e@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36a25113-731c-4b28-a695-f3fbb0996d6e@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 07:34:40AM +0100, Arnd Bergmann wrote:
> On Mon, Dec 4, 2023, at 23:33, Nathan Chancellor wrote:
> > On Mon, Dec 04, 2023 at 11:13:04AM -0700, Nathan Chancellor wrote:
> > 
> >> I am still investigating into what (if anything) can be done to resolve
> >> this on the kernel side. We could potentially revert commit
> >> ddc72c9659b5 ("kbuild: clang: do not use CROSS_COMPILE for target
> >> triple") but I am not sure that will save us from that change, as
> >> tuxmake's CROSS_COMPILE=arm-linux-gnueabihf will cause us to have an
> >> armv7 CPU even though we may not be building for armv7.
> >
> > Okay, this is a pretty awful situation the more I look into it :(
> >
> > The arm64 compat vDSO build is easy enough to fix because we require use
> > of the integrated assembler, which means we can add '-mcpu=generic' (the
> > default in LLVM for those files based on my debugging) to those files
> > and be done with it:
> >
> > diff --git a/arch/arm64/kernel/vdso32/Makefile 
> > b/arch/arm64/kernel/vdso32/Makefile
> > index 1f911a76c5af..5f5cb722cfc2 100644
> > --- a/arch/arm64/kernel/vdso32/Makefile
> > +++ b/arch/arm64/kernel/vdso32/Makefile
> > @@ -9,6 +9,10 @@ include $(srctree)/lib/vdso/Makefile
> >  ifeq ($(CONFIG_CC_IS_CLANG), y)
> >  CC_COMPAT ?= $(CC)
> >  CC_COMPAT += --target=arm-linux-gnueabi
> > +# Some distributions (such as Debian) change the default CPU for the
> > +# arm-linux-gnueabi target triple, which can break the build. 
> > Explicitly set
> > +# the CPU to generic, which is the default for Linux in LLVM.
> > +CC_COMPAT += -mcpu=generic
> >  else
> >  CC_COMPAT ?= $(CROSS_COMPILE_COMPAT)gcc
> >  endif
> 
> I'm still trying to follow what is actually going on. I
> see that we pass
> 
> VDSO_CAFLAGS += -march=armv8-a
> 
> which is meant to tell the compiler that we want it to
> use ARMv8 compatible instructions. Is the problem that
> clang ignores this flag, or do we not pass it correctly?
> 
> I would have expected -march=armv8-a to be better than
> -mcpu=generic here, as it allows the compiler to use
> a wider set of instructions that is still guaranteed to
> be available on everything it will run on.

I should have made it clearer in that message that adding
'-mcpu=generic' was only to avoid the logic added by that Debian LLVM
change, not because I believe the kernel is doing something incorrectly
now. From what I could tell following through LLVM's code, '-march='
determines the default CPU, which is then used to further inform the
full target triple and by overriding the CPU where that patch did, it
was just blowing away the user's request. By providing an '-mcpu='
option explicitly, it would avoid the default selection logic and we
would get what we asked for.

> > Sylvestre, I strongly believe you should consider reverting that change
> > or give us some compiler flag that allows us to fallback to upstream
> > LLVM's default CPU selection logic. I think that hardcoding Debian's
> > architecture defintions based on the target triple into the compiler
> > could cause issues for other projects as well. For example,
> > '--target=arm-linux-gnueabi -march=armv7-a' won't actually target ARMv7:
> >
> >   $ echo 'int main(void) { asm("dsb"); return 0; }' | \
> >         clang --target=arm-linux-gnueabi -march=armv7-a \
> >         -x c -c -o /dev/null -v -
> >   ...
> >    "/usr/bin/clang-17" -cc1 -triple armv7-unknown-linux-gnueabi ...
> >   ...
> >
> > vs.
> >
> >   $ echo 'int main(void) { asm("dsb"); return 0; }' | \
> >         clang --target=arm-linux-gnueabi -march=armv7-a \
> >         -x c -c -o /dev/null -v -
> >   ...
> >   "<prefix>/bin/clang-18" -cc1 -triple armv5e-unknown-linux-gnueabi ...
> >   ...
> 
> Right, the kernel definitely relies on -march= taking
> precedence over the default CPU, the same way that we
> tell the compiler to pick a non-default endianess or ABI.

Agreed, I have yet to test the new version of the patch but I see you
and Ard have given input on it, so hopefully it does not have any
problems like this.

Cheers,
Nathan

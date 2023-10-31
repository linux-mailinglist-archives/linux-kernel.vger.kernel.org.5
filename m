Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E595A7DD232
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346128AbjJaQff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346630AbjJaQev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:34:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74AA5213B;
        Tue, 31 Oct 2023 09:32:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31F762F4;
        Tue, 31 Oct 2023 09:33:28 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.36.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F02DA3F67D;
        Tue, 31 Oct 2023 09:32:43 -0700 (PDT)
Date:   Tue, 31 Oct 2023 16:32:41 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        LTP List <ltp@lists.linux.it>, Petr Vorel <pvorel@suse.cz>
Subject: Re: qemu-arm64: handle_futex_death - kernel/futex/core.c:661 -
 Unable to handle kernel unknown 43 at virtual address
Message-ID: <ZUEsKUVENQXftM4I@FVFF77S0Q05N>
References: <CA+G9fYsCskpn_TNpSwLq9HGUgtT=aZpDzs7SVrqpa9WmyYFaxQ@mail.gmail.com>
 <ZTqGBzOQd4Oi3e9j@FVFF77S0Q05N.cambridge.arm.com>
 <CAMj1kXE8VrG6aPsjByd83kavw7He6vn=DszhJfAd-TfP9y8VBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXE8VrG6aPsjByd83kavw7He6vn=DszhJfAd-TfP9y8VBA@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 05:39:11PM +0200, Ard Biesheuvel wrote:
> On Thu, 26 Oct 2023 at 17:30, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Thu, Oct 26, 2023 at 08:11:26PM +0530, Naresh Kamboju wrote:
> > > Following kernel crash noticed on qemu-arm64 while running LTP syscalls
> > > set_robust_list test case running Linux next 6.6.0-rc7-next-20231026 and
> > > 6.6.0-rc7-next-20231025.
> > >
> > > BAD: next-20231025
> > > Good: next-20231024
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > >
> > > Log:
> > > ----
> > > <1>[  203.119139] Unable to handle kernel unknown 43 at virtual
> > > address 0001ffff9e2e7d78
> > > <1>[  203.119838] Mem abort info:
> > > <1>[  203.120064]   ESR = 0x000000009793002b
> > > <1>[  203.121040]   EC = 0x25: DABT (current EL), IL = 32 bits
> > > set_robust_list01    1  TPASS  :  set_robust_list: retval = -1
> > > (expected -1), errno = 22 (expected 22)
> > > set_robust_list01    2  TPASS  :  set_robust_list: retval = 0
> > > (expected 0), errno = 0 (expected 0)
> > > <1>[  203.124496]   SET = 0, FnV = 0
> > > <1>[  203.124778]   EA = 0, S1PTW = 0
> > > <1>[  203.125029]   FSC = 0x2b: unknown 43
> >
> > It looks like this is fallout from the LPA2 enablement.
> >
> > According to the latest ARM ARM (ARM DDI 0487J.a), page D19-6475, that "unknown
> > 43" (0x2b / 0b101011) is the DFSC for a level -1 translation fault:
> >
> >         0b101011 When FEAT_LPA2 is implemented:
> >                  Translation fault, level -1.
> >
> > It's triggered here by an LDTR in a get_user() on a bogus userspace address.
> > The exception is expected, and it's supposed to be handled via the exception
> > fixups, but the LPA2 patches didn't update the fault_info table entries for all
> > the level -1 faults, and so those all get handled by do_bad() and don't call
> > fixup_exception(), causing them to be fatal.
> >
> > It should be relatively simple to update the fault_info table for the level -1
> > faults, but given the other issues we're seeing I think it's probably worth
> > dropping the LPA2 patches for the moment.
> >
> 
> Thanks for the analysis Mark.
> 
> I agree that this should not be difficult to fix, but given the other
> CI problems and identified loose ends, I am not going to object to
> dropping this partially or entirely at this point. I'm sure everybody
> will be thrilled to go over those 60 patches again after I rebase them
> onto v6.7-rc1 :-)

FWIW, I'm more than happy to try; the issue has lagely been finding the time.
Hopefully that'll be a bit easier after LPC!

Mark.

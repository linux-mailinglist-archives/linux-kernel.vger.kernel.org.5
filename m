Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1CF7CFD51
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346182AbjJSOvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345895AbjJSOu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:50:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07E77C2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:50:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9ADC01474;
        Thu, 19 Oct 2023 07:51:37 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.31.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E37183F5A1;
        Thu, 19 Oct 2023 07:50:55 -0700 (PDT)
Date:   Thu, 19 Oct 2023 15:50:53 +0100
From:   Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>
To:     Andrea della Porta <andrea.porta@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nik.borisov@suse.com
Subject: Re: [PATCH 2/4] arm64/process: Make loading of 32bit processes
 depend on aarch32_enabled()
Message-ID: <ZTFCTXgCM6sW_0uh@FVFF77S0Q05N.cambridge.arm.com>
References: <cover.1697614386.git.andrea.porta@suse.com>
 <a40565807874c9ca82d60c118225ee65fe668fcd.1697614386.git.andrea.porta@suse.com>
 <ZS_VJ29tFbEwNHAS@FVFF77S0Q05N.cambridge.arm.com>
 <ZTEjSD4_4xsJWkEi@apocalypse>
 <ZTE86PK5YJGV1xVq@FVFF77S0Q05N.cambridge.arm.com>
 <ZTE9-4ie8R6zw9od@apocalypse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTE9-4ie8R6zw9od@apocalypse>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 04:32:27PM +0200, Andrea della Porta wrote:
> On 15:27 Thu 19 Oct     , Mark Rutland wrote:
> > On Thu, Oct 19, 2023 at 02:38:32PM +0200, Andrea della Porta wrote:
> > > On 13:52 Wed 18 Oct     , Mark Rutland wrote:
> > > > On Wed, Oct 18, 2023 at 01:13:20PM +0200, Andrea della Porta wrote:
> > > > > Major aspect of Aarch32 emulation is the ability to load 32bit
> > > > > processes.
> > > > > That's currently decided (among others) by compat_elf_check_arch().
> > > > > 
> > > > > Make the macro use aarch32_enabled() to decide if Aarch32 compat is
> > > > > enabled before loading a 32bit process.
> > > > > 
> > > > > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > > > 
> > > > Why can't you make system_supports_32bit_el0() take the option into account
> > > > instead?
> > > >
> > > 
> > > I may be wrong here, but it seems to me that system_supports_32bit_el0()
> > > answers teh question "can this system supports compat execution?" rather than
> > > "do I want this system to run any compat execution?". That's the point of
> > > aarch32_enabled(), to state whether we want teh system to run A32 code or not,
> > > regardless of the system supporting it (of course, if the system does not
> > > support A32 in EL0, this is a no-no, but that's another story).
> > 
> > That's what the implementation does today, but we're really using it as a "do
> > we intend for 32-bit EL0 to work?" predicate, and generally the
> > system_supports_${FEATURE}() helpers are affected by the combination of actual
> > HW support, kernel config options, *and* kernel command line options. For
> > example, system_supports_sve() is affected by both CONFIG_ARM64_SVE and the
> > "arm64.nosve" command line option.
> > 
> > Thanks,
> > Mark.
> 
> Many thanks for the explanation, then inserting aach32_enabled() in
> system_supports_32bit_el0() is the way to go.

I think what we should do here is clean up the way we implement
system_supports_32bit_el0() such that it can be a cpucap, and have the
conditions that would affect aarch32_enabled() feed into that. That way,
system_supports_32bit_el0() will compile down to a single branch/nop (or elided
entirely when known to be false at compile-time), and with that I think can
reasonably fold the existing UNHANDLED() logic into the entry-common.c
exception handlers as a simplification.

The only obviously painful part is that enable_mismatched_32bit_el0() allows
(mismatched) AArch32 support to be enabled after we finalize system cpucaps, as
part of a late hotplug. I suspect that was implemented that way for expedience
rather than because we wanted to enable mismatched AArch32 after finalizing
cpucaps.

Will, do you remember why we used a cpuhp callback for enabling mismatched
32-bit support? I couldn't see anything explicit in the commit message for:

  2122a833316f2f3f ("arm64: Allow mismatched 32-bit EL0 support")

... and I suspect it was just easier to write that way, rather than adding more
code around setup_system_capabilities() ?

Mark.

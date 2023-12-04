Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34928030BC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbjLDKmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjLDKmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:42:12 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A994D5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:42:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19597169C;
        Mon,  4 Dec 2023 02:43:06 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.44.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F087B3F6C4;
        Mon,  4 Dec 2023 02:42:17 -0800 (PST)
Date:   Mon, 4 Dec 2023 10:42:15 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/Kconfig: Disable KASLR on debug builds
Message-ID: <ZW2tBy_8U5cfEkmk@FVFF77S0Q05N>
References: <20231130120552.6735-1-bp@alien8.de>
 <20231130120831.GB20153@noisy.programming.kicks-ass.net>
 <20231130124909.GEZWiExTP4J1pjNxPq@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130124909.GEZWiExTP4J1pjNxPq@fat_crate.local>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 01:49:09PM +0100, Borislav Petkov wrote:
> On Thu, Nov 30, 2023 at 01:08:31PM +0100, Peter Zijlstra wrote:
> > Works for me, but I have "nokaslr no_hash_pointers" on all my machines
> > by now. It goes right along with "debug ignore_loglevel
> > sysrq_always_enabled earlyprintk=serial,ttyS0,115200" :-)
> 
> Bah, there's cmdline switches. Lemme add them to all my scripts starting
> guests and grub too. Thanks for the hint!
> 
> I guess we could still do the Kconfig dependency when we're on new
> machines, without the scripts.
> 
> Btw, I'm not the only one who's walked right into this one:
> 
> config KCOV
>         bool "Code coverage for fuzzing"
> 
> 	...
> 
>           If RANDOMIZE_BASE is enabled, PC values will not be stable across
>           different machines and across reboots. If you need stable PC values,
>           disable RANDOMIZE_BASE.

IIUC that's no longer necessary, and the Kconfig.debug wording is stale.

That wording was introduced in March 2016 as part of the original KCOV support
in commit:

  5c9a8750a6409c63 ("kernel: add kcov code coverage")

Later, in December 2016 we made KCOV adjust the address to remove the KASLR
offset in commit:

  4983f0ab7ffaad1e ("kcov: make kcov work properly with KASLR enabled")

... so I think that's been stale for ~7 years, and we just forgot to clean up
the Kconfig.debug text.

Mark.

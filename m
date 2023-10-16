Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34087CB094
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 18:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjJPQ4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 12:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234380AbjJPQ4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 12:56:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806FC1BCB;
        Mon, 16 Oct 2023 09:52:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9381EC433C9;
        Mon, 16 Oct 2023 16:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697475143;
        bh=hGThyAcF2BwvI1uYU3x2ubk5OZMx8epy/z86MTbOYwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=awRdYo7KXl1x29SUJ7g51KHLgOtHWq+IFfPSzFHqVqOwOd8dDbuy8dUU/vLNofZvu
         WJHOF3iXf9fN19rk9N0yhKj8SSt9JzEd6RtKgL6woYpRQnJuiFJSs8zqq/3MQdzXXx
         KgzzunEEZdM0cBGahONurnUnVY13OrB6AZpMBxn0=
Date:   Mon, 16 Oct 2023 18:52:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.5 006/191] arm_pmu: acpi: Add a representative platform
 device for TRBE
Message-ID: <2023101603-bullpen-dedicate-0df5@gregkh>
References: <20231016084015.400031271@linuxfoundation.org>
 <20231016084015.550509169@linuxfoundation.org>
 <a403f9b7-697e-4000-8a31-f54438718748@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a403f9b7-697e-4000-8a31-f54438718748@leemhuis.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 06:05:53PM +0200, Thorsten Leemhuis wrote:
> On 16.10.23 10:39, Greg Kroah-Hartman wrote:
> > 6.5-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Anshuman Khandual <anshuman.khandual@arm.com>
> > 
> > [ Upstream commit 1aa3d0274a4aac338ee45a3dfc3b17c944bcc2bc ]
> > 
> > ACPI TRBE does not have a HID for identification which could create and add
> > a platform device into the platform bus. Also without a platform device, it
> > cannot be probed and bound to a platform driver.
> > 
> > This creates a dummy platform device for TRBE after ascertaining that ACPI
> > provides required interrupts uniformly across all cpus on the system. This
> > device gets created inside drivers/perf/arm_pmu_acpi.c to accommodate TRBE
> > being built as a module.
> > 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > Link: https://lore.kernel.org/r/20230817055405.249630-3-anshuman.khandual@arm.com
> > Signed-off-by: Will Deacon <will@kernel.org>
> > Stable-dep-of: 4785aa802853 ("cpuidle, ACPI: Evaluate LPI arch_flags for broadcast timer")
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> Got a compiler error when using Fedora's stable kernel config and
> compiling 6.5.8-rc1 for ARM64; not totally sure, but from the error msg
> I suspect it's caused by the change quoted above.
> 
> """
> + /usr/bin/make -s 'HOSTCFLAGS=-O2  -fexceptions -g
> -grecord-gcc-switches -pipe -Wall -Werror=format-security
> -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS
> -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
> -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1
> -mbranch-protection=standard -fasynchronous-unwind-tables
> -fstack-clash-protection' 'HOSTLDFLAGS=-Wl,-z,relro -Wl,--as-needed
> -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld
> -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -Wl,--build-id=sha1
> -specs=/usr/lib/rpm/redhat/redhat-package-notes' ARCH=arm64 'KCFLAGS= '
> WITH_GCOV=0 -j4 vmlinuz.efi
> drivers/perf/arm_pmu_acpi.c: In function 'arm_trbe_acpi_register_device':
> drivers/perf/arm_pmu_acpi.c:164:19: error: implicit declaration of
> function 'arm_acpi_register_pmu_device'; did you mean
> 'arm_spe_acpi_register_device'? [-Werror=implicit-function-declaration]
>   164 |         int ret = arm_acpi_register_pmu_device(&trbe_dev,
> ACPI_MADT_GICC_TRBE,
>       |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                   arm_spe_acpi_register_device
> cc1: some warnings being treated as errors
> make[4]: *** [scripts/Makefile.build:243: drivers/perf/arm_pmu_acpi.o]
> Error 1
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [scripts/Makefile.build:480: drivers/perf] Error 2
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [scripts/Makefile.build:480: drivers] Error 2
> make[1]: ***
> [/builddir/build/BUILD/kernel-6.5.8-rc1/linux-6.5.8-0.rc1.150.vanilla.fc37.aarch64/Makefile:2036:
> .] Error 2
> make: *** [Makefile:236: __sub-make] Error 2
> """
> 
> Full build log:
> https://copr-be.cloud.fedoraproject.org/results/@kernel-vanilla/stable-rc/fedora-37-aarch64/06529454-stablerc-stablerc-releases/builder-live.log.gz

Thanks, I'll drop the offending commit and push out a -rc2.

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B89810F05
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378116AbjLMK41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377991AbjLMK4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:56:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4832A11D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:56:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5ED5C433C7;
        Wed, 13 Dec 2023 10:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702464987;
        bh=JhVw9j5BPxOuP0wVIbYDnW3Wq4255LW6snZceT5A608=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XiGi062rJVyA332+7I8z7ufASBDnufA6yAY+hkd3pYgBYcKGpiZjrsSEfZ/Lk/BRT
         LVjN6bkSfrWwisA3w8xAr2r4Je7Qco7dNpIREwuG+9ijMWieyMKumbs5Zbe2jispjL
         PD7unpIZKDavk3ZhEMp+nwm0ksK2w46Pxx+FKQbFNlwR8d87uYGPzYof+qzI7mKtM9
         x6cWaAG0IX2LYi/B3jYSGc6KwyroCnkFcPjwrsr4Bo6lwx/vwuhJgU1zHYrjsNNzfz
         hPmf3pYpLNSmQP/muYhnewcyNlVEbf6VlFGRcCcsuwhYFcKlaFS9+Au0hJW5qsaA7h
         L9ZBe70w+SdBw==
Date:   Wed, 13 Dec 2023 10:56:23 +0000
From:   Will Deacon <will@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the arm-perf tree
Message-ID: <20231213105622.GA31277@willie-the-truck>
References: <20231213100931.12d9d85e@canb.auug.org.au>
 <20231213093057.GA31075@willie-the-truck>
 <90b43e2e-4bbc-d1f2-dba5-8c9174e7398f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90b43e2e-4bbc-d1f2-dba5-8c9174e7398f@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 10:15:25AM +0000, James Clark wrote:
> On 13/12/2023 09:30, Will Deacon wrote:
> > On Wed, Dec 13, 2023 at 10:09:31AM +1100, Stephen Rothwell wrote:
> >> After merging the arm-perf tree, today's linux-next build (x86_64
> >> allmodconfig) failed like this:
> >>
> >> In file included from drivers/perf/arm_dmc620_pmu.c:26:
> >> include/linux/perf/arm_pmu.h:15:10: fatal error: asm/cputype.h: No such file or directory
> >>    15 | #include <asm/cputype.h>
> >>       |          ^~~~~~~~~~~~~~~
> > 
> > Damn, I tested with allnoconfig, defconfig and allmodconfig before I pushed,
> > but only for ARCH=arm64. Thanks for reporting this.
> > 
> >> I can't easily tell what caused this - possibly commit
> >>
> >>   a5f4ca68f348 ("perf/arm_dmc620: Remove duplicate format attribute #defines")
> >>
> >> I have used the arm-perf and arm64 trees from next-20231212 for today
> >> (since the arm64 tree merged the arm-perf tree).
> > 
> > That looks likely. I'll try reverting it and see if it resolves the problem
> > locally.
> > 
> 
> Oops sorry about that, I didn't expect that change to break the x86
> build so I didn't test it there, but it's because of CONFIG_COMPILE_TEST.

No problem, these things happen!

> a5f4ca68f348 is the offending commit, and reverting it would fix it (it
> was just a tidyup). But this change below also works. That include was
> to build ARM_PMU_PROBE which is only used in perf_event_v6.c (and v7)
> which both already include asm/cputype.h. Although maybe that would be a
> bit of a hack.
> 
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index 337f01674b38..a4876b1c481a 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -12,7 +12,6 @@
>  #include <linux/perf_event.h>
>  #include <linux/platform_device.h>
>  #include <linux/sysfs.h>
> -#include <asm/cputype.h>
> 
>  #ifdef CONFIG_ARM_PMU

I agree that this feels like a bit of a bodge, so I'll revert for now and
maybe we can revisit things later.

Cheers,

Will

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29187BFBD1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjJJMx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjJJMxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:53:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D26AEAF;
        Tue, 10 Oct 2023 05:53:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FBDF1FB;
        Tue, 10 Oct 2023 05:54:04 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 523E23F762;
        Tue, 10 Oct 2023 05:53:20 -0700 (PDT)
Message-ID: <099dc48f-454a-40cc-aef1-f186643d2a02@arm.com>
Date:   Tue, 10 Oct 2023 13:53:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm: perf: Include threshold control fields valid
 in PMEVTYPER mask
Content-Language: en-US
To:     James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Reiji Watanabe <reijiw@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Zaid Al-Bassam <zalbassam@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev
References: <20231010104048.1923484-1-james.clark@arm.com>
 <20231010104048.1923484-2-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20231010104048.1923484-2-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2023 11:40, James Clark wrote:
> FEAT_PMUv3_TH (Armv8.8) adds two new fields to PMEVTYPER, so include
> them in the mask. These aren't writable on 32 bit kernels as they are in
> the high part of the register, so split the mask definition to the asm
> files for each platform.
> 
> Now where the value is used in some parts of KVM, include the asm file.
> 
> Despite not being used on aarch32, TH and TC macros are added to the
> shared header file, because they are used in arm_pmuv3.c which is
> compiled for both platforms.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   arch/arm/include/asm/arm_pmuv3.h   | 3 +++
>   arch/arm64/include/asm/arm_pmuv3.h | 4 ++++
>   arch/arm64/kvm/pmu-emul.c          | 1 +
>   arch/arm64/kvm/sys_regs.c          | 1 +
>   include/linux/perf/arm_pmuv3.h     | 3 ++-
>   5 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
> index 72529f5e2bed..491310133d09 100644
> --- a/arch/arm/include/asm/arm_pmuv3.h
> +++ b/arch/arm/include/asm/arm_pmuv3.h
> @@ -9,6 +9,9 @@
>   #include <asm/cp15.h>
>   #include <asm/cputype.h>
>   
> +/* Mask for writable bits */
> +#define ARMV8_PMU_EVTYPE_MASK	0xc800ffff
> +
>   #define PMCCNTR			__ACCESS_CP15_64(0, c9)
>   
>   #define PMCR			__ACCESS_CP15(c9,  0, c12, 0)
> diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
> index 18dc2fb3d7b7..4faf4f7385a5 100644
> --- a/arch/arm64/include/asm/arm_pmuv3.h
> +++ b/arch/arm64/include/asm/arm_pmuv3.h
> @@ -11,6 +11,10 @@
>   #include <asm/cpufeature.h>
>   #include <asm/sysreg.h>
>   
> +/* Mask for writable bits */
> +#define ARMV8_PMU_EVTYPE_MASK	(0xc800ffffUL | ARMV8_PMU_EVTYPE_TH | \
> +				ARMV8_PMU_EVTYPE_TC)
> +
>   #define RETURN_READ_PMEVCNTRN(n) \
>   	return read_sysreg(pmevcntr##n##_el0)
>   static inline unsigned long read_pmevcntrn(int n)
> diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
> index 6b066e04dc5d..0666212c0c15 100644
> --- a/arch/arm64/kvm/pmu-emul.c
> +++ b/arch/arm64/kvm/pmu-emul.c
> @@ -11,6 +11,7 @@
>   #include <linux/perf_event.h>
>   #include <linux/perf/arm_pmu.h>
>   #include <linux/uaccess.h>
> +#include <asm/arm_pmuv3.h>
>   #include <asm/kvm_emulate.h>
>   #include <kvm/arm_pmu.h>
>   #include <kvm/arm_vgic.h>

You may want to mention in the commit description that there is no
impact on the KVM emulating the Guest PMU with this change, as it
ignores the fields in the upper half for setting up the attributes
for the backing event.

Suzuki

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B6479C9FD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjILIbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbjILIbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:31:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0784AB9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:31:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C81FCC15;
        Tue, 12 Sep 2023 01:32:23 -0700 (PDT)
Received: from [10.57.31.51] (unknown [10.57.31.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B83033F738;
        Tue, 12 Sep 2023 01:31:45 -0700 (PDT)
Message-ID: <759c91b9-856e-a778-0e0a-e52240e5c8ce@arm.com>
Date:   Tue, 12 Sep 2023 09:31:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] arm64: cpufeature: Expose the real mpidr value to EL0
Content-Language: en-GB
To:     "guojinhui.liam" <guojinhui.liam@bytedance.com>,
        catalin.marinas@arm.com, will@kernel.org
Cc:     lizefan.x@bytedance.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230912035209.1687-1-guojinhui.liam@bytedance.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230912035209.1687-1-guojinhui.liam@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-12 04:52, guojinhui.liam wrote:
> In EL0, it can get the register midr's value to distinguish vendor.
> But it won't return real value of the register mpidr by using mrs
> in EL0. The register mpidr's value is useful to obtain the cpu
> topology information.

...except there's no guarantee that the MPIDR value is anything other 
than a unique identifier. Proper topology information is already exposed 
to userspace[1], as described by ACPI PPTT or Devicetree[2]. Userspace 
should be using that.

Not to mention that userspace fundamentally can't guarantee it won't be 
migrated at just the wrong point and read the MPIDR of a different CPU 
anyway. (This is why the MIDRs and REVIDRs are also reported via sysfs, 
such that userspace has a stable and reliable source of information in 
case it needs to consider potential errata.)

Thanks,
Robin.

[1] https://www.kernel.org/doc/html/latest/admin-guide/cputopology.html
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/cpu/cpu-topology.txt

> In some scenarios, the task scheduling in userspace can be
> optimized with CPU Die information.
> 
> Signed-off-by: guojinhui.liam <guojinhui.liam@bytedance.com>
> ---
>   arch/arm64/include/asm/sysreg.h | 3 ---
>   arch/arm64/kernel/cpufeature.c  | 2 +-
>   2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 38296579a4fd..1885857c8a22 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -901,9 +901,6 @@
>   #define SYS_TFSR_EL1_TF0	(UL(1) << SYS_TFSR_EL1_TF0_SHIFT)
>   #define SYS_TFSR_EL1_TF1	(UL(1) << SYS_TFSR_EL1_TF1_SHIFT)
>   
> -/* Safe value for MPIDR_EL1: Bit31:RES1, Bit30:U:0, Bit24:MT:0 */
> -#define SYS_MPIDR_SAFE_VAL	(BIT(31))
> -
>   #define TRFCR_ELx_TS_SHIFT		5
>   #define TRFCR_ELx_TS_MASK		((0x3UL) << TRFCR_ELx_TS_SHIFT)
>   #define TRFCR_ELx_TS_VIRTUAL		((0x1UL) << TRFCR_ELx_TS_SHIFT)
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index b018ae12ff5f..6e18597fdcc3 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -3450,7 +3450,7 @@ static inline int emulate_id_reg(u32 id, u64 *valp)
>   		*valp = read_cpuid_id();
>   		break;
>   	case SYS_MPIDR_EL1:
> -		*valp = SYS_MPIDR_SAFE_VAL;
> +		*valp = read_cpuid_mpidr();
>   		break;
>   	case SYS_REVIDR_EL1:
>   		/* IMPLEMENTATION DEFINED values are emulated with 0 */

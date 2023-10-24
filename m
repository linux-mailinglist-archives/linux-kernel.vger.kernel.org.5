Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE307D4F43
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjJXL4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjJXL4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:56:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A11BBD
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 04:56:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C653C2F4;
        Tue, 24 Oct 2023 04:56:56 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B70A3F64C;
        Tue, 24 Oct 2023 04:56:14 -0700 (PDT)
Message-ID: <e13d8d85-67d7-4a5e-893c-69dacb3a6d24@arm.com>
Date:   Tue, 24 Oct 2023 12:56:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] arm64: Introduce aarch32_enabled()
Content-Language: en-GB
To:     Andrea della Porta <andrea.porta@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nik.borisov@suse.com, arnd@arndb.de, mark.rutland@arm.com
References: <cover.1698069331.git.andrea.porta@suse.com>
 <1dec05cc8f54d0b85acffce69d929f13e6d81313.1698069331.git.andrea.porta@suse.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1dec05cc8f54d0b85acffce69d929f13e6d81313.1698069331.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/2023 3:42 pm, Andrea della Porta wrote:
> Aarch32 bit support on 64bit kernels depends on whether CONFIG_COMPAT
> is selected or not. As it is a compile time option it doesn't
> provide the flexibility to have distributions set their own policy for
> Aarch32 support and give the user the flexibility to override it.
> 
> As a first step introduce aarch32_enabled() which abstracts whether 32
> bit compat is turned on or off. Upcoming patches will implement
> the ability to set Aarch32 compat state at boot time.

Other than patch #3, which as previously mentioned should be unnecessary 
if the kernel correctly never starts an "unsupported" AArch32 process to 
begin with, what does this do that simply overriding ID_AA64PFR0_EL1.EL0 
via the existing idreg-override mechanism wouldn't?

Thanks,
Robin.

> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>   arch/arm64/include/asm/cpufeature.h | 15 +++++++++++++++
>   arch/arm64/kernel/entry-common.c    |  2 ++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 396af9b9c857..1180d68daaff 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -657,6 +657,21 @@ static inline bool supports_clearbhb(int scope)
>   						    ID_AA64ISAR2_EL1_CLRBHB_SHIFT);
>   }
>   
> +#ifdef CONFIG_COMPAT
> +extern bool __aarch32_enabled;
> +
> +static inline bool aarch32_enabled(void)
> +{
> +	return __aarch32_enabled;
> +}
> +#else /* !CONFIG_COMPAT */
> +
> +static inline bool aarch32_enabled(void)
> +{
> +	return false;
> +}
> +#endif
> +
>   const struct cpumask *system_32bit_el0_cpumask(void);
>   DECLARE_STATIC_KEY_FALSE(arm64_mismatched_32bit_el0);
>   
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index 0fc94207e69a..69ff9b8c0bde 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -877,6 +877,8 @@ asmlinkage void noinstr el0t_32_error_handler(struct pt_regs *regs)
>   {
>   	__el0_error_handler_common(regs);
>   }
> +
> +bool __aarch32_enabled __ro_after_init = true;
>   #else /* CONFIG_COMPAT */
>   UNHANDLED(el0t, 32, sync)
>   UNHANDLED(el0t, 32, irq)

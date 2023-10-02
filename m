Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7748E7B5917
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjJBR0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJBR0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:26:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3192CAC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:26:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D5FEC15;
        Mon,  2 Oct 2023 10:26:41 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.28.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 238FA3F59C;
        Mon,  2 Oct 2023 10:26:01 -0700 (PDT)
Date:   Mon, 2 Oct 2023 18:25:58 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: smp: Don't directly call
 arch_smp_send_reschedule() for wakeup
Message-ID: <ZRr9JsbOax5Xz4xC@FVFF77S0Q05N.cambridge.arm.com>
References: <20231002094526.1.Ie8f760213053e3d11592f892b30912dbac6b8b48@changeid>
 <20231002094526.2.I2e6d22fc42ccbf6b26465a28a10e36e05ccf3075@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002094526.2.I2e6d22fc42ccbf6b26465a28a10e36e05ccf3075@changeid>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 09:45:30AM -0700, Douglas Anderson wrote:
> In commit 2b2d0a7a96ab ("arm64: smp: Remove dedicated wakeup IPI") we
> started using a scheduler IPI to avoid a dedicated reschedule. When we
> did this, we used arch_smp_send_reschedule() directly rather than
> calling smp_send_reschedule(). The only difference is that calling
> arch_smp_send_reschedule() directly avoids tracing. Presumably we
> _don't_ want to avoid tracing here, so switch to
> smp_send_reschedule().
> 
> Fixes: 2b2d0a7a96ab ("arm64: smp: Remove dedicated wakeup IPI")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I don't 100% know if this is correct and I don't have any hardware
> that uses the "ACPI parking protocol", but I think it's right. My main
> incentive for this is that it makes it easier to backport pseudo-NMI
> to kernels that don't have arch_smp_send_reschedule(), but I think
> it's also more correct.
> 
> If for some reason we truly did want to avoid tracing here, please
> shout and we can drop this patch.

This should be sound, and I don't have strong feelings either way on this, so
FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> 
>  arch/arm64/kernel/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 0a6002243a8c..b530d8ef9c1d 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -1063,7 +1063,7 @@ void arch_send_wakeup_ipi(unsigned int cpu)
>  	 * We use a scheduler IPI to wake the CPU as this avoids the need for a
>  	 * dedicated IPI and we can safely handle spurious scheduler IPIs.
>  	 */
> -	arch_smp_send_reschedule(cpu);
> +	smp_send_reschedule(cpu);
>  }
>  #endif
>  
> -- 
> 2.42.0.582.g8ccd20d70d-goog
> 

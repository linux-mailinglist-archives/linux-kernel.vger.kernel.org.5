Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8868D78E9F2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 12:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343767AbjHaKMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 06:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238116AbjHaKMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:12:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AFDDE4A;
        Thu, 31 Aug 2023 03:12:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DF75C15;
        Thu, 31 Aug 2023 03:13:27 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.3.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E2853F64C;
        Thu, 31 Aug 2023 03:12:42 -0700 (PDT)
Date:   Thu, 31 Aug 2023 11:12:34 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Tomohiro Misono <misono.tomohiro@fujitsu.com>,
        Stephane Eranian <eranian@google.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>, ito-yuichi@fujitsu.com,
        linux-perf-users@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 5/7] arm64: smp: IPI_CPU_STOP and IPI_CPU_CRASH_STOP
 should try for NMI
Message-ID: <ZPBnkkDc9GSxrjmC@FVFF77S0Q05N>
References: <20230830191314.1618136-1-dianders@chromium.org>
 <20230830121115.v12.5.Ifadbfd45b22c52edcb499034dd4783d096343260@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830121115.v12.5.Ifadbfd45b22c52edcb499034dd4783d096343260@changeid>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 12:11:26PM -0700, Douglas Anderson wrote:
> There's no reason why IPI_CPU_STOP and IPI_CPU_CRASH_STOP can't be
> handled as NMI. They are very simple and everything in them is
> NMI-safe. Mark them as things to use NMI for if NMI is available.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Misono Tomohiro <misono.tomohiro@fujitsu.com>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I don't actually have any good way to test/validate this patch. It's
> added to the series at Mark's request.

I've just sent out an LKDTM test that can be used to test this:

  http://lore.kernel.org/lkml/20230831101026.3122590-1-mark.rutland@arm.com

So FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> 
> (no changes since v10)
> 
> Changes in v10:
> - ("IPI_CPU_STOP and IPI_CPU_CRASH_STOP should try for NMI") new for v10.
> 
>  arch/arm64/kernel/smp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 28c904ca499a..800c59cf9b64 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -946,6 +946,8 @@ static bool ipi_should_be_nmi(enum ipi_msg_type ipi)
>  		return false;
>  
>  	switch (ipi) {
> +	case IPI_CPU_STOP:
> +	case IPI_CPU_CRASH_STOP:
>  	case IPI_CPU_BACKTRACE:
>  		return true;
>  	default:
> -- 
> 2.42.0.283.g2d96d420d3-goog
> 

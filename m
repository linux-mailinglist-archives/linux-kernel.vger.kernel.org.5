Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6E27C68FB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbjJLJF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbjJLJF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:05:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79762D7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:05:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DC5213D5;
        Thu, 12 Oct 2023 02:06:34 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.81.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AF8C3F762;
        Thu, 12 Oct 2023 02:05:52 -0700 (PDT)
Date:   Thu, 12 Oct 2023 10:05:50 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: perf: arm_pmuv3: Update 'pmc_width' based on
 actual HW event width
Message-ID: <ZSe27i20fjvh6zSk@FVFF77S0Q05N>
References: <20231009043724.175100-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009043724.175100-1-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 10:07:24AM +0530, Anshuman Khandual wrote:
> This updates 'perf_event_mmap_page->pmc_width' based on actual HW event's
> width that are currently missing i.e ARMPMU_EVT_63BIT and ARMPMU_EVT_47BIT.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v6.6-rc5.
> 
>  drivers/perf/arm_pmuv3.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index fe4db1831662..94723d00548e 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -1375,6 +1375,10 @@ void arch_perf_update_userpage(struct perf_event *event,
>  	if (userpg->cap_user_rdpmc) {
>  		if (event->hw.flags & ARMPMU_EVT_64BIT)
>  			userpg->pmc_width = 64;
> +		else if (event->hw.flags & ARMPMU_EVT_63BIT)
> +			userpg->pmc_width = 63;
> +		else if (event->hw.flags & ARMPMU_EVT_47BIT)
> +			userpg->pmc_width = 47;

The PMUv3 driver *never* uses 63-bit or 47-bit counters, so the PMUv3 driver
doesn't need this. The ARMPMU_EVT_63BIT and ARMPMU_EVT_47BIT flags are only
used by the Apple PMU driver, which doesn't support user access, and similarly
doesn't need to handle this.

This code is not necessary as the two new branches can never run. It will also
confuse people into thinking the PMUv3 driver can use these widths when it
cannot.

NAK to this patch for the reasons above.

Mark

>  		else
>  			userpg->pmc_width = 32;
>  	}
> -- 
> 2.25.1
> 

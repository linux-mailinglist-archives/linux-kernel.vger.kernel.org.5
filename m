Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443047BD761
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345753AbjJIJni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345326AbjJIJng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:43:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BE048F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:43:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 592F01FB;
        Mon,  9 Oct 2023 02:44:15 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6D583F7A6;
        Mon,  9 Oct 2023 02:43:33 -0700 (PDT)
Message-ID: <66125bc2-ff2a-a209-a753-c2e3d8310a45@arm.com>
Date:   Mon, 9 Oct 2023 10:43:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drivers: perf: arm_pmuv3: Update 'pmc_width' based on
 actual HW event width
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, raphael.gault@arm.com
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <20231009043724.175100-1-anshuman.khandual@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20231009043724.175100-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/10/2023 05:37, Anshuman Khandual wrote:
> This updates 'perf_event_mmap_page->pmc_width' based on actual HW event's
> width that are currently missing i.e ARMPMU_EVT_63BIT and ARMPMU_EVT_47BIT.
> 

Might be worth adding why this is needed or what the actual effect is.

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

Although it doesn't explicitly say it, the bit of the docs about
pmc_width in Documentation/arch/arm64/perf.rst loosely implies that this
is always either 64 or 32. Now that this isn't the case it could mislead
someone in userspace that they don't have to handle the now arbitrary
bit widths rather than just whole bytes/ints.

I think the fix is as simple as adding something like "the width may not
match the requested value or necessarily be a multiple of 8". Unless we
think this is already widely known and I suppose we could leave it as
is. (The existing bit in perf that uses it already handles it correctly).

>  		else
>  			userpg->pmc_width = 32;
>  	}

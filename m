Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B957BF9E3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjJJLi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjJJLi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:38:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C8CC94
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:38:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2A0F1FB;
        Tue, 10 Oct 2023 04:39:05 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 751713F7A6;
        Tue, 10 Oct 2023 04:38:24 -0700 (PDT)
Message-ID: <c9f1c76e-5f39-448a-8f07-19f5b4e65e72@arm.com>
Date:   Tue, 10 Oct 2023 12:38:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: perf: arm_pmuv3: Update 'pmc_width' based on
 actual HW event width
Content-Language: en-GB
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <20231009043724.175100-1-anshuman.khandual@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231009043724.175100-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2023 5:37 am, Anshuman Khandual wrote:
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
>   drivers/perf/arm_pmuv3.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index fe4db1831662..94723d00548e 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -1375,6 +1375,10 @@ void arch_perf_update_userpage(struct perf_event *event,
>   	if (userpg->cap_user_rdpmc) {
>   		if (event->hw.flags & ARMPMU_EVT_64BIT)
>   			userpg->pmc_width = 64;
> +		else if (event->hw.flags & ARMPMU_EVT_63BIT)
> +			userpg->pmc_width = 63;
> +		else if (event->hw.flags & ARMPMU_EVT_47BIT)
> +			userpg->pmc_width = 47;

I think this will give the wrong behaviour in at least some cases - if 
the user has not requested a "long" event which would lead to 
ARMPMU_EVT_64BIT being set, we will bias the values to only count 32 
effective bits regardless of how wide the physical counters are. I 
believe this is what "the valid width of the counter" in the 
documentation is trying to refer to.

Thanks,
Robin.

>   		else
>   			userpg->pmc_width = 32;
>   	}

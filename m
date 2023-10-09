Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBE27BD5F6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345563AbjJII7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbjJII7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:59:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1466FAB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 01:59:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AF5B1FB;
        Mon,  9 Oct 2023 02:00:00 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECB173F7A6;
        Mon,  9 Oct 2023 01:59:18 -0700 (PDT)
Message-ID: <ffb41c00-1df8-e4bb-deff-c2d1cfb15ec0@arm.com>
Date:   Mon, 9 Oct 2023 09:59:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] driver: perf: arm_pmuv3: Read PMMIR_EL1 unconditionally
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, zhangshaokun@hisilicon.com
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <20231009075631.193208-1-anshuman.khandual@arm.com>
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20231009075631.193208-1-anshuman.khandual@arm.com>
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



On 09/10/2023 08:56, Anshuman Khandual wrote:
> PMMIR_EL1 needs to be captured in 'armpmu->reg_pmmir', for all appropriate
> PMU version implementations where the register is available and reading it
> is valid . Hence checking for bus slot event presence is redundant and can
> be dropped.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v6.6-rc5.
>  
>  drivers/perf/arm_pmuv3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index 1e72b486c033..9fc1b6da5106 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -1129,7 +1129,7 @@ static void __armv8pmu_probe_pmu(void *info)
>  			     pmceid, ARMV8_PMUV3_MAX_COMMON_EVENTS);
>  
>  	/* store PMMIR register for sysfs */
> -	if (is_pmuv3p4(pmuver) && (pmceid_raw[1] & BIT(31)))
> +	if (is_pmuv3p4(pmuver))
>  		cpu_pmu->reg_pmmir = read_pmmir();
>  	else
>  		cpu_pmu->reg_pmmir = 0;


This does have the side effect of showing non-zero values in caps/slots
even when the STALL_SLOT event isn't implemented. I think that's the
scenario that the original commit (f5be3a61fd) was trying to avoid:

  /sys/bus/event_source/devices/armv8_pmuv3_0/caps/slots is exposed
  under sysfs. [If] Both ARMv8.4-PMU and STALL_SLOT event are
  implemented, it returns the slots from PMMIR_EL1, otherwise it will
  return 0.

I can't really think of a scenario where that would be an issue, and the
availability of the STALL_SLOT event is already discoverable from
userspace through the events folder, so it's probably fine.

Adding the original author just in case. But otherwise:

Reviewed-by: James Clark <james.clark@arm.com>

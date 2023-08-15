Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB3177CB1D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbjHOKZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 06:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbjHOKYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 06:24:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2636810F2;
        Tue, 15 Aug 2023 03:24:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35D871063;
        Tue, 15 Aug 2023 03:25:17 -0700 (PDT)
Received: from [10.57.90.230] (unknown [10.57.90.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60F193F762;
        Tue, 15 Aug 2023 03:24:33 -0700 (PDT)
Message-ID: <ab4a51ea-3956-2d2f-5705-a760be69fb59@arm.com>
Date:   Tue, 15 Aug 2023 11:24:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v6 1/4] perf: arm_cspmu: Split 64-bit write to 32-bit
 writes
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230815063526.9022-1-ilkka@os.amperecomputing.com>
 <20230815063526.9022-2-ilkka@os.amperecomputing.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230815063526.9022-2-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2023 07:35, Ilkka Koskinen wrote:
> Split the 64-bit register accesses if 64-bit access is not supported
> by the PMU.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Reviewed-by: Besar Wicaksono <bwicaksono@nvidia.com>

Do we need a Fixes tag ?

With that:

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Suzuki

> ---
>   drivers/perf/arm_cspmu/arm_cspmu.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 04be94b4aa48..6387cbad7a7d 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -715,7 +715,10 @@ static void arm_cspmu_write_counter(struct perf_event *event, u64 val)
>   	if (use_64b_counter_reg(cspmu)) {
>   		offset = counter_offset(sizeof(u64), event->hw.idx);
>   
> -		writeq(val, cspmu->base1 + offset);
> +		if (cspmu->has_atomic_dword)
> +			writeq(val, cspmu->base1 + offset);
> +		else
> +			lo_hi_writeq(val, cspmu->base1 + offset);


>   	} else {
>   		offset = counter_offset(sizeof(u32), event->hw.idx);
>   


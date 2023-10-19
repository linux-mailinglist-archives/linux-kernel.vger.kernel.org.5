Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9446F7CF3F6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbjJSJXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjJSJXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:23:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D52298
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:23:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C7B22F4;
        Thu, 19 Oct 2023 02:24:30 -0700 (PDT)
Received: from [10.57.3.68] (unknown [10.57.3.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 536A43F5A1;
        Thu, 19 Oct 2023 02:23:48 -0700 (PDT)
Message-ID: <e642fa48-ed0a-f785-42ba-2df1249e0593@arm.com>
Date:   Thu, 19 Oct 2023 10:23:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] coresight: etm4x: Allow configuring cycle count threshold
To:     Wei-Ning Huang <wnhuang@google.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        james.clark@arm.com, leo.yan@linaro.org
Cc:     linux-kernel@vger.kernel.org
References: <20231019082357.1505047-1-wnhuang@google.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20231019082357.1505047-1-wnhuang@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2023 09:23, Wei-Ning Huang wrote:
> Allow userspace to configure cycle count threshold through
> perf_event_attr config. The last high 12-bit of config value is used to
> store the cycle count threshold.
> 

We have queued the support already in coreisght next tree,
patches posted here [0]

[0] - 
https://lore.kernel.org/r/20230921033631.1298723-1-anshuman.khandual@arm.com

Suzuki

> Signed-off-by: Wei-Ning Huang <wnhuang@google.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm4x-core.c |  6 +++++-
>   include/linux/coresight-pmu.h                      | 14 ++++++++------
>   tools/include/linux/coresight-pmu.h                | 14 ++++++++------
>   3 files changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 77b0271ce6eb..155441668b4a 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -645,6 +645,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>   	struct perf_event_attr *attr = &event->attr;
>   	unsigned long cfg_hash;
>   	int preset;
> +	u64 cyc_threadhold;
>   
>   	/* Clear configuration from previous run */
>   	memset(config, 0, sizeof(struct etmv4_config));
> @@ -667,7 +668,10 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>   	if (attr->config & BIT(ETM_OPT_CYCACC)) {
>   		config->cfg |= TRCCONFIGR_CCI;
>   		/* TRM: Must program this for cycacc to work */
> -		config->ccctlr = ETM_CYC_THRESHOLD_DEFAULT;
> +		cyc_threshold = ((attr->config >> ETM_OPT_CYC_THRESHOLD_SHIFT) &
> +				 ETM_OPT_CYC_THRESHOLD_MASK;
> +		config->ccctlr = cyc_threshold ? cyc_threshold :
> +				 ETM_CYC_THRESHOLD_DEFAULT;
>   	}
>   	if (attr->config & BIT(ETM_OPT_TS)) {
>   		/*
> diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
> index 51ac441a37c3..14f48658ff1c 100644
> --- a/include/linux/coresight-pmu.h
> +++ b/include/linux/coresight-pmu.h
> @@ -29,12 +29,14 @@
>    * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
>    * directly use below macros as config bits.
>    */
> -#define ETM_OPT_BRANCH_BROADCAST 8
> -#define ETM_OPT_CYCACC		12
> -#define ETM_OPT_CTXTID		14
> -#define ETM_OPT_CTXTID2		15
> -#define ETM_OPT_TS		28
> -#define ETM_OPT_RETSTK		29
> +#define ETM_OPT_BRANCH_BROADCAST	8
> +#define ETM_OPT_CYCACC			12
> +#define ETM_OPT_CTXTID			14
> +#define ETM_OPT_CTXTID2			15
> +#define ETM_OPT_TS			28
> +#define ETM_OPT_RETSTK			29
> +#define ETM_OPT_CYC_THRESHOLD_SHIFT	52
> +#define ETM_OPT_CYC_THRESHOLD_MASK	0xfff
>   
>   /* ETMv4 CONFIGR programming bits for the ETM OPTs */
>   #define ETM4_CFG_BIT_BB         3
> diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
> index 51ac441a37c3..14f48658ff1c 100644
> --- a/tools/include/linux/coresight-pmu.h
> +++ b/tools/include/linux/coresight-pmu.h
> @@ -29,12 +29,14 @@
>    * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
>    * directly use below macros as config bits.
>    */
> -#define ETM_OPT_BRANCH_BROADCAST 8
> -#define ETM_OPT_CYCACC		12
> -#define ETM_OPT_CTXTID		14
> -#define ETM_OPT_CTXTID2		15
> -#define ETM_OPT_TS		28
> -#define ETM_OPT_RETSTK		29
> +#define ETM_OPT_BRANCH_BROADCAST	8
> +#define ETM_OPT_CYCACC			12
> +#define ETM_OPT_CTXTID			14
> +#define ETM_OPT_CTXTID2			15
> +#define ETM_OPT_TS			28
> +#define ETM_OPT_RETSTK			29
> +#define ETM_OPT_CYC_THRESHOLD_SHIFT	52
> +#define ETM_OPT_CYC_THRESHOLD_MASK	0xfff
>   
>   /* ETMv4 CONFIGR programming bits for the ETM OPTs */
>   #define ETM4_CFG_BIT_BB         3


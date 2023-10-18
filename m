Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DBA7CD66D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbjJRI3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344651AbjJRI3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:29:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6426BEA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:29:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E1452F4;
        Wed, 18 Oct 2023 01:29:43 -0700 (PDT)
Received: from [10.57.3.139] (unknown [10.57.3.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 223043F64C;
        Wed, 18 Oct 2023 01:29:01 -0700 (PDT)
Message-ID: <f7ccb9c4-60f4-7037-085d-3f36ae024219@arm.com>
Date:   Wed, 18 Oct 2023 09:28:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] coresight: etm4x: Enable ETE device accessed via MMIO
To:     Ruidong Tian <tianruidong@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Cc:     james.clark@arm.com, coresight@lists.linaro.org,
        mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org
References: <20231018070506.65320-1-tianruidong@linux.alibaba.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20231018070506.65320-1-tianruidong@linux.alibaba.com>
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

On 18/10/2023 08:05, Ruidong Tian wrote:
> The ETM4X driver now assume that all ETE as CPU system instructions
> accessed device, in fact the ETE device on some machines also accessed
> via MMIO.
> 
> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>

Why are we going backwards to MMIO from system instructions ? Is it 
because of an "unfriendly" hypervisor preventing access ?

As such, without a sufficiently acceptable explanation, I am reluctant
to make this change

Suzuki

> ---
>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 285539104bcc..ad298c9cc87e 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1103,8 +1103,9 @@ static bool etm4_init_iomem_access(struct etmv4_drvdata *drvdata,
>   	 * with MMIO. But we cannot touch the OSLK until we are
>   	 * sure this is an ETM. So rely only on the TRCDEVARCH.
>   	 */
> -	if ((devarch & ETM_DEVARCH_ID_MASK) != ETM_DEVARCH_ETMv4x_ARCH) {
> -		pr_warn_once("TRCDEVARCH doesn't match ETMv4 architecture\n");
> +	if ((devarch & ETM_DEVARCH_ID_MASK) != ETM_DEVARCH_ETMv4x_ARCH &&
> +		(devarch & ETM_DEVARCH_ID_MASK) != ETM_DEVARCH_ETE_ARCH) {
> +		pr_warn_once("TRCDEVARCH doesn't match ETMv4/ETE architecture\n");
>   		return false;
>   	}
>   


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C064278A1F7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 23:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjH0ViP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 17:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjH0Vhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 17:37:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38685C5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 14:37:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53BF21FB;
        Sun, 27 Aug 2023 14:38:21 -0700 (PDT)
Received: from [10.57.3.66] (unknown [10.57.3.66])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E24183F738;
        Sun, 27 Aug 2023 14:37:39 -0700 (PDT)
Message-ID: <382193a4-4f30-d804-47da-a9c705b6bee5@arm.com>
Date:   Sun, 27 Aug 2023 22:37:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] coresight: tmc-etr: Don't fail probe when non-secure
 access is disabled
To:     Yabin Cui <yabinc@google.com>, Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230825233930.1875819-1-yabinc@google.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230825233930.1875819-1-yabinc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2023 00:39, Yabin Cui wrote:
> Because the non-secure access can be enabled later on some devices.

How can this be enabled ? Why not enable it before probing the ETR ?
How can a user know if this has been done or not ? It is asking for
trouble to continue without this.

Suzuki

> 
> Signed-off-by: Yabin Cui <yabinc@google.com>
> ---
>   drivers/hwtracing/coresight/coresight-tmc-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> index c106d142e632..5ebfd12b627b 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> @@ -370,7 +370,7 @@ static int tmc_etr_setup_caps(struct device *parent, u32 devid, void *dev_caps)
>   	struct tmc_drvdata *drvdata = dev_get_drvdata(parent);
>   
>   	if (!tmc_etr_has_non_secure_access(drvdata))
> -		return -EACCES;
> +		dev_warn(parent, "TMC ETR doesn't have non-secure access\n");
>   
>   	/* Set the unadvertised capabilities */
>   	tmc_etr_init_caps(drvdata, (u32)(unsigned long)dev_caps);


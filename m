Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FC3755F30
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjGQJ0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjGQJ0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:26:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8EDEC7;
        Mon, 17 Jul 2023 02:26:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55B8BD75;
        Mon, 17 Jul 2023 02:26:54 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D29D23F73F;
        Mon, 17 Jul 2023 02:26:09 -0700 (PDT)
Message-ID: <b5471ed9-66e9-8df4-e973-0dfb8091596b@arm.com>
Date:   Mon, 17 Jul 2023 10:26:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] hwtracing: coresight: Explicitly include correct DT
 includes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     devicetree@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230714174611.4057415-1-robh@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230714174611.4057415-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob

Thanks for the cleanup. Please find my comments below.

On 14/07/2023 18:46, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   drivers/hwtracing/coresight/coresight-core.c     | 2 +-
>   drivers/hwtracing/coresight/coresight-platform.c | 3 +--
>   2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 118fcf27854d..9fabe00a40d6 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -17,7 +17,7 @@
>   #include <linux/mutex.h>
>   #include <linux/clk.h>
>   #include <linux/coresight.h>
> -#include <linux/of_platform.h>
> +#include <linux/property.h>
>   #include <linux/delay.h>
>   #include <linux/pm_runtime.h>

This looks correct to me.

>   
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 3e2e135cb8f6..d94b0e77bcfc 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -9,9 +9,8 @@
>   #include <linux/slab.h>
>   #include <linux/clk.h>
>   #include <linux/of.h>
> -#include <linux/of_address.h>
> +#include <linux/of.h>

We already include of.h two lines above, so we could skip this.

>   #include <linux/of_graph.h>
> -#include <linux/of_platform.h>
>   #include <linux/platform_device.h>
>   #include <linux/amba/bus.h>
>   #include <linux/coresight.h>

Suzuki


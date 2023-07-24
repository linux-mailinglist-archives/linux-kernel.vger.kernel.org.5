Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA6475FAE6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjGXPiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjGXPiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:38:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CABB121
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:38:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71E0B11FB;
        Mon, 24 Jul 2023 08:38:56 -0700 (PDT)
Received: from [10.57.1.47] (unknown [10.57.1.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CC6F3F67D;
        Mon, 24 Jul 2023 08:38:12 -0700 (PDT)
Message-ID: <61f11ffe-473c-a36e-c51d-9e526a6fd375@arm.com>
Date:   Mon, 24 Jul 2023 16:38:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RESEND PATCH] coresight: tmc: Explicit type conversions to
 prevent integer overflow
Content-Language: en-US
To:     Ruidong Tian <tianruidong@linux.alibaba.com>,
        coresight@lists.linaro.org
Cc:     mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230714084349.31567-1-tianruidong@linux.alibaba.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230714084349.31567-1-tianruidong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/07/2023 09:43, Ruidong Tian wrote:
> Perf cs_etm session will failed when AUX buffer > 1G.
> 
>   perf record -C 0 -m ,2G -e cs_etm// -- taskset -c 0 ls
>   failed to mmap with 12 (Cannot allocate memory)
> 
> In coresight tmc driver, "nr_pages << PAGE_SHIFT" will overflow when
> nr_pages >= 0x80000(correspond to 1G AUX buffer). Explicit convert nr_pages
> to 64 bit to avoid overflow.
> 

Hi Ruidong,

I couldn't reproduce this exact issue with the error message in the
commit message. Is it not another manifestation related to this change
[1]? I don't actually get any error message, but I was able to get a
warning in dmesg even with [1] applied.

Does the overflow not result in a successful session but with the wrong
buffer size?

I think the change makes sense, but maybe we also need a check for
MAX_ORDER because I can trigger the same WARN_ON from [1]. Or maybe I'm
a bit confused because of the other change and not being able to
reproduce this exactly coming at the same time.

[1]:
https://lore.kernel.org/bpf/20230711014120.53461-1-xueshuai@linux.alibaba.com/

Thanks
James

> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 +-
>  drivers/hwtracing/coresight/coresight-tmc.h     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 766325de0e29..1425ecd1cf78 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1267,7 +1267,7 @@ alloc_etr_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
>  	 * than the size requested via sysfs.
>  	 */
>  	if ((nr_pages << PAGE_SHIFT) > drvdata->size) {
> -		etr_buf = tmc_alloc_etr_buf(drvdata, (nr_pages << PAGE_SHIFT),
> +		etr_buf = tmc_alloc_etr_buf(drvdata, ((ssize_t)nr_pages << PAGE_SHIFT),
>  					    0, node, NULL);
>  		if (!IS_ERR(etr_buf))
>  			goto done;
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index b97da39652d2..0ee48c5ba764 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -325,7 +325,7 @@ ssize_t tmc_sg_table_get_data(struct tmc_sg_table *sg_table,
>  static inline unsigned long
>  tmc_sg_table_buf_size(struct tmc_sg_table *sg_table)
>  {
> -	return sg_table->data_pages.nr_pages << PAGE_SHIFT;
> +	return (unsigned long)sg_table->data_pages.nr_pages << PAGE_SHIFT;
>  }
>  
>  struct coresight_device *tmc_etr_get_catu_device(struct tmc_drvdata *drvdata);

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A75A76EF44
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbjHCQTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbjHCQTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:19:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCA4F3AA6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 09:19:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 819D2113E;
        Thu,  3 Aug 2023 09:20:16 -0700 (PDT)
Received: from [10.57.90.14] (unknown [10.57.90.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 624213F5A1;
        Thu,  3 Aug 2023 09:19:32 -0700 (PDT)
Message-ID: <0410712c-d658-8f54-5a29-699a68bc0dea@arm.com>
Date:   Thu, 3 Aug 2023 17:19:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] coresight: tmc: Explicit type conversions to prevent
 integer overflow
To:     Ruidong Tian <tianruidong@linux.alibaba.com>
Cc:     alexander.shishkin@linux.intel.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, james.clark@arm.com
References: <20230714084349.31567-1-tianruidong@linux.alibaba.com>
 <20230803023321.111078-1-tianruidong@linux.alibaba.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230803023321.111078-1-tianruidong@linux.alibaba.com>
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

On 03/08/2023 03:33, Ruidong Tian wrote:
> Perf cs_etm session executed unexpectedly when AUX buffer > 1G.
> 
>    perf record -C 0 -m ,2G -e cs_etm// -- <workload>
>    [ perf record: Captured and wrote 2.615 MB perf.data ]
> 
> Perf only collect about 2M perf data rather than 2G. This is becasuse
> the operation, "nr_pages << PAGE_SHIFT", in coresight tmc driver, will
> overflow when nr_pages >= 0x80000(correspond to 1G AUX buffer). The
> overflow cause buffer allocation to fail, and TMC driver will alloc
> minimal buffer size(1M). You can just get about 2M perf data(1M AUX
> buffer + perf data header) at least.
> 
> Explicit convert nr_pages to 64 bit to avoid overflow.
> 
> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
> Reviewed-by: James Clark <james.clark@arm.com>

Fixes: 22f429f19c41 ("coresight: etm-perf: Add support for ETR backend")


> ---
>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 +-
>   drivers/hwtracing/coresight/coresight-tmc.h     | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 766325de0e29..1425ecd1cf78 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1267,7 +1267,7 @@ alloc_etr_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
>   	 * than the size requested via sysfs.
>   	 */
>   	if ((nr_pages << PAGE_SHIFT) > drvdata->size) {
> -		etr_buf = tmc_alloc_etr_buf(drvdata, (nr_pages << PAGE_SHIFT),
> +		etr_buf = tmc_alloc_etr_buf(drvdata, ((ssize_t)nr_pages << PAGE_SHIFT),
>   					    0, node, NULL);
>   		if (!IS_ERR(etr_buf))
>   			goto done;
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index b97da39652d2..0ee48c5ba764 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -325,7 +325,7 @@ ssize_t tmc_sg_table_get_data(struct tmc_sg_table *sg_table,
>   static inline unsigned long
>   tmc_sg_table_buf_size(struct tmc_sg_table *sg_table)
>   {
> -	return sg_table->data_pages.nr_pages << PAGE_SHIFT;
> +	return (unsigned long)sg_table->data_pages.nr_pages << PAGE_SHIFT;
>   }
>   
>   struct coresight_device *tmc_etr_get_catu_device(struct tmc_drvdata *drvdata);

There are other places where such a fix is needed.
e.g.,

$ git grep "nr_pages << PAGE_SHIFT" 
drivers/hwtracing/coresight/coresight-tmc*
drivers/hwtracing/coresight/coresight-tmc-etf.c:        head = 
handle->head & ((buf->nr_pages << PAGE_SHIFT) - 1);
drivers/hwtracing/coresight/coresight-tmc-etr.c:#define 
PERF_IDX2OFF(idx, buf)  ((idx) % ((buf)->nr_pages << PAGE_SHIFT))
drivers/hwtracing/coresight/coresight-tmc-etr.c:        if ((nr_pages << 
PAGE_SHIFT) > drvdata->size) {
drivers/hwtracing/coresight/coresight-tmc-etr.c:                etr_buf 
= tmc_alloc_etr_buf(drvdata, (nr_pages << PAGE_SHIFT),
drivers/hwtracing/coresight/coresight-tmc.h:    return 
sg_table->data_pages.nr_pages << PAGE_SHIFT;

Are you able to fix all of them ?

Suzuki


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77137AD494
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbjIYJfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjIYJfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:35:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11511DA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:35:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1CA2DA7;
        Mon, 25 Sep 2023 02:35:42 -0700 (PDT)
Received: from [10.57.0.188] (unknown [10.57.0.188])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45D8E3F5A1;
        Mon, 25 Sep 2023 02:35:03 -0700 (PDT)
Message-ID: <c8bc1219-77ac-f8b7-a9be-f108653a1675@arm.com>
Date:   Mon, 25 Sep 2023 10:34:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] perf/arm-cmn: Fix the unhandled overflow status of
 counter 4 to 7
Content-Language: en-GB
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1695612152-123633-1-git-send-email-renyu.zj@linux.alibaba.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1695612152-123633-1-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-25 04:22, Jing Zhang wrote:
> The register por_dt_pmovsr Bits[7:0] indicates overflow from counters 7
> to 0. But in arm_cmn_handle_irq(), only handled the overflow status of
> Bits[3:0] which results in unhandled overflow status of counters 4 to 7.
> 
> So let the overflow status of DTC counters 4 to 7 to be handled.

Oh dear goodness, how has such a stupid typo managed to exist for 4 
years? Truly this is a brown paper bag moment... :(

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Fixes: 0ba64770a2f2 ("perf: Add Arm CMN-600 PMU driver")
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> ---
>   drivers/perf/arm-cmn.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 913dc04..6b50bc5 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -1972,7 +1972,7 @@ static irqreturn_t arm_cmn_handle_irq(int irq, void *dev_id)
>   		u64 delta;
>   		int i;
>   
> -		for (i = 0; i < CMN_DTM_NUM_COUNTERS; i++) {
> +		for (i = 0; i < CMN_DT_NUM_COUNTERS; i++) {
>   			if (status & (1U << i)) {
>   				ret = IRQ_HANDLED;
>   				if (WARN_ON(!dtc->counters[i]))

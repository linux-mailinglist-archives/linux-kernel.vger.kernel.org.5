Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096B877016C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjHDN0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjHDN0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:26:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80A3E4C1E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:26:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 223851007;
        Fri,  4 Aug 2023 06:17:15 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 668A33F5A1;
        Fri,  4 Aug 2023 06:16:31 -0700 (PDT)
Message-ID: <a9349988-6153-05f7-10de-4af47b49761c@arm.com>
Date:   Fri, 4 Aug 2023 14:16:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/1] coresight: tmc: Explicit type conversions to
 prevent integer overflow
Content-Language: en-US
To:     Ruidong Tian <tianruidong@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        james.clark@arm.com
References: <20230714084349.31567-1-tianruidong@linux.alibaba.com>
 <20230804081514.120171-1-tianruidong@linux.alibaba.com>
 <20230804081514.120171-2-tianruidong@linux.alibaba.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230804081514.120171-2-tianruidong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023 09:15, Ruidong Tian wrote:
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
> Fixes: 22f429f19c41 ("coresight: etm-perf: Add support for ETR backend")
> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
> Reviewed-by: James Clark <james.clark@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-tmc-etf.c | 2 +-
>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 5 +++--
>   drivers/hwtracing/coresight/coresight-tmc.h     | 2 +-
>   3 files changed, 5 insertions(+), 4 deletions(-)


Added additional Fixes tags as required and pushed it here :

https://git.kernel.org/coresight/c/fd380097cdb3

Thanks!
Suzuki

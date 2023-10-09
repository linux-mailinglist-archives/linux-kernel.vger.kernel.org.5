Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854BF7BDBC0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376343AbjJIM1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346402AbjJIM1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:27:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD9F999
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:27:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8AA61FB;
        Mon,  9 Oct 2023 05:28:28 -0700 (PDT)
Received: from [10.57.3.51] (unknown [10.57.3.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F4363F762;
        Mon,  9 Oct 2023 05:27:46 -0700 (PDT)
Message-ID: <b6050a3f-d464-6b0a-dc79-18103dd7d527@arm.com>
Date:   Mon, 9 Oct 2023 13:27:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] coresight: Fix crash when Perf and sysfs modes are used
 concurrently
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        hejunhao3@huawei.com
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231006131452.646721-1-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20231006131452.646721-1-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Junhao He,

Please could you test the patch and let us know if it resolves the
problem for you ?

On 06/10/2023 14:14, James Clark wrote:
> Partially revert the change in commit 6148652807ba ("coresight: Enable
> and disable helper devices adjacent to the path") which changed the bare
> call from source_ops(csdev)->enable() to coresight_enable_source() for
> Perf sessions. It was missed that coresight_enable_source() is
> specifically for the sysfs interface, rather than being a generic call.
> This interferes with the sysfs reference counting to cause the following
> crash:
> 
>    $ perf record -e cs_etm/@tmc_etr0/ -C 0 &
>    $ echo 1 > /sys/bus/coresight/devices/tmc_etr0/enable_sink
>    $ echo 1 > /sys/bus/coresight/devices/etm0/enable_source
>    $ echo 0 > /sys/bus/coresight/devices/etm0/enable_source
> 
>    Unable to handle kernel NULL pointer dereference at virtual
>    address 00000000000001d0
>    Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>    ...
>    Call trace:
>     etm4_disable+0x54/0x150 [coresight_etm4x]
>     coresight_disable_source+0x6c/0x98 [coresight]
>     coresight_disable+0x74/0x1c0 [coresight]
>     enable_source_store+0x88/0xa0 [coresight]
>     dev_attr_store+0x20/0x40
>     sysfs_kf_write+0x4c/0x68
>     kernfs_fop_write_iter+0x120/0x1b8
>     vfs_write+0x2dc/0x3b0
>     ksys_write+0x70/0x108
>     __arm64_sys_write+0x24/0x38
>     invoke_syscall+0x50/0x128
>     el0_svc_common.constprop.0+0x104/0x130
>     do_el0_svc+0x40/0xb8
>     el0_svc+0x2c/0xb8
>     el0t_64_sync_handler+0xc0/0xc8
>     el0t_64_sync+0x1a4/0x1a8
>    Code: d53cd042 91002000 b9402a81 b8626800 (f940ead5)
>    ---[ end trace 0000000000000000 ]---
> 
> This commit linked below also fixes the issue, but has unlocked updates
> to the mode which could potentially race. So until we come up with a
> more complete solution that takes all locking and interaction between
> both modes into account, just revert back to the old behavior for Perf.
> 
> Reported-by: Junhao He <hejunhao3@huawei.com>
> Closes: https://lore.kernel.org/linux-arm-kernel/20230921132904.60996-1-hejunhao3@huawei.com/
> Fixes: 6148652807ba ("coresight: Enable and disable helper devices adjacent to the path")
> Signed-off-by: James Clark <james.clark@arm.com>

The patch looks good to me. I will wait for Junhao to test this before
pulling it in.

Suzuki




> ---
>   drivers/hwtracing/coresight/coresight-etm-perf.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 5ca6278baff4..89e8ed214ea4 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -493,7 +493,7 @@ static void etm_event_start(struct perf_event *event, int flags)
>   		goto fail_end_stop;
>   
>   	/* Finally enable the tracer */
> -	if (coresight_enable_source(csdev, CS_MODE_PERF, event))
> +	if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF))
>   		goto fail_disable_path;
>   
>   	/*
> @@ -587,7 +587,7 @@ static void etm_event_stop(struct perf_event *event, int mode)
>   		return;
>   
>   	/* stop tracer */
> -	coresight_disable_source(csdev, event);
> +	source_ops(csdev)->disable(csdev, event);
>   
>   	/* tell the core */
>   	event->hw.state = PERF_HES_STOPPED;


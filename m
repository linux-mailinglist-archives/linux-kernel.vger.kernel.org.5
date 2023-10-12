Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969FA7C6BF9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378046AbjJLLML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343805AbjJLLMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:12:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB629B7;
        Thu, 12 Oct 2023 04:12:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E62713D5;
        Thu, 12 Oct 2023 04:12:48 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE1C43F762;
        Thu, 12 Oct 2023 04:12:04 -0700 (PDT)
Message-ID: <9eaae02d-360a-4676-98e9-1070222acc40@arm.com>
Date:   Thu, 12 Oct 2023 12:12:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight-tmc-etr: Fix busy error when enable multiple
 sources
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>
References: <20231012110754.32635-1-quic_jinlmao@quicinc.com>
Content-Language: en-US
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20231012110754.32635-1-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2023 12:07, Mao Jinlong wrote:
> In enable sink sysfs function, when etr is enabled, it doesn't need
> to call enable hw function again.
> 
> [   91.057233] ------------[ cut here ]------------
> [   91.061983] WARNING: CPU: 6 PID: 145 at drivers/hwtracing/coresight/coresight-tmc-etr.c:1038 tmc_etr_enable_hw+0xc4/0xd0
> [   91.073153] Modules linked in:
> [   91.076302] CPU: 6 PID: 145 Comm: sh Tainted: G S      W          6.5.0-rc3-g66d5eaa9e5a7 #111
> [   91.085149] Hardware name: Qualcomm Technologies, Inc. SM8450 QRD (DT)
> [   91.091847] pstate: 634000c5 (nZCv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> [   91.099000] pc : tmc_etr_enable_hw+0xc4/0xd0
> [   91.103389] lr : tmc_enable_etr_sink+0x13c/0x294
> [   91.108130] sp : ffff8000815cbb30
> [   91.111537] x29: ffff8000815cbb30 x28: ffff68ce4352a800 x27: 0000000000000000
> [   91.118868] x26: ffff68ce414cc040 x25: ffff68ce414a82e0 x24: 0000000000000000
> [   91.126199] x23: ffff68ce423a1ee0 x22: ffff68ce423a1e80 x21: ffff68ce4352a800
> [   91.133527] x20: 0000000000000001 x19: ffff68ce414aa500 x18: fffffda31cf9c008
> [   91.140857] x17: 0000000000000040 x16: 0000000000000001 x15: fffffc0000000000
> [   91.148188] x14: 00000000f0000080 x13: 0000000000000000 x12: ffff9739c0000000
> [   91.155516] x11: ffffbe9cdf71e400 x10: 0000000000001000 x9 : ffff68d0b29e3b28
> [   91.162845] x8 : fffffda31cf983c8 x7 : fffffda31cf98388 x6 : 00000000ffffffd0
> [   91.170174] x5 : ffff68ce435d8ec0 x4 : ffff68d0b29e2610 x3 : ffff68ce435d8ec0
> [   91.177502] x2 : ffff68ce414aa500 x1 : ffff68ce414aa500 x0 : ffff68ce423a1e80
> [   91.184833] Call trace:
> [   91.187349]  tmc_etr_enable_hw+0xc4/0xd0
> [   91.191388]  tmc_enable_etr_sink+0x13c/0x294
> [   91.195777]  coresight_enable_path+0x21c/0x24c
> [   91.200347]  coresight_enable+0x9c/0x204
> [   91.204379]  enable_source_store+0x58/0xa0
> [   91.208595]  dev_attr_store+0x18/0x2c
> [   91.212361]  sysfs_kf_write+0x40/0x54
> [   91.216126]  kernfs_fop_write_iter+0x164/0x1dc
> [   91.220692]  vfs_write+0x3a8/0x460
> [   91.224191]  ksys_write+0x6c/0x100
> [   91.227690]  __arm64_sys_write+0x1c/0x28
> [   91.231728]  invoke_syscall+0x44/0x100
> [   91.235586]  el0_svc_common.constprop.1+0x6c/0xe4
> [   91.240418]  do_el0_svc+0x38/0x94
> [   91.243833]  el0_svc+0x28/0x74
> [   91.246981]  el0t_64_sync_handler+0xa0/0xc4
> [   91.251282]  el0t_64_sync+0x174/0x178
> [   91.255045] ---[ end trace 0000000000000000 ]---
> sh: write error: Device or resource busy
> 

Please could you try this patch ?

https://lore.kernel.org/r/20230823042948.12879-1-lcherian@marvell.com

It is queued in Greg's tree for v6.6, hopefully it will hit -rc6.

Suzuki


> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 66dc5f97a009..e1c7bae9f6ee 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1204,7 +1204,7 @@ static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
>   
>   static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
>   {
> -	int ret;
> +	int ret = 0;
>   	unsigned long flags;
>   	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>   	struct etr_buf *sysfs_buf = tmc_etr_get_sysfs_buffer(csdev);
> @@ -1213,12 +1213,16 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
>   		return PTR_ERR(sysfs_buf);
>   
>   	spin_lock_irqsave(&drvdata->spinlock, flags);
> +	if (drvdata->mode == CS_MODE_SYSFS)
> +		goto out;
> +
>   	ret = tmc_etr_enable_hw(drvdata, sysfs_buf);
>   	if (!ret) {
>   		drvdata->mode = CS_MODE_SYSFS;
>   		atomic_inc(&csdev->refcnt);
>   	}
>   
> +out:
>   	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>   
>   	if (!ret)


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072CD7EC90F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjKOQvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjKOQvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:51:35 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95880196
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:51:32 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6F2ADA7;
        Wed, 15 Nov 2023 08:52:17 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E91BF3F641;
        Wed, 15 Nov 2023 08:51:30 -0800 (PST)
Message-ID: <bac9a753-b1fb-5cd2-404b-832c80a94f89@arm.com>
Date:   Wed, 15 Nov 2023 16:51:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 4/4] coresight: ultrasoc-smb: Use guards to cleanup
Content-Language: en-US
To:     Junhao He <hejunhao3@huawei.com>, suzuki.poulose@arm.com
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        jonathan.cameron@huawei.com, yangyicong@huawei.com,
        prime.zeng@hisilicon.com, u.kleine-koenig@pengutronix.de
References: <20231114133346.30489-1-hejunhao3@huawei.com>
 <20231114133346.30489-5-hejunhao3@huawei.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20231114133346.30489-5-hejunhao3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/11/2023 13:33, Junhao He wrote:
> Use guards to reduce gotos and simplify control flow.
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>

Nice cleanup!

Reviewed-by: James Clark <james.clark@arm.com>

> ---
>  drivers/hwtracing/coresight/ultrasoc-smb.c | 70 +++++++---------------
>  1 file changed, 22 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
> index 6e32d31a95fe..cd14b2eded4e 100644
> --- a/drivers/hwtracing/coresight/ultrasoc-smb.c
> +++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
> @@ -97,27 +97,19 @@ static int smb_open(struct inode *inode, struct file *file)
>  {
>  	struct smb_drv_data *drvdata = container_of(file->private_data,
>  					struct smb_drv_data, miscdev);
> -	int ret = 0;
>  
> -	spin_lock(&drvdata->spinlock);
> +	guard(spinlock)(&drvdata->spinlock);
>  
> -	if (drvdata->reading) {
> -		ret = -EBUSY;
> -		goto out;
> -	}
> +	if (drvdata->reading)
> +		return -EBUSY;
>  
> -	if (atomic_read(&drvdata->csdev->refcnt)) {
> -		ret = -EBUSY;
> -		goto out;
> -	}
> +	if (atomic_read(&drvdata->csdev->refcnt))
> +		return -EBUSY;
>  
>  	smb_update_data_size(drvdata);
> -
>  	drvdata->reading = true;
> -out:
> -	spin_unlock(&drvdata->spinlock);
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static ssize_t smb_read(struct file *file, char __user *data, size_t len,
> @@ -160,9 +152,8 @@ static int smb_release(struct inode *inode, struct file *file)
>  	struct smb_drv_data *drvdata = container_of(file->private_data,
>  					struct smb_drv_data, miscdev);
>  
> -	spin_lock(&drvdata->spinlock);
> +	guard(spinlock)(&drvdata->spinlock);
>  	drvdata->reading = false;
> -	spin_unlock(&drvdata->spinlock);
>  
>  	return 0;
>  }
> @@ -255,19 +246,15 @@ static int smb_enable(struct coresight_device *csdev, enum cs_mode mode,
>  	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
>  	int ret = 0;
>  
> -	spin_lock(&drvdata->spinlock);
> +	guard(spinlock)(&drvdata->spinlock);
>  
>  	/* Do nothing, the trace data is reading by other interface now */
> -	if (drvdata->reading) {
> -		ret = -EBUSY;
> -		goto out;
> -	}
> +	if (drvdata->reading)
> +		return -EBUSY;
>  
>  	/* Do nothing, the SMB is already enabled as other mode */
> -	if (drvdata->mode != CS_MODE_DISABLED && drvdata->mode != mode) {
> -		ret = -EBUSY;
> -		goto out;
> -	}
> +	if (drvdata->mode != CS_MODE_DISABLED && drvdata->mode != mode)
> +		return -EBUSY;
>  
>  	switch (mode) {
>  	case CS_MODE_SYSFS:
> @@ -281,13 +268,10 @@ static int smb_enable(struct coresight_device *csdev, enum cs_mode mode,
>  	}
>  
>  	if (ret)
> -		goto out;
> +		return ret;
>  
>  	atomic_inc(&csdev->refcnt);
> -
>  	dev_dbg(&csdev->dev, "Ultrasoc SMB enabled\n");
> -out:
> -	spin_unlock(&drvdata->spinlock);
>  
>  	return ret;
>  }
> @@ -295,19 +279,14 @@ static int smb_enable(struct coresight_device *csdev, enum cs_mode mode,
>  static int smb_disable(struct coresight_device *csdev)
>  {
>  	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
> -	int ret = 0;
>  
> -	spin_lock(&drvdata->spinlock);
> +	guard(spinlock)(&drvdata->spinlock);
>  
> -	if (drvdata->reading) {
> -		ret = -EBUSY;
> -		goto out;
> -	}
> +	if (drvdata->reading)
> +		return -EBUSY;
>  
> -	if (atomic_dec_return(&csdev->refcnt)) {
> -		ret = -EBUSY;
> -		goto out;
> -	}
> +	if (atomic_dec_return(&csdev->refcnt))
> +		return -EBUSY;
>  
>  	/* Complain if we (somehow) got out of sync */
>  	WARN_ON_ONCE(drvdata->mode == CS_MODE_DISABLED);
> @@ -317,12 +296,9 @@ static int smb_disable(struct coresight_device *csdev)
>  	/* Dissociate from the target process. */
>  	drvdata->pid = -1;
>  	drvdata->mode = CS_MODE_DISABLED;
> -
>  	dev_dbg(&csdev->dev, "Ultrasoc SMB disabled\n");
> -out:
> -	spin_unlock(&drvdata->spinlock);
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static void *smb_alloc_buffer(struct coresight_device *csdev,
> @@ -395,17 +371,17 @@ static unsigned long smb_update_buffer(struct coresight_device *csdev,
>  	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
>  	struct smb_data_buffer *sdb = &drvdata->sdb;
>  	struct cs_buffers *buf = sink_config;
> -	unsigned long data_size = 0;
> +	unsigned long data_size;
>  	bool lost = false;
>  
>  	if (!buf)
>  		return 0;
>  
> -	spin_lock(&drvdata->spinlock);
> +	guard(spinlock)(&drvdata->spinlock);
>  
>  	/* Don't do anything if another tracer is using this sink. */
>  	if (atomic_read(&csdev->refcnt) != 1)
> -		goto out;
> +		return 0;
>  
>  	smb_disable_hw(drvdata);
>  	smb_update_data_size(drvdata);
> @@ -424,8 +400,6 @@ static unsigned long smb_update_buffer(struct coresight_device *csdev,
>  	smb_sync_perf_buffer(drvdata, buf, handle->head);
>  	if (!buf->snapshot && lost)
>  		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
> -out:
> -	spin_unlock(&drvdata->spinlock);
>  
>  	return data_size;
>  }

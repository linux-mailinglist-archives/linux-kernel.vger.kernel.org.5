Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488CD7EC8DA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjKOQn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjKOQnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:43:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4DB3181
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:43:51 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47F37DA7;
        Wed, 15 Nov 2023 08:44:37 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DFAB3F641;
        Wed, 15 Nov 2023 08:43:50 -0800 (PST)
Message-ID: <f5effc3e-91b7-9e96-d1e6-dbbd596c21a3@arm.com>
Date:   Wed, 15 Nov 2023 16:43:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/4] coresight: ultrasoc-smb: Config SMB buffer before
 register sink
Content-Language: en-US
To:     Junhao He <hejunhao3@huawei.com>, suzuki.poulose@arm.com,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        jonathan.cameron@huawei.com, yangyicong@huawei.com,
        prime.zeng@hisilicon.com
References: <20231114133346.30489-1-hejunhao3@huawei.com>
 <20231114133346.30489-3-hejunhao3@huawei.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20231114133346.30489-3-hejunhao3@huawei.com>
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
> The SMB dirver register the enable/disable sysfs interface in function
> smb_register_sink(), however the buffer depends on the following
> configuration to work well. So it'll be possible for user to access an
> unreset one.
> 
> Move the config buffer operation to before register_sink().
> Ignore the return value, if smb_config_inport() fails. That will
> cause the hardwares disable trace path to fail, should not affect
> SMB driver remove. So we make smb_remove() return success,
> 
> Fixes: 06f5c2926aaa ("drivers/coresight: Add UltraSoc System Memory Buffer driver")
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> ---
>  drivers/hwtracing/coresight/ultrasoc-smb.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
> index 0a0fe9fcc57f..2f2aba90a514 100644
> --- a/drivers/hwtracing/coresight/ultrasoc-smb.c
> +++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
> @@ -583,37 +583,32 @@ static int smb_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	ret = smb_config_inport(dev, true);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, drvdata);
>  	spin_lock_init(&drvdata->spinlock);
>  	drvdata->pid = -1;
>  
>  	ret = smb_register_sink(pdev, drvdata);
>  	if (ret) {
> +		smb_config_inport(&pdev->dev, false);
>  		dev_err(dev, "Failed to register SMB sink\n");
>  		return ret;
>  	}
>  
> -	ret = smb_config_inport(dev, true);
> -	if (ret) {
> -		smb_unregister_sink(drvdata);
> -		return ret;
> -	}
> -
> -	platform_set_drvdata(pdev, drvdata);
> -
>  	return 0;
>  }
>  
>  static int smb_remove(struct platform_device *pdev)
>  {
>  	struct smb_drv_data *drvdata = platform_get_drvdata(pdev);
> -	int ret;
> -
> -	ret = smb_config_inport(&pdev->dev, false);
> -	if (ret)
> -		return ret;
>  
>  	smb_unregister_sink(drvdata);
>  
> +	smb_config_inport(&pdev->dev, false);
> +
>  	return 0;
>  }
>  

I'm not sure if it makes sense to implement Uwe's change to use
.remove_new instead here? And then drop the change on the other
patchset. Otherwise Suzuki will have to resolve the conflict. Maybe it's
quite simple so it's not an issue.

Either way:

Reviewed-by: James Clark <james.clark@arm.com>


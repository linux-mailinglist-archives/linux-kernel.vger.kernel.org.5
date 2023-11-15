Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D434B7EC90E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjKOQrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjKOQrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:47:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 096CAF9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:47:32 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FB8BDA7;
        Wed, 15 Nov 2023 08:48:17 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 875A33F641;
        Wed, 15 Nov 2023 08:47:30 -0800 (PST)
Message-ID: <4a3c3369-456e-f3d3-0338-f170da69482b@arm.com>
Date:   Wed, 15 Nov 2023 16:47:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 3/4] coresight: ultrasoc-smb: Fix uninitialized before
 use buf_hw_base
Content-Language: en-US
To:     Junhao He <hejunhao3@huawei.com>, suzuki.poulose@arm.com
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        jonathan.cameron@huawei.com, yangyicong@huawei.com,
        prime.zeng@hisilicon.com, u.kleine-koenig@pengutronix.de
References: <20231114133346.30489-1-hejunhao3@huawei.com>
 <20231114133346.30489-4-hejunhao3@huawei.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20231114133346.30489-4-hejunhao3@huawei.com>
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
> In smb_reset_buffer, the sdb->buf_hw_base variable is uninitialized
> before use, which initializes it in smb_init_data_buffer. And the SMB
> regiester are set in smb_config_inport.
> So move the call after smb_config_inport.
> 
> Fixes: 06f5c2926aaa ("drivers/coresight: Add UltraSoc System Memory Buffer driver")
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> ---
>  drivers/hwtracing/coresight/ultrasoc-smb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
> index 2f2aba90a514..6e32d31a95fe 100644
> --- a/drivers/hwtracing/coresight/ultrasoc-smb.c
> +++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
> @@ -477,7 +477,6 @@ static int smb_init_data_buffer(struct platform_device *pdev,
>  static void smb_init_hw(struct smb_drv_data *drvdata)
>  {
>  	smb_disable_hw(drvdata);
> -	smb_reset_buffer(drvdata);
>  
>  	writel(SMB_LB_CFG_LO_DEFAULT, drvdata->base + SMB_LB_CFG_LO_REG);
>  	writel(SMB_LB_CFG_HI_DEFAULT, drvdata->base + SMB_LB_CFG_HI_REG);
> @@ -587,6 +586,7 @@ static int smb_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	smb_reset_buffer(drvdata);
>  	platform_set_drvdata(pdev, drvdata);
>  	spin_lock_init(&drvdata->spinlock);
>  	drvdata->pid = -1;

Reviewed-by: James Clark <james.clark@arm.com>

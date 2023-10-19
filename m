Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B59C7CEE20
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjJSCfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSCfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:35:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A9C124
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 19:34:57 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S9sDq37GszrSB5;
        Thu, 19 Oct 2023 10:32:11 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 19 Oct 2023 10:34:55 +0800
CC:     <james.clark@arm.com>, <suzuki.poulose@arm.com>,
        <yangyicong@hisilicon.com>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [PATCH 3/3] coresight: ultrasoc-smb: fix uninitialized before use
 buf_hw_base
To:     Junhao He <hejunhao3@huawei.com>
References: <20231012094706.21565-1-hejunhao3@huawei.com>
 <20231012094706.21565-4-hejunhao3@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <fe5af067-d2f4-7967-e75b-272b00e6275f@huawei.com>
Date:   Thu, 19 Oct 2023 10:34:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20231012094706.21565-4-hejunhao3@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.177]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/12 17:47, Junhao He wrote:
> In smb_reset_buffer, the sdb->buf_hw_base variable is uninitialized
> before use, which initializes it in smb_init_data_buffer. And the SMB
> regiester are set in smb_config_inport.
> So move the call after smb_config_inport.
> 
> Fixes: 06f5c2926aaa ("drivers/coresight: Add UltraSoc System Memory Buffer driver")
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> ---
>  drivers/hwtracing/coresight/ultrasoc-smb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
> index e78edc3480ce..21ba473786e5 100644
> --- a/drivers/hwtracing/coresight/ultrasoc-smb.c
> +++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
> @@ -475,7 +475,6 @@ static int smb_init_data_buffer(struct platform_device *pdev,
>  static void smb_init_hw(struct smb_drv_data *drvdata)
>  {
>  	smb_disable_hw(drvdata);
> -	smb_reset_buffer(drvdata);
>  
>  	writel(SMB_LB_CFG_LO_DEFAULT, drvdata->base + SMB_LB_CFG_LO_REG);
>  	writel(SMB_LB_CFG_HI_DEFAULT, drvdata->base + SMB_LB_CFG_HI_REG);
> @@ -597,6 +596,7 @@ static int smb_probe(struct platform_device *pdev)
>  	}
>  
>  	platform_set_drvdata(pdev, drvdata);
> +	smb_reset_buffer(drvdata);

Shouldn't we reset the buffer before registering the sink? Otherwise it'll
be possible for user to access an unreset one.

>  
>  	return 0;
>  }
> 

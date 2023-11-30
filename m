Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60DA7FF2D8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346063AbjK3OtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjK3OtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:49:08 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3582196
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:49:14 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SgzVV4rgKz6H80S;
        Thu, 30 Nov 2023 22:44:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
        by mail.maildlp.com (Postfix) with ESMTPS id 379AB140C98;
        Thu, 30 Nov 2023 22:49:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 Nov
 2023 14:49:12 +0000
Date:   Thu, 30 Nov 2023 14:49:11 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Huisong Li <lihuisong@huawei.com>
CC:     <xuwei5@hisilicon.com>, <linux-kernel@vger.kernel.org>,
        <soc@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <arnd@arndb.de>, <krzk@kernel.org>, <sudeep.holla@arm.com>,
        <liuyonglong@huawei.com>
Subject: Re: [PATCH v2 4/4] soc: hisilicon: kunpeng_hccs: Support the
 platform with PCC type3 and interrupt ack
Message-ID: <20231130144911.00005faf@Huawei.com>
In-Reply-To: <20231130134550.33398-5-lihuisong@huawei.com>
References: <20231109054526.27270-1-lihuisong@huawei.com>
        <20231130134550.33398-1-lihuisong@huawei.com>
        <20231130134550.33398-5-lihuisong@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 21:45:50 +0800
Huisong Li <lihuisong@huawei.com> wrote:

> Support the platform with PCC type3 and interrupt ack. And a version
> specific structure is introduced to handle the difference between the
> device in the code.
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>

Hi.

A few trivial things inline but now looks good to me!

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/soc/hisilicon/kunpeng_hccs.c | 136 ++++++++++++++++++++++-----
>  drivers/soc/hisilicon/kunpeng_hccs.h |  15 +++
>  2 files changed, 126 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
> index 15125f1e0f3e..d2302ff8c0e9 100644
> --- a/drivers/soc/hisilicon/kunpeng_hccs.c
> +++ b/drivers/soc/hisilicon/kunpeng_hccs.c

...

>  
> -static int hccs_check_chan_cmd_complete(struct hccs_dev *hdev)
> +static inline int hccs_wait_cmd_complete_by_poll(struct hccs_dev *hdev)

Why inline?  Do we have numbers to support this hint to the compiler being
useful?

>  {
>  	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
>  	struct acpi_pcct_shared_memory __iomem *comm_base =
> @@ -194,30 +211,75 @@ static int hccs_check_chan_cmd_complete(struct hccs_dev *hdev)
>  	return ret;
>  }
>  
> +static inline int hccs_wait_cmd_complete_by_irq(struct hccs_dev *hdev)
> +{
> +	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
> +	int ret = 0;

Drop ret...

> +
> +	if (!wait_for_completion_timeout(&cl_info->done,
> +			usecs_to_jiffies(cl_info->deadline_us))) {
> +		dev_err(hdev->dev, "PCC command executed timeout!\n");
> +		ret = -ETIMEDOUT;
		return -TIMEDOUT;
...
> +	}
> +
> +	return ret;
return 0;

> +}

> +static const struct hccs_verspecific_data hisi04b1_verspec_data = {
> +	.rx_callback = NULL,

It's harmless but no need to set callback to NULL. Maybe it acts as documentation?
It's common practice to just let C spec guarantees initialize any not implemented callbacks
to 0 without them needing to be done explicitly.

> +	.wait_cmd_complete = hccs_wait_cmd_complete_by_poll,
> +	.fill_pcc_shared_mem = hccs_fill_pcc_shared_mem_region,
> +	.shared_mem_size = sizeof(struct acpi_pcct_shared_memory),
> +	.has_txdone_irq = false,
> +};
> +
> +static const struct hccs_verspecific_data hisi04b2_verspec_data = {
> +	.rx_callback = hccs_pcc_rx_callback,
> +	.wait_cmd_complete = hccs_wait_cmd_complete_by_irq,
> +	.fill_pcc_shared_mem = hccs_fill_ext_pcc_shared_mem_region,
> +	.shared_mem_size = sizeof(struct acpi_pcct_ext_pcc_shared_memory),
> +	.has_txdone_irq = true,
> +};


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E10F7FC120
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346023AbjK1PpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345879AbjK1PpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:45:03 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B305C5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:45:07 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SfmvR3PBkz6K9FF;
        Tue, 28 Nov 2023 23:43:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
        by mail.maildlp.com (Postfix) with ESMTPS id 256F114025A;
        Tue, 28 Nov 2023 23:45:05 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 Nov
 2023 15:44:48 +0000
Date:   Tue, 28 Nov 2023 15:44:48 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Huisong Li <lihuisong@huawei.com>
CC:     <xuwei5@hisilicon.com>, <linux-kernel@vger.kernel.org>,
        <soc@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <arnd@arndb.de>, <krzk@kernel.org>, <sudeep.holla@arm.com>,
        <liuyonglong@huawei.com>
Subject: Re: [PATCH v1 3/3] soc: hisilicon: kunpeng_hccs: Support the
 platform with PCC type3 and interrupt ack
Message-ID: <20231128154448.00006b8f@Huawei.com>
In-Reply-To: <20231109054526.27270-4-lihuisong@huawei.com>
References: <20231109054526.27270-1-lihuisong@huawei.com>
        <20231109054526.27270-4-lihuisong@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

On Thu, 9 Nov 2023 13:45:26 +0800
Huisong Li <lihuisong@huawei.com> wrote:

> Support the platform with PCC type3 and interrupt ack.
Probably mention this is version 2 as that's what you call it
in the code.
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>

Hi.

Main comment in here is that it is almost always better to use
a version specific structure with callbacks / data etc rather than
have instances of if (version1) do_x; else if (version2) do_y;

It ends up pulling all the differences into one place + allows a
great deal more flexibility.  See inline for details.

Otherwise looks fine to me

Jonathan

> ---
>  drivers/soc/hisilicon/kunpeng_hccs.c | 137 +++++++++++++++++++++------
>  drivers/soc/hisilicon/kunpeng_hccs.h |   2 +
>  2 files changed, 110 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
> index fd3ca0eb8175..96cdac7be244 100644
> --- a/drivers/soc/hisilicon/kunpeng_hccs.c
> +++ b/drivers/soc/hisilicon/kunpeng_hccs.c
> @@ -38,6 +38,11 @@
...

>  
> +static int hccs_get_device_version(struct hccs_dev *hdev)
> +{
> +	const struct acpi_device_id *acpi_id;
> +
> +	acpi_id = acpi_match_device(hdev->dev->driver->acpi_match_table,
> +				    hdev->dev);


Why not just have
hdev->dev_ver = (u8)acpi_device_get_match_data(&hdev->dev);
inline where this is called?

You probably don't even need the error check as you can't get here
without an appropriate match as the driver would never be matched.

> +	if (!acpi_id) {
> +		dev_err(hdev->dev, "get device version failed.");
> +		return -EINVAL;
> +	}
> +
> +	hdev->dev_ver = (u8)acpi_id->driver_data;
> +	return 0;
> +}
> +

...

>  static void hccs_unregister_pcc_channel(struct hccs_dev *hdev)
>  {
>  	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
> @@ -131,6 +159,11 @@ static int hccs_register_pcc_channel(struct hccs_dev *hdev)
>  	cl->tx_block = false;
>  	cl->knows_txdone = true;
>  	cl->tx_done = hccs_chan_tx_done;
> +	if (hdev->dev_ver == HCCS_HW_DEVICE_V2) {

I'd prefer to see this done as data. That is, instead of having an enum
used in the ACPI match data, have a pointer to a struct with the callback.
Then this will become something like

	hcc_info = acpi_device_get_match_data(hdev);
	cl->rx_callback = hcc_info->rx_callback;
	init_completion(&cl_info->done);

Initializing the completion is harmless if it's not used, so just do it
unconditionally.

> +		cl->rx_callback = hccs_pcc_rx_callback;
> +		init_completion(&cl_info->done);
> +	}
> +
>  	pcc_chan = pcc_mbox_request_channel(cl, hdev->chan_id);
>  	if (IS_ERR(pcc_chan)) {
>  		dev_err(dev, "PPC channel request failed.\n");
> @@ -147,10 +180,16 @@ static int hccs_register_pcc_channel(struct hccs_dev *hdev)
>  	 */
>  	cl_info->deadline_us =
>  			HCCS_PCC_CMD_WAIT_RETRIES_NUM * pcc_chan->latency;
> -	if (cl_info->mbox_chan->mbox->txdone_irq) {
> +	if (hdev->dev_ver == HCCS_HW_DEVICE_V1 &&
> +	    cl_info->mbox_chan->mbox->txdone_irq) {

Also data in hcc_info would be better than version number based
code flow.
	if (hcc_info->has_txdone_irq &&
	    cl_info->mbox_chan->mbox->rx_done_irq) {
	....
	} else if (!hcc_info->has_txdone_irq &&
		   !cl_info->mbox_chan->mbox->tx_done_irq) {
	...
	}
>  		dev_err(dev, "PCC IRQ in PCCT is enabled.\n");
>  		rc = -EINVAL;
>  		goto err_mbx_channel_free;
> +	} else if (hdev->dev_ver == HCCS_HW_DEVICE_V2 &&
> +		   !cl_info->mbox_chan->mbox->txdone_irq) {
> +		dev_err(dev, "PCC IRQ in PCCT isn't supported.\n");
> +		rc = -EINVAL;
> +		goto err_mbx_channel_free;
>  	}
>  
>  	if (pcc_chan->shmem_base_addr) {
> @@ -175,49 +214,81 @@ static int hccs_register_pcc_channel(struct hccs_dev *hdev)
>  static int hccs_check_chan_cmd_complete(struct hccs_dev *hdev)
>  {
>  	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
> -	struct acpi_pcct_shared_memory __iomem *comm_base =
> -							cl_info->pcc_comm_addr;
> +	struct acpi_pcct_shared_memory __iomem *comm_base;
> +	int ret = 0;
>  	u16 status;
> -	int ret;
>  
>  	/*
>  	 * Poll PCC status register every 3us(delay_us) for maximum of
>  	 * deadline_us(timeout_us) until PCC command complete bit is set(cond)
>  	 */
> -	ret = readw_poll_timeout(&comm_base->status, status,
> -				 status & PCC_STATUS_CMD_COMPLETE,
> -				 HCCS_POLL_STATUS_TIME_INTERVAL_US,
> -				 cl_info->deadline_us);
> -	if (unlikely(ret))
> -		dev_err(hdev->dev, "poll PCC status failed, ret = %d.\n", ret);
> +	if (hdev->dev_ver == HCCS_HW_DEVICE_V1) {

As above. I'd prefer to see this as a call back in an info structure rather
than code here.

> +		comm_base = cl_info->pcc_comm_addr;
> +		ret = readw_poll_timeout(&comm_base->status, status,
> +					status & PCC_STATUS_CMD_COMPLETE,
> +					HCCS_POLL_STATUS_TIME_INTERVAL_US,
> +					cl_info->deadline_us);
> +		if (unlikely(ret))
> +			dev_err(hdev->dev, "poll PCC status failed, ret = %d.\n", ret);
> +	} else {
> +		if (!wait_for_completion_timeout(&cl_info->done,
> +				usecs_to_jiffies(cl_info->deadline_us))) {
> +			dev_err(hdev->dev, "PCC command executed timeout!\n");
> +			ret = -ETIMEDOUT;
> +		}
> +	}
>  
>  	return ret;
>  }
>  
> +static void hccs_fill_pcc_shared_mem_region(struct hccs_dev *hdev, u8 cmd,
> +					    struct hccs_desc *desc,
> +					    void __iomem *comm_space,
> +					    u16 space_size)
> +{
> +	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
> +	struct acpi_pcct_ext_pcc_shared_memory tmp1 = {0};
> +	struct acpi_pcct_shared_memory tmp2 = {0};
> +
> +	if (hdev->dev_ver == HCCS_HW_DEVICE_V1) {
1) tmp1 and temp2 are local to the two forks of this statement
so pull them down here.
2) Use c99 style struct init to make this cleaner.
		struct acpi_pcct_shared_memory = {
			.signature = x,
			.command = cmd,
		};

I'd also like this to be a callback in the version specific info
structure rather than done as an if / else here that really doesn't
extend well if we get a lot more versions doing it differently.

> +		tmp2.signature = PCC_SIGNATURE | hdev->chan_id;
> +		tmp2.command = cmd;
> +		tmp2.status = 0;
> +		memcpy_toio(cl_info->pcc_comm_addr, (void *)&tmp2,
> +			    sizeof(struct acpi_pcct_shared_memory));
> +	} else {
> +		tmp1.signature = PCC_SIGNATURE | hdev->chan_id;
> +		tmp1.command = cmd;
> +		tmp1.flags = PCC_CMD_COMPLETION_NOTIFY;
> +		tmp1.length = HCCS_PCC_SHARE_MEM_BYTES;
> +		memcpy_toio(cl_info->pcc_comm_addr, (void *)&tmp1,
> +			    sizeof(struct acpi_pcct_ext_pcc_shared_memory));
> +	}
> +
> +	/* Copy the message to the PCC comm space */
> +	memcpy_toio(comm_space, (void *)desc, space_size);
> +}
...


> @@ -1214,6 +1288,10 @@ static int hccs_probe(struct platform_device *pdev)
>  	hdev->dev = &pdev->dev;
>  	platform_set_drvdata(pdev, hdev);
>  
> +	rc = hccs_get_device_version(hdev);
> +	if (rc)
> +		return rc;
> +
>  	mutex_init(&hdev->lock);
>  	rc = hccs_get_pcc_chan_id(hdev);
>  	if (rc)
> @@ -1251,7 +1329,8 @@ static void hccs_remove(struct platform_device *pdev)
>  }
>  
>  static const struct acpi_device_id hccs_acpi_match[] = {
> -	{ "HISI04B1"},
> +	{ "HISI04B1", HCCS_HW_DEVICE_V1},
> +	{ "HISI04B2", HCCS_HW_DEVICE_V2},
>  	{ ""},
Side comment, but 
	{}
So no content (rely on c initializing it to be zero filled anyway and no comma
as we don't want anything after this point.

>  };
>  MODULE_DEVICE_TABLE(acpi, hccs_acpi_match);
> diff --git a/drivers/soc/hisilicon/kunpeng_hccs.h b/drivers/soc/hisilicon/kunpeng_hccs.h
> index 6012d2776028..bbb1aada0c6c 100644
> --- a/drivers/soc/hisilicon/kunpeng_hccs.h
> +++ b/drivers/soc/hisilicon/kunpeng_hccs.h
> @@ -51,12 +51,14 @@ struct hccs_mbox_client_info {
>  	struct pcc_mbox_chan *pcc_chan;
>  	u64 deadline_us;
>  	void __iomem *pcc_comm_addr;
> +	struct completion done;
>  };
>  
>  struct hccs_dev {
>  	struct device *dev;
>  	struct acpi_device *acpi_dev;
>  	u64 caps;
> +	u8 dev_ver;
See above, but I'd rather see
	const struct hcc_verspecific_info *info;
here that encodes the differences as callbacks and data and rather than code.
>  	u8 chip_num;
>  	struct hccs_chip_info *chips;
>  	u8 chan_id;


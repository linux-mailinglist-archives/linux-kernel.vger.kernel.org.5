Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B4A754DFA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 11:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjGPJLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 05:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjGPJLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 05:11:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2A0DF
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 02:11:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B776460BDC
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 09:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BB4C433C7;
        Sun, 16 Jul 2023 09:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689498667;
        bh=ZZXN75dtnMG51uFamIxRcjMrQkXN4wt2+BTu4NtAjow=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VznWtr11jg0j3ORJCsgietlb5nj3J1lDfTQpSQvhQa1mfev3/95rM/SPP1culvSSd
         tjbMj/KCDkjyXCfkXn4yV+eEOZF/GM9Ej8YwE/Jer76w3nZ3i9862Ght/phFplr9p8
         yTlwEJge396B4C2uSbfwRjWhi1qyQ3cGW16vMzEBAlyQg8tI3W9Pd55jJS8kE1f6CQ
         v2D/FTJDNOtaPecN0lJnboMCBDljxqDE13TloeOKNtdRjmVBtNvWJD4f9U9v39vQsR
         YqyoeLk8ceS9WjDNoJH2QBBZz2f2PDotsY7tk8N4HHmG6axyK04Z9nqQbne8b9zjSs
         hIItAiVxvLdxQ==
Message-ID: <5f23ea3e-2f8a-cd26-4af4-164ab9cfbe22@kernel.org>
Date:   Sun, 16 Jul 2023 04:11:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] firmware: stratix10-rsu: query spt addresses
Content-Language: en-US
To:     kah.jing.lee@intel.com
Cc:     linux-kernel@vger.kernel.org, radu.bacrau@intel.com,
        tien.sung.ang@intel.com
References: <cover.1689490408.git.kah.jing.lee@intel.com>
 <b565b90641a38f1040017aad917e116e699757ea.1689490408.git.kah.jing.lee@intel.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <b565b90641a38f1040017aad917e116e699757ea.1689490408.git.kah.jing.lee@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/16/23 02:05, kah.jing.lee@intel.com wrote:
> From: Radu Bacrau <radu.bacrau@intel.com>
> 
> Extend Intel Remote System Update (RSU) driver to get SPT
> (Sub-Partition Table) addresses. The query SPT address can be used
> to determine if the RSU QSPI layout is 32kB or 64kB aligned.
> The alignment can be determined by minus the upper with the lower of
> the SPT addresses.
> 
> This patch depends on patch:
> firmware: stratix10-svc: Generic Mailbox Command
> 
> Signed-off-by: Radu Bacrau <radu.bacrau@intel.com>
> Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
> ---
>   drivers/firmware/stratix10-rsu.c | 100 ++++++++++++++++++++++++++++++-
>   1 file changed, 99 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/stratix10-rsu.c b/drivers/firmware/stratix10-rsu.c
> index e51c95f8d445..417627fe8577 100644
> --- a/drivers/firmware/stratix10-rsu.c
> +++ b/drivers/firmware/stratix10-rsu.c
> @@ -34,6 +34,10 @@
>   #define INVALID_RETRY_COUNTER		0xFF
>   #define INVALID_DCMF_VERSION		0xFF
>   #define INVALID_DCMF_STATUS		0xFFFFFFFF
> +#define INVALID_SPT_ADDRESS		0x0
> +
> +#define RSU_GET_SPT_CMD			0x5A
> +#define RSU_GET_SPT_RESP_LEN		(4 * sizeof(unsigned int))
>   
>   typedef void (*rsu_callback)(struct stratix10_svc_client *client,
>   			     struct stratix10_svc_cb_data *data);
> @@ -59,6 +63,9 @@ typedef void (*rsu_callback)(struct stratix10_svc_client *client,
>    * @dcmf_status.dcmf3: dcmf3 status
>    * @retry_counter: the current image's retry counter
>    * @max_retry: the preset max retry value
> + * @spt0_address: address of spt0
> + * @spt1_address: address of spt1
> + * @get_spt_response_buf: response from sdm for get_spt command
>    */
>   struct stratix10_rsu_priv {
>   	struct stratix10_svc_chan *chan;
> @@ -90,6 +97,11 @@ struct stratix10_rsu_priv {
>   
>   	unsigned int retry_counter;
>   	unsigned int max_retry;
> +
> +	unsigned long spt0_address;
> +	unsigned long spt1_address;
> +
> +	unsigned int *get_spt_response_buf;
>   };
>   
>   /**
> @@ -259,6 +271,36 @@ static void rsu_dcmf_status_callback(struct stratix10_svc_client *client,
>   	complete(&priv->completion);
>   }
>   
> +static void rsu_get_spt_callback(struct stratix10_svc_client *client,
> +				     struct stratix10_svc_cb_data *data)
> +{
> +	struct stratix10_rsu_priv *priv = client->priv;
> +	unsigned long *mbox_err = (unsigned long *)data->kaddr1;
> +	unsigned long *resp_len = (unsigned long *)data->kaddr2;
> +
> +	if ((data->status != BIT(SVC_STATUS_OK)) || (*mbox_err) ||
> +	    (*resp_len != RSU_GET_SPT_RESP_LEN))
> +		goto error;
> +
> +	priv->spt0_address = priv->get_spt_response_buf[0];
> +	priv->spt0_address <<= 32;
> +	priv->spt0_address |= priv->get_spt_response_buf[1];
> +
> +	priv->spt1_address = priv->get_spt_response_buf[2];
> +	priv->spt1_address <<= 32;
> +	priv->spt1_address |= priv->get_spt_response_buf[3];
> +
> +	goto complete;
> +
> +error:
> +	dev_err(client->dev, "failed to get SPTs\n");
> +
> +complete:
> +	stratix10_svc_free_memory(priv->chan, priv->get_spt_response_buf);
> +	priv->get_spt_response_buf = NULL;
> +	complete(&priv->completion);
> +}
> +
>   /**
>    * rsu_send_msg() - send a message to Intel service layer
>    * @priv: pointer to rsu private data
> @@ -288,6 +330,14 @@ static int rsu_send_msg(struct stratix10_rsu_priv *priv,
>   	if (arg)
>   		msg.arg[0] = arg;
>   
> +	if (command == COMMAND_MBOX_SEND_CMD) {
> +		msg.arg[1] = 0;
> +		msg.payload = NULL;
> +		msg.payload_length = 0;
> +		msg.payload_output = priv->get_spt_response_buf;
> +		msg.payload_length_output = RSU_GET_SPT_RESP_LEN;
> +	}
> +
>   	ret = stratix10_svc_send(priv->chan, &msg);
>   	if (ret < 0)
>   		goto status_done;
> @@ -572,6 +622,34 @@ static ssize_t notify_store(struct device *dev,
>   	return count;
>   }
>   
> +static ssize_t spt0_address_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
> +
> +	if (!priv)
> +		return -ENODEV;
> +
> +	if (priv->spt0_address == INVALID_SPT_ADDRESS)
> +		return -EIO;
> +
> +	return scnprintf(buf, PAGE_SIZE, "0x%08lx\n", priv->spt0_address);
> +}
> +
> +static ssize_t spt1_address_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
> +
> +	if (!priv)
> +		return -ENODEV;
> +
> +	if (priv->spt1_address == INVALID_SPT_ADDRESS)
> +		return -EIO;
> +
> +	return scnprintf(buf, PAGE_SIZE, "0x%08lx\n", priv->spt1_address);
> +}
> +
>   static DEVICE_ATTR_RO(current_image);
>   static DEVICE_ATTR_RO(fail_image);
>   static DEVICE_ATTR_RO(state);
> @@ -590,6 +668,8 @@ static DEVICE_ATTR_RO(dcmf2_status);
>   static DEVICE_ATTR_RO(dcmf3_status);
>   static DEVICE_ATTR_WO(reboot_image);
>   static DEVICE_ATTR_WO(notify);
> +static DEVICE_ATTR_RO(spt0_address);
> +static DEVICE_ATTR_RO(spt1_address);
>   
>   static struct attribute *rsu_attrs[] = {
>   	&dev_attr_current_image.attr,
> @@ -610,6 +690,8 @@ static struct attribute *rsu_attrs[] = {
>   	&dev_attr_dcmf3_status.attr,
>   	&dev_attr_reboot_image.attr,
>   	&dev_attr_notify.attr,
> +	&dev_attr_spt0_address.attr,
> +	&dev_attr_spt1_address.attr,
>   	NULL
>   };
>   
> @@ -639,11 +721,13 @@ static int stratix10_rsu_probe(struct platform_device *pdev)
>   	priv->dcmf_version.dcmf1 = INVALID_DCMF_VERSION;
>   	priv->dcmf_version.dcmf2 = INVALID_DCMF_VERSION;
>   	priv->dcmf_version.dcmf3 = INVALID_DCMF_VERSION;
> -	priv->max_retry = INVALID_RETRY_COUNTER;
>   	priv->dcmf_status.dcmf0 = INVALID_DCMF_STATUS;
>   	priv->dcmf_status.dcmf1 = INVALID_DCMF_STATUS;
>   	priv->dcmf_status.dcmf2 = INVALID_DCMF_STATUS;
>   	priv->dcmf_status.dcmf3 = INVALID_DCMF_STATUS;
> +	priv->max_retry = INVALID_RETRY_COUNTER;
> +	priv->spt0_address = INVALID_SPT_ADDRESS;
> +	priv->spt1_address = INVALID_SPT_ADDRESS;
>   
>   	mutex_init(&priv->lock);
>   	priv->chan = stratix10_svc_request_channel_byname(&priv->client,
> @@ -693,6 +777,20 @@ static int stratix10_rsu_probe(struct platform_device *pdev)
>   		stratix10_svc_free_channel(priv->chan);
>   	}
>   
> +	priv->get_spt_response_buf =
> +		stratix10_svc_allocate_memory(priv->chan, RSU_GET_SPT_RESP_LEN);
> +
> +	if (!priv->get_spt_response_buf) {
> +		dev_err(dev, "failed to allocate get spt buffer\n");
> +	} else {
> +		ret = rsu_send_msg(priv, COMMAND_MBOX_SEND_CMD,
> +				RSU_GET_SPT_CMD, rsu_get_spt_callback);
> +		if (ret) {
> +			dev_err(dev, "Error, getting SPT table %i\n", ret);
> +			stratix10_svc_free_channel(priv->chan);
> +		}
> +	}
> +
>   	return ret;
>   }
>   

You forgot to address all my comments from v1.

Dinh

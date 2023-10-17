Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5DC7CD07D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 01:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344415AbjJQXXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 19:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344307AbjJQXXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 19:23:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4613EF7;
        Tue, 17 Oct 2023 16:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697584999; x=1729120999;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=CHJ5c/rgNCeYwsWKj461nWA5YOYqSXvbYEb3J1+5U7Q=;
  b=GzeSj5X+AP9euUybYwnPXA9j6RZlrHmHjI8CJP6UMnf2TOj+hBPZV4Ca
   UB/RxCP79hCNPyUBUWT4U9/vTGqmNo7NS39OxMmRtfgbRh0/tOAUtls99
   HYYtG5uMLJKZus1mP4APSbG7+BfnUwKo9Frw2mFfakkUIQwlwLtvaaFgv
   P/B5781LIH80dIztJwG+IIip9dB3GvhVcZiKUHAXn8AgtfzqwBMOVJpSB
   NtG7UoXK7BU8Yr61Xig6SiypEPns8qF9VMmlCONmn31y3dpb+IQJyYWcd
   gy7a5212UdKSc+9alHmv+qTyOkG8NQbMWqE/T15ICp3gwjgKvjh95mFv5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="384778089"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="384778089"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 16:23:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="826637462"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="826637462"
Received: from asprado-mobl2.amr.corp.intel.com (HELO [10.212.55.179]) ([10.212.55.179])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 16:23:16 -0700
Message-ID: <8eb90a7a-8649-4a31-9997-d970915510bf@linux.intel.com>
Date:   Tue, 17 Oct 2023 16:48:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v9 07/34] ASoC: Add SOC USB APIs for adding an USB backend
To:     Wesley Cheng <quic_wcheng@quicinc.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, srinivas.kandagatla@linaro.org,
        bgoswami@quicinc.com, Thinh.Nguyen@synopsys.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20231017200109.11407-1-quic_wcheng@quicinc.com>
 <20231017200109.11407-8-quic_wcheng@quicinc.com>
Content-Language: en-US
In-Reply-To: <20231017200109.11407-8-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/23 15:00, Wesley Cheng wrote:
> Some platforms may have support for offloading USB audio devices to a
> dedicated audio DSP.  Introduce a set of APIs that allow for management of
> USB sound card and PCM devices enumerated by the USB SND class driver.
> This allows for the ASoC components to be aware of what USB devices are

USB devices or USB endpoints? or both?

> available for offloading.

> +/**
> + * struct snd_soc_usb_device
> + * @card_idx - sound card index associated with USB device
> + * @chip_idx - USB sound chip array index
> + * @num_playback - number of playback streams
> + * @num_capture - number of capture streams

presumably excluding explicit feedback streams?

> + **/
> +struct snd_soc_usb_device {
> +	int card_idx;
> +	int chip_idx;
> +	int num_playback;
> +	int num_capture;
> +};
> +
> +/**
> + * struct snd_soc_usb
> + * @list - list head for SND SOC struct list
> + * @dev - USB backend device reference
> + * @component - reference to ASoC component
> + * @connection_status_cb - callback to notify connection events
> + * @priv_data - driver data
> + **/
> +struct snd_soc_usb {
> +	struct list_head list;
> +	struct device *dev;

usbdev for consistency with the API below?

> +	struct snd_soc_component *component;

could you use component only and infer the device from component->dev?

> +	int (*connection_status_cb)(struct snd_soc_usb *usb,
> +			struct snd_soc_usb_device *sdev, bool connected);
> +	void *priv_data;
> +};
> +
> +int snd_soc_usb_connect(struct device *usbdev, struct snd_soc_usb_device *sdev);
> +int snd_soc_usb_disconnect(struct device *usbdev, struct snd_soc_usb_device *sdev);
> +void *snd_soc_usb_get_priv_data(struct device *usbdev);
> +
> +struct snd_soc_usb *snd_soc_usb_add_port(struct device *dev, void *priv,

struct device *usbdev for consistency ?

> +			int (*connection_cb)(struct snd_soc_usb *usb,
> +			struct snd_soc_usb_device *sdev, bool connected));
> +int snd_soc_usb_remove_port(struct device *dev);

struct device *usbdev for consistency ?


> +struct snd_soc_usb *snd_soc_usb_add_port(struct device *dev, void *priv,
> +			int (*connection_cb)(struct snd_soc_usb *usb,
> +			struct snd_soc_usb_device *sdev, bool connected))> +{
> +	struct snd_soc_usb *usb;
> +
> +	usb = devm_kzalloc(dev, sizeof(*usb), GFP_KERNEL);
> +	if (!usb)
> +		return ERR_PTR(-ENOMEM);
> +
> +	usb->connection_status_cb = connection_cb;
> +	usb->dev = dev;
> +	usb->priv_data = priv;
> +
> +	mutex_lock(&ctx_mutex);
> +	list_add_tail(&usb->list, &usb_ctx_list);
> +	mutex_unlock(&ctx_mutex);
> +
> +	return usb;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_usb_add_port);
> +
> +/**
> + * snd_soc_usb_remove_port() - Remove a USB backend port
> + * @dev: USB backend device
> + *
> + * Remove a USB backend device from USB SND SOC.  Memory is freed when USB
> + * backend is removed.

when the USB backend driver is unbound?

> + *
> + */
> +int snd_soc_usb_remove_port(struct device *dev)
> +{
> +	struct snd_soc_usb *ctx, *tmp;
> +
> +	mutex_lock(&ctx_mutex);
> +	list_for_each_entry_safe(ctx, tmp, &usb_ctx_list, list) {
> +		if (ctx->dev == dev) {
> +			list_del(&ctx->list);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&ctx_mutex);
> +
> +	return 0;

can this return void to align with the current trend?

> +}
> +EXPORT_SYMBOL_GPL(snd_soc_usb_remove_port);
> +
> +/**
> + * snd_soc_usb_connect() - Notification of USB device connection
> + * @usbdev: USB bus device
> + * @card_idx: USB SND card instance
> + *
> + * Notify of a new USB SND device connection.  The card_idx can be used to
> + * handle how the DPCM backend selects, which device to enable USB offloading
> + * on.

card_idx is not used below, and I don't see how this relates to a
notification?

> + *
> + */
> +int snd_soc_usb_connect(struct device *usbdev, struct snd_soc_usb_device *sdev)
> +{
> +	struct snd_soc_usb *ctx;
> +	struct device_node *node;
> +
> +	if (!usbdev)
> +		return -ENODEV;
> +
> +	node = snd_soc_find_phandle(usbdev);
> +	if (IS_ERR(node))
> +		return -ENODEV;
> +
> +	ctx = snd_soc_find_usb_ctx(node);
> +	of_node_put(node);
> +	if (!ctx)
> +		return -ENODEV;
> +
> +	if (ctx->connection_status_cb)
> +		ctx->connection_status_cb(ctx, sdev, true);
> +
> +	return 0;
> +}


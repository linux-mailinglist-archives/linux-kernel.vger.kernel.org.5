Return-Path: <linux-kernel+bounces-11165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDBD81E24F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 21:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54961F21E50
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 20:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536415381B;
	Mon, 25 Dec 2023 20:27:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543A21B26E;
	Mon, 25 Dec 2023 20:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.6] (ip5f5af7b1.dynamic.kabel-deutschland.de [95.90.247.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A9F2661E5FE01;
	Mon, 25 Dec 2023 21:26:06 +0100 (CET)
Message-ID: <b0d94116-1fa0-4c1f-8a3e-2919fd75b635@molgen.mpg.de>
Date: Mon, 25 Dec 2023 21:26:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: Fix Bluetooth for BCM4377 on T2 Intel
 MacBooks
Content-Language: en-US
To: Felix Zhang <mrman@mrman314.tech>
Cc: linux-bluetooth@vger.kernel.org, stable@vger.kernel.org,
 Johan Hovold <johan+linaro@kernel.org>, marcan@marcan.st,
 bagasdotme@gmail.com, sven@svenpeter.dev, alyssa@rosenzweig.io,
 marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 orlandoch.dev@gmail.com, kekrby@gmail.com, admin@kodeit.net, j@jannau.net,
 gargaditya08@live.com, asahi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <77419ffacc5b4875e920e038332575a2a5bff29f.camel@mrman314.tech>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <77419ffacc5b4875e920e038332575a2a5bff29f.camel@mrman314.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Felix,


Thank you very much for the patch. I am adding Johan to Cc field.

Am 25.12.23 um 21:01 schrieb Felix Zhang:
> Starting v6.5, Bluetooth does not work at all on my T2 MacBookAir9,1
> 
> with the BCM4377 chip.  When I boot up the computer, go into

Somehow a blank line snug in above.

> bluetoothctl, and then try to run commands like scan on, show, list,
> it returns "No default controller available."  I have tried reloading
> the

It’d be great if you reflowed for 75 characters per line (also below).

> kernel module, in which the log outputs "{Added,Removed} hci0
> (unconfigured)."  With this patch, I am able to use Bluetooth as
> normal
> without any errors regarding hci0 being unconfigured.  However, an
> issue is still present where sometimes hci_bcm4377 will have to be
> reloaded in order to get bluetooth to work.  I believe this was still
> present before the previously mentioned commit.
> 
> Due to the bit HCI_QUIRK_USE_BDADDR_PROPERTY being always set in
> drivers/bluetooth/hci_bcm4377.c (line 2371), the chip would be left
> unconfigured on kernels compiled after commit 6945795bc81a
> ("Bluetooth:
> fix use-bdaddr-property quirk") due to a change in its logic.  On the
> M1 Macs, the device would be configured in the devicetree.  However,
> that is not the case on T2 Macs.  Because the bluetooth adapter is
> left
> unconfigured, it is not usable in the operating system.  In order to
> circumvent this issue, a flag is added to prevent the bit from being
> set on the BCM4377, while setting it on the other devices.
> 
> Because I do not have an M1 device to test this patch on, I am not sure
> whether the patch breaks anything for said devices.  I would be very
> grateful if anyone is willing to test this patch on their M1 device.
> 
> I would also like to thank Kerem Karabay <kekrby@gmail.com> for
> assisting me with this patch.
> 
> Fixes: 6945795bc81a ("Bluetooth: fix use-bdaddr-property quirk")
> Signed-off-by: Felix Zhang <mrman@mrman314.tech>
> ---
> v3:
> * Adjust the format to pass the CI (again).
> ---
>   drivers/bluetooth/hci_bcm4377.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm4377.c
> b/drivers/bluetooth/hci_bcm4377.c
> index a61757835695..5c6fef1aa0f6 100644
> --- a/drivers/bluetooth/hci_bcm4377.c
> +++ b/drivers/bluetooth/hci_bcm4377.c
> @@ -513,6 +513,7 @@ struct bcm4377_hw {
>   	unsigned long broken_ext_scan : 1;
>   	unsigned long broken_mws_transport_config : 1;
>   	unsigned long broken_le_coded : 1;
> +	unsigned long use_bdaddr_property : 1;
>   
>   	int (*send_calibration)(struct bcm4377_data *bcm4377);
>   	int (*send_ptb)(struct bcm4377_data *bcm4377,
> @@ -2368,7 +2369,8 @@ static int bcm4377_probe(struct pci_dev *pdev,
> const struct pci_device_id *id)
>   	hdev->set_bdaddr = bcm4377_hci_set_bdaddr;
>   	hdev->setup = bcm4377_hci_setup;
>   
> -	set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
> +	if (bcm4377->hw->use_bdaddr_property)
> +		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
>   	if (bcm4377->hw->broken_mws_transport_config)
>   		set_bit(HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG, &hdev-
>> quirks);
>   	if (bcm4377->hw->broken_ext_scan)
> @@ -2465,6 +2467,7 @@ static const struct bcm4377_hw
> bcm4377_hw_variants[] = {
>   		.has_bar0_core2_window2 = true,
>   		.broken_mws_transport_config = true,
>   		.broken_le_coded = true,
> +		.use_bdaddr_property = true,
>   		.send_calibration = bcm4378_send_calibration,
>   		.send_ptb = bcm4378_send_ptb,
>   	},
> @@ -2479,6 +2482,7 @@ static const struct bcm4377_hw
> bcm4377_hw_variants[] = {
>   		.clear_pciecfg_subsystem_ctrl_bit19 = true,
>   		.broken_mws_transport_config = true,
>   		.broken_le_coded = true,
> +		.use_bdaddr_property = true,
>   		.send_calibration = bcm4387_send_calibration,
>   		.send_ptb = bcm4378_send_ptb,
>   	},

The diff looks good, and it works for you.


Kind regards,

Paul


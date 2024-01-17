Return-Path: <linux-kernel+bounces-28693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8818301E9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08FF4283F3C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C28F134C8;
	Wed, 17 Jan 2024 09:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="CBxsKsqr"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B6C7499;
	Wed, 17 Jan 2024 09:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705482592; cv=none; b=ZccBX1qrmEfrM5sRZ+3senPl4pe9pxIbbKeJKat0MhWznEDdx8MrN6Il2icxCRRVRHcLdszzLp2ozv+HOPdI/9fcI2pbqTQULPfq5MoDiy+2J0f2J6zgQP+riYBr3iWh1dhsD4kZrYM+kLSbqXauJS8XqmhBe1eHhO8qVN+sZAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705482592; c=relaxed/simple;
	bh=5j17r/xB4xQ5o1f6tq7hA/Wkesyo2d/N9aaESNmk4Fk=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=MMJ5PfphHzoT3FLm9PQ7+tqsKNbnltTDQiNJXUHHjBI+MstbiD9JJyQDtq/sXkqg9B0HvxevKiCs+1myhh+35YoDJSt8yQ/VErVqq6NVhwodthJqYM1JYvHc8wwi7454IOGosJf9KAtMQnnELCKqIA64ylC8WT7tN2XLp7RI5HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=CBxsKsqr; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 4325A1F843;
	Wed, 17 Jan 2024 10:09:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1705482577;
	bh=xqdaqTIn4+SF6ajFUYVQd9+gVC9/BmOTEwCQ1+uuJhQ=; h=From:To:Subject;
	b=CBxsKsqrjVcFRzkI7EGKuI881iaY8ffoWeKcT0Hp6R1/myBTkWUyu+m2tspnQsJix
	 BX07hsOd0rxnPsO9gkXNxdIH2CxBC7iWiUHc4nb0Kbc0w2CCohIQGkJRNVrE1aYD/J
	 Hlqj8Eb3CNic4LsAf9DDZ+gSuLWa3/h79ttl7V8d8TCWgjGGt67/BO1Vfjun4ldmeN
	 r15Ie3gkIvoFrVwyKGT8fEbFVZailWsRoELPjLaRVepMiCGBw+j63Z+QrH66Yp5mQv
	 RPUSQj3jEX4BxO/NcN3MFk9/bnnwD0ceP+isw1L304DOpAksB6nT/OKkI+/rwvp7TY
	 4LbA1DwsM7zVQ==
Date: Wed, 17 Jan 2024 10:09:32 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
	marcel.ziswiler@toradex.com, amitkumar.karwar@nxp.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	sherry.sun@nxp.com, rohit.fule@nxp.com
Subject: Re: [RFC PATCH] Bluetooth: btnxpuart: Fix nxp_setup in case chip is
 powered on late
Message-ID: <20240117090932.GA3787@francesco-nb>
References: <20240117030501.149114-1-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117030501.149114-1-neeraj.sanjaykale@nxp.com>

On Wed, Jan 17, 2024 at 08:35:01AM +0530, Neeraj Sanjay Kale wrote:
> This adds a setup retry mechanism in case the chip is powered on after the
> btnxpuart driver is loaded.
> 
> The NXP chipsets have a common PDn pin shared between Wi-Fi and Bluetooth.
> 
> When customers use mwifiex_sdio drivers for Wi-Fi, the pwrseq tied to the
> driver toggles the GPIO connected to the chip's PDn pin, powering it on.
> 
> The btnxpuart driver is loaded before mwifiex, and the setup function does
> not receive any bootloader signature, as PDn is held low at this moment.
> The driver inadvertently assumes that FW is already running on the chip.
> 
> The nxp_setup exits with a success, and BT subsystem proceeds with sending
> initialization commands, which result in a timeout.
> [  284.588177] Bluetooth: hci0: Opcode 0x0c03 failed: -110
> [  286.636167] Bluetooth: hci0: Setting wake-up method failed (-110)
> 
> Later when mwifiex is loaded, the pwrseq makes PDn pin high, and downloads
> either WiFi or combo FW.
> 
> However, the btnxpuart is in a bad state, and re-loading btnxpuart module
> does not help.
> 
> This fix adds a check for CTS pin, in case no bootloader signatures are
> received. If CTS is high, it means that the chip is currently powered off,
> and nxp_setup will return an error, preventing any HCI initialization
> commands to be sent by the BT subsystem.
> 
> The driver attempts to check for bootloader signatures and CTS again, by
> scheduling the hci power_on work after every 5 seconds, as long as the
> btnxpuart module is inserted in the kernel.
> 
> This fix attempts to improvise the fix provided my Marcel Ziswiler and
> handle this scenario gracefully.
> https://patchwork.kernel.org/project/bluetooth/patch/20231018145540.34014-3-marcel@ziswiler.com/
> 
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Closes: https://patchwork.kernel.org/project/bluetooth/patch/20231018145540.34014-3-marcel@ziswiler.com/
> ---
>  drivers/bluetooth/btnxpuart.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
> index 7f88b6f52f26..20a3a5bd5529 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1036,6 +1048,13 @@ static int nxp_setup(struct hci_dev *hdev)
>  		err = nxp_download_firmware(hdev);
>  		if (err < 0)
>  			return err;
> +	} else if (!serdev_device_get_cts(nxpdev->serdev)) {
> +		/* CTS is high and no bootloader signatures detected */
> +		bt_dev_dbg(hdev, "Controller not detected. Will check again in %d msec",
> +			   NXP_SETUP_RETRY_TIME_MS);
> +		schedule_delayed_work(&nxpdev->setup_retry_work,
> +				      msecs_to_jiffies(NXP_SETUP_RETRY_TIME_MS));
> +		return -ENODEV;
why not just

return -EPROBE_DEFER;

and remove everything else, no need for any kind of retry or delayed work
if the driver core takes care of it.


Francesco




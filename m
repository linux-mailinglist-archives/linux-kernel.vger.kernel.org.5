Return-Path: <linux-kernel+bounces-11960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8A581EE38
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A091F21D25
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5840E10952;
	Wed, 27 Dec 2023 10:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsMirJGK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F3519458;
	Wed, 27 Dec 2023 10:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B84C433C8;
	Wed, 27 Dec 2023 10:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703673021;
	bh=hRApFlhb/sxbWDx8I+HyotwyIw8GdewkTN3/MMfXZYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UsMirJGKgWeJr8vW83fc+EhEoV1ap1tB34O2P3joMCzCnFvLjc4y3xMky21CNam3E
	 PWskdI/i2PCsoW5QhgJZNafgUvftiHV7uOH9NKSx+w/y0DvipKfOeQqC0e3Qpki0Jh
	 iTpWt5zPg0zZFczYbdVtLfy1kFxIxEkHIkka9tT/y3Yzn39d+GyNCplB8bL+8yrjLl
	 gUvhfqBtRR9nJCLEHLtNJqizw9yWHTA+Dt/3W6VyyQiIh33buFx3ZlTbw0KGeI6Acd
	 4nKCr00NW/C4vDAkSnVpL1tx/OungSZ/jzAIZJCPhqEOII2vOQczyfGnbMxLxpfnBu
	 7ZHDiXBI80eKg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rIRB0-0002sD-0I;
	Wed, 27 Dec 2023 11:30:14 +0100
Date: Wed, 27 Dec 2023 11:30:14 +0100
From: Johan Hovold <johan@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>, Felix Zhang <mrman@mrman314.tech>
Cc: linux-bluetooth@vger.kernel.org, stable@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>, marcan@marcan.st,
	bagasdotme@gmail.com, sven@svenpeter.dev, alyssa@rosenzweig.io,
	marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
	orlandoch.dev@gmail.com, kekrby@gmail.com, admin@kodeit.net,
	j@jannau.net, gargaditya08@live.com, asahi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Bluetooth: Fix Bluetooth for BCM4377 on T2 Intel
 MacBooks
Message-ID: <ZYv8tp3fMiAqK8OI@hovoldconsulting.com>
References: <77419ffacc5b4875e920e038332575a2a5bff29f.camel@mrman314.tech>
 <b0d94116-1fa0-4c1f-8a3e-2919fd75b635@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0d94116-1fa0-4c1f-8a3e-2919fd75b635@molgen.mpg.de>

On Mon, Dec 25, 2023 at 09:26:05PM +0100, Paul Menzel wrote:

> Thank you very much for the patch. I am adding Johan to Cc field.

Thanks for the report. Guess I could use a break from the proverbial
eggnog.

> Am 25.12.23 um 21:01 schrieb Felix Zhang:
> > Starting v6.5, Bluetooth does not work at all on my T2 MacBookAir9,1
> > 
> > with the BCM4377 chip.  When I boot up the computer, go into
> 
> Somehow a blank line snug in above.
> 
> > bluetoothctl, and then try to run commands like scan on, show, list,
> > it returns "No default controller available."  I have tried reloading
> > the
> 
> It’d be great if you reflowed for 75 characters per line (also below).
> 
> > kernel module, in which the log outputs "{Added,Removed} hci0
> > (unconfigured)."  With this patch, I am able to use Bluetooth as
> > normal
> > without any errors regarding hci0 being unconfigured.  However, an
> > issue is still present where sometimes hci_bcm4377 will have to be
> > reloaded in order to get bluetooth to work.  I believe this was still
> > present before the previously mentioned commit.
> > 
> > Due to the bit HCI_QUIRK_USE_BDADDR_PROPERTY being always set in
> > drivers/bluetooth/hci_bcm4377.c (line 2371), the chip would be left
> > unconfigured on kernels compiled after commit 6945795bc81a
> > ("Bluetooth:
> > fix use-bdaddr-property quirk") due to a change in its logic.  On the
> > M1 Macs, the device would be configured in the devicetree.  However,
> > that is not the case on T2 Macs.  Because the bluetooth adapter is
> > left
> > unconfigured, it is not usable in the operating system.  In order to
> > circumvent this issue, a flag is added to prevent the bit from being
> > set on the BCM4377, while setting it on the other devices.

The commit you tracked this down to restored the original semantics for
HCI_QUIRK_USE_BDADDR_PROPERTY, which means that it should only be set
for devices with an invalid address.

The Broadcom BCM4377 driver has so far been setting this flag
unconditionally which now potentially results in also valid addresses
being marked as invalid.

I've just sent a patch that makes sure to only mark invalid addresses as
invalid:

	https://lore.kernel.org/lkml/20231227101003.10534-1-johan+linaro@kernel.org/

Note however that the flag still needs to be set in case your device
lacks storage for a unique device address so you cannot simply drop it
for some device classes as you do below (unless you are certain that
these devices will always have a valid address).

Devices without a valid address starts in an unconfigured state and
cannot be used until userspace has provided an address (e.g. using
btmgmt):

	btmgmt --index 0 public-addr 00:11:22:33:44:55

> > Fixes: 6945795bc81a ("Bluetooth: fix use-bdaddr-property quirk")
> > Signed-off-by: Felix Zhang <mrman@mrman314.tech>

> > @@ -2368,7 +2369,8 @@ static int bcm4377_probe(struct pci_dev *pdev,
> > const struct pci_device_id *id)
> >   	hdev->set_bdaddr = bcm4377_hci_set_bdaddr;
> >   	hdev->setup = bcm4377_hci_setup;
> >   
> > -	set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
> > +	if (bcm4377->hw->use_bdaddr_property)
> > +		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
> >   	if (bcm4377->hw->broken_mws_transport_config)
> >   		set_bit(HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG, &hdev-
> >> quirks);
> >   	if (bcm4377->hw->broken_ext_scan)
> > @@ -2465,6 +2467,7 @@ static const struct bcm4377_hw
> > bcm4377_hw_variants[] = {
> >   		.has_bar0_core2_window2 = true,
> >   		.broken_mws_transport_config = true,
> >   		.broken_le_coded = true,
> > +		.use_bdaddr_property = true,
> >   		.send_calibration = bcm4378_send_calibration,
> >   		.send_ptb = bcm4378_send_ptb,
> >   	},
> > @@ -2479,6 +2482,7 @@ static const struct bcm4377_hw
> > bcm4377_hw_variants[] = {
> >   		.clear_pciecfg_subsystem_ctrl_bit19 = true,
> >   		.broken_mws_transport_config = true,
> >   		.broken_le_coded = true,
> > +		.use_bdaddr_property = true,
> >   		.send_calibration = bcm4387_send_calibration,
> >   		.send_ptb = bcm4378_send_ptb,
> >   	},

Back to the eggnog.

Johan


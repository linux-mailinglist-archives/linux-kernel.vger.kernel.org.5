Return-Path: <linux-kernel+bounces-45323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4A6842E83
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82E0EB235DD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D16A762DD;
	Tue, 30 Jan 2024 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="TEyb964F"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262DD71B52;
	Tue, 30 Jan 2024 21:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649198; cv=none; b=B8OjHumpc2O6u5hEzhoS/ApyTlOSJkS83HdHBOxyZLcXEHLMa6rzpq/ugI/Q/jQB8vh1esDxJYCZpELgwpYA5ckSem8YSkaDUkPUXOFVAH1a9aDbo79ZFANzdtWroowg3UzJBID0TYnBpOu4k8GIqzQlA/9cRrcoOzr7WZKzDGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649198; c=relaxed/simple;
	bh=MdH8VV32E2JfAoYXD93UT+Rz70qQW7+Nb94p5dLwPFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llQSupjPZHZ7K7JYJJmZkIj41bdSDZHb7h2GtKQOxpyV0tYUQXzTXgTlujQ5YOBHjD2L8JiXoG84bsEEc6caIddmvlnuPT8uhoQBTuTiKHX1E2EZkZ6YIBSUQNVj9JcLfHzPp+VOKZeGLzAzr/90oBVd8Eo6H0W2xLyxEpIK8Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=TEyb964F; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1706649186; bh=MdH8VV32E2JfAoYXD93UT+Rz70qQW7+Nb94p5dLwPFg=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=TEyb964F4BMcL4Pby1aJRBS7c6WOLeqkCxrBZiILRJH2UCM79tvKDZBl5NKeXs93u
	 QnWEyuq4Ugd5PcaIjm3efQbmrsO2hUka21Gb9aFgh4wVhIb7NIR1gNB3KyEpiA2mWE
	 MxuCcvCYvJnZC9Q91G1b2ty/6G1aV08XovjC2N9c=
Date: Tue, 30 Jan 2024 22:13:06 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Aren Moynihan <aren@peacevolution.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hans de Goede <j.w.r.degoede@gmail.com>, Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, 
	Chen-Yu Tsai <wens@csie.org>, Quentin Schulz <quentin.schulz@bootlin.com>, 
	Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 5/5] power: supply: axp20x_usb_power: set input
 current limit in probe
Message-ID: <6nf7h3nc4q7fwrnm4spmgv2sdkczowkfpietcv2tyv4mixkq3b@svxgzkdqnzlq>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Aren Moynihan <aren@peacevolution.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hans de Goede <j.w.r.degoede@gmail.com>, Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, 
	Chen-Yu Tsai <wens@csie.org>, Quentin Schulz <quentin.schulz@bootlin.com>, 
	Sebastian Reichel <sre@kernel.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240130203714.3020464-1-aren@peacevolution.org>
 <20240130203714.3020464-6-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130203714.3020464-6-aren@peacevolution.org>

On Tue, Jan 30, 2024 at 03:28:01PM -0500, Aren Moynihan wrote:
> axp803 sets the current limit to 3A by default if it doesn't detect a
> battery. The datasheet says that register 0x2D bit 6 is used to indicate
> first power on status. According to it, if that bit is 0 and the battery
> is not detected, it will set the input current limit to 3A, however
> setting that bit to 1 doesn't to prevent the pmic from setting the
> current limit to 3A.
> 
> Waiting for USB BC detection doesn't work either, because (as far as I
> can tell) USB BC detection isn't performed when there isn't a battery
> detected.
> 
> Fixes: c279adafe6ab ("power: supply: axp20x_usb_power: add support for AXP813")

Breaks: ;)

Last time you wrote:

> Unfortunately BC 1.2 detection doesn't seem to be performed without a
> battery, at least I wasn't able to trigger it.
>
> This will be worth revising once we have a driver that can provide a
> signal that USB-PD is in progress and/or finished, but until then I'd
> prefer not take on that complexity.

This patch adds complexity and will lead to hard to debug issues for some
people. It certainly did cause issues for me, when I had similar patch in
my tree a while ago, forcing me to drop it.

There are other situations you're not considering. Like battery being
very discharged and unable to provide power, while still being detected
and BC1.2 running correctly and successfully when the device is powered
up by being plugged into DCP port (only option of powerup in such a 
scenario).

Battery is detected at 2.2V and certainly it will not provide any power
if OCV of the battery is anywhere below 3V. See "9.4.5 Battery detection"
in AXP803 datasheet. So you have about 1V range of possible battery voltage
where BC1.2 will work, but you'll force lower the correctly detected current
limit and break boot, because 2.5W is too low for the boot time power surge.

The phone will just randomly die halfthrough boot for apparently no reason,
despite being connected to DCP.

And also forget Pinephone, there may also be batteryless SBCs using this PMIC
with battery as an option (similar to Quartz64-A - Rockchip SBC, but exactly
this setup with battery capable PMIC in the power path on a normal SBC, with
battery being optional), where this patch will break boot on them, too. I'm
quite confident PMIC relaxing the limit without a battery is meant for such use
cases.

If you insist on adding this, at least add dev_warn() about forcing lower
limit than detected by the PMIC, so that people who'll do cursory debugging
via serial console will know why's their device failing to boot on a strong
enough power supply, or why their SBC is suddenly failing when used without
battery.

As for me, this patch should not be applied at all.

Kind regards,
        o.

> Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> ---
> I'm not sure if the pmic simply ignores the first power on field, or if
> it needs to be set in a specific way / at a specific time. I tried
> setting it in arm-trusted-firmware, and the pmic still set the input
> current limit to 3A.
> 
> The datasheet for axp813 says it has the same first power on bit, but I
> don't have hardware to test if it behaves the same way. This driver uses
> the same platform data for axp803 and axp813.
> 
> (no changes since v1)
> 
>  drivers/power/supply/axp20x_usb_power.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
> index dae7e5cfc54e..751b9f02d36f 100644
> --- a/drivers/power/supply/axp20x_usb_power.c
> +++ b/drivers/power/supply/axp20x_usb_power.c
> @@ -51,6 +51,7 @@ struct axp_data {
>  	unsigned int			num_irq_names;
>  	const int			*curr_lim_table;
>  	int				curr_lim_table_size;
> +	int				force_curr_lim;
>  	struct reg_field		curr_lim_fld;
>  	struct reg_field		vbus_valid_bit;
>  	struct reg_field		vbus_mon_bit;
> @@ -545,6 +546,7 @@ static const struct axp_data axp813_data = {
>  	.curr_lim_table = axp813_usb_curr_lim_table,
>  	.curr_lim_table_size = ARRAY_SIZE(axp813_usb_curr_lim_table),
>  	.curr_lim_fld	= REG_FIELD(AXP22X_CHRG_CTRL3, 4, 7),
> +	.force_curr_lim = 500000,
>  	.usb_bc_en_bit	= REG_FIELD(AXP288_BC_GLOBAL, 0, 0),
>  	.usb_bc_det_fld = REG_FIELD(AXP288_BC_DET_STAT, 5, 7),
>  	.vbus_disable_bit = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 7, 7),
> @@ -726,6 +728,17 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
>  			return ret;
>  	}
>  
> +	if (power->axp_data->force_curr_lim) {
> +		/*
> +		 * Some chips set the input current limit to 3A when there is no
> +		 * battery connected. Normally the default is 500mA.
> +		 */
> +		ret = axp20x_usb_power_set_input_current_limit(power,
> +				power->axp_data->force_curr_lim);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (power->usb_bc_en_bit) {
>  		/* Enable USB Battery Charging specification detection */
>  		ret = regmap_field_write(power->usb_bc_en_bit, 1);
> -- 
> 2.43.0
> 


Return-Path: <linux-kernel+bounces-32800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A09836032
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30A0288E09
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293BE3A292;
	Mon, 22 Jan 2024 10:59:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEA416439;
	Mon, 22 Jan 2024 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921160; cv=none; b=HznUIlgSgpiuJyHaQPTUrKrg5YwUBYBeMZF4HLvPAmXyEasYBQJlVhSGpGDVa3ZRZt5jozTZAUQbdyWVGoBmAF1J72KNcq9L4QvXW0j2lNk1N6PoqsXLeOPyw+WeARBKGojmotwuAH/iXVHDZNJMLGv9NbCq7UNrxc5gjr47cUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921160; c=relaxed/simple;
	bh=4VojL6vyX4QOTthvwAA6Yn4UBHckVBnn15bNxPgHjEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpY/zMTArGeQiIhS47PgJ451o8yx5cnVC+oqyeUsPRMGW9ase+8JPebDP1D8L0Pib0mKLZs+7MSoCe7dWWQjuKdWulvKnFzhnIgIaduZFRUdrEFw6uLTHV5NiGz1lxVJnNFjMKKly8qi9XlLSMqOcBXqpdIAV4GkfdcsbFHsyow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27C211FB;
	Mon, 22 Jan 2024 03:00:04 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09FE83F5A1;
	Mon, 22 Jan 2024 02:59:16 -0800 (PST)
Date: Mon, 22 Jan 2024 10:59:14 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sudeep.holla@arm.com, jdelvare@suse.com, linux@roeck-us.net,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] hwmon: scmi-hwmon: implement change_mode
Message-ID: <Za5Kgp6_qUEMc-AO@pluto>
References: <20240122080441.1957022-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122080441.1957022-1-peng.fan@oss.nxp.com>

On Mon, Jan 22, 2024 at 04:04:41PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The sensor maybe disabled before kernel boot, so add change_mode
> to support configuring the sensor to enabled state.
> 

Hi Peng,

minor remarks down below

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/hwmon/scmi-hwmon.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> index 364199b332c0..f7bd63d52d15 100644
> --- a/drivers/hwmon/scmi-hwmon.c
> +++ b/drivers/hwmon/scmi-hwmon.c
> @@ -151,7 +151,36 @@ static int scmi_hwmon_thermal_get_temp(struct thermal_zone_device *tz,
>  	return ret;
>  }
>  
> +static int scmi_hwmon_thermal_change_mode(struct thermal_zone_device *tz,
> +					  enum thermal_device_mode new_mode)
> +{
> +	int ret;
> +	u32 config;
> +	enum thermal_device_mode cur_mode = THERMAL_DEVICE_DISABLED;
> +	struct scmi_thermal_sensor *th_sensor = thermal_zone_device_priv(tz);
> +
> +	ret = sensor_ops->config_get(th_sensor->ph, th_sensor->info->id,
> +				     &config);
> +	if (ret)
> +		return ret;
> +
> +	if (config & BIT(0))

if SCMI_SENS_CFG_IS_ENABLED(config)

> +		cur_mode = THERMAL_DEVICE_ENABLED;
> +
> +	if (cur_mode == new_mode)
> +		return 0;
> +
> +	if (new_mode == THERMAL_DEVICE_ENABLED)
> +		config |= SCMI_SENS_CFG_SENSOR_ENABLED_MASK;
> +	else
> +		config &= ~SCMI_SENS_CFG_SENSOR_ENABLED_MASK;
> +

Here you are ORing the enable bit to preserve the value obtained by
config_get (rightly so), BUT unfortunately looking at the spec
CONFIG_SET uses bits [10:9] for setting the rounding mode while
CONFIG_GET does NOT report (bits [10:2] are Reserved) so you are
in fact setting ROUNDING to 00 probably, meaning ROUND_DOWN.

We could have to add (in the future not now) something in CONFIG_GET
to get the round mode (I'll speak with Souvik) BUT in the meantime I
wonder if it is not more safe here to just explicitly set the mode to
10 to signify it is up to the platform to autonomously choose how to
round. (there are SCMI_SENS_CFG_ROUND_ macros and mask in
scmi_protocol.h)

Other than these small things, LGTM.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian


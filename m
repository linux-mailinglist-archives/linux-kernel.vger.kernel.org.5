Return-Path: <linux-kernel+bounces-35918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A462D8398CB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFE6F1C20B6B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C30886AC9;
	Tue, 23 Jan 2024 18:49:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1328613A;
	Tue, 23 Jan 2024 18:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035757; cv=none; b=Mdf3PVeBBPRID2OH3Uv20ooLJ/DHCAgXZfZMVydW/yQwI/Tgl7beSYDb+288ne1tYbfBbhgkPrK8otG8kAWliyzpe8by2cHLhVYJGUtf8cKW5xmXJe+aMtz2Qlg3f4gY984PNym9uGhAs2kfTR5cM4q5Hr/9CXM3Uch+9emuqYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035757; c=relaxed/simple;
	bh=77rf7zCSV26/dXTTGnsJlMJepVbnzdJ7eIMFaK/mcxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udQa+Q+54587vimYOalMTu8r68W6Q7jZ5O43Pnhqg7uzbc2gMW9ENQ/D4AC9936rZUO/JSgsst4hZnZZcMnLskuW7/mZA8U/ibe+hP73RYTcr5ri1SzMRXR2uYkAA0oP8YEtFflUneBadr4YSifVGn9cwetBJf+ntbgyE7Fb5E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E76361FB;
	Tue, 23 Jan 2024 10:49:59 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 653FD3F762;
	Tue, 23 Jan 2024 10:49:13 -0800 (PST)
Date: Tue, 23 Jan 2024 18:49:10 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sudeep.holla@arm.com, jdelvare@suse.com, linux@roeck-us.net,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] hwmon: scmi-hwmon: implement change_mode
Message-ID: <ZbAKErJmyQY9mXMO@pluto>
References: <20240123150526.3615901-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123150526.3615901-1-peng.fan@oss.nxp.com>

On Tue, Jan 23, 2024 at 11:05:26PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The sensor maybe disabled before kernel boot, so add change_mode
> to support configuring the sensor to enabled state.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

In general LGTM.
It would be better clearly explaining in the commit message that this
change is around HWMON thermal zones and also add a comment down below
to justify why we have decided to clear out those config bits.

> 
> V2:
>  Use SCMI_SENS_CFG_IS_ENABLED & clear BIT[31:9] before update config(Thanks Cristian)
> 
>  drivers/hwmon/scmi-hwmon.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> index 364199b332c0..913acd1b137b 100644
> --- a/drivers/hwmon/scmi-hwmon.c
> +++ b/drivers/hwmon/scmi-hwmon.c
> @@ -151,7 +151,39 @@ static int scmi_hwmon_thermal_get_temp(struct thermal_zone_device *tz,
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
> +	if (SCMI_SENS_CFG_IS_ENABLED(config))
> +		cur_mode = THERMAL_DEVICE_ENABLED;
> +
> +	if (cur_mode == new_mode)
> +		return 0;
> +

This config bits_clearing is worth an explanation in a comment (like we
did in the mail thread...)

> +	config &= ~(SCMI_SENS_CFG_UPDATE_SECS_MASK |
> +		    SCMI_SENS_CFG_UPDATE_EXP_MASK |
> +		    SCMI_SENS_CFG_ROUND_MASK);
> +	if (new_mode == THERMAL_DEVICE_ENABLED)
> +		config |= SCMI_SENS_CFG_SENSOR_ENABLED_MASK;
> +	else
> +		config &= ~SCMI_SENS_CFG_SENSOR_ENABLED_MASK;
> +
> +	return sensor_ops->config_set(th_sensor->ph, th_sensor->info->id,
> +				      config);
> +}
> +

Other than this,

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian


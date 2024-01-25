Return-Path: <linux-kernel+bounces-38979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B179E83C94A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ACA028F03B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529C814462D;
	Thu, 25 Jan 2024 16:57:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DEA14461B;
	Thu, 25 Jan 2024 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201868; cv=none; b=ORpto0jLIsQ/QFXOSG2Ygz/hYUrdVBbl0V6MBbk1h/pFUuwNh2E68IpuWZzqsqMsn++IOantda1sToLFs8jMmEp3O7tuusgZPU/FIPp90HCmXrOg8GZF+YrZKG+E+kaOSuEMxTfFPksa7tsbQwj+dpPLDUmW2TNk1r9cf7hlwas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201868; c=relaxed/simple;
	bh=J4RVHINTHxXCUS3FqAsSmdDYotLQ5j6o0EmlbWfe8BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2TkMxIGgSoSPsmJetQpyltIgboLXzo0+U8zuesJ6iMOm1FQbl8T0sioLzJH4rqn9XXo/IzkrEvIIvK0yBn8g7jM6gKgCUflKysvuu46T14fMkqmb9rW2m8rPCsoAsyv/RIX/nh6WMVnqeQmH5ZaKHxaEslARw7KVw7ecjCgFO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 026011FB;
	Thu, 25 Jan 2024 08:58:30 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7407E3F73F;
	Thu, 25 Jan 2024 08:57:44 -0800 (PST)
Date: Thu, 25 Jan 2024 16:57:42 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"groeck7@gmail.com" <groeck7@gmail.com>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"jdelvare@suse.com" <jdelvare@suse.com>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3] hwmon: scmi-hwmon: implement change_mode for thermal
 zones
Message-ID: <ZbKTBmt_BP6JRLBj@pluto>
References: <20240125064422.347002-1-peng.fan@oss.nxp.com>
 <b839f83f-c8c7-4fa8-8597-bdde1b40168a@roeck-us.net>
 <DU0PR04MB9417DAD2DBB8820344FEFB07887A2@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <540cf4b3-ebf6-4a85-84c4-c012a69db416@roeck-us.net>
 <ZbKHpFRGoaQpWX16@pluto>
 <da42560b-32b2-49c6-9aeb-b7fbd5b5577c@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da42560b-32b2-49c6-9aeb-b7fbd5b5577c@roeck-us.net>

On Thu, Jan 25, 2024 at 08:16:45AM -0800, Guenter Roeck wrote:
> On 1/25/24 08:09, Cristian Marussi wrote:
> 
> > Agreed, but it seems that indeed here the attempt is to make sure that
> > an accidentally disabled sensor is turned on.
> > 
> 
> From the patch:
> 
> +static int scmi_hwmon_thermal_change_mode(struct thermal_zone_device *tz,
> +					  enum thermal_device_mode new_mode)
> +{
> ...
> +	if (new_mode == THERMAL_DEVICE_ENABLED)
> +		config |= SCMI_SENS_CFG_SENSOR_ENABLED_MASK;
> +	else
> +		config &= ~SCMI_SENS_CFG_SENSOR_ENABLED_MASK;
> 
> This clearly contradicts your statement. It leaves the sensor in full control
> by the thermal subsystem. If the thermal subsystem decides to turn it off,
> it is turned off.

Yes, indeed, and this is wrong as you explained; what I meant is that it seems
to me now after this discussion, and from the commit message, that the reason
(and the aim of this patch) is different from how it achieves it (as a
side effect)

"The thermal sensors maybe disabled before kernel boot, so add change_mode
 for thermal zones to support configuring the thermal sensor to enabled
 state. If reading the temperature when the sensor is disabled, there will
 be error reported."

So when I said:

> > Agreed, but it seems that indeed here the attempt is to make sure that
> > an accidentally disabled sensor is turned on.

and

>> In this case seems like the sensor is NOT supposed to be ever disabled
>> (not even temporarily), it it just that you want to ensure that is
>>enabled, so I would say @Peng, should not that be done in the fw
>> SCMI server ? (i.e. to turn on, early on, all those resources that are
>>  exposed to the agent and meant to be always on)

I implied to drop this patch and instead make sure the visible-and-always-enabled
sensor is default-enabled by the SCMI server running in the firmware, given that
there won't be any need to ever disable it, from the hwmon interface NOR from
the thermal subsystem.

Sorry if I have not been clear (but I maybe still well-wrong anyway :D)

Thanks,
Cristian




Return-Path: <linux-kernel+bounces-38868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6057783C78E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923041C24D37
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BFE128379;
	Thu, 25 Jan 2024 16:09:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3A37C080;
	Thu, 25 Jan 2024 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706198955; cv=none; b=gMh/iTuZxGdC2YIjbUEy6wJOy6u0zSADiqyUelXTOGwy69rDkDjRsgSFjyj15/WJw14EH/+cyDwOAstCKvzhxqN6oh0uYQCjKeZ6l9i2f0WtJ3ofvCWRd/BWoFoz1Sn24VqIsORyWpbQWqYb7VZwsmMXdMCeGViYV04U1NTelqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706198955; c=relaxed/simple;
	bh=GVeMR8zxROHaPrrjozz1M1Pz++mbT0lI0YxeFX0v8aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URWKMo5f2qIEyT+R8SLn5PGMvvoO3XyJoKwXJnykeUoZluFhnuqq4beVTlbQXFgdwQu8BvfidMb2Qfxcqg1RjEXszepfDm1cQS2rxkHOWY1ezL8MuJSRnFYEiPRN7UtGRUa9dKoBimoLE3TcoVWVfWyaTEZBBY31IiRbupsD/e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B06F51FB;
	Thu, 25 Jan 2024 08:09:55 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2ACC73F5A1;
	Thu, 25 Jan 2024 08:09:10 -0800 (PST)
Date: Thu, 25 Jan 2024 16:09:08 +0000
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
Message-ID: <ZbKHpFRGoaQpWX16@pluto>
References: <20240125064422.347002-1-peng.fan@oss.nxp.com>
 <b839f83f-c8c7-4fa8-8597-bdde1b40168a@roeck-us.net>
 <DU0PR04MB9417DAD2DBB8820344FEFB07887A2@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <540cf4b3-ebf6-4a85-84c4-c012a69db416@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <540cf4b3-ebf6-4a85-84c4-c012a69db416@roeck-us.net>

On Thu, Jan 25, 2024 at 06:25:00AM -0800, Guenter Roeck wrote:
> On 1/24/24 23:06, Peng Fan wrote:
> > Hi Guenter,
> > 
> > > Subject: Re: [PATCH V3] hwmon: scmi-hwmon: implement change_mode for
> > > thermal zones
> > > 
> > > On 1/24/24 22:44, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > > 
> > > > The thermal sensors maybe disabled before kernel boot, so add
> > > > change_mode for thermal zones to support configuring the thermal
> > > > sensor to enabled state. If reading the temperature when the sensor is
> > > > disabled, there will be error reported.
> > > > 
> > > > The cost is an extra config_get all to SCMI firmware to get the status
> > > > of the thermal sensor. No function level impact.
> > > > 
> > > > Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > > 
> > > > V3:
> > > >    Update commit log to show it only applys to thermal
> > > >    Add comments in code
> > > >    Add R-b from Cristian
> > > > 
> > > 
> > > You didn't address my question regarding the behavior of hwmon attributes if
> > > a sensor is disabled.
> > 
> > Would you please share a bit more on what attributes?
> > You mean the files under /sys/class/hwmon/hwmon0?
> > 
> > If the sensor is disabled, when cat temp[x]_input, it will
> > report:
> > root@imx95-19x19-lpddr5-evk:/sys/class/hwmon/hwmon0# cat temp3_input
> > cat: temp3_input: Protocol error
> > 
> > For enabled, it will report value:
> > root@imx95-19x19-lpddr5-evk:/sys/class/hwmon/hwmon0# cat temp1_input
> > 31900
> > 
> 
> This is wrong. If the sensor is disabled, there should either be no
> sensor attribute (if the condition is permanent), or there should be
> tempX_enable attribute(s) which return the sensor status (and, if
> appropriate, permit it to be enabled). If the condition is not
> permanent, attempts to read the sensor value should return -ENODATA.
> 
If the sensor is permanently disabled it should not have been exposed by
the SCMI server at all, in first place; in such a case it wont appear at
all in hwmon.

In this case seems like the sensor is NOT supposed to be ever disabled
(not even temporarily), it it just that you want to ensure that is
enabled, so I would say @Peng, should not that be done in the fw
SCMI server ? (i.e. to turn on, early on, all those resources that are 
 exposed to the agent and meant to be always on)

Regarding the non-permanent condition, currently if the SCMI reading
failed, for some reason, we return the same error as returned from the
SCMI layer, so I suppose I should post a patch to remap that return
value to -ENODATA.

> Overall, hwmon functionality is orthogonal to thermal subsystem use.
> It is not appropriate for the thermal subsystem to disable any
> temperature sensors in the hwmon subsystem because the user might
> expect to be able to read temperatures from hwmon devices even
> if sensors are not in use by the thermal subsystem.

Agreed, but it seems that indeed here the attempt is to make sure that
an accidentally disabled sensor is turned on.

Thanks,
Cristian



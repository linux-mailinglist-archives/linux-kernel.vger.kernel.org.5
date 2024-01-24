Return-Path: <linux-kernel+bounces-36615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FC483A3C9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7938D295605
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F98017551;
	Wed, 24 Jan 2024 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NhKdXh9L"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C90217542;
	Wed, 24 Jan 2024 08:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706083886; cv=none; b=OPQL+42fxJIIPhYGDmcMFgxkwjevgMrpBQcsrP3rsq6dT23YVL1DeXNvkOT2bOHbjlJhu9j36vDKblFUv7ksExSC1RlAWbK2DbgOYWIdMPVodGX7ajI+rf/fNoeZ7eKpJdlsZIdhHD7nmM1PVT+OF1j41Txy4b0IaIIYqGO1CQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706083886; c=relaxed/simple;
	bh=+eI7bPLmEB1v+Dyc3X2fZC6r5js6f9RaDDwre1lY988=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NG9YO3VpWsK6p6v16CiZy2Gml/sNwODtR9ljL6QVA7j5MB47eZA5+ea1Dpr+tUolb+ztieiV+hXMNbO7tiLY8mU/ckdv8lTTFyYl8PsFOkNj4EPQhFHwPqgFqc5Z0QUfPrbb1DsgaOQn7Wi5TNnKNvW+lAGeAlxtFRg/nnEY4yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NhKdXh9L; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706083884; x=1737619884;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+eI7bPLmEB1v+Dyc3X2fZC6r5js6f9RaDDwre1lY988=;
  b=NhKdXh9LL8hKfdzap6Pdn1d020f7FGxS0LtjD68tucag6/8QOnFVheWf
   pYztlUXEOGyP3HOMEUbVoFKjYk747VeZ4CeNCVo52uQSroNv6MNbPCoPM
   Hl0x7SFbMjdzznAW6Z3Q1dAWdhtYM4yBCYOyJj0dhdW+CrlAS5QEbU2A7
   hk4ZJ1Nnn22JLEPEXD5aVd9cOG+A2gO3yAAe26awvXrGYznFOBcaOzzsr
   UDOeiwGSreMJDChQ/JgmuX4TV0wesMv8yzlhq40fkqmDHGeqqSzdWJg1P
   ZKdCkEK4UHdU0M7xWClH+0SGWPzgcQiCswEG6/egV39hzNrQh0aqeR8ee
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="398930061"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="398930061"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 00:11:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="929594812"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="929594812"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 24 Jan 2024 00:11:20 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 24 Jan 2024 10:11:19 +0200
Date: Wed, 24 Jan 2024 10:11:19 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: linux-usb@vger.kernel.org, Dell.Client.Kernel@dell.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Jack Pham <quic_jackp@quicinc.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] usb: ucsi_acpi: Quirk to ack a connector change
 ack cmd
Message-ID: <ZbDGJ3x5cFr4gmyz@kuha.fi.intel.com>
References: <20240121204123.275441-1-lk@c--e.de>
 <20240121204123.275441-4-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121204123.275441-4-lk@c--e.de>

On Sun, Jan 21, 2024 at 09:41:23PM +0100, Christian A. Ehrhardt wrote:
> The PPM on some Dell laptops seems to expect that the ACK_CC_CI
> command to clear the connector change notification is in turn
> followed by another ACK_CC_CI to acknowledge the ACK_CC_CI command
> itself. This is in violation of the UCSI spec that states:
> 
>     "The only notification that is not acknowledged by the OPM is
>      the command completion notification for the ACK_CC_CI or the
>      PPM_RESET command."
> 
> Add a quirk to send this ack anyway.
> Apply the quirk to all Dell systems.
> 
> On the first command that acks a connector change send a dummy
> command to determine if it runs into a timeout. Only activate
> the quirk if it does. This ensure that we do not break Dell
> systems that do not need the quirk.
> 
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_acpi.c | 71 ++++++++++++++++++++++++++++--
>  1 file changed, 68 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
> index fa222080887d..928eacbeb21a 100644
> --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
> +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
> @@ -25,6 +25,8 @@ struct ucsi_acpi {
>  	unsigned long flags;
>  	guid_t guid;
>  	u64 cmd;
> +	bool dell_quirk_probed;
> +	bool dell_quirk_active;
>  };
>  
>  static int ucsi_acpi_dsm(struct ucsi_acpi *ua, int func)
> @@ -126,12 +128,73 @@ static const struct ucsi_operations ucsi_zenbook_ops = {
>  	.async_write = ucsi_acpi_async_write
>  };
>  
> -static const struct dmi_system_id zenbook_dmi_id[] = {
> +/*
> + * Some Dell laptops expect that an ACK command with the
> + * UCSI_ACK_CONNECTOR_CHANGE bit set is followed by a (separate)
> + * ACK command that only has the UCSI_ACK_COMMAND_COMPLETE bit set.
> + * If this is not done events are not delivered to OSPM and
> + * subsequent commands will timeout.
> + */
> +static int
> +ucsi_dell_sync_write(struct ucsi *ucsi, unsigned int offset,
> +		     const void *val, size_t val_len)
> +{
> +	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
> +	u64 cmd = *(u64 *)val, ack = 0;
> +	int ret;
> +
> +	if (UCSI_COMMAND(cmd) == UCSI_ACK_CC_CI &&
> +	    cmd & UCSI_ACK_CONNECTOR_CHANGE)
> +		ack = UCSI_ACK_CC_CI | UCSI_ACK_COMMAND_COMPLETE;
> +
> +	ret = ucsi_acpi_sync_write(ucsi, offset, val, val_len);
> +	if (ret != 0)
> +		return ret;
> +	if (ack == 0)
> +		return ret;
> +
> +	if (!ua->dell_quirk_probed) {
> +		ua->dell_quirk_probed = true;
> +
> +		cmd = UCSI_GET_CAPABILITY;
> +		ret = ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &cmd,
> +					   sizeof(cmd));
> +		if (ret == 0)
> +			return ucsi_acpi_sync_write(ucsi, UCSI_CONTROL,
> +						    &ack, sizeof(ack));
> +		if (ret != -ETIMEDOUT)
> +			return ret;
> +
> +		ua->dell_quirk_active = true;
> +		dev_err(ua->dev, "Firmware bug: Additional ACK required after ACKing a connector change.\n");
> +		dev_err(ua->dev, "Firmware bug: Enabling workaround\n");
> +	}
> +
> +	if (!ua->dell_quirk_active)
> +		return ret;
> +
> +	return ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &ack, sizeof(ack));
> +}
> +
> +static const struct ucsi_operations ucsi_dell_ops = {
> +	.read = ucsi_acpi_read,
> +	.sync_write = ucsi_dell_sync_write,
> +	.async_write = ucsi_acpi_async_write
> +};
> +
> +static const struct dmi_system_id ucsi_acpi_quirks[] = {
>  	{
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>  			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX325UA_UM325UA"),
>  		},
> +		.driver_data = (void *)&ucsi_zenbook_ops,
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +		},
> +		.driver_data = (void *)&ucsi_dell_ops,
>  	},
>  	{ }
>  };
> @@ -160,6 +223,7 @@ static int ucsi_acpi_probe(struct platform_device *pdev)
>  {
>  	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
>  	const struct ucsi_operations *ops = &ucsi_acpi_ops;
> +	const struct dmi_system_id *id;
>  	struct ucsi_acpi *ua;
>  	struct resource *res;
>  	acpi_status status;
> @@ -189,8 +253,9 @@ static int ucsi_acpi_probe(struct platform_device *pdev)
>  	init_completion(&ua->complete);
>  	ua->dev = &pdev->dev;
>  
> -	if (dmi_check_system(zenbook_dmi_id))
> -		ops = &ucsi_zenbook_ops;
> +	id = dmi_first_match(ucsi_acpi_quirks);
> +	if (id)
> +		ops = id->driver_data;
>  
>  	ua->ucsi = ucsi_create(&pdev->dev, ops);
>  	if (IS_ERR(ua->ucsi))
> -- 
> 2.40.1

-- 
heikki


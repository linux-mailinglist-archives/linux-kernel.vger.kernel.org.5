Return-Path: <linux-kernel+bounces-135014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDD589B9F2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27CA1F21D97
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF3F32182;
	Mon,  8 Apr 2024 08:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdzQmQxM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7506B3BBC4;
	Mon,  8 Apr 2024 08:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712564013; cv=none; b=OlLyDbj6j5vJcZULKJEOSSRTj7jFZNvwhB1EtprQkcO2GVg7DCzlwKGeVbGnebkQ58jX9V4tMNWU72FLe6kIgTJb9syNKNXnPCj1pupRTmFvPWej/YphW3c3h2lUKRA0pamrIEhtMx45yomzqMuDfoS8Zqrshw9M60WD7toRsF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712564013; c=relaxed/simple;
	bh=WEeMAl5Iqj9tc9Ix7uKHT60HGpMM9PPE3v/6L9yJzao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBHhzZh9lZ2loQLnAFwo8aREkm+eZ1JZH5vOdkvaCqfehGcGRHRHVfmy2dGuX6D9n6DziAHvfYqgHuSZxF1FYGhccmIT63bhHhW+dRmcvnbxz8oSMtmPsMgXaZNIcn0s/E4kXxA1C7ZyNNogFDS8GiyxFcHWcwbECzMbFD79fyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdzQmQxM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98782C433C7;
	Mon,  8 Apr 2024 08:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712564013;
	bh=WEeMAl5Iqj9tc9Ix7uKHT60HGpMM9PPE3v/6L9yJzao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mdzQmQxMMKcFpmq+QHRoh7bB4ojP9CvdolrCbac8NlQjgC0AgDFJKDy6I8NTOM9Ph
	 oUNcpZh/iWSbpVTpwPiSfdyKoxUhOLLXY2/m3KMRwOzqc3K1eqmz2S5B9WEoAKohlw
	 4lv29wk/bZKGvsC2eZTTB0c9lSBETOZX+oXTTFwa8tmaceY22/VbShFETOtZOoUEgw
	 tHfutXUmKc+Nis+CJ1yg0tcvs23id8XqnrHGFbftn4BQJk6sIP+kyAakKX8/8NONlw
	 5WxBkjgKBighBPwJ9MxymQ3uB1bliUMxGaHW4/ie98whDPhx+uZG59Up8asGN2FvIv
	 0IGDbJ2X0m8qA==
Date: Mon, 8 Apr 2024 16:13:29 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Pavan Holla <pholla@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v3 2/2] usb: typec: ucsi: Implement ChromeOS UCSI driver
Message-ID: <ZhOnKWcNllls6gdA@google.com>
References: <20240403-public-ucsi-h-v3-0-f848e18c8ed2@chromium.org>
 <20240403-public-ucsi-h-v3-2-f848e18c8ed2@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403-public-ucsi-h-v3-2-f848e18c8ed2@chromium.org>

On Wed, Apr 03, 2024 at 06:05:22PM +0000, Pavan Holla wrote:
> Implementation of a UCSI transport driver for ChromeOS.
> This driver will be loaded if the ChromeOS EC implements a PPM.

How this driver get probed?  From drivers/mfd/cros_ec_dev.c?  If so, there is
no "cros-ec-ucsi" in the MFD driver yet.

> diff --git a/drivers/usb/typec/ucsi/cros_ec_ucsi.c b/drivers/usb/typec/ucsi/cros_ec_ucsi.c
> [...]
> +static int cros_ucsi_async_write(struct ucsi *ucsi, unsigned int offset,
> +				 const void *val, size_t val_len)
> +{
> +	struct cros_ucsi_data *udata = ucsi_get_drvdata(ucsi);
> +	uint8_t ec_buffer[MAX_EC_DATA_SIZE + sizeof(struct ec_params_ucsi_ppm_set)];
> +	struct ec_params_ucsi_ppm_set *req = (struct ec_params_ucsi_ppm_set *)ec_buffer;
> +	int ret = 0;

The initialization is redundant.  `ret` will be overridden soon.

> +	if (val_len > MAX_EC_DATA_SIZE) {
> +		dev_err(udata->dev, "Can't write %zu bytes. Too big.", val_len);
> +		return -EINVAL;
> +	}
> +
> +	memset(req, 0, sizeof(ec_buffer));

The `memset` is redundant.

> +	req->offset = offset;
> +	memcpy(req->data, val, val_len);
> +	ret = cros_ec_cmd(udata->ec, 0, EC_CMD_UCSI_PPM_SET,
> +			  req, sizeof(struct ec_params_ucsi_ppm_set) + val_len, NULL, 0);

`sizeof(*req)`.

> +static int cros_ucsi_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> [...]
> +	udata->ucsi = ucsi_create(udata->dev, &cros_ucsi_ops);

`dev`.

> [...]
> +static const struct platform_device_id cros_ec_ucsi_id[] = {

To be consistent with other symbols, consider either:
- s/cros_ec_/cros_/ for the symbol.
or
- s/cros_ucsi_/cros_ec_ucsi_/g for echoing the file name.

> +	{ "cros-ec-ucsi"},

The driver has declared DRV_NAME, use it.  `{ DRV_NAME, 0 },`.

> +	{}
> +};
> +MODULE_DEVICE_TABLE(platform, cros_ec_ucsi_id);

Ditto.

> +static struct platform_driver cros_ucsi_driver = {
> +	.driver = {
> +		.name = DRV_NAME,
> +		.pm = &cros_ucsi_pm_ops,
> +	},
> +	.id_table = cros_ec_ucsi_id,

Ditto.


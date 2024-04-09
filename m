Return-Path: <linux-kernel+bounces-137198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB86689DF46
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BDC5B2EE86
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDAE1353EC;
	Tue,  9 Apr 2024 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oYYc9qCT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC46013473B;
	Tue,  9 Apr 2024 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675805; cv=none; b=puKyv+HOojGM5lvqirKcIN5zSL93uVxRzuIfkFccghsEUOv+MJ9twOI4Ww5HpY7fu/Cg8owPvKA+OOrr1+nXXH9kS1W7jwcOvDEk9q0aXgoG/tbf0ms8typ9VJ83sqDpsQQ/yCTfy/sAyBH1UXmeu/9Rq8VmyYedM8+D6/Jadgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675805; c=relaxed/simple;
	bh=NdYA5pDvn1gXLpGkX7ACdvJkw6wL9HAHo+IMmiRklHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCrQL2b/JXk3lr2KgswhzWFews069Y27bbPRW86GQA007UhkxioY0cC6w0NRQc4Xi4z2RZYgFL+SucwgGqwddTxjurqrEVogWFi8YE14jyW4ifo27u/PHF1i/flGS3EhCh7PRY7iR5RR5qi/kwhO8arrA7myifUSGpY4RYj1Lqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oYYc9qCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C5EC433F1;
	Tue,  9 Apr 2024 15:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712675805;
	bh=NdYA5pDvn1gXLpGkX7ACdvJkw6wL9HAHo+IMmiRklHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oYYc9qCTo+c+CfNgjYqOvbDaSEraAEyyJJt01CncHRDwpLElJHlotYfo0+ZVID6gX
	 Oouk78RpmM3eHO7+EKriNviCMnGtvrEdRKg1ZaET7CtOT6ExV1yXWogZRP2GJtlElc
	 Dstvn0GIg+N/j08GZwEXUll76Bgami7nm9moEjpU=
Date: Tue, 9 Apr 2024 17:16:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pavan Holla <pholla@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v4 2/2] usb: typec: ucsi: Implement ChromeOS UCSI driver
Message-ID: <2024040916-kleenex-machinist-4858@gregkh>
References: <20240409-public-ucsi-h-v4-0-e770735222a2@chromium.org>
 <20240409-public-ucsi-h-v4-2-e770735222a2@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409-public-ucsi-h-v4-2-e770735222a2@chromium.org>

On Tue, Apr 09, 2024 at 02:27:37AM +0000, Pavan Holla wrote:
> +#define DRV_NAME "cros-ec-ucsi"

KBUILD_MODNAME?

> +
> +#define MAX_EC_DATA_SIZE 256
> +#define WRITE_TMO_MS 500

What are these and why these values?  And tabs perhaps?

> +
> +struct cros_ucsi_data {
> +	struct device *dev;
> +	struct ucsi *ucsi;
> +
> +	struct cros_ec_device *ec;
> +	struct notifier_block nb;
> +	struct work_struct work;
> +
> +	struct completion complete;
> +	unsigned long flags;
> +};
> +
> +static int cros_ucsi_read(struct ucsi *ucsi, unsigned int offset, void *val,
> +			  size_t val_len)
> +{
> +	struct cros_ucsi_data *udata = ucsi_get_drvdata(ucsi);
> +	struct ec_params_ucsi_ppm_get req = {
> +		.offset = offset,
> +		.size = val_len,
> +	};
> +	int ret;
> +
> +	if (val_len > MAX_EC_DATA_SIZE) {
> +		dev_err(udata->dev, "Can't read %zu bytes. Too big.", val_len);
> +		return -EINVAL;
> +	}
> +
> +	ret = cros_ec_cmd(udata->ec, 0, EC_CMD_UCSI_PPM_GET,
> +			  &req, sizeof(req), val, val_len);
> +	if (ret < 0) {
> +		dev_warn(udata->dev, "Failed to send EC message UCSI_PPM_GET: error=%d", ret);
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static int cros_ucsi_async_write(struct ucsi *ucsi, unsigned int offset,
> +				 const void *val, size_t val_len)
> +{
> +	struct cros_ucsi_data *udata = ucsi_get_drvdata(ucsi);
> +	uint8_t ec_buffer[MAX_EC_DATA_SIZE + sizeof(struct ec_params_ucsi_ppm_set)];

That's a lot of data on the stack, are you sure you want to do that?

And are you sure you are allowed to have this data on the stack?  It
never ends up being sent using DMA?

And please, don't use non-kernel types like "uint8_t", use "u8" like
intended.  This isn't userspace (yes, I know a lot of kernel code uses
these, but as you are going to change this, might as well change that
too.)

thanks,

greg k-h


Return-Path: <linux-kernel+bounces-167606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 193528BABDD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FE18B20D72
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A84152DE8;
	Fri,  3 May 2024 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="q5X8z44V"
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAEB152513;
	Fri,  3 May 2024 11:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714737076; cv=none; b=C7rn/+eROZaTDHHOZfg+Gx0PCshLdR2JPA1CULwY1oiZ1WK//bqCLWmXIdCdJ4WDwkPtz9bteZ8lE6+bvIgOSpgElyKCwE6d9sHGQwPA+8mCJjDfe+LzyuOuicCphIu17M4rMHxO7EQuwht/BC7bv+Spe4gAJuURjzhDJVxo5lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714737076; c=relaxed/simple;
	bh=gDDE1kJ1sy/xm240iGbzn9Y0oqO0rWxMrIv6iP84Hrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8gif76WgjnSd2ZPZ1qFEe2uyRGQHRKhIEavxSd9nDwfFQIVPGKhyKBhiXyrgJTMoUjdeb/FnzuG3XAWaVuu9GXW4ic8XJFbFdyPaNhQg9bAHto5UwzzmhBxciNasI4p0Quz8w4gS1EKov8j3IZn/HztZLu3CKp6DkhKXLDj5ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=q5X8z44V; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1714737065; bh=gDDE1kJ1sy/xm240iGbzn9Y0oqO0rWxMrIv6iP84Hrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q5X8z44VkMQw3UcKogA7wv8aZaP9vvuZFbG4woc2eHhzrsYp0MlgTdzNeOKjHv7eC
	 VbCKVahuu5MJ/TMNGdvGAnS9G0nLI+JEigSauj8lVXcRofEOZ6ziwT16D4UsEHSLeK
	 BTJ3yXpcEL5d33+F+/sHyBYc98oB+/eTIY0pD4PSa8K15fYnYswAnK5M6x/zF6lcRH
	 TRX4jCMrOJB5agAGbHUypZ3Ie2qfXZJrrsLTTKFAhtLVYsT8PFJuAbYzKkZTZDSzej
	 +Y97zeH6rWaU0AUhENG/tPGxsD1ZjHFAvH1LPmRs5zq912CEh5aMjuDD/ziAGhBs6k
	 0lTMfRfWJCMvw==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id B3DB410005E; Fri,  3 May 2024 12:51:05 +0100 (BST)
Date: Fri, 3 May 2024 12:51:05 +0100
From: Sean Young <sean@mess.org>
To: Zheng Yejian <zhengyejian1@huawei.com>
Cc: mchehab@kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Subject: Re: [PATCH v2] media: dvb-usb: Fix unexpected infinite loop in
 dvb_usb_read_remote_control()
Message-ID: <ZjTPqR3_EhbNU-fm@gofer.mess.org>
References: <20240412135256.1546051-1-zhengyejian1@huawei.com>
 <20240430104137.1014471-1-zhengyejian1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430104137.1014471-1-zhengyejian1@huawei.com>

On Tue, Apr 30, 2024 at 06:41:37PM +0800, Zheng Yejian wrote:
> Infinite log printing occurs during fuzz test:
> 
>   rc rc1: DViCO FusionHDTV DVB-T USB (LGZ201) as ...
>   ...
>   dvb-usb: schedule remote query interval to 100 msecs.
>   dvb-usb: DViCO FusionHDTV DVB-T USB (LGZ201) successfully initialized ...
>   dvb-usb: bulk message failed: -22 (1/0)
>   dvb-usb: bulk message failed: -22 (1/0)
>   dvb-usb: bulk message failed: -22 (1/0)
>   ...
>   dvb-usb: bulk message failed: -22 (1/0)
> 
> Looking into the codes, there is a loop in dvb_usb_read_remote_control(),
> that is in rc_core_dvb_usb_remote_init() create a work that will call
> dvb_usb_read_remote_control(), and this work will reschedule itself at
> 'rc_interval' intervals to recursively call dvb_usb_read_remote_control(),
> see following code snippet:
> 
>   rc_core_dvb_usb_remote_init() {
>     ...
>     INIT_DELAYED_WORK(&d->rc_query_work, dvb_usb_read_remote_control);
>     schedule_delayed_work(&d->rc_query_work,
>                           msecs_to_jiffies(rc_interval));
>     ...
>   }
> 
>   dvb_usb_read_remote_control() {
>     ...
>     err = d->props.rc.core.rc_query(d);
>     if (err)
>       err(...)  // Did not return even if query failed
>     schedule_delayed_work(&d->rc_query_work,
>                           msecs_to_jiffies(rc_interval));
>   }
> 
> When the infinite log printing occurs, the query callback
> 'd->props.rc.core.rc_query' is cxusb_rc_query(). And the log is due to
> the failure of finding a valid 'generic_bulk_ctrl_endpoint'
> in usb_bulk_msg(), see following code snippet:
> 
>   cxusb_rc_query() {
>     cxusb_ctrl_msg() {
>       dvb_usb_generic_rw() {
>         ret = usb_bulk_msg(d->udev, usb_sndbulkpipe(d->udev,
>                            d->props.generic_bulk_ctrl_endpoint),...);
>         if (ret)
>           err("bulk message failed: %d (%d/%d)",ret,wlen,actlen);
>           ...
>       }
>   ...
>   }
> 
> By analyzing the corresponding USB descriptor, it shows that the
> bNumEndpoints is 0 in its interface descriptor, but
> the 'generic_bulk_ctrl_endpoint' is 1, that means user don't configure
> a valid endpoint for 'generic_bulk_ctrl_endpoint', therefore this
> 'invalid' USB device should be rejected before it calls into
> dvb_usb_read_remote_control().
> 
> To fix it, we need to add endpoint check for 'generic_bulk_ctrl_endpoint'.
> And as Sean suggested, the same check and clear halts should be done for
> 'generic_bulk_ctrl_endpoint_response'. So introduce
> dvb_usb_check_bulk_endpoint() to do it for both of them.
> 
> Fixes: 4d43e13f723e ("V4L/DVB (4643): Multi-input patch for DVB-USB device")
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> ---
>  drivers/media/usb/dvb-usb/dvb-usb-init.c | 27 ++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> v2:
>  - As Sean suggested, check endpoint and clear halt for both
>    'generic_bulk_ctrl_endpoint' and 'generic_bulk_ctrl_endpoint_response'
>    with the new introduced dvb_usb_check_bulk_endpoint();
>    Link: https://lore.kernel.org/all/ZjCl97Ww6NrzJQCB@gofer.mess.org/
>    Link: https://lore.kernel.org/all/ZjC7rXU7ViaH60_S@gofer.mess.org/
> 
>  - Add Fixes tag.
> 
> v1:
>  - Link: https://lore.kernel.org/all/20240412135256.1546051-1-zhengyejian1@huawei.com/
> 
> diff --git a/drivers/media/usb/dvb-usb/dvb-usb-init.c b/drivers/media/usb/dvb-usb/dvb-usb-init.c
> index fbf58012becd..7eb321bab84f 100644
> --- a/drivers/media/usb/dvb-usb/dvb-usb-init.c
> +++ b/drivers/media/usb/dvb-usb/dvb-usb-init.c
> @@ -23,6 +23,23 @@ static int dvb_usb_force_pid_filter_usage;
>  module_param_named(force_pid_filter_usage, dvb_usb_force_pid_filter_usage, int, 0444);
>  MODULE_PARM_DESC(force_pid_filter_usage, "force all dvb-usb-devices to use a PID filter, if any (default: 0).");
>  
> +static int dvb_usb_check_bulk_endpoint(struct dvb_usb_device *d, u8 endpoint)
> +{
> +	if (endpoint) {
> +		int ret;
> +
> +		ret = usb_pipe_type_check(d->udev, usb_sndbulkpipe(d->udev, endpoint));
> +		if (ret)
> +			return ret;
> +		ret = usb_pipe_type_check(d->udev, usb_rcvbulkpipe(d->udev, endpoint));
> +		if (ret)
> +			return ret;
> +		usb_clear_halt(d->udev, usb_sndbulkpipe(d->udev, endpoint));
> +		usb_clear_halt(d->udev, usb_rcvbulkpipe(d->udev, endpoint));
> +	}
> +	return 0;
> +}
> +
>  static int dvb_usb_adapter_init(struct dvb_usb_device *d, short *adapter_nrs)
>  {
>  	struct dvb_usb_adapter *adap;
> @@ -103,10 +120,12 @@ static int dvb_usb_adapter_init(struct dvb_usb_device *d, short *adapter_nrs)
>  	 * when reloading the driver w/o replugging the device
>  	 * sometimes a timeout occurs, this helps
>  	 */
> -	if (d->props.generic_bulk_ctrl_endpoint != 0) {
> -		usb_clear_halt(d->udev, usb_sndbulkpipe(d->udev, d->props.generic_bulk_ctrl_endpoint));
> -		usb_clear_halt(d->udev, usb_rcvbulkpipe(d->udev, d->props.generic_bulk_ctrl_endpoint));
> -	}
> +	ret = dvb_usb_check_bulk_endpoint(d, d->props.generic_bulk_ctrl_endpoint);
> +	if (ret)
> +		goto frontend_init_err;
> +	ret = dvb_usb_check_bulk_endpoint(d, d->props.generic_bulk_ctrl_endpoint_response);
> +	if (ret)
> +		goto frontend_init_err;
>  
>  	return 0;

This results in the following warning:

drivers/media/usb/dvb-usb/dvb-usb-init.c:133:9: warning: 'adap' may be used uninitialized [-Wmaybe-uninitialized]

I think these tests should be moved to the top of the function, so no cleanup 
is required.


Sean


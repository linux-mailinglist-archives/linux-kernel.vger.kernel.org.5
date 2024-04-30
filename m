Return-Path: <linux-kernel+bounces-163713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A7C8B6E9E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26C81F24866
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B34C1A38E3;
	Tue, 30 Apr 2024 09:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="OiWl84V5"
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E624FC02;
	Tue, 30 Apr 2024 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714469810; cv=none; b=e5ICjvra3EsI4VfTsMOlibOc4ESV3Ze85FE5u1yPuxMhcwKfqk7Sj+yQoKUXMdjARZniRxMiPHFXmBQ/eM2p46LOvm01WQCCpmtLczbdQ7f8Zgn50IvWkWajT1ILGK+wC7eN/bJrDijRg1ZSN3LTl1iXKhn05WALD0r4IdZB9cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714469810; c=relaxed/simple;
	bh=6pVPCtjEhaN9YMepNxoaA6Di8GBA8TQ/2wuNs1NSRqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhCUEdXc2W+hMeI22QKy9Y6aq9b/Six97S02Me9anGnccfWVsX3so3lWj2EkJcAiS8q2VeCzIUYKOxp8jj0qmcv+Vw2m8y3QkxyshLlR2jQLi3fpTqAVyLRtaaUJ496iw4lS3M8PXXj0Pea1S7I3/onI9VOFS1Q4wpi+Z+58KHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=OiWl84V5; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1714469805; bh=6pVPCtjEhaN9YMepNxoaA6Di8GBA8TQ/2wuNs1NSRqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OiWl84V5o0akms2gy6ED0kg8NOAMXZMTIwMPrPVDetnJkYqCdm/hSgxuPY0EpApGN
	 L8mwd/xtvzidpG3XVfvavQZKm0FxLOslKztW8yKO3CxfXSzC0GslVlGFTAHBlS14Vg
	 c3+kzhvP/2NuDnqs4eb44m0vOO9VolsnreDtyvoP+XvOi1ETUpytlwWO/h2/ILebZI
	 uf5ioSkWWyR18SzAFy1flo7UMR+DfuRXS/Q6GFU7ECzTVJH+VgapTQVopiQ4V9PeAg
	 6Oo+HyTNWve3sbgg+NHGev0zBjPoEwzslvkTIjMwdFEtprYlGSN9/LdbS3AG+pPOHt
	 L8E8Hfw7rwjdg==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id C0BC310005E; Tue, 30 Apr 2024 10:36:45 +0100 (BST)
Date: Tue, 30 Apr 2024 10:36:45 +0100
From: Sean Young <sean@mess.org>
To: Zheng Yejian <zhengyejian1@huawei.com>
Cc: mchehab@kernel.org, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: dvb-usb: Fix unexpected infinite loop in
 dvb_usb_read_remote_control()
Message-ID: <ZjC7rXU7ViaH60_S@gofer.mess.org>
References: <20240412135256.1546051-1-zhengyejian1@huawei.com>
 <5c0359c7-502f-fe8b-c1ee-3470b36b586c@huawei.com>
 <ZjCl97Ww6NrzJQCB@gofer.mess.org>
 <37581090-ae63-46c4-98c1-76e9138e6b6e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37581090-ae63-46c4-98c1-76e9138e6b6e@huawei.com>

On Tue, Apr 30, 2024 at 05:19:56PM +0800, Zheng Yejian wrote:
> Thanks for your suggestion!
> Do you mean the following change? If it is ok, I'll send a v2!
> 
> diff --git a/drivers/media/usb/dvb-usb/dvb-usb-init.c b/drivers/media/usb/dvb-usb/dvb-usb-init.c
> index fbf58012becd..2a8395d6373c 100644
> --- a/drivers/media/usb/dvb-usb/dvb-usb-init.c
> +++ b/drivers/media/usb/dvb-usb/dvb-usb-init.c
> @@ -23,6 +23,23 @@ static int dvb_usb_force_pid_filter_usage;
>  module_param_named(force_pid_filter_usage, dvb_usb_force_pid_filter_usage, int, 0444);
>  MODULE_PARM_DESC(force_pid_filter_usage, "force all dvb-usb-devices to use a PID filter, if any (default: 0).");
> 
> +static int dvb_usb_clear_halt(struct dvb_usb_device *d, u8 endpoint)

I don't think this is a good function name; we are checking that the
endpoint is correct and also clearing halts.

How about: dvb_usb_check_bulk_endpoint()

Looks good otherwise

Sean

> +{
> +       if (endpoint) {
> +               int ret;
> +
> +               ret = usb_pipe_type_check(d->udev, usb_sndbulkpipe(d->udev, endpoint));
> +               if (ret)
> +                       return ret;
> +               ret = usb_pipe_type_check(d->udev, usb_rcvbulkpipe(d->udev, endpoint));
> +               if (ret)
> +                       return ret;
> +               usb_clear_halt(d->udev, usb_sndbulkpipe(d->udev, endpoint));
> +               usb_clear_halt(d->udev, usb_rcvbulkpipe(d->udev, endpoint));
> +       }
> +       return 0;
> +}
> +
>  static int dvb_usb_adapter_init(struct dvb_usb_device *d, short *adapter_nrs)
>  {
>         struct dvb_usb_adapter *adap;
> @@ -103,10 +120,12 @@ static int dvb_usb_adapter_init(struct dvb_usb_device *d, short *adapter_nrs)
>          * when reloading the driver w/o replugging the device
>          * sometimes a timeout occurs, this helps
>          */
> -       if (d->props.generic_bulk_ctrl_endpoint != 0) {
> -               usb_clear_halt(d->udev, usb_sndbulkpipe(d->udev, d->props.generic_bulk_ctrl_endpoint));
> -               usb_clear_halt(d->udev, usb_rcvbulkpipe(d->udev, d->props.generic_bulk_ctrl_endpoint));
> -       }
> +       ret = dvb_usb_clear_halt(d, d->props.generic_bulk_ctrl_endpoint);
> +       if (ret)
> +               goto frontend_init_err;
> +       ret = dvb_usb_clear_halt(d, d->props.generic_bulk_ctrl_endpoint_response);
> +       if (ret)
> +               goto frontend_init_err;
> 
>         return 0;
> 
> --
> Thanks,
> Zheng Yejian
> 
> > Thanks
> > 
> > Sean
> 


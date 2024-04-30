Return-Path: <linux-kernel+bounces-163517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B7B8B6C6E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B85E2840F8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1282745035;
	Tue, 30 Apr 2024 08:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="eP2MHSQe"
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E9A41232;
	Tue, 30 Apr 2024 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714464257; cv=none; b=CfsjXm8qeLkmENIV6JzMti8c9ql/ZqmqLTvIiU9XP6Pd6cFJKqX5MQdAZ0n2CtAg5+R1marLNo1ETrj6aqZ85sdyHXPZ0EL/XlowS4TxxCMRb1wxf2BLPb4aHA+f5v7Ip2tXKlJNx+9d7ifGH2yEmoQsy6mGJZnmq3K8GyeRzU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714464257; c=relaxed/simple;
	bh=Z1D2LTONy2JcTIil02F/WJtl0DUhIpE4YgdNGJBPS08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mk2pUJ7//7s8FB6wYcuaiQTEnt/TCENRAPNkpkLhqxALaE3vjeTALMoE6LTjAIkW8o72/7ee/LL/d9oybMRTBvH3FIPSht+2auebWHKXSn55p15e/u7sP0z+qBM2PqQ3y2B/BumTuPb8ypqp8fntgzuQMZD29uQ8MfT/IXExGFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=eP2MHSQe; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1714464247; bh=Z1D2LTONy2JcTIil02F/WJtl0DUhIpE4YgdNGJBPS08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eP2MHSQekscdLBQR9ayy1ukTur6fu0LwVRGn2jcmA9mD2g7V6pgbVvu0f60x1s0dc
	 Y3wpZQOuYCuVqUQUT8vzpsiqReRbPya9cO/H9Yw/HORuptiOX3WQPiTTfZbGaWV2kG
	 mhHSuUKupHdKTwT9e7k6r28PUi+H2fLIIya80m3G8TzMloWrm9orXdHPXym8IzV+Oo
	 6E4VnQfmlhr8i0aIV9fNXWm1SgDH6a7Tfpp5yPv6Wx+js8yVQlikHn2V7Nr0rITNuT
	 /Jrt/x4pNhwtoH1rb86cW3ZWaopy2/OMpuGthJ3Vx7a2PH3RdCqBykevJOjLIIQmcB
	 Q+1ijHFLxeJKw==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id 499A110005E; Tue, 30 Apr 2024 09:04:07 +0100 (BST)
Date: Tue, 30 Apr 2024 09:04:07 +0100
From: Sean Young <sean@mess.org>
To: Zheng Yejian <zhengyejian1@huawei.com>
Cc: mchehab@kernel.org, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: dvb-usb: Fix unexpected infinite loop in
 dvb_usb_read_remote_control()
Message-ID: <ZjCl97Ww6NrzJQCB@gofer.mess.org>
References: <20240412135256.1546051-1-zhengyejian1@huawei.com>
 <5c0359c7-502f-fe8b-c1ee-3470b36b586c@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c0359c7-502f-fe8b-c1ee-3470b36b586c@huawei.com>

On Mon, Apr 29, 2024 at 07:24:21PM +0800, Zheng Yejian wrote:
> On 2024/4/12 21:52, Zheng Yejian wrote:
> > Infinite log printing occurs during fuzz test:
> > 
> >    rc rc1: DViCO FusionHDTV DVB-T USB (LGZ201) as ...
> >    ...
> >    dvb-usb: schedule remote query interval to 100 msecs.
> >    dvb-usb: DViCO FusionHDTV DVB-T USB (LGZ201) successfully initialized ...
> >    dvb-usb: bulk message failed: -22 (1/0)
> >    dvb-usb: bulk message failed: -22 (1/0)
> >    dvb-usb: bulk message failed: -22 (1/0)
> >    ...
> >    dvb-usb: bulk message failed: -22 (1/0)
> > 
> > Looking into the codes, there is a loop in dvb_usb_read_remote_control(),
> > that is in rc_core_dvb_usb_remote_init() create a work that will call
> > dvb_usb_read_remote_control(), and this work will reschedule itself at
> > 'rc_interval' intervals to recursively call dvb_usb_read_remote_control(),
> > see following code snippet:
> > 
> >    rc_core_dvb_usb_remote_init() {
> >      ...
> >      INIT_DELAYED_WORK(&d->rc_query_work, dvb_usb_read_remote_control);
> >      schedule_delayed_work(&d->rc_query_work,
> >                            msecs_to_jiffies(rc_interval));
> >      ...
> >    }
> > 
> >    dvb_usb_read_remote_control() {
> >      ...
> >      err = d->props.rc.core.rc_query(d);
> >      if (err)
> >        err(...)  // Did not return even if query failed
> >      schedule_delayed_work(&d->rc_query_work,
> >                            msecs_to_jiffies(rc_interval));
> >    }
> > 
> > When the infinite log printing occurs, the query callback
> > 'd->props.rc.core.rc_query' is cxusb_rc_query(). And the log is due to
> > the failure of finding a valid 'generic_bulk_ctrl_endpoint'
> > in usb_bulk_msg(), see following code snippet:
> > 
> >    cxusb_rc_query() {
> >      cxusb_ctrl_msg() {
> >        dvb_usb_generic_rw() {
> >          ret = usb_bulk_msg(d->udev, usb_sndbulkpipe(d->udev,
> >                             d->props.generic_bulk_ctrl_endpoint),...);
> >          if (ret)
> >            err("bulk message failed: %d (%d/%d)",ret,wlen,actlen);
> >            ...
> >        }
> >    ...
> >    }
> > 
> > By analyzing the corresponding USB descriptor, it shows that the
> > bNumEndpoints is 0 in its interface descriptor, but
> > the 'generic_bulk_ctrl_endpoint' is 1, that means user don't configure
> > a valid endpoint for 'generic_bulk_ctrl_endpoint', therefore this
> > 'invalid' USB device should be rejected before it calls into
> > dvb_usb_read_remote_control().
> > 
> > To fix it, iiuc, we can add endpoint check in dvb_usb_adapter_init().
> > 
> > Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> > ---
> >   drivers/media/usb/dvb-usb/dvb-usb-init.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> > 
> > Hi, I'm not very familiar with USB driver, and I'm not sure the
> > type check is appropriate or not here. Would be any device properties
> > that allow 'generic_bulk_ctrl_endpoint' not being configured, or would
> > it be configured late after init ? :)
> > 
> 
> Kindly ping :)
> Hi, Mauro, would you mind taking a look at this code ?
> 
> --
> Thanks,
> Zheng Yejian
> 
> > diff --git a/drivers/media/usb/dvb-usb/dvb-usb-init.c b/drivers/media/usb/dvb-usb/dvb-usb-init.c
> > index fbf58012becd..48e7b9fb93dd 100644
> > --- a/drivers/media/usb/dvb-usb/dvb-usb-init.c
> > +++ b/drivers/media/usb/dvb-usb/dvb-usb-init.c
> > @@ -104,6 +104,14 @@ static int dvb_usb_adapter_init(struct dvb_usb_device *d, short *adapter_nrs)
> >   	 * sometimes a timeout occurs, this helps
> >   	 */
> >   	if (d->props.generic_bulk_ctrl_endpoint != 0) {
> > +		ret = usb_pipe_type_check(d->udev, usb_sndbulkpipe(d->udev,
> > +					  d->props.generic_bulk_ctrl_endpoint));
> > +		if (ret)
> > +			goto frontend_init_err;
> > +		ret = usb_pipe_type_check(d->udev, usb_rcvbulkpipe(d->udev,
> > +					  d->props.generic_bulk_ctrl_endpoint));
> > +		if (ret)
> > +			goto frontend_init_err;
> >   		usb_clear_halt(d->udev, usb_sndbulkpipe(d->udev, d->props.generic_bulk_ctrl_endpoint));
> >   		usb_clear_halt(d->udev, usb_rcvbulkpipe(d->udev, d->props.generic_bulk_ctrl_endpoint));
> >   	}
> 

Thank you for your patch.

I think your change looks good. The only comment I have is that the same
check should be done for generic_bulk_ctrl_endpoint_response as well; the
usb_clear_halt() should be done as well, I think.

Thanks

Sean


Return-Path: <linux-kernel+bounces-97349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3603C87693F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE48B1F2457E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B2224A05;
	Fri,  8 Mar 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NxDOJFxH"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B786133CC;
	Fri,  8 Mar 2024 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709917386; cv=none; b=D4xUewWX43S2IStk6qw+JKYkYmLRIXSbFnjq7e4LcS6spepz3V8RZJd0FQ4BTUXVALSoShKpKW8PfOLYdNnoRHSTJ95jQFOHaK07IFctCzvT7SWmCiAWyChHtw5D77TDi6f+4g/+FMt09bPx9vT0pbO6zhol1kPndjm6JjFL9eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709917386; c=relaxed/simple;
	bh=x+BSDaogTlTx6HExeJr2kY2Xre214xK5ve/7vns2ivI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QV/5EJ4+FqhYFDbq/Wp/Ogr53knqXXm9aUeK6IBLLHHSkznogovv34q8nJt8oUZQRL/M0EeWCQ4byeMBM36vNlZBn/g2a3AST8VZYvMp2rSx08zusU1JGr2lxAwcvk0yqCMli9IlaVflzeEnurhom0eJYwqJfLKRK06PqsfZgf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NxDOJFxH; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4D209E000C;
	Fri,  8 Mar 2024 17:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709917382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f9DxpRYK3Ncnn+zC+8VF/kBAVFbc4p7Pz1eQkOUJfqs=;
	b=NxDOJFxHZZQpII8j4FhRtWaaVeu2+jnA4DKtp2VDRbX22TNJqYWjrpQ12j2mdhrtyNmbsQ
	OLVJgJr/Px/rZAuJY4K2+H1shQUaEz8LbDrP4qJ6SyY7lIx7BJ42s6iMN7eL6ctGvU00KU
	HR4VjODLrN2jsSGEUOWtCCrjtwJoKBvCafH6hoMvcZttd/5HnV8g1QtFvHJWI6SYt2ah5q
	XfAHg5DWx0565aYzdYhnCnvKq+7YqC2VANQAyswcCuNbeleE1Yhegk8bsxEwivvNTMYI6+
	tlD4s/maYzK1CoW3AvgbOXbgBzhMYRYWgHaGJCnp/0FYQNHjCISidhKvtsoGBQ==
Date: Fri, 8 Mar 2024 18:03:00 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Peter Hilber <peter.hilber@opensynergy.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	virtio-dev@lists.oasis-open.org, linux-rtc@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [RFC PATCH v3 7/7] virtio_rtc: Add RTC class driver
Message-ID: <2024030817030063a909f0@mail.local>
References: <20231218073849.35294-1-peter.hilber@opensynergy.com>
 <20231218073849.35294-8-peter.hilber@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218073849.35294-8-peter.hilber@opensynergy.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

Hello,

I'll start by saying that I'm sorry, I have a very very high level
knowledge about what virtio is.

On 18/12/2023 08:38:45+0100, Peter Hilber wrote:
> Expose the virtio-rtc UTC clock as an RTC clock to userspace, if it is
> present. Support RTC alarm if the virtio-rtc alarm feature is present. The
> virtio-rtc device signals an alarm by marking an alarmq buffer as used.
> 
> Peculiarities
> -------------
> 
> A virtio-rtc clock is a bit special for an RTC clock in that
> 
> - the clock may step (also backwards) autonomously at any time and
> 
> - the device, and its notification mechanism, will be reset during boot or
>   resume from sleep.
> 
> The virtio-rtc device avoids that the driver might miss an alarm. The
> device signals an alarm whenever the clock has reached or passed the alarm
> time, and also when the device is reset (on boot or resume from sleep), if
> the alarm time is in the past.
> 
> Open Issue
> ----------
> 
> The CLOCK_BOOTTIME_ALARM will use the RTC clock to wake up from sleep, and
> implicitly assumes that no RTC clock steps will occur during sleep. The RTC
> class driver does not know whether the current alarm is a real-time alarm
> or a boot-time alarm.
> 
> Perhaps this might be handled by the driver also setting a virtio-rtc
> monotonic alarm (which uses a clock similar to CLOCK_BOOTTIME_ALARM). The
> virtio-rtc monotonic alarm would just be used to wake up in case it was a
> CLOCK_BOOTTIME_ALARM alarm.
> 
> Otherwise, the behavior should not differ from other RTC class drivers.
> 

What I don't quite get is how this is actually related to RTCs. This
would be a super imprecise mechanism to get the current time and date
from the host to the guest which is what I think your are trying to do,
especially since this is not supporting UIE.
The host system clock may come from reading the RTC at some point in
time but more likely from another source so is it really the best
synchronization mechanism?

The other thing is that I don't quite get the point of the RTC alarm
versus a regular timer in this context.


[...]

> +static const struct rtc_class_ops viortc_class_with_alarm_ops = {
> +	.read_time = viortc_class_read_time,
> +	.read_alarm = viortc_class_read_alarm,
> +	.set_alarm = viortc_class_set_alarm,
> +	.alarm_irq_enable = viortc_class_alarm_irq_enable,
> +};
> +
> +static const struct rtc_class_ops viortc_class_no_alarm_ops = {
> +	.read_time = viortc_class_read_time,
> +};
> +

[...]

> +/**
> +/**
> + * viortc_class_init() - init RTC class wrapper and device
> + * @viortc: device data
> + * @vio_clk_id: virtio_rtc clock id
> + * @have_alarm: expose alarm ops
> + * @parent_dev: virtio device
> + *
> + * Context: Process context.
> + * Return: RTC class wrapper on success, ERR_PTR otherwise.
> + */
> +struct viortc_class *viortc_class_init(struct viortc_dev *viortc,
> +				       u16 vio_clk_id, bool have_alarm,
> +				       struct device *parent_dev)
> +{
> +	struct viortc_class *viortc_class;
> +	struct rtc_device *rtc;
> +
> +	viortc_class =
> +		devm_kzalloc(parent_dev, sizeof(*viortc_class), GFP_KERNEL);
> +	if (!viortc_class)
> +		return ERR_PTR(-ENOMEM);
> +
> +	viortc_class->viortc = viortc;
> +
> +	rtc = devm_rtc_allocate_device(parent_dev);
> +	if (IS_ERR(rtc))
> +		return ERR_PTR(PTR_ERR(rtc));
> +
> +	viortc_class->rtc = rtc;
> +
> +	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
> +
> +	rtc->ops = have_alarm ? &viortc_class_with_alarm_ops :
> +				&viortc_class_no_alarm_ops;

Don't do this, simply clear the alarm feature.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


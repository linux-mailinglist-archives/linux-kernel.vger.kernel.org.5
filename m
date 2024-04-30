Return-Path: <linux-kernel+bounces-163537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB828B6CC7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846011F22372
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87867FBD3;
	Tue, 30 Apr 2024 08:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AQP/UqpV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181DA7605D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714465643; cv=none; b=gxIFK5ktE3vd9NVP1GDd2bxOMtlClDogXv5UzrJpsvPPYJbxFqH5ZP4fYi+pvMoQR8jKzSeWcK8RY1Xf5TQHK13k5fCLMN3SyHKOlF+D6Uqbu+iqgtsWnw+U4Qsjulp+CVoSPhNOzxu2q6PYWIzeLF72xInYjts/dN9lMXRBnJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714465643; c=relaxed/simple;
	bh=VRTiklx5Hl5Or6kMsGEng4M+G0KfPp1uPJdSeMB+dTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMSv6FxcMv7YJiNtj1qy9WXdfteRjaqutdBHgYT/qsnm+VLCV0Y9RxIuVGz0RW6+dSNbqnvK//3EKZkz+CQbRQtl/n25Pn3ndGIWNyGcnSeW4XFZ6wSeR5M5GLkUcHp91yJPJg15Leeps5T8LdMwfPv4jcu0nAtHgDzmdbJ6MTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AQP/UqpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313ACC4AF19;
	Tue, 30 Apr 2024 08:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714465642;
	bh=VRTiklx5Hl5Or6kMsGEng4M+G0KfPp1uPJdSeMB+dTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AQP/UqpVWsCN8pz5x9eDJAZflH3hzb7rE6n7NlnGBWrTYMl8YwdELN8Zu/dLIYZJs
	 rUL671F+7WGVMs03JyeRwcfnjiGM2qkjAVNKqJujIJFae4YphVKprEz8Yl+1HTBfrO
	 aCm9oGyHlFqFu6TFUvmOt5fk4reXEgs8HMJNZhJs=
Date: Tue, 30 Apr 2024 10:27:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, linux-kernel@vger.kernel.org,
	Rafael J Wysocki <rafael@kernel.org>,
	syzbot+ffa8143439596313a85a@syzkaller.appspotmail.com,
	Eugeniu Rosca <eugeniu.rosca@bosch.com>,
	Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH] drivers: core: Make dev->driver usage safe in
 dev_uevent()
Message-ID: <2024043038-haunt-fastball-6db3@gregkh>
References: <20240430045531.4062232-1-dirk.behme@de.bosch.com>
 <2024043030-remnant-plenty-1eeb@gregkh>
 <20240430081754.GA1927@mypc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430081754.GA1927@mypc>

On Tue, Apr 30, 2024 at 10:17:54AM +0200, Eugeniu Rosca wrote:
> Hi Greg,
> 
> On Tue, Apr 30, 2024 at 09:20:10AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Apr 30, 2024 at 06:55:31AM +0200, Dirk Behme wrote:
> > > Inspired by the function dev_driver_string() in the same file make sure
> > > in case of uninitialization dev->driver is used safely in dev_uevent(),
> > > as well.
> > 
> > I think you are racing and just getting "lucky" with your change here,
> > just like dev_driver_string() is doing there (that READ_ONCE() really
> > isn't doing much to protect you...)
> 
> I hope below details shed more details on the repro:
> https://gist.github.com/erosca/1e8a87fbcc9e5ad0fecd32ebcb6266c3

Sometimes I only have access to email, nothing else, please include in
the email the full details.

> To improve the occurrence rate:
>  - a dummy ds90ux9xx-dummy driver was used
>  - a dummy i2c node was added to DTS
>  - a dummy pr_alert() was added to dev_uevent() @ drivers/base/core.c
>  - UBSAN + KASAN enabled in .config

So this is entirely fake?  No real device or driver ever causes this
problem?

Why would you add a pr_alert() call?  What is that for?

totally confused.


> 
> > > This change is based on the observation of the following race condition:
> > > 
> > > Thread #1:
> > > ==========
> > > 
> > > really_probe() {
> > > ...
> > > probe_failed:
> > > ...
> > > device_unbind_cleanup(dev) {
> > >       ...
> > >       dev->driver = NULL;   // <= Failed probe sets dev->driver to NULL
> > >       ...
> > >       }
> > > ...
> > > }
> > > 
> > > Thread #2:
> > > ==========
> > > 
> > > dev_uevent() {
> > 
> > Wait, how can dev_uevent() be called if probe fails?  Who is calling
> > that?
> 
> dev_uevent() is called by reading /sys/bus/i2c/devices/<dev>/uevent.
> Not directly triggered by the probe failure.
> Please, kindly check the above gist/notes.

Again, put the info in the email so we can properly quote and read it,
and it's present for the history involved (web pages disappear, email is
for forever.)

So you have userspace hammering on a uevent file?  Why is it being
called if userspace hasn't even been notified that the device has a
driver bound to it yet?  What causes this action?


> 
> [--- cut ---]
> 
> > > -	if (dev->driver)
> > > -		add_uevent_var(env, "DRIVER=%s", dev->driver->name);
> > > +	/* dev->driver can change to NULL underneath us because of unbinding
> > > +	 * or failing probe(), so be careful about accessing it.
> > > +	 */
> > > +	drv = READ_ONCE(dev->driver);
> > > +	if (drv)
> > > +		add_uevent_var(env, "DRIVER=%s", drv->name);
> > 
> > Again, you are just reducing the window here.  Maybe a bit, but not all
> > that much overall as there is no real lock present.
> 
> The main objective of the patch is to "cache" dev->driver, such
> that it is not cleared asynchronously from a parallel thread.
> A refined/minimal locking alternative (if feasible) is welcome.

"cacheing" a stale pointer still results in a stale pointer :(

thanks,

greg k-h


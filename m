Return-Path: <linux-kernel+bounces-163613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBFC8B6DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F0028B3A1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2EC12A144;
	Tue, 30 Apr 2024 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m+onuW3J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44E9129E88
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467440; cv=none; b=O2AHQyN+5To61SIdosQjD/GJhxr4jFPf0/4pSYm83Y7njUqzsbSMM8WZ03+foNaZoCvpPbTxKrkWgic5b4EHlthDOQO853n55WqNZscWP0lx6NvGcPdM3Mj8OxdqFzCGy5bTe9zf6kHD3c2ml5gYYmS/xQ+TM77PgMdEhWFg4e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467440; c=relaxed/simple;
	bh=D1NhrQDR1ohZV4hhojnKfdDfDCmUA/YR7Temfn6vEgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYbGFAmh2LpTBR8Abg+3drn+0SkTy15DWsE3J+DaXjmchgY86PnRz/aH+EuQ2PcAeF3SLKrpeUUgZqjv7NmajBNo3erTuAig88cF4CAH8zCnZ9gyfNeXL2LQlez8P/tKAVdYBOnwJsGUtp7+7a4FWP2TK2q8kuyM2GVfhWPXvjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m+onuW3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2CBC4AF14;
	Tue, 30 Apr 2024 08:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714467440;
	bh=D1NhrQDR1ohZV4hhojnKfdDfDCmUA/YR7Temfn6vEgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m+onuW3JBirJf5z5uzVpiptqFspaUYE0W6FKN2RBdWKV6xAVE39ajo1HuwsxUCTAo
	 wCst+1sYwojZhG6LLH/1RgH2h0QtdvpgKviMmjCIq7e6StBWdrNK3ocY9XwsuB4KXP
	 AI2N2yEMrBZqw6lw0F2B0F1VnOQ1A1tjGDe6JSuQ=
Date: Tue, 30 Apr 2024 10:57:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-kernel@vger.kernel.org, Rafael J Wysocki <rafael@kernel.org>,
	syzbot+ffa8143439596313a85a@syzkaller.appspotmail.com,
	Eugeniu Rosca <eugeniu.rosca@bosch.com>
Subject: Re: [PATCH] drivers: core: Make dev->driver usage safe in
 dev_uevent()
Message-ID: <2024043005-crusher-repaint-e02b@gregkh>
References: <20240430045531.4062232-1-dirk.behme@de.bosch.com>
 <2024043030-remnant-plenty-1eeb@gregkh>
 <eadf2812-85c8-4458-b504-10a60a16d1ea@de.bosch.com>
 <2024043041-arrange-defy-30de@gregkh>
 <4f197ed9-e0d2-478b-b236-bea682303e91@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f197ed9-e0d2-478b-b236-bea682303e91@de.bosch.com>

On Tue, Apr 30, 2024 at 10:50:52AM +0200, Dirk Behme wrote:
> On 30.04.2024 10:41, Greg Kroah-Hartman wrote:
> > On Tue, Apr 30, 2024 at 10:23:36AM +0200, Dirk Behme wrote:
> > > Hi Greg,
> > > 
> > > On 30.04.2024 09:20, Greg Kroah-Hartman wrote:
> > > > On Tue, Apr 30, 2024 at 06:55:31AM +0200, Dirk Behme wrote:
> > > > > Inspired by the function dev_driver_string() in the same file make sure
> > > > > in case of uninitialization dev->driver is used safely in dev_uevent(),
> > > > > as well.
> > > > 
> > > > I think you are racing and just getting "lucky" with your change here,
> > > > just like dev_driver_string() is doing there (that READ_ONCE() really
> > > > isn't doing much to protect you...)
> > > > 
> > > > > This change is based on the observation of the following race condition:
> > > > > 
> > > > > Thread #1:
> > > > > ==========
> > > > > 
> > > > > really_probe() {
> > > > > ...
> > > > > probe_failed:
> > > > > ...
> > > > > device_unbind_cleanup(dev) {
> > > > >         ...
> > > > >         dev->driver = NULL;   // <= Failed probe sets dev->driver to NULL
> > > > >         ...
> > > > >         }
> > > > > ...
> > > > > }
> > > > > 
> > > > > Thread #2:
> > > > > ==========
> > > > > 
> > > > > dev_uevent() {
> > > > 
> > > > Wait, how can dev_uevent() be called if probe fails?  Who is calling
> > > > that?
> > > > 
> > > > > ...
> > > > > if (dev->driver)
> > > > >         // If dev->driver is NULLed from really_probe() from here on,
> > > > >         // after above check, the system crashes
> > > > >         add_uevent_var(env, "DRIVER=%s", dev->driver->name);
> > > > > 
> > > > > dev_driver_string() can't be used here because we want NULL and not
> > > > > anything else in the non-init case.
> > > > > 
> > > > > Similar cases are reported by syzkaller in
> > > > > 
> > > > > https://syzkaller.appspot.com/bug?extid=ffa8143439596313a85a
> > > > > 
> > > > > But these are regarding the *initialization* of dev->driver
> > > > > 
> > > > > dev->driver = drv;
> > > > > 
> > > > > As this switches dev->driver to non-NULL these reports can be considered
> > > > > to be false-positives (which should be "fixed" by this commit, as well,
> > > > > though).
> > > > > 
> > > > > Fixes: 239378f16aa1 ("Driver core: add uevent vars for devices of a class")
> > > > > Cc: syzbot+ffa8143439596313a85a@syzkaller.appspotmail.com
> > > > > Reviewed-by: Eugeniu Rosca <eugeniu.rosca@bosch.com>
> > > > > Tested-by: Eugeniu Rosca <eugeniu.rosca@bosch.com>
> > > > > Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> > > > > ---
> > > > >    drivers/base/core.c | 9 +++++++--
> > > > >    1 file changed, 7 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > > index 5f4e03336e68..99ead727c08f 100644
> > > > > --- a/drivers/base/core.c
> > > > > +++ b/drivers/base/core.c
> > > > > @@ -2639,6 +2639,7 @@ static const char *dev_uevent_name(const struct kobject *kobj)
> > > > >    static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
> > > > >    {
> > > > >    	const struct device *dev = kobj_to_dev(kobj);
> > > > > +	struct device_driver *drv;
> > > > >    	int retval = 0;
> > > > >    	/* add device node properties if present */
> > > > > @@ -2667,8 +2668,12 @@ static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
> > > > >    	if (dev->type && dev->type->name)
> > > > >    		add_uevent_var(env, "DEVTYPE=%s", dev->type->name);
> > > > > -	if (dev->driver)
> > > > > -		add_uevent_var(env, "DRIVER=%s", dev->driver->name);
> > > > > +	/* dev->driver can change to NULL underneath us because of unbinding
> > > > > +	 * or failing probe(), so be careful about accessing it.
> > > > > +	 */
> > > > > +	drv = READ_ONCE(dev->driver);
> > > > > +	if (drv)
> > > > > +		add_uevent_var(env, "DRIVER=%s", drv->name);
> > > > 
> > > > Again, you are just reducing the window here.  Maybe a bit, but not all
> > > > that much overall as there is no real lock present.
> > > > 
> > > > So how is this actually solving anything?
> > > 
> > > 
> > > Looking at dev_driver_string() I hoped that it just reads *once*. I.e. we
> > > don't care if we read NULL or any valid pointer, as long as this pointer
> > > read is done only once ("atomically"?). If READ_ONCE() doesn't do that, I
> > > agree, it's not the (race) fix we are looking for.
> > 
> > Yes, what if you read it, and then it is unloaded from the system before
> > you attempt to access drv->name?  not good.
> > 
> > > Initially, I was thinking about anything like [1] below. I.e. adding a mutex
> > > lock.  But not sure if that is better (acceptable?).
> > 
> > a proper lock is the only way to correctly solve this.
> 
> 
> Would using device_lock()/unlock() for locking like done below [1]
> acceptable?

Why not test it out and see!  :)



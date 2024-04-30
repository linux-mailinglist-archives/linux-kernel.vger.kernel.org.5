Return-Path: <linux-kernel+bounces-163979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 161F18B76CA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE98B1F24B2C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3554E17166C;
	Tue, 30 Apr 2024 13:18:19 +0000 (UTC)
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A6B17107C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.241.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483098; cv=none; b=iYH+SlCWhCwdQ6+azfh35nMLwhjII2y+9ukOcYo/VjdvqCngiyjhcYnGr/SyfE366BAn+hHffn6lo9C5lvS6uxXoaEF5L9RxFXQNtjTcc7qa8M290iJGO3kXjpXRI85noE/azKzXKdl7odQdcOWxwX3CUG5t4olE5tRov0PbtuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483098; c=relaxed/simple;
	bh=87xMadzi3+AHnIOAzl3v2td19EDukezvR3UMXomLmaI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5Iu5RksfBsRIW0jXGYdpg237VE7TiCn4T+C54jKMGTGN6sOP/KJQWUIDJ3A7EbuDWk9IqX/5Qc9U6Ph7QYNp4NHCYhDHtAP64WZdFVuzSi7K+UkGgu0RzcAoCTdjVDCopb/qC1gSAeiu4LHsoo94i2hDLhFkxeXm+/ECpdtPrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com; spf=pass smtp.mailfrom=de.adit-jv.com; arc=none smtp.client-ip=93.241.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.adit-jv.com
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
	by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 39B16520150;
	Tue, 30 Apr 2024 15:18:13 +0200 (CEST)
Received: from mypc (10.72.94.1) by hi2exch02.adit-jv.com (10.72.92.28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.37; Tue, 30 Apr
 2024 15:18:12 +0200
Date: Tue, 30 Apr 2024 15:18:08 +0200
From: Eugeniu Rosca <erosca@de.adit-jv.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Eugeniu Rosca <erosca@de.adit-jv.com>, Dirk Behme
	<dirk.behme@de.bosch.com>, <linux-kernel@vger.kernel.org>, Rafael J Wysocki
	<rafael@kernel.org>, <syzbot+ffa8143439596313a85a@syzkaller.appspotmail.com>,
	Eugeniu Rosca <eugeniu.rosca@bosch.com>, Eugeniu Rosca
	<roscaeugeniu@gmail.com>
Subject: Re: [PATCH] drivers: core: Make dev->driver usage safe in
 dev_uevent()
Message-ID: <20240430131808.GA5272@mypc>
References: <20240430045531.4062232-1-dirk.behme@de.bosch.com>
 <2024043030-remnant-plenty-1eeb@gregkh>
 <20240430081754.GA1927@mypc>
 <2024043038-haunt-fastball-6db3@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2024043038-haunt-fastball-6db3@gregkh>
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)

Hello Greg,

On Tue, Apr 30, 2024 at 10:27:19AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Apr 30, 2024 at 10:17:54AM +0200, Eugeniu Rosca wrote:
> > Hi Greg,
> > 
> > On Tue, Apr 30, 2024 at 09:20:10AM +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Apr 30, 2024 at 06:55:31AM +0200, Dirk Behme wrote:
> > > > Inspired by the function dev_driver_string() in the same file make sure
> > > > in case of uninitialization dev->driver is used safely in dev_uevent(),
> > > > as well.
> > > 
> > > I think you are racing and just getting "lucky" with your change here,
> > > just like dev_driver_string() is doing there (that READ_ONCE() really
> > > isn't doing much to protect you...)
> > 
> > I hope below details shed more details on the repro:
> > https:// gist.github.com/erosca/1e8a87fbcc9e5ad0fecd32ebcb6266c3
> 
> Sometimes I only have access to email, nothing else, please include in
> the email the full details.

Will follow your preference in the future.

> 
> > To improve the occurrence rate:
> >  - a dummy ds90ux9xx-dummy driver was used
> >  - a dummy i2c node was added to DTS
> >  - a dummy pr_alert() was added to dev_uevent() @ drivers/base/core.c
> >  - UBSAN + KASAN enabled in .config
> 
> So this is entirely fake?  No real device or driver ever causes this
> problem?

Of course not. This issue is impacting the end user by resetting the HW
target once in a couple of months. Our synthetic test-case tries to
emulate the end user's scenario, for quicker reproduction & validation
of potential/candidate solutions.

Dirk's synthetic scenario leads to the same logs as shared by the user.
Based on that evidence, we believe we found the root cause.

> 
> Why would you add a pr_alert() call?  What is that for?
> 
> totally confused.

pr_alert() acts as a simple delay, accelerating the reproduction.

> 
> 
> > 
> > > > This change is based on the observation of the following race condition:
> > > > 
> > > > Thread #1:
> > > > ==========
> > > > 
> > > > really_probe() {
> > > > ...
> > > > probe_failed:
> > > > ...
> > > > device_unbind_cleanup(dev) {
> > > >       ...
> > > >       dev->driver = NULL;   // <= Failed probe sets dev->driver to NULL
> > > >       ...
> > > >       }
> > > > ...
> > > > }
> > > > 
> > > > Thread #2:
> > > > ==========
> > > > 
> > > > dev_uevent() {
> > > 
> > > Wait, how can dev_uevent() be called if probe fails?  Who is calling
> > > that?
> > 
> > dev_uevent() is called by reading /sys/bus/i2c/devices/<dev>/uevent.
> > Not directly triggered by the probe failure.
> > Please, kindly check the above gist/notes.
> 
> Again, put the info in the email so we can properly quote and read it,
> and it's present for the history involved (web pages disappear, email is
> for forever.)

Agreed & will follow in the future (did not want to clutter the e-mail)

> 
> So you have userspace hammering on a uevent file?  Why is it being
> called if userspace hasn't even been notified that the device has a
> driver bound to it yet?  What causes this action?

We know that uevent subsystem is involved, based on the post-mortem logs.
Hence, reading sysfs was the easiest way to translate the real-life
use-case to a synthetic one.

> > 
> > [--- cut ---]
> > 
> > > > -	if (dev->driver)
> > > > -		add_uevent_var(env, "DRIVER=%s", dev->driver->name);
> > > > +	/* dev->driver can change to NULL underneath us because of unbinding
> > > > +	 * or failing probe(), so be careful about accessing it.
> > > > +	 */
> > > > +	drv = READ_ONCE(dev->driver);
> > > > +	if (drv)
> > > > +		add_uevent_var(env, "DRIVER=%s", drv->name);
> > > 
> > > Again, you are just reducing the window here.  Maybe a bit, but not all
> > > that much overall as there is no real lock present.
> > 
> > The main objective of the patch is to "cache" dev->driver, such
> > that it is not cleared asynchronously from a parallel thread.
> > A refined/minimal locking alternative (if feasible) is welcome.
> 
> "cacheing" a stale pointer still results in a stale pointer :(

Agreed. So, likely minimal/least-intrusive locking will be necessary.

> 
> thanks,
> 
> greg k-h

BR, Eugeniu


Return-Path: <linux-kernel+bounces-163535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00D88B6CBD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8E3283E80
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77F57D3E8;
	Tue, 30 Apr 2024 08:25:01 +0000 (UTC)
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121587BAE4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.241.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714465501; cv=none; b=cPOqHku8DcNTPg5a2eXUikL8gmhHdNUGhaVjmQimw4epD4NNAIEXv+4hu9E5s+8pCbEG4NrHsHXB1w252MhAfxKW+FhrUVTDPnVYjKo2ZU4HqaazVEWif1U0Ek+0IjI7TpGl3oVdZEK21tLt546F1hTU0As3VnKyOlxkg5sn/RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714465501; c=relaxed/simple;
	bh=q3mxS2YU1sgtPjDx3kbMqfbXNu+SMqlzdZWv3eLiLUA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oT7dPtEJwRMEkaaspnDNM5oT4sFwaq8ItG+dsVpav1/DYEyVy0gbPr2mhIMjCfCacytXSZm/91TtCQCz0eSnU7BK8Qy+w97/bX2B76C+Aterw9REgWKwO6WYOal3OGr4uPI1rn+zs21tqFN6nHCjzv/P0g25Jz76Tm63ptFP01U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com; spf=pass smtp.mailfrom=de.adit-jv.com; arc=none smtp.client-ip=93.241.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.adit-jv.com
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
	by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 19F50520173;
	Tue, 30 Apr 2024 10:18:00 +0200 (CEST)
Received: from mypc (10.72.94.1) by hi2exch02.adit-jv.com (10.72.92.28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.37; Tue, 30 Apr
 2024 10:17:59 +0200
Date: Tue, 30 Apr 2024 10:17:54 +0200
From: Eugeniu Rosca <erosca@de.adit-jv.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Dirk Behme <dirk.behme@de.bosch.com>, <linux-kernel@vger.kernel.org>,
	Rafael J Wysocki <rafael@kernel.org>,
	<syzbot+ffa8143439596313a85a@syzkaller.appspotmail.com>, Eugeniu Rosca
	<eugeniu.rosca@bosch.com>, Eugeniu Rosca <erosca@de.adit-jv.com>, Eugeniu
 Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH] drivers: core: Make dev->driver usage safe in
 dev_uevent()
Message-ID: <20240430081754.GA1927@mypc>
References: <20240430045531.4062232-1-dirk.behme@de.bosch.com>
 <2024043030-remnant-plenty-1eeb@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2024043030-remnant-plenty-1eeb@gregkh>
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)

Hi Greg,

On Tue, Apr 30, 2024 at 09:20:10AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Apr 30, 2024 at 06:55:31AM +0200, Dirk Behme wrote:
> > Inspired by the function dev_driver_string() in the same file make sure
> > in case of uninitialization dev->driver is used safely in dev_uevent(),
> > as well.
> 
> I think you are racing and just getting "lucky" with your change here,
> just like dev_driver_string() is doing there (that READ_ONCE() really
> isn't doing much to protect you...)

I hope below details shed more details on the repro:
https://gist.github.com/erosca/1e8a87fbcc9e5ad0fecd32ebcb6266c3

To improve the occurrence rate:
 - a dummy ds90ux9xx-dummy driver was used
 - a dummy i2c node was added to DTS
 - a dummy pr_alert() was added to dev_uevent() @ drivers/base/core.c
 - UBSAN + KASAN enabled in .config

> > This change is based on the observation of the following race condition:
> > 
> > Thread #1:
> > ==========
> > 
> > really_probe() {
> > ...
> > probe_failed:
> > ...
> > device_unbind_cleanup(dev) {
> >       ...
> >       dev->driver = NULL;   // <= Failed probe sets dev->driver to NULL
> >       ...
> >       }
> > ...
> > }
> > 
> > Thread #2:
> > ==========
> > 
> > dev_uevent() {
> 
> Wait, how can dev_uevent() be called if probe fails?  Who is calling
> that?

dev_uevent() is called by reading /sys/bus/i2c/devices/<dev>/uevent.
Not directly triggered by the probe failure.
Please, kindly check the above gist/notes.

[--- cut ---]

> > -	if (dev->driver)
> > -		add_uevent_var(env, "DRIVER=%s", dev->driver->name);
> > +	/* dev->driver can change to NULL underneath us because of unbinding
> > +	 * or failing probe(), so be careful about accessing it.
> > +	 */
> > +	drv = READ_ONCE(dev->driver);
> > +	if (drv)
> > +		add_uevent_var(env, "DRIVER=%s", drv->name);
> 
> Again, you are just reducing the window here.  Maybe a bit, but not all
> that much overall as there is no real lock present.

The main objective of the patch is to "cache" dev->driver, such
that it is not cleared asynchronously from a parallel thread.
A refined/minimal locking alternative (if feasible) is welcome.

> 
> So how is this actually solving anything?  And who is calling a uevent
> on a device that is not probed properly?  Userspace?  Within the kernel?
> Something else?

Repro details provided in the gist/notes above.

BR, Eugeniu


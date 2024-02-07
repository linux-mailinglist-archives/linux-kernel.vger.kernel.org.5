Return-Path: <linux-kernel+bounces-56310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ECD84C88D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77C31B22FDC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4247825616;
	Wed,  7 Feb 2024 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Th6daon7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711702560F;
	Wed,  7 Feb 2024 10:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301506; cv=none; b=Yg0dCpCBbdQo2FbvmyzOyCOXrWFKdpZJwwbNAQ8vB6Qgug1301px6YRjlbnkBPgTcTXAQpBXLHPvsQmRp9/QMOMWgrM4WSuxXgKz9pthFhopjelSYUc/FbiagfQlbSId+Fs/RmGSU8R4JIiu9FmVhP7XVUqmRvkMSOfOSnDV1hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301506; c=relaxed/simple;
	bh=D58qgJiMO/DYE+PqVkbHRsWSO4cNXHI8fj75RFB7UWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ihe84Ctd9BogY12XSU9v2Pecytc2NWUSzbQcEu2CEPy3DjO7of8989jH0jBXbm4PNr4biAremi86EGquboC32NoVoUsTP84+Ugbe8kcdEls5MRWjIP3NpXlz/WXBRm1XE7Unxvy1XWWcpUyAe9UIhqnf/XoIwQX+oWs6+/gO+no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Th6daon7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C307C433C7;
	Wed,  7 Feb 2024 10:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707301505;
	bh=D58qgJiMO/DYE+PqVkbHRsWSO4cNXHI8fj75RFB7UWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Th6daon7zKarFRy/prkw0rx+iDQ6zyhb32PFc2qhw3h4m0X98Y0KS5lcGsI+AmdYK
	 yjUea/rLkdFqwvoI0O3MHBoVDvN+jB0O0bPKoBSoS0iuvtrJPMMV3BfzLSQaXiH36K
	 lQ2SYObYO/+mAyHTw3zV1Ws+QE3AKTuIMbvnmm4Y=
Date: Wed, 7 Feb 2024 10:25:02 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vimal Kumar <vimal.kumar32@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, chinmoyghosh2001@gmail.com,
	badolevishal1116@gmail.com, mintupatel89@gmail.com
Subject: Re: [PATCH v4] PM / sleep: Mechanism to find source aborting kernel
 suspend transition
Message-ID: <2024020747-grit-splinter-806d@gregkh>
References: <20240205170747.19748-1-vimal.kumar32@gmail.com>
 <2024020555-usable-hardy-345e@gregkh>
 <20240207035457.GA19804@DESKTOP-KA7F9LU.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207035457.GA19804@DESKTOP-KA7F9LU.localdomain>

On Wed, Feb 07, 2024 at 09:24:57AM +0530, Vimal Kumar wrote:
> On Mon, Feb 05, 2024 at 07:33:17PM +0000, Greg Kroah-Hartman wrote:
> > On Mon, Feb 05, 2024 at 10:37:45PM +0530, Vimal Kumar wrote:
> > > Sometimes kernel suspend transitions can be aborted unconditionally by
> > > manipulating pm_abort_suspend value using "hard" wakeup triggers or
> > > through "pm_system_wakeup()".
> > > 
> > > There is no way to trace the source path of module or subsystem which
> > > aborted the suspend transitions. This change will create a list of
> > > wakeup sources aborting suspend in progress through "hard" events as
> > > well as subsytems aborting suspend using "pm_system_wakeup()".
> > > 
> > > Example: Existing suspend failure logs:
> > > [  349.708359] PM: Some devices failed to suspend, or early wake event detected
> > > [  350.327842] PM: suspend exit
> > > 
> > > Suspend failure logs with this change:
> > > [  518.761835] PM: Some devices failed to suspend, or early wake event detected
> > > [  519.486939] PM: wakeup source or subsystem uart_suspend_port aborted suspend
> > > [  519.500594] PM: suspend exit
> > > 
> > > Here we can clearly identify the module triggerring abort suspend.
> > > 
> > > Co-developed-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
> > > Signed-off-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
> > > Co-developed-by: Mintu Patel <mintupatel89@gmail.com>
> > > Signed-off-by: Mintu Patel <mintupatel89@gmail.com>
> > > Co-developed-by: Vishal Badole <badolevishal1116@gmail.com>
> > > Signed-off-by: Vishal Badole <badolevishal1116@gmail.com>
> > > Signed-off-by: Vimal Kumar <vimal.kumar32@gmail.com>
> > > ---
> > > Changes in v4:
> > > - Changed GFP_KERNEL flag to GFP_ATOMIC
> > > - Changed mutex_lock to raw_spin_lock
> > 
> > why raw?
> >
>  As mutex_lock might sleep, we need to use lock that is suitable for usages in atomic context. raw_spin_lock is already being used for other list in
> this driver, so I used the same. If suggested we can switch to spin_lock_irqsave as well.

You need a really good reason, and a documented one, as to why to use a
raw spinlock.  If not, please just use a normal one (or irqsave if it
can be grabbed in irq context.)

> > > +exit:
> > > +#else
> > > +	if (pm_suspend_target_state != PM_SUSPEND_ON)
> > > +		pm_pr_dbg("Some wakeup source or subsystem aborted suspend\n");
> > > +#endif
> > > +#endif
> > 
> > Would you want to maintain this #ifdef nesting mess for the next 20
> > years?  Please do not do this.
> > 
>  I was hoping if we can remove the "CONFIG_PM_DEBUG" as this functionality can exist by default as well.

Then submit changes for that if that is what you want :)

thanks,

greg k-h


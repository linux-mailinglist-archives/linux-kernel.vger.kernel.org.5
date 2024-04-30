Return-Path: <linux-kernel+bounces-163460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1CD8B6B59
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 929FE1F22A7D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC9D376E5;
	Tue, 30 Apr 2024 07:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g0EpUuWy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD81933EC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714461613; cv=none; b=GkE/FW3crdfvVzAAX2TZXc6xvkdndtFaATGG04JHSUYr9rZF63gzdW0YJDM+oSNC8YSttdFZMtOlwxsr88miT5ODiZ6Etr26WqzvYNW6mB0RsiDE82s9tGWzX/gfnIs/HDQQ7sMtw37sev9gp1WB1aJTD647G5BVGYnHq41Tkx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714461613; c=relaxed/simple;
	bh=dDoRX0sFyMPB/yD48eqj4XKbmpiWrNu6eqDRZ+zd/rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlXEBmwUzkwDj3lM5R+2QhHm4YvP14ZRvS8EgOj9SUTT+mZkKViIPI2dXKg9pRpPrBgn8psZ4AbdQhs0o3SpYskHLJrkys5YWPsRQTZPacEbZuX15fH7HtZPGQ0gaokzCNvMdMnqtyOLeDtokKKYdYkZIwvCVf2mplkhvJif4mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g0EpUuWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DFCC2BBFC;
	Tue, 30 Apr 2024 07:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714461613;
	bh=dDoRX0sFyMPB/yD48eqj4XKbmpiWrNu6eqDRZ+zd/rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g0EpUuWyd5/69M77k9gSdkaLwaexYtvX6Bd7gLzbohIYjfC1BPsI63whTG99Gd4S6
	 iKJhqC45EmES+G6NTTjGQHDbeRzagFnv4IfFpPDV/wJ7THxPdz4aRGqK91vjAfgRLh
	 9XyZkG0UoDAUMY/HLfpfpz52YOBo82HO96/5orVE=
Date: Tue, 30 Apr 2024 09:20:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-kernel@vger.kernel.org, Rafael J Wysocki <rafael@kernel.org>,
	syzbot+ffa8143439596313a85a@syzkaller.appspotmail.com,
	Eugeniu Rosca <eugeniu.rosca@bosch.com>
Subject: Re: [PATCH] drivers: core: Make dev->driver usage safe in
 dev_uevent()
Message-ID: <2024043030-remnant-plenty-1eeb@gregkh>
References: <20240430045531.4062232-1-dirk.behme@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430045531.4062232-1-dirk.behme@de.bosch.com>

On Tue, Apr 30, 2024 at 06:55:31AM +0200, Dirk Behme wrote:
> Inspired by the function dev_driver_string() in the same file make sure
> in case of uninitialization dev->driver is used safely in dev_uevent(),
> as well.

I think you are racing and just getting "lucky" with your change here,
just like dev_driver_string() is doing there (that READ_ONCE() really
isn't doing much to protect you...)

> This change is based on the observation of the following race condition:
> 
> Thread #1:
> ==========
> 
> really_probe() {
> ...
> probe_failed:
> ...
> device_unbind_cleanup(dev) {
>       ...
>       dev->driver = NULL;   // <= Failed probe sets dev->driver to NULL
>       ...
>       }
> ...
> }
> 
> Thread #2:
> ==========
> 
> dev_uevent() {

Wait, how can dev_uevent() be called if probe fails?  Who is calling
that?

> ...
> if (dev->driver)
>       // If dev->driver is NULLed from really_probe() from here on,
>       // after above check, the system crashes
>       add_uevent_var(env, "DRIVER=%s", dev->driver->name);
> 
> dev_driver_string() can't be used here because we want NULL and not
> anything else in the non-init case.
> 
> Similar cases are reported by syzkaller in
> 
> https://syzkaller.appspot.com/bug?extid=ffa8143439596313a85a
> 
> But these are regarding the *initialization* of dev->driver
> 
> dev->driver = drv;
> 
> As this switches dev->driver to non-NULL these reports can be considered
> to be false-positives (which should be "fixed" by this commit, as well,
> though).
> 
> Fixes: 239378f16aa1 ("Driver core: add uevent vars for devices of a class")
> Cc: syzbot+ffa8143439596313a85a@syzkaller.appspotmail.com
> Reviewed-by: Eugeniu Rosca <eugeniu.rosca@bosch.com>
> Tested-by: Eugeniu Rosca <eugeniu.rosca@bosch.com>
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> ---
>  drivers/base/core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 5f4e03336e68..99ead727c08f 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2639,6 +2639,7 @@ static const char *dev_uevent_name(const struct kobject *kobj)
>  static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
>  {
>  	const struct device *dev = kobj_to_dev(kobj);
> +	struct device_driver *drv;
>  	int retval = 0;
>  
>  	/* add device node properties if present */
> @@ -2667,8 +2668,12 @@ static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
>  	if (dev->type && dev->type->name)
>  		add_uevent_var(env, "DEVTYPE=%s", dev->type->name);
>  
> -	if (dev->driver)
> -		add_uevent_var(env, "DRIVER=%s", dev->driver->name);
> +	/* dev->driver can change to NULL underneath us because of unbinding
> +	 * or failing probe(), so be careful about accessing it.
> +	 */
> +	drv = READ_ONCE(dev->driver);
> +	if (drv)
> +		add_uevent_var(env, "DRIVER=%s", drv->name);

Again, you are just reducing the window here.  Maybe a bit, but not all
that much overall as there is no real lock present.

So how is this actually solving anything?  And who is calling a uevent
on a device that is not probed properly?  Userspace?  Within the kernel?
Something else?

thanks,

greg k-h


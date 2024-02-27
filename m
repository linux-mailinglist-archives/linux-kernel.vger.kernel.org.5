Return-Path: <linux-kernel+bounces-82717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 062BD86888F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8515F2831A5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDC552F89;
	Tue, 27 Feb 2024 05:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="07zmUOlR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1711DA21;
	Tue, 27 Feb 2024 05:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709011215; cv=none; b=Qi22WgtCcL6GODb5DVcu4kWW88XCKKOXYdqItQe0xm+8OJoF1+/ypNU6hx1Hf3mL6ZsJRH1w34ZPi4OALjoC8Gko0JbzNgfWR8TTADT5oZ3RNJC6sP0jQ07fhhMMKy5oUJpCWKTZX1dqTzKl50B4Voglz2zkQ27wF0yz9iSjqOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709011215; c=relaxed/simple;
	bh=QVewK2zLxexaTPiFK0mIpI4ee/yNirNM/UnKFGxyB6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aF/2auyiGfn4VwN+oDqDsPWhVY7zFe9wXT7IYADeEN4cHPhbAXJ6MoRSe4NjVd9OJP9w5ll0k2FYyk3xtDzhF9ngBSjOBw1LrSoi5TNg2gNTYlptC5CV4SyXg9fMxrFQN5GZnWbaGvQsN8YfBSNBwF+qovDfZbnyxYCuC/M39gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=07zmUOlR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EEAC433F1;
	Tue, 27 Feb 2024 05:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709011214;
	bh=QVewK2zLxexaTPiFK0mIpI4ee/yNirNM/UnKFGxyB6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=07zmUOlRqlFbNy+Fhm8BmCkvtT4bTIH1j+8pt5hfIUf3qqucLc5wdVzw87sJaN8oM
	 01d2N+MTuWe43puug39xCXBdR9PD4ZVDQk2M+dL4sQHhaZxBjt2zz9E0EQaiCdtoXn
	 fUcjo5zfb8GRWcs7QxyT9K7UBqe9hu1YuYGvUfg0=
Date: Tue, 27 Feb 2024 06:20:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: RD Babiera <rdbabiera@google.com>
Cc: heikki.krogerus@linux.intel.com, badhri@google.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: altmodes/displayport: create sysfs nodes
 after assigning driver data
Message-ID: <2024022731-dusk-posture-b83f@gregkh>
References: <20240226234228.1768725-2-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226234228.1768725-2-rdbabiera@google.com>

On Mon, Feb 26, 2024 at 11:42:29PM +0000, RD Babiera wrote:
> The DisplayPort driver's sysfs nodes may be present to the userspace before
> typec_altmode_set_drvdata() completes in dp_altmode_probe. This means that
> a sysfs read can trigger a NULL pointer error by deferencing dp->hpd in
> hpd_show or dp->lock in pin_assignment_show, as dev_get_drvdata() returns
> NULL in those cases.
> 
> Create sysfs nodes after typec_altmode_set_drvdata call.
> 
> Fixes: 0e3bb7d6894d ("usb: typec: Add driver for DisplayPort alternate mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: RD Babiera <rdbabiera@google.com>
> ---
> Changes from v1:
> * Moved sysfs node creation instead of NULL checking dev_get_drvdata().
> ---
>  drivers/usb/typec/altmodes/displayport.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index 5a80776c7255..5bbdd2c04237 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -731,10 +731,6 @@ int dp_altmode_probe(struct typec_altmode *alt)
>  	      DP_CAP_PIN_ASSIGN_DFP_D(alt->vdo)))
>  		return -ENODEV;
>  
> -	ret = sysfs_create_group(&alt->dev.kobj, &dp_altmode_group);
> -	if (ret)
> -		return ret;
> -
>  	dp = devm_kzalloc(&alt->dev, sizeof(*dp), GFP_KERNEL);
>  	if (!dp)
>  		return -ENOMEM;
> @@ -766,6 +762,10 @@ int dp_altmode_probe(struct typec_altmode *alt)
>  	if (plug)
>  		typec_altmode_set_drvdata(plug, dp);
>  
> +	ret = sysfs_create_group(&alt->dev.kobj, &dp_altmode_group);
> +	if (ret)
> +		return ret;
> +

Now I am going to push back again and ask why you are even attempting to
create sysfs files "by hand" here at all?

Why is this just not set to be a default group?  That way the group is
managed properly by the driver core and the driver doesn't have to worry
about ANY of this at all.  Bonus is that you remove the "you raced with
userspace and lost" problem that this code still has even with the
change you made here.

Huge hint, if you EVER have to call sysfs_*() from a driver, usually
something is wrong (there are a few exceptions, this is not one.)

thanks,

greg k-h


Return-Path: <linux-kernel+bounces-87609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BD886D672
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 121D9B21F60
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FF06D52F;
	Thu, 29 Feb 2024 21:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Vufomjse"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0352B16FF46;
	Thu, 29 Feb 2024 21:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709243938; cv=none; b=i7Obq1iFF8iCkYCHxFVb1V6j1UIEw1fo9iSZ+ccMLQ3nr6gVAr98grd59uHI0SQ0DCfYUpv7Z5P7+Mr4nZUj/dXpYXvOzuwikL7cvnyHqgV4k0HzTNjElo3T4TR8o/eEBDQ4sDowsOyxmEb0g9YmrU0Mp6xHUszFUO6lLAiMDAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709243938; c=relaxed/simple;
	bh=5JVabrlMLe/1NI62rmzy/ei3KAtCFMI1zLcwOM4J3wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZx7KXFi9bs9Z9QwfBwpTSyCX85p5KPjjO7gk501CTQdY475mE5ry5CemuPSTvNH8uLI5XxwqjOZDVGJNsszFV5EWj9NcXYY5akVUUjJQZEtQ6AXhV0SWCf8uN00LYis3KsR5pFLb3WIKY26p73mNDflmBNGot6I8qTLa0wClNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Vufomjse; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9AEDF40003;
	Thu, 29 Feb 2024 21:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709243934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DiJQ8IEdW2Jkk/S4jOTeOO3q8QRmk15ZcHgGmWobrwI=;
	b=Vufomjser0fMBgkFugDyP7xz2NZDrANrKG05Os5lRiWQQXwpRfMzls1U5UVZfCj5mGCYba
	5aJ3QYmmc8fc0/4bxjHolLYyp6+I0mYpkgOkagq1VAy9ei7hF5XdFt9KRU8p7qKO5AFnSI
	IDmHMn7xkIikioGrvhOglf1pB1piCcIgXRwijdx3iZwFVhiQWk0Z/Zc120AtPSiUql9bAZ
	5Og6pScc2s5MeWAL+U4EWkNgFn//q4vYRkZ8AF6ALxhFwbXShvYnMej6r4x9QOp+qJYnwW
	VB/q3oYjxHjy6ekb6CGKYrGj8M6OBOg3WeuUyEmA5yDBbTs4iyxSNx8tLH8WUw==
Date: Thu, 29 Feb 2024 22:58:50 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Nicholas Miehlbradt <nicholas@linux.ibm.com>
Cc: a.zummo@towertech.it, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: fix uninitialized read of rtc_wkalrm.time
Message-ID: <20240229215850a1990100@mail.local>
References: <20231129073647.2624497-1-nicholas@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129073647.2624497-1-nicholas@linux.ibm.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

Hello,

On 29/11/2023 07:36:47+0000, Nicholas Miehlbradt wrote:
> If either of the first two branches of the if statement in
> rtc_read_alarm_internal are taken the fields of alarm->time are not
> initialized but are subsequently read by the call to rtc_tm_to_time64.
> 
> Refactor so that the time field is only read if the final branch of the
> if statment which initializes the field is taken.
> 

While the problem description is correct, the solution is not because
you have no guarantee that the fields have been initialized if
->read_alarm returns a value different from 0

So, instead of avoiding the conversion unless the final branch is taken,
it should be avoided as long as err != 0.

But, I'm also wondering whether there is actually an issue. mktime64
can be fed whatever value without bugging out and the value of err will
be part of the trace so userspace knows that it shouldn't trust the
value.

So, what is the actual issue? :)

> Signed-off-by: Nicholas Miehlbradt <nicholas@linux.ibm.com>
> ---
>  drivers/rtc/interface.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
> index 1b63111cdda2..f40e76d2fe2b 100644
> --- a/drivers/rtc/interface.c
> +++ b/drivers/rtc/interface.c
> @@ -179,6 +179,7 @@ static int rtc_read_alarm_internal(struct rtc_device *rtc,
>  				   struct rtc_wkalrm *alarm)
>  {
>  	int err;
> +	time64_t trace_time = -1;
>  
>  	err = mutex_lock_interruptible(&rtc->ops_lock);
>  	if (err)
> @@ -201,11 +202,12 @@ static int rtc_read_alarm_internal(struct rtc_device *rtc,
>  		alarm->time.tm_yday = -1;
>  		alarm->time.tm_isdst = -1;
>  		err = rtc->ops->read_alarm(rtc->dev.parent, alarm);
> +		trace_time = rtc_tm_to_time64(&alarm->time);
>  	}
>  
>  	mutex_unlock(&rtc->ops_lock);
>  
> -	trace_rtc_read_alarm(rtc_tm_to_time64(&alarm->time), err);
> +	trace_rtc_read_alarm(trace_time, err);
>  	return err;
>  }
>  
> -- 
> 2.37.2
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


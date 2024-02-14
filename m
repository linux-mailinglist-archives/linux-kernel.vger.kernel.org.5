Return-Path: <linux-kernel+bounces-64997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D919C85465E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DDB7B2499C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B39168CE;
	Wed, 14 Feb 2024 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="BCLoYihU"
Received: from smtp94.iad3b.emailsrvr.com (smtp94.iad3b.emailsrvr.com [146.20.161.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B9A1429C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904023; cv=none; b=isK9z6WrshXUUG0ALLelfAKFKV0UnLWPLm/2dtYCIvhUhNrPk9/00XZuKna3y3Lb/A2RIEoCBu33BVjHyhf7FumHV4xTy2z7wcakpABMRM3jj64caeUZEMBYVQaJ5O01Fn69aM3BgYy0b/THNfwzzYK8Kc1VH5t8fibP1hQpEFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904023; c=relaxed/simple;
	bh=/ld5vGvXRP2hSvgBY+VJzWtlXK+B5HhsvmC/rXZS9F8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JmWKFVtkWxJkZUnJfkZaKD/59RjVYF2Z2W1/ZdhPMn4ROmKymjjxtRG9D2fK4bft1a/IhgRXjJcSDUofnQhadhLP3hOu3In5WuNsPPU1gVlg53+yQvza3Gqhdb6CcoyR5lVj+tsa6hsu60ETwaUoeShMr4kMZaBmmuLFnHiYlac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=BCLoYihU; arc=none smtp.client-ip=146.20.161.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1707904015;
	bh=/ld5vGvXRP2hSvgBY+VJzWtlXK+B5HhsvmC/rXZS9F8=;
	h=Date:Subject:To:From:From;
	b=BCLoYihUA6MDtJU8A9Cz/n5HDcGpWb7P4OlVDK48Rd0yVD8NKSuNGp+KPDcFb7ruO
	 NfeGZtZTW5QIYSYjRlKmVs7DJFQ1wP6/JJnyRb88XfF+NHLpyndVWl7UJ23COoFuP/
	 6icn2jhdcMaQ0HkjEf6TnEEw43T9RF7P0BEAjxTo=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp12.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id F3306C00BA;
	Wed, 14 Feb 2024 04:46:54 -0500 (EST)
Message-ID: <7b29252e-41dc-4fb5-a8aa-050b9c63f7bb@mev.co.uk>
Date: Wed, 14 Feb 2024 09:46:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: comedi_test: Prevent timers rescheduling during
 deletion
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 H Hartley Sweeten <hsweeten@visionengravers.com>, stable@vger.kernel.org
References: <20240213181004.105072-1-abbotti@mev.co.uk>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20240213181004.105072-1-abbotti@mev.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 882c513c-da9e-419c-9719-dff49a88041d-1-1

On 13/02/2024 18:10, Ian Abbott wrote:
> The comedi_test devices have a couple of timers (ai_timer and ao_timer)
> that can be started to simulate hardware interrupts.  Their expiry
> functions normally reschedule the timer.  The driver code calls either
> del_timer_sync() or del_timer() to delete the timers from the queue, but
> does not currently prevent the timers from rescheduling themselves so
> synchronized deletion may be ineffective.
> 
> Add a couple of boolean members (one for each timer: ai_timer_enable and
> ao_timer_enable) to the device private data structure to indicate
> whether the timers are allowed to reschedule themselves.  Set the member
> to true when adding the timer to the queue, and to false when deleting
> the timer from the queue in the waveform_ai_cancel() and
> waveform_ao_cancel() functions.
> 
> The del_timer_sync() function is also called from the waveform_detach()
> function, but the timer enable members will already be set to false when
> that function is called, so no change is needed there.
> 
> Fixes: 403fe7f34e33 ("staging: comedi: comedi_test: fix timer race conditions")
> Cc: <stable@vger.kernel.org> # 4.4+
> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
> ---
>   drivers/comedi/drivers/comedi_test.c | 37 +++++++++++++++++++++++++---
>   1 file changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/comedi/drivers/comedi_test.c b/drivers/comedi/drivers/comedi_test.c
> index 30ea8b53ebf8..7fefe0de0bcc 100644
> --- a/drivers/comedi/drivers/comedi_test.c
> +++ b/drivers/comedi/drivers/comedi_test.c
> @@ -87,6 +87,8 @@ struct waveform_private {
>   	struct comedi_device *dev;	/* parent comedi device */
>   	u64 ao_last_scan_time;		/* time of previous AO scan in usec */
>   	unsigned int ao_scan_period;	/* AO scan period in usec */
> +	bool ai_timer_enable:1;		/* should AI timer be running? */
> +	bool ao_timer_enable:1;		/* should AO timer be running? */
>   	unsigned short ao_loopbacks[N_CHANS];
>   };
>   
> @@ -232,12 +234,18 @@ static void waveform_ai_timer(struct timer_list *t)
>   	if (cmd->stop_src == TRIG_COUNT && async->scans_done >= cmd->stop_arg) {
>   		async->events |= COMEDI_CB_EOA;
>   	} else {
> +		unsigned long flags;
> +
>   		if (devpriv->ai_convert_time > now)
>   			time_increment = devpriv->ai_convert_time - now;
>   		else
>   			time_increment = 1;
> -		mod_timer(&devpriv->ai_timer,
> -			  jiffies + usecs_to_jiffies(time_increment));
> +		spin_lock_irqsave(&dev->spinlock, flags);
> +		if (devpriv->ai_timer_enable) {
> +			mod_timer(&devpriv->ai_timer,
> +				  jiffies + usecs_to_jiffies(time_increment));
> +		}
> +		spin_unlock_irqrestore(&dev->spinlock, flags);

Actually, I should have used a plain old spin_lock() in the above (and 
spin_lock_bh() elsewhere in the code) instead of spin_lock_irqsave(), 
since there are no hard interrupts involved.

I'll send a v2 patch shortly.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-



Return-Path: <linux-kernel+bounces-118529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E7088BC33
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB1B1F37FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0089A13340F;
	Tue, 26 Mar 2024 08:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RJQoui9W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BD81CAA2;
	Tue, 26 Mar 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711441382; cv=none; b=SPSXQA4xe0UeTrK37YmF5QpzOzoaAWwZWx7nZCI34iZ1G0bYHVd3eJ2hdmElUJqaFzWbayMn35cOTelU6Dg+LMERDcmyYrZ3rHJTu2hQgFo73uF3IEsrx+LfVxXL0PxRmXCU1EZdGFjSO9zM6zLeFg6EMD9LeUHKGTOR+tqqirg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711441382; c=relaxed/simple;
	bh=hwm0DgownOe+a+wofavFrRbBxRMYeIjoVarruVwkAp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBfZezmEoiBnOGv2dwTUnPFb2aOBozS+Ut273fc7liOtYCL4xwwvjHd2k8B52Q5nkxUEKBU1bjJuJmnzNRntLfqw7WCrVLstQbqUH25VyEia1mCuEFcAfw3rPyKIk5pFbdXdn0pHEIttc28bPN1JfAv6V8mFQbQL07JQR9srauM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RJQoui9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBC1C433F1;
	Tue, 26 Mar 2024 08:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711441381;
	bh=hwm0DgownOe+a+wofavFrRbBxRMYeIjoVarruVwkAp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RJQoui9Wv8kNVDt2z9iBQZygQxlmX8aSnUITgrc3cyQw4pnhb+7i74VCqYXCe8lJy
	 qKZwtCfRkdoc+PcDT45tR9DmH8PAr/1CIaBuR5suhR929+L/UJUwSCe01Ri4Yns4B5
	 QS79pRCAD50jqWIOcKlqq+4Jg6aajCVTkyrriolw=
Date: Tue, 26 Mar 2024 09:22:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: liu.yec@h3c.com
Cc: daniel.thompson@linaro.org, jirislaby@kernel.org, dianders@chromium.org,
	jason.wessel@windriver.com, kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH V6] kdb: Fix the deadlock issue in KDB debugging.
Message-ID: <2024032630-croon-consuming-6ef9@gregkh>
References: <20240325165436.GA485978@aspen.lan>
 <20240326074014.1905023-1-liu.yec@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326074014.1905023-1-liu.yec@h3c.com>

On Tue, Mar 26, 2024 at 03:40:14PM +0800, liu.yec@h3c.com wrote:
> Note that we still need to  a workqueue since we cannot resync
> the keyboard state from the hardirq context provided by irq_work.

I think you are missing a word between "to" and "a", right?

> That must be done from task context for the calls into the input
> subystem. Hence we must defer the work twice. First to safely
> switch from the debug trap (NMI-like context) to hardirq and
> then, secondly, to get from hardirq to the system workqueue.
> 
> Signed-off-by: LiuYe <liu.yeC@h3c.com>
> Co-authored-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> ---
> V5 -> V6: Replace with a more professional and accurate answer.
> V4 -> V5: Answer why schedule another work in the irq_work and not do the job directly.
> V3 -> V4: Add changelogs
> V2 -> V3: Add description information
> V1 -> V2: using irq_work to solve this properly.
> ---
> ---
>  drivers/tty/serial/kgdboc.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 7ce7bb164..161b25ecc 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -22,6 +22,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/serial_core.h>
> +#include <linux/irq_work.h>
>  
>  #define MAX_CONFIG_LEN		40
>  
> @@ -99,10 +100,17 @@ static void kgdboc_restore_input_helper(struct work_struct *dummy)
>  
>  static DECLARE_WORK(kgdboc_restore_input_work, kgdboc_restore_input_helper);
>  
> +static void kgdboc_queue_restore_input_helper(struct irq_work *unused)
> +{
> +	schedule_work(&kgdboc_restore_input_work);

As this is a "two stage deferment" or something like that, it should be
documented in the code exactly why this is needed and what is happening,
otherwise it looks very odd.

thanks,

greg k-h


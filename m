Return-Path: <linux-kernel+bounces-88375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB27186E0AF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686621F2521C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4706CDD6;
	Fri,  1 Mar 2024 11:50:47 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323186CDD0;
	Fri,  1 Mar 2024 11:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709293847; cv=none; b=GYDoQI/XZLllZUFqjk1aaEwIlh8LdDPqAAK7Q6QVhgUfSWQMkiI+Ulk/GFzIhK2fAt/DwYX/7oBSQfmtG0s7zLsqqZAgWpIA8yUrjLBEnFXtZ9ygzEcih9OBArhth6jdllMuFklWQ7oea/LoLTgzzj5N4vqq4NgB3lPy+98NeMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709293847; c=relaxed/simple;
	bh=ZyOdMMu8KP6WhIKw+knptD9Cm6F09MQ4QMVz6tu/0BQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FQcdei8ivH66QN/dmb4z07hZkdl+EBzhMwgwL4+mjWgNA/KxLB6itDtzUWm0dcS58o+3vE6xpfUWBdcPCXppIYO61jfCB+Jkpa2xAy8nLfOyhUchMUa5Vg6NAzaowNArh0s0yZC+8EAP1ISN5mUx9xOvybR+t8FsEgM/TLHc8Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 097B161E5FE01;
	Fri,  1 Mar 2024 12:50:08 +0100 (CET)
Message-ID: <38c07228-639f-4082-b09a-ffe62fe14b71@molgen.mpg.de>
Date: Fri, 1 Mar 2024 12:50:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH regression fix] misc: lis3lv02d_i2c: Fix regulators
 getting en-/dis-abled twice on suspend/resume
To: Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Eric Piel <eric.piel@tremplin-utc.net>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 regressions@lists.linux.dev
References: <20240220190035.53402-1-hdegoede@redhat.com>
Content-Language: en-US
In-Reply-To: <20240220190035.53402-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Hans,


Thank you for the patch.

Am 20.02.24 um 20:00 schrieb Hans de Goede:
> When not configured for wakeup lis3lv02d_i2c_suspend() will call
> lis3lv02d_poweroff() even if the device has already been turned off
> by the runtime-suspend handler and if configured for wakeup and
> the device is runtime-suspended at this point then it is not turned
> back on to serve as a wakeup source.
> 
> Before commit b1b9f7a49440 ("misc: lis3lv02d_i2c: Add missing setting
> of the reg_ctrl callback"), lis3lv02d_poweroff() failed to disable
> the regulators which as a side effect made calling poweroff() twice ok.
> 
> Now that poweroff() correctly disables the regulators, doing this twice
> triggers a WARN() in the regulator core:
> 
> unbalanced disables for regulator-dummy
> WARNING: CPU: 1 PID: 92 at drivers/regulator/core.c:2999 _regulator_disable
> ...
> 
> Fix lis3lv02d_i2c_suspend() to not call poweroff() a second time if
> already runtime-suspended and add a poweron() call when necessary to
> make wakeup work.
> 
> lis3lv02d_i2c_resume() has similar issues, with an added weirness that
> it always powers on the device if it is runtime suspended, after which
> the first runtime-resume will call poweron() again, causing the enabled
> count for the regulator to increase by 1 every suspend/resume. These
> unbalanced regulator_enable() calls cause the regulator to never
> be turned off and trigger the following WARN() on driver unbind:
> 
> WARNING: CPU: 1 PID: 1724 at drivers/regulator/core.c:2396 _regulator_put
> 
> Fix this by making lis3lv02d_i2c_resume() mirror the new suspend().
> 
> Fixes: b1b9f7a49440 ("misc: lis3lv02d_i2c: Add missing setting of the reg_ctrl callback")
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Closes: https://lore.kernel.org/regressions/5fc6da74-af0a-4aac-b4d5-a000b39a63a5@molgen.mpg.de/
> Cc: stable@vger.kernel.org
> Cc: regressions@lists.linux.dev
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/misc/lis3lv02d/lis3lv02d_i2c.c | 21 +++++++++++++--------
>   1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
> index c6eb27d46cb0..15119584473c 100644
> --- a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
> +++ b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
> @@ -198,8 +198,14 @@ static int lis3lv02d_i2c_suspend(struct device *dev)
>   	struct i2c_client *client = to_i2c_client(dev);
>   	struct lis3lv02d *lis3 = i2c_get_clientdata(client);
>   
> -	if (!lis3->pdata || !lis3->pdata->wakeup_flags)
> +	/* Turn on for wakeup if turned off by runtime suspend */
> +	if (lis3->pdata && lis3->pdata->wakeup_flags) {
> +		if (pm_runtime_suspended(dev))
> +			lis3lv02d_poweron(lis3);
> +	/* For non wakeup turn off if not already turned off by runtime suspend */
> +	} else if (!pm_runtime_suspended(dev))
>   		lis3lv02d_poweroff(lis3);
> +
>   	return 0;
>   }
>   
> @@ -208,13 +214,12 @@ static int lis3lv02d_i2c_resume(struct device *dev)
>   	struct i2c_client *client = to_i2c_client(dev);
>   	struct lis3lv02d *lis3 = i2c_get_clientdata(client);
>   
> -	/*
> -	 * pm_runtime documentation says that devices should always
> -	 * be powered on at resume. Pm_runtime turns them off after system
> -	 * wide resume is complete.
> -	 */
> -	if (!lis3->pdata || !lis3->pdata->wakeup_flags ||
> -		pm_runtime_suspended(dev))
> +	/* Turn back off if turned on for wakeup and runtime suspended*/
> +	if (lis3->pdata && lis3->pdata->wakeup_flags) {
> +		if (pm_runtime_suspended(dev))
> +			lis3lv02d_poweroff(lis3);
> +	/* For non wakeup turn back on if not runtime suspended */
> +	} else if (!pm_runtime_suspended(dev))
>   		lis3lv02d_poweron(lis3);
>   
>   	return 0;

I applied this commit on top of Linus’ master branch, and successfully 
tested with S0ix and ACPI S3, that the warning is gone.

Tested-by: Paul Menzel <pmenzel@molgen.mpg.de> # Dell XPS 15 7590

Looking at the diff, this also looks good. Thank you for writing the 
helpful commit message.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Thank you for addressing this so quickly, and sorry for the late reply.


Kind regards,

Paul


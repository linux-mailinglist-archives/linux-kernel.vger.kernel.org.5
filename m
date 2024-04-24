Return-Path: <linux-kernel+bounces-157129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C26DC8B0D33
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0C2281F8C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC36C15F3F1;
	Wed, 24 Apr 2024 14:52:00 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 30A8715EFAE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970320; cv=none; b=qadnwQVDEGynivzyos2mRDhT6NI/6R4HtkgxYy6bCMXxC9SRy3kSfav3+7SXb0WSNLuo5Yr/NxMkT9RT5Yi5uAIKQluBgJt1CsdCjmS/CqDCmMtOv/SjU/GYEW05c2YtPCveYIgPaDPxBhlEEcmwri/Wqy5dztU/pmewiomgM1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970320; c=relaxed/simple;
	bh=3Z6uVOtYIw3MLXx0Sb5rRJUYpjtvpVEB1ZfVvMdz0v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f51ZGoPPp5PHFekILtXmnyhcFMX1fU3kumQ7XnJm8BqlZqKJTBYQEjmBI5mdQT26FdNWdLppuZlN0QlqXOg/DDUrITzSbsgIFIH6kuArLX30dJKfsrcm2oMNE10dnMs5sIHsiquE25QOUSNieGdxVP7H/QfH6JYkG9B8hXbVG6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 453342 invoked by uid 1000); 24 Apr 2024 10:51:57 -0400
Date: Wed, 24 Apr 2024 10:51:57 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
Cc: gregkh@linuxfoundation.org, corbet@lwn.net, linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
  usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH v4] usb-storage: Optimize scan delay more precisely
Message-ID: <c06aaaa1-a2af-47c6-a615-602f2c70de86@rowland.harvard.edu>
References: <20240424013134.17307-1-Norihiko.Hama@alpsalpine.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424013134.17307-1-Norihiko.Hama@alpsalpine.com>

On Wed, Apr 24, 2024 at 10:31:34AM +0900, Norihiko Hama wrote:
> Current storage scan delay is reduced by the following old commit.
> 
> a4a47bc03fe5 ("Lower USB storage settling delay to something more reasonable")
> 
> It means that delay is at least 'one second', or zero with delay_use=0.
> 'one second' is still long delay especially for embedded system but
> when delay_use is set to 0 (no delay), still error observed on some USB drives.
> 
> So delay_use should not be set to 0 but 'one second' is quite long.
> Especially for embedded system, it's important for end user
> how quickly access to USB drive when it's connected.
> That's why we have a chance to minimize such a constant long delay.
> 
> This patch optimizes scan delay more precisely
> to minimize delay time but not to have any problems on USB drives
> by extending module parameter 'delay_use' in milliseconds internally.
> The parameter 'delay_use' is changed to be parsed as 3 decimal point value
> if it has digit values with '.'.
> It makes the range of value to 1 / 1000 in internal 32-bit value
> but it's still enough to set the delay time.
> By default, delay time is 'one second' for backward compatibility.
> 
> For example, it seems to be good by changing delay_use=0.1,
> that is 100 millisecond delay without issues for most USB pen drives.
> 
> Signed-off-by: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
> ---
> V3 -> V4: Separate parser functions from module parameter set/get
> V2 -> V3: Change to use kstrtouint only for parsing decimal point
> V1 -> V2: Extend existing module parameter 'delay_use' to support decimal points

This is pretty good.  I've got a couple of minor suggestions.

>  .../admin-guide/kernel-parameters.txt         |   5 +
>  drivers/usb/storage/usb.c                     | 120 +++++++++++++++++-
>  2 files changed, 121 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 561d0dd776c7..8248426524d5 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6190,6 +6190,11 @@
>  	usb-storage.delay_use=
>  			[UMS] The delay in seconds before a new device is
>  			scanned for Logical Units (default 1).
> +			The delay can have up to 3 decimal places, giving a
> +			resolution of one millisecond.
> +			Example:
> +				delay_use=2.567

This could go on the previous line.

			Example:  delay_use = 2.567

> +					2.567 second delay

This is obvious; I don't think you need to say it.

>  
>  	usb-storage.quirks=
>  			[UMS] A list of quirks entries to supplement or
> diff --git a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
> index 90aa9c12ffac..c908cf2a8027 100644
> --- a/drivers/usb/storage/usb.c
> +++ b/drivers/usb/storage/usb.c
> @@ -67,9 +67,121 @@ MODULE_AUTHOR("Matthew Dharm <mdharm-usb@one-eyed-alien.net>");
>  MODULE_DESCRIPTION("USB Mass Storage driver for Linux");
>  MODULE_LICENSE("GPL");
>  
> -static unsigned int delay_use = 1;
> -module_param(delay_use, uint, S_IRUGO | S_IWUSR);
> -MODULE_PARM_DESC(delay_use, "seconds to delay before using a new device");
> +static unsigned int delay_use = 1 * MSEC_PER_SEC;
> +
> +/**
> + * str_to_fixed_point_uint - parse an unsigned fixed-point decimal integer
> + * @str: String to parse.
> + * @ndecimals: Number of decimal places in the fixed-point value.
> + * @val: Where to store the parsed value.
> + *
> + * Parse an unsigned fixed-point decimal value in @str, containing at
> + * most ndecimal digits to the right of the decimal point.
> + * Stores the parsed value in @val, scaled by 10^(@ndecimal).
> + *
> + * As with kstrtouint(), the string must be NUL-terminated and may
> + * include a single newline before the terminating NUL.  The first
> + * character may be a plus sign but not a minus sign.  The decimal
> + * point and fractional digits are optional.
> + *
> + * Returns 0 on success, a negative error code otherwise.
> + */
> +static int str_to_fixed_point_uint(const char *str, int ndecimals,
> +				   unsigned int *val)
> +{
> +	int n, n1, n2;
> +	const char *p;
> +	char *q;
> +	char buf[16];
> +
> +	n = strlen(str);
> +	if (n > 0 && str[n - 1] == '\n')
> +		--n;
> +
> +	p = strnchr(str, n, '.');
> +	if (p) {
> +		n1 = p++ - str;
> +		n2 = n - (n1 + 1);
> +		if (n2 == 0 || n2 > ndecimals)
> +			return -EINVAL;
> +	} else {
> +		n1 = n;
> +		n2 = 0;
> +	}
> +	if (n1 == 0 || n1 + ndecimals > sizeof(buf) - 1)
> +		return -EINVAL;

There's no reason to rule out strings like ".5" or "2.".  Allow either n1 
or n2 to be 0, as long as they aren't both 0.  (And even then, the code 
would accept "+" or "+.", which is bizarre but not terrible.)

> +
> +	memcpy(buf, str, n1);
> +	if (p)
> +		memcpy(buf + n1, p, n2);
> +	for (q = buf + n1 + n2; n2 < ndecimals; ++n2)
> +		*q++ = '0';
> +	*q = 0;
> +
> +	return kstrtouint(buf, 10, val);
> +}
> +
> +/**
> + * fixed_point_uint_to_str - parse into fixed-point decimal integer string
> + * @val: Integer value to parse.
> + * @ndecimals: Number of decimal places in the fixed-point value.
> + * @str: Where to store the parsed string.
> + * @size: The size of buffer for @str.
> + *
> + * Stores the parsed @val scaled by 10^(@ndecimal) into @str.
> + * The string trailing fractional part '0' is trimmed.

"Parse" is the wrong word here.  You parse a string to understand what it 
means (so the previous function parses @str).  But here you're converting 
an integer to a string; that's called "formatting".

So the function's description should be: format a fixed-point decimal value 
into a string.  @val is the integer value to format, scaled by 
10^(@ndecimals), and @str is where to store the formatted string.

> + *
> + * Returns the number of characters written into @str.
> + */
> +static int fixed_point_uint_to_str(unsigned int val, int ndecimals,
> +				   char *str, int size)
> +{
> +	unsigned int delay_ms = val;
> +	unsigned int rem = do_div(delay_ms, int_pow(10, ndecimals));
> +	int len;
> +	char buf[16];
> +
> +	len = scnprintf(buf, sizeof(buf), "%d", delay_ms);
> +	if (rem) {
> +		char format[8];
> +
> +		snprintf(format, sizeof(format) - 1, ".%%0%dd", ndecimals);
> +		len += scnprintf(buf + len, sizeof(buf) - len, format, rem);
> +		while (buf[len - 1] == '0') {
> +			buf[len - 1] = '\0';
> +			if (--len <= 1)
> +				break;
> +		}

Small simplification:  You know that len can never reach 0 because rem is 
nonzero, and in any case buf contains a '.' somewhere.  So this loop 
can be written as:

		while (buf[--len] == '0')
			buf[len] = 0;

Alan Stern

> +	}
> +	return scnprintf(str, size, "%s\n", buf);
> +}
> +
> +static int delay_use_set(const char *s, const struct kernel_param *kp)
> +{
> +	unsigned int delay_ms;
> +	int ret;
> +
> +	ret = str_to_fixed_point_uint(skip_spaces(s), 3, &delay_ms);
> +	if (ret < 0)
> +		return ret;
> +
> +	*((unsigned int *)kp->arg) = delay_ms;
> +	return 0;
> +}
> +
> +static int delay_use_get(char *s, const struct kernel_param *kp)
> +{
> +	unsigned int delay_ms = *((unsigned int *)kp->arg);
> +
> +	return fixed_point_uint_to_str(delay_ms, 3, s, PAGE_SIZE);
> +}
> +
> +static const struct kernel_param_ops delay_use_ops = {
> +	.set = delay_use_set,
> +	.get = delay_use_get,
> +};
> +module_param_cb(delay_use, &delay_use_ops, &delay_use, 0644);
> +MODULE_PARM_DESC(delay_use, "time to delay before using a new device");
>  
>  static char quirks[128];
>  module_param_string(quirks, quirks, sizeof(quirks), S_IRUGO | S_IWUSR);
> @@ -1066,7 +1178,7 @@ int usb_stor_probe2(struct us_data *us)
>  	if (delay_use > 0)
>  		dev_dbg(dev, "waiting for device to settle before scanning\n");
>  	queue_delayed_work(system_freezable_wq, &us->scan_dwork,
> -			delay_use * HZ);
> +			msecs_to_jiffies(delay_use));
>  	return 0;
>  
>  	/* We come here if there are any problems */
> -- 
> 2.17.1
> 
> 


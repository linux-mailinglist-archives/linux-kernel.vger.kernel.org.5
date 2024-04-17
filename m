Return-Path: <linux-kernel+bounces-147823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA77E8A7A23
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB901C2164F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97FB1851;
	Wed, 17 Apr 2024 01:24:55 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id B3CE6184F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 01:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713317095; cv=none; b=hlhneIPD4qR1XpzzCZYQITOXXB66u6UeoB0hJYtFHDSQSv7Js8wwk41e9xqJWYo2zGdYYC/7zWN6nsLeZooMhDBSGXvmT7YOA9aH7InmlGRU2taVyUlvRqg/hHovztk/pl7QDMI9cHBVUltFD9mynUgFRUgQBC8mG8BZy/70fcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713317095; c=relaxed/simple;
	bh=QEokpzywCij/rs8KGCbS/96yPJ0h0w2hazVYrHtROdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZM/9laBLaG2QJbqMxUzkwjO7EXGSyh8tTze3IEkdJRJ2BgdGTYkY4oriik4ikgD8+5tuc4SUN03CilCJJspK34zrcqlbGEdtd6kqtsLdRHsC0lAfj7YEUKrSuPCRIVUyttp2ZCfL1+j7oKJxoW/yPw3O+UrNqqj+v/8/8oiv0eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 182709 invoked by uid 1000); 16 Apr 2024 21:24:48 -0400
Date: Tue, 16 Apr 2024 21:24:48 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
Cc: mdharm-usb@one-eyed-alien.net, gregkh@linuxfoundation.org,
  linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
  linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH v3] usb-storage: Optimize scan delay more precisely
Message-ID: <4d94b2a8-dd2a-4bae-9a0c-8125747f404a@rowland.harvard.edu>
References: <20240416082821.10164-1-Norihiko.Hama@alpsalpine.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416082821.10164-1-Norihiko.Hama@alpsalpine.com>

On Tue, Apr 16, 2024 at 05:28:21PM +0900, Norihiko Hama wrote:
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

At this location you're supposed to describe how this version of the patch 
differs from the previous version.

>  .../admin-guide/kernel-parameters.txt         | 10 +++
>  drivers/usb/storage/usb.c                     | 72 +++++++++++++++++--
>  2 files changed, 78 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 561d0dd776c7..ae1eb5988706 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6190,6 +6190,16 @@
>  	usb-storage.delay_use=
>  			[UMS] The delay in seconds before a new device is
>  			scanned for Logical Units (default 1).
> +			To specify more precise delay, supports 3 decimal point.
> +			The range of decimal point is in milliseconds,
> +			hence the minimum value is "0.001".

The text could be better.  For example:

			The delay can have up to 3 decimal places, giving a
			resolution of one millisecond.

> +			Example:
> +				delay_use=1
> +					1 second delay
> +				delay_use=0.1
> +					0.1 second delay
> +				delay_use=2.55
> +					2.55 second elay

This should show all 3 decimal places:

				delay_use=2.567
					2.567 second delay

>  	usb-storage.quirks=
>  			[UMS] A list of quirks entries to supplement or
> diff --git a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
> index 90aa9c12ffac..d5eb7dd8f3b1 100644
> --- a/drivers/usb/storage/usb.c
> +++ b/drivers/usb/storage/usb.c
> @@ -67,9 +67,73 @@ MODULE_AUTHOR("Matthew Dharm <mdharm-usb@one-eyed-alien.net>");
>  MODULE_DESCRIPTION("USB Mass Storage driver for Linux");
>  MODULE_LICENSE("GPL");
>  
> -static unsigned int delay_use = 1;
> -module_param(delay_use, uint, S_IRUGO | S_IWUSR);
> -MODULE_PARM_DESC(delay_use, "seconds to delay before using a new device");
> +static unsigned int delay_use = 1 * MSEC_PER_SEC;
> +
> +static int delay_use_set(const char *s, const struct kernel_param *kp)
> +{
> +	unsigned int delay_ms = 0;
> +	int frac = 3, ret;
> +	char *p = skip_spaces(s);
> +	char buf[16];
> +
> +	if (strlen(p) >= sizeof(buf) - frac)
> +		return -EINVAL;
> +
> +	strscpy_pad(buf, p, sizeof(buf));
> +
> +	p = strchr(buf, '.');
> +	if (p) {
> +		int i = 0;
> +		char *tmp = p + 1;
> +
> +		while (tmp[i] && tmp[i] != '\n')
> +			*p++ = tmp[i++];
> +
> +		if (i == 0 || i > frac)
> +			return -EINVAL;
> +		frac -= i;
> +	} else {
> +		p = buf + strlen(buf) - 1;
> +		if (*p != '\n')
> +			p++;
> +	}
> +	while (frac-- > 0)
> +		*p++ = '0';
> +	*p = '\0';
> +
> +	ret = kstrtouint(buf, 10, &delay_ms);
> +	if (ret < 0)
> +		return ret;
> +
> +	*((unsigned int *)kp->arg) = delay_ms;
> +	return 0;
> +}

As I said before, the parsing code should be in a separate function to make 
reviewing the code easier.  It also should be written more clearly.  Here's 
my attempt (not tested at all).  You might prefer to remove some of the 
comments; I put in a lot of them.

/**
 * str_to_fixed_point_uint - parse an unsigned fixed-point decimal integer
 * @str: String to parse.
 * @ndecimals: Number of decimal places in the fixed-point value.
 * @val: Where to store the parsed value.
 *
 * Parse an unsigned fixed-point decimal value in @str, containing at
 * most ndecimal digits to the right of the decimal point.
 * Stores the parsed value in @val, scaled by 10^(@ndecimal).
 *
 * As with kstrtouint(), the string must be NUL-terminated and may
 * include a single newline before the terminating NUL.  The first
 * character may be a plus sign but not a minus sign.  The decimal
 * point and fractional digits are optional.
 *
 * Returns 0 on success, a negative error code otherwise.
 */
static int str_to_fixed_point_uint(const char *str, int ndecimals,
		unsigned int *val)
{
	int n, n1, n2;
	const char *p;
	char *q;
	char buf[16];

	n = strlen(str);
	if (n > 0 && str[n - 1] == '\n');
		--n;

	p = strchr(str, '.');
	if (p) {
		n1 = p++ - str;		/* Length of integral part */
		n2 = n - (n1 + 1);	/* Length of fractional part */
		if (n2 > ndecimals)
			return -EINVAL;
	} else {
		n1 = n;			/* Length of integral part */
		n2 = 0;			/* No fractional part */
	}
	if (n1 + n2 == 0 || n1 + ndecimals > sizeof(buf) - 1)
		return -EINVAL;		/* No digits present or too long */

	memcpy(buf, str, n1);		/* Integer part */
	memcpy(buf + n1, p, n2);	/* Fractional part */
	for (q = buf + n1 + n2; n2 < ndecimals; ++n2)
		*q++ = '0';		/* Remaining fractional digits */
	*q = 0;

	return kstrtouint(buf, 10, val);
}

> +
> +static int delay_use_get(char *s, const struct kernel_param *kp)
> +{
> +	unsigned int delay_ms = *((unsigned int *)kp->arg);
> +	unsigned int rem = do_div(delay_ms, MSEC_PER_SEC);
> +	int len;
> +	char buf[16];
> +
> +	len = scnprintf(buf, sizeof(buf), "%d", delay_ms);
> +	if (rem) {
> +		len += scnprintf(buf + len, sizeof(buf) - len, ".%03d", rem);
> +		while (buf[len - 1] == '0') {
> +			buf[len - 1] = '\0';
> +			if (--len <= 1)
> +				break;
> +		}
> +	}

While this could also go in a separate function, it's short enough to keep 
here.

Alan Stern

> +	return scnprintf(s, PAGE_SIZE, "%s\n", buf);
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
> @@ -1066,7 +1130,7 @@ int usb_stor_probe2(struct us_data *us)
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


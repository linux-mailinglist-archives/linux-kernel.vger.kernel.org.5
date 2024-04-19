Return-Path: <linux-kernel+bounces-151002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B8F8AA7D2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8725A1F2257B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 04:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5152EB676;
	Fri, 19 Apr 2024 04:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ubcp+33G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BQ3/qSU0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0434EC2;
	Fri, 19 Apr 2024 04:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713502618; cv=none; b=ZeMrgysCaUV4K+xrFVBeq7QzoeEM/d99ibk2mL/qy+9bZn7lraxoVbOXdou0/e7+L1Og8bVR0DQEZZUXWcoAGRiwPOT6P9ivqc2i+AZPouCQfMiyusem7B++l8GPT7jh6Jp6ElrItJroMieQ72aQRjSjbclOMz++dlqECJUnd7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713502618; c=relaxed/simple;
	bh=LhcICYrRiV8xiViW1aHl2GXVz/KKPmpuIQ2A7GqnOoY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=UA6y6LOmtS5HpDm03M04drHOETwcX/hAT2gb5xM8ovSZOMv3j8U4+vlxH3h3cSWwjFfwb9O8EjH+LgYqEmv7Lbj3zC/tieXelrL/2EHLEMBLf0XWPauJK6rbrKqNqHlJKVnzebHtz9HwLC8g7tKyhi4oC2lEXzNN6FT8TVf3hWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ubcp+33G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BQ3/qSU0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713502615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=uupDmNKjCkWvyJzlSeacjHDiwKRL52cSr4mj/5PyHbE=;
	b=Ubcp+33GXD1D6YMtyUumZMG9dCmM1NvFOpKB3ePpKPp9FUGY3JD742t01872e+3hJRdvt3
	Who4lGkyv94z7V0UOTOUYhdrjioKQQoUpACAWpfbMJy6/B+vuYC+XsrVRbf15BXNuaSyrp
	1G9i/ab7rblbSDVg6gy9jmI4i4vUgahn4J9ud+KA7F4tYn0Li7orD0N2VTW1f7NPSYvbN+
	Q2YX9Q2VyYy+uf3uvxHyj+svgcanlXeEIdrtDJ01jmcMjNi6f1we+zrOIUdoId7E33oH0h
	vGWtd15/mbw4bJIwad9xA1CQ1ETDM60eKHa1JMmGJ2kHrbYWp2gOkM5q/3n4uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713502615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=uupDmNKjCkWvyJzlSeacjHDiwKRL52cSr4mj/5PyHbE=;
	b=BQ3/qSU0hDlNBGZZTPLG8xtJYVU98bQicJU5MO2P9OaLa5KRVzFRnG31XvCkYi2kYa26DP
	5DYDXMYEhtZLeADw==
To: Mahesh Bandewar <maheshb@google.com>, Netdev <netdev@vger.kernel.org>,
 Linux <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Sagi Maimon
 <maimon.sagi@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>,
 Mahesh Bandewar <mahesh@bandewar.net>, Mahesh Bandewar
 <maheshb@google.com>
Subject: Re: [PATCHv2 next] ptp: update gettimex64 to provide ts optionally
 in mono-raw base.
In-Reply-To: <20240418042706.1261473-1-maheshb@google.com>
Date: Fri, 19 Apr 2024 06:56:43 +0200
Message-ID: <87cyqmx850.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 17 2024 at 21:27, Mahesh Bandewar wrote:

Subject: ptp: update gettimex64 to provide ts optionally in mono-raw base.

Can we please have proper sentences without cryptic abbreviations? This
is not twatter or SMS.

Aside of that this is not about updating gettimex64(). The fact that
this is an UAPI change is the real important information. gettimex64()
is only the kernel side implementation detail.

   ptp/ioctl: Support MONOTONIC_RAW timestamps forPTP_SYS_OFFSET_EXTENDED

or something like that. 

> The current implementation of PTP_SYS_OFFSET_EXTENDED provides
> PHC reads in the form of [pre-TS, PHC, post-TS]. These pre and
> post timestamps are useful to measure the width of the PHC read.
> However, the current implementation provides these timestamps in
> CLOCK_REALTIME only. Since CLOCK_REALTIME is disciplined by NTP
> or NTP-like service(s), the value is subjected to change. This
> makes some applications that are very sensitive to time change
> have these timestamps delivered in different time-base.

The last sentence does not make any sense to me.

> This patch updates the gettimex64 / ioctl op PTP_SYS_OFFSET_EXTENDED

git grep 'This patch' Documentation/process/

> to provide these (sandwich) timestamps optionally in
> CLOCK_MONOTONIC_RAW timebase while maintaining the default behavior
> or giving them in CLOCK_REALTIME.

This change log lacks a proper explanation why this is needed and what's
the purpose and benefit.

Aside of that it fails to mention that using the currently unused
reserved field is correct because CLOCK_REALTIME == 0. 

> ~# testptp -d /dev/ptp0 -x 3 -y raw
> extended timestamp request returned 3 samples
> sample # 0: mono-raw time before: 371.548640128
>             phc time: 371.579671788
>             mono-raw time after: 371.548640912
> sample # 1: mono-raw time before: 371.548642104
>             phc time: 371.579673346
>             mono-raw time after: 371.548642490
> sample # 2: mono-raw time before: 371.548643320
>             phc time: 371.579674652
>             mono-raw time after: 371.548643756
> ~# testptp -d /dev/ptp0 -x 3 -y real
> extended timestamp request returned 3 samples
> sample # 0: system time before: 1713243413.403474250
>             phc time: 385.699915490
>             system time after: 1713243413.403474948
> sample # 1: system time before: 1713243413.403476220
>             phc time: 385.699917168
>             system time after: 1713243413.403476642
> sample # 2: system time before: 1713243413.403477555
>             phc time: 385.699918442
>             system time after: 1713243413.403477961

That takes up a lot of space, but what's the actual value of this
information? Especially as there is no actual test case for this which
people can use to validate the changes.

> diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
> index 6e4b8206c7d0..7563da6db09b 100644
> --- a/include/linux/ptp_clock_kernel.h
> +++ b/include/linux/ptp_clock_kernel.h
> @@ -47,10 +47,12 @@ struct system_device_crosststamp;
>   * struct ptp_system_timestamp - system time corresponding to a PHC timestamp
>   * @pre_ts: system timestamp before capturing PHC
>   * @post_ts: system timestamp after capturing PHC
> + * @clockid: clockid used for cpaturing timestamp

cpaturing?

s/timestamp/the system timestamps/

Precision matters not only for PTP.

>   */
>  struct ptp_system_timestamp {
>  	struct timespec64 pre_ts;
>  	struct timespec64 post_ts;
> +	clockid_t clockid;
>  };
>  
>  /**
> @@ -457,14 +459,34 @@ static inline ktime_t ptp_convert_timestamp(const ktime_t *hwtstamp,
>  
>  static inline void ptp_read_system_prets(struct ptp_system_timestamp *sts)
>  {
> -	if (sts)
> -		ktime_get_real_ts64(&sts->pre_ts);
> +	if (sts) {
> +		switch (sts->clockid) {
> +		case CLOCK_REALTIME:
> +			ktime_get_real_ts64(&sts->pre_ts);
> +			break;
> +		case CLOCK_MONOTONIC_RAW:
> +			ktime_get_raw_ts64(&sts->pre_ts);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
>  }
>  
>  static inline void ptp_read_system_postts(struct ptp_system_timestamp *sts)
>  {
> -	if (sts)
> -		ktime_get_real_ts64(&sts->post_ts);
> +	if (sts) {
> +		switch (sts->clockid) {
> +		case CLOCK_REALTIME:
> +			ktime_get_real_ts64(&sts->post_ts);
> +			break;
> +		case CLOCK_MONOTONIC_RAW:
> +			ktime_get_raw_ts64(&sts->post_ts);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
>  }
>  
>  #endif
> diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
> index 053b40d642de..fc5825e72330 100644
> --- a/include/uapi/linux/ptp_clock.h
> +++ b/include/uapi/linux/ptp_clock.h
> @@ -157,7 +157,12 @@ struct ptp_sys_offset {
>  
>  struct ptp_sys_offset_extended {
>  	unsigned int n_samples; /* Desired number of measurements. */
> -	unsigned int rsv[3];    /* Reserved for future use. */
> +	/* The original implementation provided timestamps (always) in
> +	 * REALTIME clock-base. Since CLOCK_REALTIME is 0, adding
> +	 * clockid doesn't break backward compatibility.
> +	 */

This wants to be in the change log.

If you want to document the evolution of this data structure in a
comment, then 'original implementation' is not really the best wording
to use.

I'd rather see the documentation fixed so that it uses proper kernel doc
style for the whole data structure instead of having this mix of inline
and tail comments along with a properly structured version information.

/**
 * ptp_sys_offset_extended - Data structure for IOCTL_PTP_.....
 *
 * @n_samples:		Desired number of samples
 * ....
 * @...
 *
 * History:
 * V1:	Initial implementation
 *
 * V2:  Use the first reserved field for @clockid. That's backwards
 *      compatible for V1 user space because CLOCK_REALTIME is 0 and
 *	the reserved fields must be 0.
 */

Or something like that. Hmm?

Thanks,

        tglx


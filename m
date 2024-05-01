Return-Path: <linux-kernel+bounces-165768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02F28B90FE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986661C21681
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90426165FBD;
	Wed,  1 May 2024 21:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L0Iy4axw"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0426160785
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714597720; cv=none; b=GAWBXrgmbuF0TtGASISFKy/2E6KOr4o6CDfsL+LSk0/6sNuykuz7bQeiaa2jS1zd3fTS3NuLn0MYgA1qfzCrpKjL7DEpfj6yQcoWyTFb/KjVtTucQyb1IxpZGL5qq6Fqi2zQMs+5yC73mF/vHWcTCg3bgDE2iU3yPP2IVER0PBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714597720; c=relaxed/simple;
	bh=B7qAGFGI/bxEd5Q1LPU2V/hryghMwy7cXIVEchTKrFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCLNlSGFYlWdfCYdLMdbv7NsjSYTsAT8xSPPBFUcGRmikmEXXUpAfCBALHLN0yY88jj5o3yxA1mzkbeaNSCaYalbAjbvZuaszPnq26gpqL64g4cQmlpspMCTV0zkX4vxbBmVbAHgGaHQ1i2LAzfX69W8MNLxr7TQx3Lhxi02J5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L0Iy4axw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ec69e3dbcfso15836675ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 14:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714597718; x=1715202518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WyQVnwnxj7rjRobXy08x57R70AetlsmZRJbnEni1v7A=;
        b=L0Iy4axw3hWe2hQRN7DiqICWh4G5XMB8OJSlCtRonnVZ25FQH/YtfXkMA+eJLg5KoJ
         wTmhU9sjk8r4p/7ctN9wKar3PZuIrmxoRgBeyzrNCInssqNPh+anyK507F/woIjJgo2S
         xtr9aC1GEfwnHS2cenD+UvVxY/crUlkvRFpxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714597718; x=1715202518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyQVnwnxj7rjRobXy08x57R70AetlsmZRJbnEni1v7A=;
        b=EuNQhIjXZGSEWVEt77XN+P3z8SmXSjFLn4k5ufbGsc9KFa5+PgweZSnDdC1rvR6X+f
         UnWrC2zaAVIqMH2x16fAdcSLtwQTPqjGZAIjQXwBgu5Fnj0RY9Gd/tVNyIegImKLIjUK
         7hnzUWBVChYzZIIfwhDisOiQoDxTFoEazrvgtNqT/O80vLvwxgeHgZUwwXCEJXTIqPsg
         UwTOw6t+uDToHhCY50ZHsUtk4ricmHiNJPEGHut22rAnT923+yaQPMuQNqRNrdKXuzE1
         C8R6Lmresc9ARY+ewtyiR/LyDM4B8J45WClKAipUUunR1oPK4Xr5+RgzrSiRaQgVzXxD
         xMkA==
X-Forwarded-Encrypted: i=1; AJvYcCXeK4aY6Pz+iNqrIbx6XAAW63rjcuiO6KCEAZDuLW3KTPWiHSqg4AEoJeeuMni99BXbYWGo1ujdn4bVLkQjbZLKPC8x+pzNOsD0+K+b
X-Gm-Message-State: AOJu0Yx/EfsW1mEp6moHbVlfOHzjWbKzjuX1CO3B9VqtsSVNQkILk86N
	YPZ6b9WfdSDYoAGDEzT+fun1cifKLDq8UNeXLPXDpPmNFEz2Ye5iAK3MKQfykcVwvXYbVNccPJA
	=
X-Google-Smtp-Source: AGHT+IE9FGOHdmDg44s08H7J/PjssevGbga2XFanboUcNU/a7V5Q37yj0sflqb9URzzrmO06WsW4XQ==
X-Received: by 2002:a17:903:32c9:b0:1ea:5aff:c8ce with SMTP id i9-20020a17090332c900b001ea5affc8cemr53337plr.29.1714597717980;
        Wed, 01 May 2024 14:08:37 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902e74500b001eb5a81f688sm8660101plf.221.2024.05.01.14.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 14:08:36 -0700 (PDT)
Date: Wed, 1 May 2024 14:08:36 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] printk: cleanup deprecated uses of strncpy/strcpy
Message-ID: <202405011406.E4998CB515@keescook>
References: <20240429-strncpy-kernel-printk-printk-c-v1-1-4da7926d7b69@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429-strncpy-kernel-printk-printk-c-v1-1-4da7926d7b69@google.com>

On Mon, Apr 29, 2024 at 11:06:54PM +0000, Justin Stitt wrote:
> Cleanup some deprecated uses of strncpy() and strcpy() [1].
> 
> There doesn't seem to be any bugs with the current code but the
> readability of this code could benefit from a quick makeover while
> removing some deprecated stuff as a benefit.
> 
> The most interesting replacement made in this patch involves
> concatenating "ttyS" with a digit-led user-supplied string. Instead of
> doing two distinct string copies with carefully managed offsets and
> lengths, let's use the more robust and self-explanatory scnprintf().
> scnprintf will 1) respect the bounds of @buf, 2) null-terminate @buf, 3)
> do the concatenation. This allows us to drop the manual NUL-byte assignment.
> 
> Also, since isdigit() is used about a dozen lines after the open-coded
> version we'll replace it for uniformity's sake.
> 
> All the strcpy() --> strscpy() replacements are trivial as the source
> strings are literals and much smaller than the destination size. No
> behavioral change here.
> 
> Use the new 2-argument version of strscpy() introduced in Commit
> e6584c3964f2f ("string: Allow 2-argument strscpy()"). However, to make
> this work fully (since the size must be known at compile time), also
> update the extern-qualified declaration to have the proper size
> information.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90 [2]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [3]
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> ---
>  include/linux/printk.h |  2 +-
>  kernel/printk/printk.c | 20 +++++++++-----------
>  2 files changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 955e31860095..b3a29c27abe9 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -71,7 +71,7 @@ extern void console_verbose(void);
>  
>  /* strlen("ratelimit") + 1 */
>  #define DEVKMSG_STR_MAX_SIZE 10
> -extern char devkmsg_log_str[];
> +extern char devkmsg_log_str[DEVKMSG_STR_MAX_SIZE];
>  struct ctl_table;
>  
>  extern int suppress_printk;
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index adf99c05adca..64617bcda070 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -178,9 +178,9 @@ static int __init control_devkmsg(char *str)
>  	 * Set sysctl string accordingly:
>  	 */
>  	if (devkmsg_log == DEVKMSG_LOG_MASK_ON)
> -		strcpy(devkmsg_log_str, "on");
> +		strscpy(devkmsg_log_str, "on");
>  	else if (devkmsg_log == DEVKMSG_LOG_MASK_OFF)
> -		strcpy(devkmsg_log_str, "off");
> +		strscpy(devkmsg_log_str, "off");
>  	/* else "ratelimit" which is set by default. */
>  
>  	/*
> @@ -209,7 +209,7 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
>  			return -EINVAL;
>  
>  		old = devkmsg_log;
> -		strncpy(old_str, devkmsg_log_str, DEVKMSG_STR_MAX_SIZE);
> +		strscpy(old_str, devkmsg_log_str);
>  	}
>  
>  	err = proc_dostring(table, write, buffer, lenp, ppos);
> @@ -227,7 +227,7 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
>  
>  			/* ... and restore old setting. */
>  			devkmsg_log = old;
> -			strncpy(devkmsg_log_str, old_str, DEVKMSG_STR_MAX_SIZE);
> +			strscpy(devkmsg_log_str, old_str);
>  
>  			return -EINVAL;
>  		}
> @@ -2506,21 +2506,19 @@ static int __init console_setup(char *str)
>  	/*
>  	 * Decode str into name, index, options.
>  	 */
> -	if (str[0] >= '0' && str[0] <= '9') {
> -		strcpy(buf, "ttyS");
> -		strncpy(buf + 4, str, sizeof(buf) - 5);
> +	if (isdigit(str[0])) {
> +		scnprintf(buf, sizeof(buf), "ttyS%s", str);
>  	} else {
> -		strncpy(buf, str, sizeof(buf) - 1);
> +		strscpy(buf, str);
>  	}
> -	buf[sizeof(buf) - 1] = 0;
>  	options = strchr(str, ',');
>  	if (options)
>  		*(options++) = 0;
>  #ifdef __sparc__
>  	if (!strcmp(str, "ttya"))
> -		strcpy(buf, "ttyS0");
> +		strscpy(buf, "ttyS0");
>  	if (!strcmp(str, "ttyb"))
> -		strcpy(buf, "ttyS1");
> +		strscpy(buf, "ttyS1");
>  #endif
>  	for (s = buf; *s; s++)
>  		if (isdigit(*s) || *s == ',')
> 
> ---
> base-commit: 9e4bc4bcae012c98964c3c2010debfbd9e5b229f
> change-id: 20240429-strncpy-kernel-printk-printk-c-6a72fe6d0715
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>

Yeah, everything here checks out. I had to read through the sysctl
handler pretty carefully, but I think this is a nice readability
improvement. Thanks!

-Kees

-- 
Kees Cook


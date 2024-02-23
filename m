Return-Path: <linux-kernel+bounces-78650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD7086168A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D5EBB2537B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE20D82D77;
	Fri, 23 Feb 2024 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AaULP+NU"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C262F823A8
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703831; cv=none; b=ZfJhqpBSdR8sqkuDDmp1AmcNoAoPLeY05gEkhzZ2p7xSFynyey6Qz9hwLz5J9YOyt25+05BMj5sPepXGygK6ZHPladgOjdvLFjFWY/Y8JaXKCOWYIn9kpeG/3woyr4As6uxT/8e2aHh0zhxNhfr1eFavHYLZzu6qtNL6P2YqdKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703831; c=relaxed/simple;
	bh=MO8sgNOuHllwxy61pqPWSsxwxbwsUMpnOcsZ3p5VzfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAohTRM1dVc8gsTDRZR5+DqpMaDKwKr7w7V79clazPyX0Ju8lyQgIGnelfUEkVPC3aHE4WWLaKY5bSriDT7AVyGxX7NFVh/9oMJvPU6YhAWcxk1eh22vMH9QcnTfHd43rotA7qiMiM+mPehHBzD01YXn8/Nj7xx+Fgj+rBXrZ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AaULP+NU; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso134811566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 07:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1708703827; x=1709308627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AAoY4XJpRfmiPRwk6cpeOR1p6SYb4lFVCzehhnB4Sxg=;
        b=AaULP+NUbjA+txX1/tzXTrcV8IdPVbIidWbLFTq93Nz2bXJJXZqZXTZmobhjNKNNV2
         LjmFD6J+Eo9KWSoEk106F8bnqiH5n+KXl/1e0pfKPkivj25vrLTbSWmneb2N0bTzZKM5
         vBSeQxNV80Can2F0r9yvNXb4VwbfUBino9fxMTNq7gCp0jCfk/uVx14rx2HT4j3PZ4hU
         8smerk1cqIDjfJInzfDZS8mqUTDDmcfdREqqSH9R1zElSUNWIw54udpEsiaNsvoJALyN
         A7zGpZzoIbnVdmseEAYhdI4qZ6oxrc+eQfeo2Xw5cwiksrZgrI3C9zrQfXqcnpK0/KQz
         xW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708703827; x=1709308627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAoY4XJpRfmiPRwk6cpeOR1p6SYb4lFVCzehhnB4Sxg=;
        b=F2LM/OI2ZWdK6IQwcUm7lM/lh/vU61j9v4rQjO5UAffCCCzoUd1WZpXNQvDjxAc+yx
         LwN+QoibqGbjoxMHgIdlsMVsVj8xV12vMOnUjIEtQ5qUSpQQPt5GG6EmenK0M4xO+P6V
         M14LHQmFZY3TG/a2gAGZPeaB3NeAgdwNctbxkZoLEmjDrSp5rVv+UoxRYMvCID8SQmO6
         A5TFYZQkvT4zrnrGE0Rqr67UwXp8CywelA/iU71VSO30TcijY0xEtSc4E3rXHC9YO0sM
         YqS+Lqf4n/hIfTROiPq/IBVuJKAnD+fTtwrL+9z3FBzsY8pSxtLRVg37tXtIDr3Tr3ef
         rZbA==
X-Forwarded-Encrypted: i=1; AJvYcCVQP1Te72h7zNH296Fizk4ZG6IFWQhmbdo8ElDDLTh4ROnUeMeiv3H1NOuyu3gjV3W4nRwjmu/S4an2qTJ5TJ3cQgdZUwoV2C9gILRg
X-Gm-Message-State: AOJu0Yw2rou1DwvwQUEAJUawxOygseiz2uLQRSMY3omtJvnqqOahZ5la
	kMpcK8Shi+LQl7TfYzoX/VZJ4TICOqSTPBM0wFIwv5T+XU8Q1Np5+3rOQg/3YePPk5B//JubX6M
	p
X-Google-Smtp-Source: AGHT+IEsRXaPpkWzo1vKGiWgNGYqXDj2mOkeVg7XJysSB5xMtL2Kfr7jCMv52ujgthX3QRGJCKL+dw==
X-Received: by 2002:a17:906:1310:b0:a3d:a63f:2db0 with SMTP id w16-20020a170906131000b00a3da63f2db0mr176627ejb.28.1708703827087;
        Fri, 23 Feb 2024 07:57:07 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id js1-20020a170906ca8100b00a3ec3390ea1sm4525692ejb.25.2024.02.23.07.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 07:57:06 -0800 (PST)
Date: Fri, 23 Feb 2024 16:57:05 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 15/26] printk: Track registered boot consoles
Message-ID: <ZdjAUZiEDRCEROXk@alley>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-16-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218185726.1994771-16-john.ogness@linutronix.de>

On Sun 2024-02-18 20:03:15, John Ogness wrote:
> Unfortunately it is not known if a boot console and a regular
> (legacy or nbcon) console use the same hardware. For this reason
> they must not be allowed to print simultaneously.
> 
> For legacy consoles this is not an issue because they are
> already synchronized with the boot consoles using the console
> lock. However nbcon consoles can be triggered separately.
> 
> Add a global flag @have_boot_console to identify if any boot
> consoles are registered. This will be used in follow-up commits
> to ensure that boot consoles and nbcon consoles cannot print
> simultaneously.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Just a nit below.

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3598,6 +3611,17 @@ static int unregister_console_locked(struct console *console)
>  	if (console->exit)
>  		res = console->exit(console);
>  
> +	/*
> +	 * With this console gone, the global flags tracking registered
> +	 * console types may have changed. Update them.
> +	 */
> +	for_each_console(c) {
> +		if (c->flags & CON_BOOT)
> +			found_boot_con = true;
> +	}
> +	if (!found_boot_con)
> +		have_boot_console = false;

I would use:

	have_boot_console = found_boot_console;

But I do not have strong opinion. Maybe, you wanted to make
it obvious that the function only clears the flag.

Best Regards,
Petr


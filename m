Return-Path: <linux-kernel+bounces-162812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA918B60DC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1441F22B23
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7420F12839E;
	Mon, 29 Apr 2024 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O8Eud+ar"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488FF127B5D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714413738; cv=none; b=aIMH/yHnk9ihgfaLA1Zf1em/BZ8Kw9Eaif0/eKKk2GM+207p+y77xuVb+Ems5aPp5P99ErFYOnF7xhpIOUADvx/h0ysBV5kkeCe5gmVNKwHZoHTokEdqaOItvkXnydxYrWTw87CSG24yVGTFnLSaw7vGnjwmm/S70FVXJhbQyHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714413738; c=relaxed/simple;
	bh=gL0+tSE89ipQmrWrMcQPeqHsy334PXTO2zO/FIm0++Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UV287wVj/WZ5POntdwssn2DoxxoMOxSYAyYYx9UPnnEJO8l5HGkmwTIsdAf1fV9sToyjZqnlqZ7wUFw5Yb+Ud3p84peIDvE3FeGIers8GZV8HTdSrhGKmmoomFaYrWcwb50JhzGNObcZU+EkrTddJozBDak0xEvKHQn7saf+rFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O8Eud+ar; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e3f17c6491so39692035ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714413737; x=1715018537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6x8lt/QnOXVC9VHXwmVhKmm/O95+/YfUgqH6Mk9eoek=;
        b=O8Eud+areymLQ6RfxXaAKYQHRxQwptIhRkSw8cmzyViLIs/0kO7x6313rCCkivWKtR
         zq7LrwpZ2qfM2Xaooj4OwGaWbrrExAknNAQp/FJDpYK5mdPuH45vWjuSAwL1g9Vqdcjs
         l6ZfM3jonFTNh7akYf3WwKcxyM/fTotV/SYB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714413737; x=1715018537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6x8lt/QnOXVC9VHXwmVhKmm/O95+/YfUgqH6Mk9eoek=;
        b=R8ibT2mKoWsKb4UMQm3ivT9DpDEvLzLf14pXoZ5nhY4JC/2opqKnfwqjuWJmgVMS7l
         HEEghFImW3RjFiOqYiqeLlviEQzKowQo0QlAa5hLn2vgWczpxYe/7TXjvovgb+w0n1f0
         ucBCyHM8TKSJibQ0lLatZZYQ2hCAkQPUjgFBfNPz+9pgs0G2S4VlvupDi9w5W6SQmNy0
         Rs9yhTXS+C+1a7+ywo+wTo9Okl54sjOXavriODCwMB/NY4Fm4MSNMyZHZIdQQBMMTTD9
         x8CAFBLFkbUkEKW3aRmc9ET245JuMVSMQYQejBe93pv1hh+/21bAVaUKqpnFAhIcnl5+
         GstA==
X-Forwarded-Encrypted: i=1; AJvYcCXVQG8QtWfGvCMagmtuXb+4gN8qshUNG+B/q/i9sdzYE69AQAGgWo/qOq3GMhtuAB9gMWtaKhUAe7VEQFBvFXPp8YYSvbG41t6w4231
X-Gm-Message-State: AOJu0Yw3OL9hQ04JJFDzlM+SZsAPGMHnHvJUSUqJhsqW2cGGjiZfZiyQ
	oWZvBoNhQ0lcpvwjcjGd+DqnwUJuiogoD/UEHjoERuuMbHM1RbcR3s0YqKJDfw==
X-Google-Smtp-Source: AGHT+IEQfk9lL1aOUOkf//WozQck3LaV69Zfa5tOr6Oj+f6mKhEF0gk04YzTIOrNwRmpzUEbItTyoQ==
X-Received: by 2002:a17:902:d487:b0:1e2:1df:449b with SMTP id c7-20020a170902d48700b001e201df449bmr14900464plg.69.1714413736574;
        Mon, 29 Apr 2024 11:02:16 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ix19-20020a170902f81300b001e895c9ec6asm20207649plb.152.2024.04.29.11.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 11:02:16 -0700 (PDT)
Date: Mon, 29 Apr 2024 11:02:15 -0700
From: Kees Cook <keescook@chromium.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] tty: rfcomm: prefer struct_size over open coded
 arithmetic
Message-ID: <202404291047.B08E8BE759@keescook>
References: <AS8PR02MB723725E0069F7AE8F64E876E8B142@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB723725E0069F7AE8F64E876E8B142@AS8PR02MB7237.eurprd02.prod.outlook.com>

On Sun, Apr 28, 2024 at 03:29:34PM +0200, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1][2].
> 
> As the "dl" variable is a pointer to "struct rfcomm_dev_list_req" and
> this structure ends in a flexible array:
> 
> struct rfcomm_dev_list_req {
        u16      dev_num;
> 	struct   rfcomm_dev_info dev_info[];
> };

Similar to before, this should gain __counted_by(), and the logic using
dev_info[] refactored slightly to gain coverage.

> 
> the preferred way in the kernel is to use the struct_size() helper to
> do the arithmetic instead of the calculation "size + count * size" in
> the kzalloc() and copy_to_user() functions.
> 
> At the same time remove the "size" variable as it is no longer needed.
> This way, the code is more readable and safer.
> 
> This code was detected with the help of Coccinelle, and audited and
> modified manually.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/160 [2]
> Signed-off-by: Erick Archer <erick.archer@outlook.com>
> ---
> Hi,
> 
> The Coccinelle script used to detect this code pattern is the following:
> 
> virtual report
> 
> @rule1@
> type t1;
> type t2;
> identifier i0;
> identifier i1;
> identifier i2;
> identifier ALLOC =~ "kmalloc|kzalloc|kmalloc_node|kzalloc_node|vmalloc|vzalloc|kvmalloc|kvzalloc";
> position p1;
> @@
> 
> i0 = sizeof(t1) + sizeof(t2) * i1;
> ...
> i2 = ALLOC@p1(..., i0, ...);
> 
> @script:python depends on report@
> p1 << rule1.p1;
> @@
> 
> msg = "WARNING: verify allocation on line %s" % (p1[0].line)
> coccilib.report.print_report(p1[0],msg)
> 
> Regards,
> Erick
> ---
>  net/bluetooth/rfcomm/tty.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
> index 69c75c041fe1..bdc64c8fb85b 100644
> --- a/net/bluetooth/rfcomm/tty.c
> +++ b/net/bluetooth/rfcomm/tty.c
> @@ -504,7 +504,7 @@ static int rfcomm_get_dev_list(void __user *arg)
>  	struct rfcomm_dev *dev;
>  	struct rfcomm_dev_list_req *dl;
>  	struct rfcomm_dev_info *di;
> -	int n = 0, size, err;
> +	int n = 0, err;
>  	u16 dev_num;
>  
>  	BT_DBG("");
> @@ -515,9 +515,7 @@ static int rfcomm_get_dev_list(void __user *arg)
>  	if (!dev_num || dev_num > (PAGE_SIZE * 4) / sizeof(*di))
>  		return -EINVAL;
>  
> -	size = sizeof(*dl) + dev_num * sizeof(*di);

Luckily, "size" can't overflow. Max value seems to be around 1834980,
but I'd rather this be in struct_size() as you have it below. Good!

> -
> -	dl = kzalloc(size, GFP_KERNEL);
> +	dl = kzalloc(struct_size(dl, dev_info, dev_num), GFP_KERNEL);
>  	if (!dl)
>  		return -ENOMEM;

When you add __counted_by, this will need to be added here:

	dl->dev_num = dev_num;


Continuing...

        di = dl->dev_info;
	...
        list_for_each_entry(dev, &rfcomm_dev_list, list) {
                if (!tty_port_get(&dev->port))
                        continue;
                (di + n)->id      = dev->id;
                (di + n)->flags   = dev->flags;
                (di + n)->state   = dev->dlc->state;
                (di + n)->channel = dev->channel;
                bacpy(&(di + n)->src, &dev->src);
                bacpy(&(di + n)->dst, &dev->dst);
                tty_port_put(&dev->port);
                if (++n >= dev_num)
                        break;
        }

Hmpf. I'd rather this code use di[n] instead of (di + n) -- that's much
more idiomatic.

> @@ -542,9 +540,7 @@ static int rfcomm_get_dev_list(void __user *arg)
>  	mutex_unlock(&rfcomm_dev_lock);
>  
>  	dl->dev_num = n;

And this reset of dl->dev_num can stay as-is, since it's reducing the
number of valid entries, in can &rfcomm_dev_list is smaller than the
dev_num count userspace offered.

> -	size = sizeof(*dl) + n * sizeof(*di);
> -
> -	err = copy_to_user(arg, dl, size);
> +	err = copy_to_user(arg, dl, struct_size(dl, dev_info, n));
>  	kfree(dl);
>  

Otherwise looks good!

-Kees

-- 
Kees Cook


Return-Path: <linux-kernel+bounces-37763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8DB83B4E0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BD8E1F26286
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C83135A6C;
	Wed, 24 Jan 2024 22:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="DHMrAzoX"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0209135403
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136201; cv=none; b=mEliXJkT18A8KPnkyPhc2+OjDmUChpvd7nCG5UBavG5lIDl/qtIQZS3eI2sioGomYwa0ouvnYRq+eXBqCAVHoniX2dpFtXoUyZS8Q2vqdyFYFqj6SD+6aUEV/pDNYT+8Nz1IUlFJykmxxuBWWNI5IPYf0ue9Hl/VFzTlYtPtQzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136201; c=relaxed/simple;
	bh=C2h0bJiy/dRZAlRvBQ3RYcM8Moc4U+OtxLI1x7moPd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1uqp8vsHHIWUnYqIqSceWg/zEtA7KFj3KDYp6KfuKjlMQnDSJYnBJYyDtRs2L7i+m3IqZ/usXFE9oDLJ+rY4vsYVJW8qlCru1u9iGYYY0evWAh+o2JAAJkmEeqGpm7EVpB1FvtKNlRPuYuKxSmIwRnTBpCXbIMf//u28j6SgnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=DHMrAzoX; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a31092083acso160187866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1706136198; x=1706740998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DhEZ4I9lcmdbrmB8iD3XwiQxLtoMpp5EY22nl9LuCMw=;
        b=DHMrAzoXS0RxtuLoongnYzccPJ//xOEctldV9xR8O4zi4vUdsPQ+NMKRRVsjNsSMLv
         xi8frFWMsQcdYh9qUJzOrT0XlRfgbbXR2s4c/rHQtg4BLcEfXMkSopex+mgTLN8tjwLH
         7q0PIOKgQ/WN3/SeBvW9CfRqLvMaeTjzFQi18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706136198; x=1706740998;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DhEZ4I9lcmdbrmB8iD3XwiQxLtoMpp5EY22nl9LuCMw=;
        b=Lb00O1ju/FMhp4XcF1fKvirloM5OvxL3RaYu2gkVuWy1kLG7zTmojLDW5nvjhNSrRE
         FatzF2p/fn7eEvtdGpSD0XNJQEkUNXgdwy/E/vyZ9mODEIUCcfqi9ZOHVQdKXRgPj0fE
         CARLgJVlPro0uoFSny1dFh+33pPxuerStoNMwhF5ZWALWhFryFU1mvjCz7IWPRjukhIO
         cRB9obrUowWo5bEIZqjmcZIgl1+VVWisYJGd1an0NiLvwrOA+F/XTocsTcYd9sh57jQd
         EAheZIWHFOGlj9tWx0CQGEtLnAbesUOjHingnC8W9B/P04/paGL4uLtDZ0bDDV9n8eOR
         5pbw==
X-Gm-Message-State: AOJu0YzvYRajvrfEd06mzvKMfpmwf0YX0OUOf7wUmD+9nhVKwq28g2qG
	GTa1+bRTGYHXA4cattlIQZebAhBxKxxcyvKN4JZ106zdX/onDZVZNjLptzRJz/rSVZVd9iQUnYG
	2Wbw=
X-Google-Smtp-Source: AGHT+IH05EfRmOMzl8cA5MV+RH8uMdlnLfuEGqtjAw7M3EbUfGcoun4AytUv6ySH0f7UBiFzDh8BGA==
X-Received: by 2002:a17:907:168a:b0:a2e:96df:28ce with SMTP id cx10-20020a170907168a00b00a2e96df28cemr5654ejd.62.1706136197737;
        Wed, 24 Jan 2024 14:43:17 -0800 (PST)
Received: from [192.168.1.28] (77.33.185.10.dhcp.fibianet.dk. [77.33.185.10])
        by smtp.gmail.com with ESMTPSA id g24-20020a170906595800b00a30b77c3b49sm330292ejr.100.2024.01.24.14.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 14:43:17 -0800 (PST)
Message-ID: <94713e86-30a8-4828-959d-bd95800149e4@rasmusvillemoes.dk>
Date: Wed, 24 Jan 2024 23:43:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Printing numbers in SI units
Content-Language: en-US, da
To: Matthew Wilcox <willy@infradead.org>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
References: <ZbFd5TZ_pi7q3hso@casper.infradead.org>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <ZbFd5TZ_pi7q3hso@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/01/2024 19.58, Matthew Wilcox wrote:
> I was looking at hugetlbfs and it has several snippets of code like
> this:
> 
>         string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
>         pr_warn("HugeTLB: allocating %u of page size %s failed node%d.  Only allocated %lu hugepages.\n",
>                 h->max_huge_pages_node[nid], buf, nid, i);
> 
> That's not terribly ergonomic, so I wondered if I could do better.
> Unfortunately, I decided to do it using the SPECIAL flag which GCC
> warns about.  But I've written the code now, so I'm sending it out in
> case anybody has a better idea for how to incorporate it.

Well, something that gcc will warn about with Wformat isn't gonna fly,
obviously. But my man page also mentions ' as a possible flag for d
conversions:

       '      For decimal conversion (i, d, u, f, F, g, G) the output is
to be grouped with thousands'
              grouping characters if the locale information indicates any.

Obviously, our printf wouldn't implement that, but "grouping by
(roughly) 1000s" is kinda related to what you want the output to be, so
it seems apt. The man page also says "Note that many versions of gcc(1)
cannot parse this option and will issue a warning.", but I think that's
an ancient and irrelevant note. None of the gcc (or clang) versions
godbolt knows about give that warning.

I'm not really sure the implementation should imply a trailing B; that
might as well be included in the format string itself - perhaps the
quantity is bits, so a lowercase b is better, or perhaps it's some
frequency so the user wants Hz.

As for frequency, one would probably prefer the real, 1000^n, SI
prefixes and not the IEC 1024^n ones, and regardless, I think there
should be some way of doing both STRING_UNITS_2 and STRING_UNITS_10. At
first I thought one could distinguish by using either one or two ', but
gcc does warn for repeated flags. Two options I can think of: (a)
Overload the precision, so a precision p >= 10 means STRING_UNITS_10
with actual precision being p-10 (and yes, by all means cap that at 2).
(b) Currently %i and %d are completely equivalent, we could make them
different in case a ' flag is present and make one do the 2^n and other
the 10^n.

In the over-engineering department, maybe let the space flag indicate to
put a space between the number and the prefix.

> 
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 69b6a5e177f2..69af4d24a814 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -178,6 +178,16 @@ test_number(void)
>  	 * behaviour.
>  	 */
>  	test("00|0|0|0|0", "%.2d|%.1d|%.0d|%.*d|%1.0d", 0, 0, 0, 0, 0, 0);
> +
> +	/*
> +	 * C23 does not define the effect of "alternative form".  Indeed
> +	 * I think it actually defines it to be Undefined Behaviour which
> +	 * apparently lets the compiler delete your entire source code.
> +	 */
> +	test("2KiB", "%#d", 2048);
> +	test("2MiB", "%#d", 2048 * 1024);
> +	test("1GiB", "%#d", 1024 * 1024 * 1024);
> +	test("1000MiB", "%#d", 1024 * 1024 * 1000);
>  }
>  
>  static void __init
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 552738f14275..a702582c598c 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -370,6 +370,56 @@ char *put_dec(char *buf, unsigned long long n)
>  
>  #endif
>  
> +/*
> + * precision is the number of digits after the decimal place.  we limit
> + * it to two, because more would be complicated and unnecessary.
> + */
> +static noinline_for_stack
> +char *put_si(char *buf, unsigned long long n, int precision)

Please don't call the Mi etc. "SI", there's already enough confusion
about what a megabyte really is.

Rasmus



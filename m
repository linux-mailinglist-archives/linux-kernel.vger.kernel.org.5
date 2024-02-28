Return-Path: <linux-kernel+bounces-84674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333F086A9F5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D39EDB254A2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C1325567;
	Wed, 28 Feb 2024 08:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="D1ec4Kw0"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803F0175BE
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109163; cv=none; b=VyF/wVIb8zvdDgKXm/M4q/K0zo+mCXbLZOjKI5jKV0s2ihdG4Ws1DsqgM8O2fR2WPi+IgggT+uHCtIWjlaHK5jLpYMNZPMwn3jE0Ktq/a9oHqjJD+GdH5FLuvluDtxVBZsDZGusD3PQa2SHOgO3XdYOK/d4mlapymkeekHYPxDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109163; c=relaxed/simple;
	bh=XuoZVsjuqL9ymQigbA4AZAaJC1MKZZUm1j8DOVdHHFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sleuw6CvqzEcy1tX8Z5hhEydE7sfm41S2q+sQoJSdqtVXNbWdSRamFZ/mfmKf+GIfNrfrvlP/uOlXibXuO8I0RUGaQckL3RarCIxlXcCyktpu+1mvL72gKeOsBRp/fwqGWrHm4xNzweAK4OH77YWDhKVhFCKx1Z714mt7h97xLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=D1ec4Kw0; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5131c0691feso307384e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 00:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1709109159; x=1709713959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7hBKRUp7e0mhp2H2stJDtIQw2OG2HDV7CHmEtk094uw=;
        b=D1ec4Kw0vj2ilI9T/rsZyd22+3ELwz+Q5MaJ8G8geATweI3+/1bMI5WOzJ175jFQAz
         cZvs4i+DxcBttqQ3NWNtOrb3Bl3Fx5o/iJcg2mY6nJmLFgeHY8yjeOeBFbdK8GzUsIHe
         hDwGk+V6ingJkrfTixW7moY8FQeyqy+8TXCMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709109159; x=1709713959;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hBKRUp7e0mhp2H2stJDtIQw2OG2HDV7CHmEtk094uw=;
        b=W42opMbIF8cmOPzt0Z+hTtLkzz33oR1MZ/CwkMJIQscq7IpFqUXgjE9M8l6LMe2AwN
         9SHZ2xfVY7MQPWmyfKfQRwhGi2TUdQR1ZqEtZW0dm+l4wYy1+0sE18o2Kutq44hp2Sr8
         xa3c0/yT5MnzYnPMxRQLRAIeTW8zrnc77T5vSUp90wWBT09AJ6Hgve0U05Ed/N3vVv3v
         YMXp5G3ZZT0Z+YLPEF7GBomXAzijhTKTL1pCJK/v6NzXwXcimhCCN0dzpCAVrLAb6OIm
         8jtn/zUMzdVMWWIAEvUJNx8vR9s6tJULEBqGUZ5Er+jNt1VGWZtVZfUb837kY82IdhIi
         ypsw==
X-Forwarded-Encrypted: i=1; AJvYcCWVC8YSNBarbWufjk70spX66FV82G6+9lzdQHOay44I9Su9u2VMAXUyg4JVYih401NTVHpdhhjfGl1rSkgUAdNo+QaYBiDIWDf39DZj
X-Gm-Message-State: AOJu0Yx61eX7MQxVZ7SwvudBM0OQQIn/gX3zqh5Ef0SrMMl/zvgIg2Ne
	FwK6YXt0TFe33x93WK83UCWKIZLd5OHIqxLI7hzTG/LzItTN3dXM2MmN3tyTtak=
X-Google-Smtp-Source: AGHT+IHhzFLxoiH9+AU+L7p3vLl2O9Xn51+/b3OSBwWZMnBRJ5im/LBBZHrb88gIGCj1ZDGvWIW63g==
X-Received: by 2002:ac2:523b:0:b0:513:1573:2dd4 with SMTP id i27-20020ac2523b000000b0051315732dd4mr1572707lfl.45.1709109159320;
        Wed, 28 Feb 2024 00:32:39 -0800 (PST)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id w23-20020ac24437000000b00513128da8eesm401725lfl.197.2024.02.28.00.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 00:32:38 -0800 (PST)
Message-ID: <fa42285b-099e-4d2d-9368-58cea7f67010@rasmusvillemoes.dk>
Date: Wed, 28 Feb 2024 09:32:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] drm/i915: Indicate which pipe failed the fastset
 check overall
Content-Language: en-US, da
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-gfx@lists.freedesktop.org,
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org
References: <20240215164055.30585-1-ville.syrjala@linux.intel.com>
 <20240215164055.30585-2-ville.syrjala@linux.intel.com>
 <ZdfApN1h97GTfL1t@intel.com> <Zdj2ONs8BZ6959Xb@intel.com>
 <87bk83mfwp.fsf@intel.com>
 <1013ff2d-76b2-41f9-a5d4-39a567a3b0cc@rasmusvillemoes.dk>
 <Zd4qrLVWcacza747@intel.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <Zd4qrLVWcacza747@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/02/2024 19.32, Ville Syrjälä wrote:
> On Tue, Feb 27, 2024 at 10:38:10AM +0100, Rasmus Villemoes wrote:
>> On 26/02/2024 15.57, Jani Nikula wrote:
>>
>>> Personally I suck at remembering even the standard printf conversion
>>> specifiers, let alone all the kernel extensions. I basically have to
>>> look them up every time. I'd really love some %{name} format for named
>>> pointer things. And indeed preferrably without the %p. Just %{name}.
>>
>> Sorry to spoil the fun, but that's a non-starter.
>>
>> foo.c: In function ‘foo’:
>> foo.c:5:24: warning: unknown conversion type character ‘{’ in format
>> [-Wformat=]
>>     5 |         printf("Hello %{function} World\n", &foo);
>>       |                        ^
>>
>> You can't start accepting stuff that -Wformat will warn about. We're not
>> going to start building with Wno-format.
> 
> Are there any sensible looking characters we could use for
> this? Ideally I'd like to have something to bracket the
> outsides, and perhaps a namespace separator in the middle.
> 
> Or are we really forced into having essentially a random set
> of characters following just a %p/etc.?

You can't put stuff after % that is not in the C standard (or POSIX) -
not until you teach all supported compilers a way to register your own
printf specifier and the semantics of the expected varargs. And the only
format specifier that will accept a random pointer is %p.

Now, as for what we put after %p, the reason we've ended up with the
"random collection of letters" is (probably, I wasn't around when this
was introduced) that you can very reasonably have a format string with
%p followed by some punctuation where you mean for that punctuation to
be output as-is (as a normal printf() implementation would), whereas it
would be weird to write %pR" and expect some output like 0x1234fedcR .
Hence the heuristic was that one could allow any alphanumerics to modify
how that %p should be handled, and in the format string parser simply
skip over those alphanumerics - all without making the compiler angry.

So the problem with introducing %p{some-thing} is that somebody could
already have that %p (possibly with some existing alphanumeric
extension(s)) followed by an opening curly brace, with the latter
expected to be a literal thing. Same for any other punctuation
character. You could probably mostly grep and see if any exist, but
there might be format strings broken across two lines using implicit
string concatenation that won't be found, as well as even more creative
things.

That leaves something like %pX{}, i.e. where some new letter is
designated to indicate "hey, I want something much more readable and
please interpret what's inside {}". That's doable, and then you could
put mostly anything (except } and %) inside there. The format parsing
would just need to be taught that X is special and skip to the }, not
just alphanumerics.

>>> And then we could discuss adding support for drm specific things. I
>>> guess one downside is that the functions to do this would have to be in
>>> vsprintf.c instead of drm. Unless we add some code in drm for this
>>> that's always built-in.
>>
>> If people can be trusted to write callbacks with the proper semantics
>> for snprintf [1], we could do a generic
> 
> Yeah, I was at some point thinking that having a version of
> register_printf_function() for printk() might be nice. The dangers
> being that we get conflicts between subsystems (*), or that it gets
> totally out of hand, or as you point out below people will start
> to do questionable things in there.
> 
> (*) My earlier "include a subsystem namespace in the format" 
> idea was basically how I was thinking of avoiding conflicts.

So if we really want to go down this road, I think it should be
something like %pX{drm:whatever}, with core printf just looking up the
token "drm" in a run-time list of registered callbacks (because I don't
want vsprintf.c filled with random subsystems' formatting code), and
that single callback would then be handed a pointer to the rest of the
format string (i.e. the "whatever}..."), the pointer argument from the
varargs, and the buf,end pair. But then we're back to trusting that
callback (which might of course multiplex based on the "whatever" part)
to behave correctly. And then we might as well avoid the string parsing
and just do the "callback + pointer" in one struct (passed as pointer to
compound literal), which also avoids the tricky "what to do about module
unload versus unregistering of callbacks" etc.

Rasmus



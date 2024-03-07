Return-Path: <linux-kernel+bounces-95105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BFB87493E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEBAA1C212C3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A4F63134;
	Thu,  7 Mar 2024 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="gp/w6eVR"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0E3633F9
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709799030; cv=none; b=Cv0MP5tZD5udrOEFQjkFVwlsnp3TunqP33tNj+wBpTDsYRaRvvMeFfVaTV/jyStFXOzKJMo9MLZk4G+HVFg8nQ4rWND8FAtaWC7Smrirqi9YvoQLlkwhVIo2WlbecRDil4hNJCdDur3J2ejK3818bbr1YEK3agcJBz3iV+KkF7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709799030; c=relaxed/simple;
	bh=LxR99NUUOq1nZ6s+o1kKstvrQ4OiW5ubdAODqsj9WGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nUMQ1mKu2r7fxLvSc97gN2hcABzmVrEUp0GpAi9GPBTUFDvF5aJ1eq7eZCMxlbZnSidNt2YJTAFks2vJzNGCQXJEjaEGc6ie2HYYjTwjo41thFzhhGuaTVUp55BrZPu8OSdP0v/Zc9JS/VYvr3X3puOW+qeVv9FyUaIQ/hNYXJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=gp/w6eVR; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d220e39907so7606501fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 00:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1709799026; x=1710403826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cG7smFmpna1hDFK0tyouFYQSRWo3mvaAW8JJvQiUY80=;
        b=gp/w6eVRaEWCh2k2GDHgHnp6O54FCxNQFNUSekGZN+cFGi3rl9izSV60k6iSjDP0Zh
         uRqlb45nqQYbTpNFkqA2Y80gdjkG6y7cd+Qsgu76Oa5eM6p1D3TlDaCCW6Qs+nPk/9HU
         bRt4U1O07IDKL6LjeiP1VL9TuWAgZcX3U8ptY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709799026; x=1710403826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cG7smFmpna1hDFK0tyouFYQSRWo3mvaAW8JJvQiUY80=;
        b=ARET430xkYt/mBNZywprQE2ju4LHz4grnVRmJ53yVzAWh+1Zwwh0PPjtH3dbRipnNx
         ClGAwmtBOAbSuJfCVrZP0+2NKgMOscLjxToABQfhvo7iV3YNU0U+OXy2TGrU+MJ1Of62
         zfIkl2HPtOIuUPWmrcHviGfICq5J3xfGSEitC1FvPcaRvdlg6h8EIIiByOUu2gW1cZL0
         yS+IppLEqiokvRQKq9Jzhg2YJkCncW/Bn1MG4q5EcAZVueJo4mxxZc5WW8E+GWQWnXOT
         3RAPRgDeW2hje/vkkHkyBlbAQU/kjrPBKabPHyIrw7l9zH+ifXZNmZs2flU4q20EdbiY
         DHbw==
X-Forwarded-Encrypted: i=1; AJvYcCWhPGN0WGYaAu8UUIE6KiEDXS12v2dP8oEOYaOzrkc415wZnjY/CBVxpBy8IZjpvMfUkbteGrZQNlkFmE9beV+3YqiK6nCVT1Fe6v/4
X-Gm-Message-State: AOJu0Yz/n+4ejsAOkAbj/KA6MVd4uvUET4QYvF9IHvQNnoXWIwwORiWg
	LXWfvHe1XDao7nhDRe1VYJlMlSD8OnnuFSaqT+gGfOKreQWl+Wr4yPqQqZXxYHg=
X-Google-Smtp-Source: AGHT+IHzPGoSfqNzjTcduvzXG8jWaMN7dG5LLQKHWBMZmlqfHFKtYQejGP9FvtLpPSkRt2EXovuyWw==
X-Received: by 2002:a2e:8716:0:b0:2d4:842:dabe with SMTP id m22-20020a2e8716000000b002d40842dabemr1009395lji.36.1709799026450;
        Thu, 07 Mar 2024 00:10:26 -0800 (PST)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id v14-20020a2e924e000000b002d2b76dd76esm2888032ljg.57.2024.03.07.00.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 00:10:25 -0800 (PST)
Message-ID: <e1075345-ea35-4b39-a158-a0d165314a14@rasmusvillemoes.dk>
Date: Thu, 7 Mar 2024 09:10:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bootconfig: do not put quotes on cmdline items unless
 necessary
Content-Language: en-US, da
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
References: <20240306122452.1664709-1-linux@rasmusvillemoes.dk>
 <20240306124211.b490ea3c2372d89cff8c287c@linux-foundation.org>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20240306124211.b490ea3c2372d89cff8c287c@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/03/2024 21.42, Andrew Morton wrote:
> On Wed,  6 Mar 2024 13:24:52 +0100 Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> 
>> When trying to migrate to using bootconfig to embed the kernel's and
>> PID1's command line with the kernel image itself, and so allowing
>> changing that without modifying the bootloader, I noticed that
>> /proc/cmdline changed from e.g.
>>
>>   console=ttymxc0,115200n8 cma=128M quiet -- --log-level=notice
>>
>> to
>>
>>   console="ttymxc0,115200n8" cma="128M" quiet -- --log-level="notice"
>>
>> The kernel parameters are parsed just fine, and the quotes are indeed
>> stripped from the actual argv[] given to PID1. However, the quoting
>> doesn't really serve any purpose and looks excessive, and might
>> confuse some (naive) userspace tool trying to parse /proc/cmdline. So
>> do not quote the value unless it contains whitespace.
>>
>> ...
>>
>> --- a/init/main.c
>> +++ b/init/main.c
>> @@ -319,12 +319,20 @@ static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
>>  
>>  #define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
>>  
>> +static int has_space(const char *v)
>> +{
>> +	for (; *v; v++)
>> +		if (isspace(*v))
>> +			return 1;
>> +	return 0;
>> +}
> 
> Do we already have something which does this?

Well, 'value[strcspn(value, " \t\r\n")] ? "\"" : ""' would be a
oneliner, but not particularly readable. Also that list of characters
doesn't necessarily match isspace(), see below.

> Could do strchr(' ')||strchr('\t')
> 
> Do we really support tab separation here?  I doubt if that gets used or
> tested much.

Indeed, I did consider just doing strchr(' '), but ended up with
something based on isspace() as that is what next_arg() in lib/cmdline.c
uses, and also what lib/bootconfig.c allows through (together with
isprint() of course). But yes, \t, \r and \n are unlikely to be used,
even more so \f and \v, but perhaps somebody has 0xa0 by accident (nbsp
in latin1) which our isspace() also allows.

I didn't really want to risk a "prettify the 99% normal use cases" patch
breaking some odd existing setup, so went with the full isspace() check
which really wanted to be done in a helper.

> This function could be __init.

True, but the compiler inlines it to its only caller.

Rasmus



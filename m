Return-Path: <linux-kernel+bounces-62526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8948A852259
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA9C1C230E4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BB64F5FE;
	Mon, 12 Feb 2024 23:17:39 +0000 (UTC)
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [49.12.208.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38B94DA06
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 23:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.208.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707779859; cv=none; b=NF26LHg/FhVRCgyWG/oPh6FcxOuiIASo/NEJ8+LRYeT8hlUsbfAZcxN7so+lhzpDsKhAoXQkAwdA/v8EnB3PF0EEjzvu/Pg0oRnayLmvObXEBtFnyVKZ/OaC0bR+lVZMRkvShMumH7PURiBys92E6jn5LkLuWPRPLKsR75DO5/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707779859; c=relaxed/simple;
	bh=UIwSPn7oqBOap6PMVYgh93csn3P5c0tGwe6B0A6oExc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CrEhtyq755SFzchZLl8g4YlmayxwS65jNRM6MQWIJ730uT6Ho3Znk9buZJN6Ro1YiHSlI6hyYCS2M+Z9DLgiBkfW5zYHs48CgNoh5R/5Ij6JSRRs/TP/hkjYhIPBzSbaRmMmBV/RdlE+XMFWnYTdfExIBkphY6zFGWThyF1Bz90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar; spf=pass smtp.mailfrom=sdfg.com.ar; arc=none smtp.client-ip=49.12.208.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdfg.com.ar
Received: from [192.168.0.26]
	by sdfg.com.ar (chasquid) with ESMTPSA
	tls TLS_AES_128_GCM_SHA256
	(over submission+TLS, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
	; Mon, 12 Feb 2024 23:16:10 +0000
Message-ID: <52c52665-35f5-4111-a9d4-f8669c79bf70@sdfg.com.ar>
Date: Tue, 13 Feb 2024 00:16:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] tools/nolibc: Fix strlcat() return code and size
 usage
To: Willy Tarreau <w@1wt.eu>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 linux-kernel@vger.kernel.org
References: <20240129141516.198636-1-rodrigo@sdfg.com.ar>
 <20240129141516.198636-3-rodrigo@sdfg.com.ar> <20240211104817.GA19364@1wt.eu>
Content-Language: en-US
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
In-Reply-To: <20240211104817.GA19364@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/11/24 11:48, Willy Tarreau wrote:
> Hi Rodrigo,
> 
> first, thanks for the series!

Thank you, for your time and review! :)

> On Mon, Jan 29, 2024 at 03:15:14PM +0100, Rodrigo Campos wrote:
>> The return code should always be strlen(src) + strlen(dst), but dst is
>> considered shorter if size is less than strlen(dst).
>>
>> While we are there, make sure to copy at most size-1 bytes and
>> null-terminate the dst buffer.
>>
>> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
>> ---
>>   tools/include/nolibc/string.h | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
>> index ed15c22b1b2a..b2149e1342a8 100644
>> --- a/tools/include/nolibc/string.h
>> +++ b/tools/include/nolibc/string.h
>> @@ -187,23 +187,23 @@ char *strndup(const char *str, size_t maxlen)
>>   static __attribute__((unused))
>>   size_t strlcat(char *dst, const char *src, size_t size)
>>   {
>> -	size_t len;
>>   	char c;
>> +	size_t len = strlen(dst);
>> +	size_t ret = strlen(src) + (size < len? size: len);
> 
>  From what I'm reading in the man page, ret should *always* be the sum
> of the two string lengths. I guess it helps for reallocation. It's even
> explicitly mentioned:
> 
>    "While this may seem somewhat confusing, it was done to make truncation
>     detection simple."

Yes, that was my *first* understanding of the manpage too. But it 
doesn't seem to be the correct interpretation.

Also, this is exactly what I tried to say in the cover letter, with:

	I thought the manpage was clear, but when checking against that,
	I noted a few twists (like the manpage says the return code of
	strlcat is strlen(src) + strlen(dst), but it was not clear it is
	not that if size < strlen(dst). When looking at the libbsd
	implementation and re-reading the manpage, I understood what it
	really meant).


Sorry if I wasn't clear. Let me try again.

My first interpretation of the manpage was also that, and I think it 
would make sense to be that one. However, it is wrong, they also say 
this, that is what made me add the ternary operator:

	Note, however, that if strlcat() traverses size characters
	without finding a NUL, the length of the string is considered
	to be  size and the destination string will not be NUL
	terminated (since there was no space for the NUL)

So, my interpretation is that it is the sum of both, except when we 
can't find the NUL in that size, in which case we conside "size" to be 
the len of dst.

If you compare it with the output of libbsd, the return code seems to be 
exactly that. I was surprised too, as the manpage seem so clear... :-/

> Above ret will be bound to the existing size so a realloc wouldn't work.
> Thus I think the correct solution is:

Note that this implementation fails the tests added on patch 4. I've 
tested them (output and return code) to match the libbsd implementation.


> The test inside the loop is going to make this not very efficient. Same
> for the fact that we're measuring the length of src twice (once via
> strlen, a second time through the loop). I've just had a look and it
> compiles to 77 bytes at -Os. A simpler variant would consist in trying

How are you measuring the size?

I've added noinline to strlcat to the version I sent, so now it is shown 
in nm, but I have this as output:

$ nm --size -t x test.o
	0000000000000004 V errno
	0000000000000006 t strlcat.constprop.0
	0000000000000008 V _auxv
	0000000000000008 V environ
	000000000000000e W strlen
	000000000000000f W _start
	0000000000000018 W raise
	000000000000001b W abort
	000000000000004c T main
	000000000000005a t u64toa_r.isra.0
	0000000000000095 W _start_c
	00000000000002a8 t printf

How are you measuring it there?

Sorry, I'm not familiar with this :)


> to copy what fits in <size> and once reached, go on just for trailing
> zero and the size measurement:
> 
> size_t strlcat(char *dst, const char *src, size_t size)
> {
>          size_t len = strlen(dst);

The thing is, we need to return always at least strlen(src). Maybe plus 
something else. Even if size==0 and we don't copy anything.

Maybe we can special case that, so we simplify the loop, and it's smaller?

I've been playing, but as I can't measure the size, I'm not sure what is 
really better. I'd like to play a little once I know how to measure it :)



Best,
Rodrigo


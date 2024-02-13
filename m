Return-Path: <linux-kernel+bounces-63007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 227448528D0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557641C23420
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92BF175A9;
	Tue, 13 Feb 2024 06:20:23 +0000 (UTC)
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [49.12.208.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9568917590
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.208.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805223; cv=none; b=K4e7pr5gxVKmOsyGyVJVhUzhdeFJMmId5rtR5AVvqdFDdHl3N48qcOFSeolE028+X80b7NYTHrNUfuhb+lgLSFqfueHrbbOv7V9ycMgfB4Cwv5d3hpfgg+6qqAO3/a5x9h0U3+StU/yE0UtHUVn7ErkZetICmrVpvNqungPMhGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805223; c=relaxed/simple;
	bh=/heVYW+CDh4v4PfxyLKnGyX5vzL0XxVPCXx4mh2FCVw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=omdbpII/v1wiBhWNvA8BHHF/mErA+bb/kd/f8jOssRA7LkeURchqcBaWqPdXrb0hgeDChXAjy7+xcZibo/UljHholdv0xZWUyobEvambc58b8ivq0dOGASOAPKqbnGLz1RyRPtkBL5ynbmuXLnqlEJCDLSJ8wKfjiqNxAwsQFGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar; spf=pass smtp.mailfrom=sdfg.com.ar; arc=none smtp.client-ip=49.12.208.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdfg.com.ar
Received: from [192.168.0.26]
	by sdfg.com.ar (chasquid) with ESMTPSA
	tls TLS_AES_128_GCM_SHA256
	(over submission+TLS, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
	; Tue, 13 Feb 2024 06:20:18 +0000
Message-ID: <4de5a6a5-8f7f-4af4-a4ad-d6521b056a4f@sdfg.com.ar>
Date: Tue, 13 Feb 2024 07:20:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] tools/nolibc: Fix strlcat() return code and size
 usage
Content-Language: en-US
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
To: Willy Tarreau <w@1wt.eu>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 linux-kernel@vger.kernel.org
References: <20240129141516.198636-1-rodrigo@sdfg.com.ar>
 <20240129141516.198636-3-rodrigo@sdfg.com.ar> <20240211104817.GA19364@1wt.eu>
 <52c52665-35f5-4111-a9d4-f8669c79bf70@sdfg.com.ar>
In-Reply-To: <52c52665-35f5-4111-a9d4-f8669c79bf70@sdfg.com.ar>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/13/24 00:16, Rodrigo Campos wrote:
> On 2/11/24 11:48, Willy Tarreau wrote:
>> Hi Rodrigo,
>>
>> first, thanks for the series!
> 
> Thank you, for your time and review! :)
> 
>> On Mon, Jan 29, 2024 at 03:15:14PM +0100, Rodrigo Campos wrote:
>>> The return code should always be strlen(src) + strlen(dst), but dst is
>>> considered shorter if size is less than strlen(dst).
>>>
>>> While we are there, make sure to copy at most size-1 bytes and
>>> null-terminate the dst buffer.
>>>
>>> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
>>> ---
>>>   tools/include/nolibc/string.h | 14 +++++++-------
>>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/tools/include/nolibc/string.h 
>>> b/tools/include/nolibc/string.h
>>> index ed15c22b1b2a..b2149e1342a8 100644
>>> --- a/tools/include/nolibc/string.h
>>> +++ b/tools/include/nolibc/string.h
>>> @@ -187,23 +187,23 @@ char *strndup(const char *str, size_t maxlen)
>>>   static __attribute__((unused))
>>>   size_t strlcat(char *dst, const char *src, size_t size)
>>>   {
>>> -    size_t len;
>>>       char c;
>>> +    size_t len = strlen(dst);
>>> +    size_t ret = strlen(src) + (size < len? size: len);
>>
>>  From what I'm reading in the man page, ret should *always* be the sum
>> of the two string lengths. I guess it helps for reallocation. It's even
>> explicitly mentioned:
>>
>>    "While this may seem somewhat confusing, it was done to make 
>> truncation
>>     detection simple."
> 
> Yes, that was my *first* understanding of the manpage too. But it 
> doesn't seem to be the correct interpretation.
> 
> Also, this is exactly what I tried to say in the cover letter, with:
> 
>      I thought the manpage was clear, but when checking against that,
>      I noted a few twists (like the manpage says the return code of
>      strlcat is strlen(src) + strlen(dst), but it was not clear it is
>      not that if size < strlen(dst). When looking at the libbsd
>      implementation and re-reading the manpage, I understood what it
>      really meant).
> 
> 
> Sorry if I wasn't clear. Let me try again.
> 
> My first interpretation of the manpage was also that, and I think it 
> would make sense to be that one. However, it is wrong, they also say 
> this, that is what made me add the ternary operator:
> 
>      Note, however, that if strlcat() traverses size characters
>      without finding a NUL, the length of the string is considered
>      to be  size and the destination string will not be NUL
>      terminated (since there was no space for the NUL)
> 
> So, my interpretation is that it is the sum of both, except when we 
> can't find the NUL in that size, in which case we conside "size" to be 
> the len of dst.
> 
> If you compare it with the output of libbsd, the return code seems to be 
> exactly that. I was surprised too, as the manpage seem so clear... :-/


I'm not convinced now if that is the right interpretation. I'll check 
the libbsd code, I don't remember it now, it's been a few days already.

My memory is that it was not something so sane.


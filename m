Return-Path: <linux-kernel+bounces-41343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2070883EF18
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 18:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16A26B226F3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A992D044;
	Sat, 27 Jan 2024 17:28:38 +0000 (UTC)
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [49.12.208.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BDF2CCBA
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.208.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706376517; cv=none; b=X4ExMNuAGYKkbPF5KwYMtjN940/Z3ISTlR4+Gv5+cv8OWw0pejmCOMSbFs+KdooVyBkBizoHHndgW39/pRLW8pY8gTqbMsvrxlvbuMeAeueUNtF7kcuPdznKM4Q396gs/WsHBbicQJnTIgQ9NkO6zBMZUIZFOuLde5YnM1eFIeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706376517; c=relaxed/simple;
	bh=FitbO8MCaHW5HJwzn2tUgZRT1fw26fTzyBZBRZ5CpK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MxRWI1SupTpYcFOz3TdLjSFAUsx/2ta7fWd6D2n8lfDpreLYUSufaiNY/oB9zgNy+F0bZOBGj1Koo5VYbm1jaOsk5StlMxeWWqsDugKbY70U/0Qg2ivxjLav0yEBSzXe9gDUOkGhUz2zW+11rcbdR/EZBHcr+qI7wg3QKAUIQF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar; spf=pass smtp.mailfrom=sdfg.com.ar; arc=none smtp.client-ip=49.12.208.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdfg.com.ar
Received: from [IPV6:2a02:8109:aa26:4b00:1a1e:9a1e:44f7:a3cd]
	by sdfg.com.ar (chasquid) with ESMTPSA
	tls TLS_AES_128_GCM_SHA256
	(over submission+TLS, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
	; Sat, 27 Jan 2024 17:28:26 +0000
Message-ID: <9538a8fe-b92f-42a5-99d1-25969cf51647@sdfg.com.ar>
Date: Sat, 27 Jan 2024 18:28:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] tools/nolibc/string: export strlen()
Content-Language: en-US
To: Willy Tarreau <w@1wt.eu>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org
References: <20240126142411.22972-1-rodrigo@sdfg.com.ar>
 <9abed5e3-cd61-474e-bb16-13243709f5c5@t-8ch.de>
 <20240127162400.GA14079@1wt.eu>
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
In-Reply-To: <20240127162400.GA14079@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/27/24 17:24, Willy Tarreau wrote:
> On Sat, Jan 27, 2024 at 03:53:32PM +0100, Thomas Weißschuh wrote:
>> On 2024-01-26 15:24:10+0100, Rodrigo Campos wrote:
>>> Please note that this code is not using strlen() and strlcat() doesn't seems to use it either.
>>
>> I think the comment in strlen() explains it:
>>
>>      Note that gcc12 recognizes an strlen() pattern and replaces it with a
>>      jump to strlen().
>>
>> strlcat() indeed contains this pattern.
>>
>> I was able to fix the issue by replacing the open-coded strlen() in
>> strlcat() with a call to the function and that also fixed the issue.
>>
>> It seems nicer to me as a fix, on the other hand the change to a weak
>> definition will also catch other instances of the issue.
>> Maybe we do both.
> 
> Yes, once we have the proof that the compiler may produce such a call, it
> can also happen in whatever user code so we need to export the function,
> there's no other solution.

Makes sense, thanks!

> 
>>> First I noted that removing the attribute unused in strlen(), the compilation worked fine. And then
>>> I noticied that other functions had the attribute weak, a custom section and export the function.
>>>
>>> In particular, what happens here seems to be the same as in commit "tools/nolibc/string: export memset() and
>>> memmove()" (8d304a374023), as removing the -Os or adding the -ffreestanding seem to fix the issue.
>>> So, I did the same as that commit, for strlen().
>>>
>>> However, I'm not 100% confident on how to check that this is done by the compiler to later replace
>>> it and provide a builtin. I'm not sure how that was verified for commit 8d304a374023, but if you let
>>> me know, I can verify it too.
>>>
>>> What do you think?
>>
>> Personally I don't know how it was verified, we'll have to wait for
>> Willy on that.
> 
> Oh it's very simple, just build a small code that doesn't contain any
> such explicit nor implicit call and check that it doesn't contain the
> function.
> 
> E.g >
>    $ printf "int main(void) { }\n" | gcc -nostdlib -static -Isysroot/x86/include -include nolibc.h -Os -Wl,--gc-sections -xc -
>    $ nm --size a.out

Oh, cool. I can confirm that gcc does indeed add the strlen call
(note I had to remove the "--size" param to nm, as the symbol is 
undefined and not shown otherwise)

I wonder if there is an easy way to check for which functions gcc/clang 
do this...

>>> As a side note, it seems strlcat()/strlcpy() fail to set the terminating null byte on some cases,
> 
> Indeed I've just checked and you're right, that defeats their purpose!

Cool.

>>> Let me know if you think it is worth adding some _simple_ patches (I don't think it is worth fixing
>>> all the cases, the code is to fix all of the cases is probably not nice and not worth it).
>>
>> Souns reasonable to me to fix the return values.
>> And get some tests for it.
> 
> Seconded!

Thanks, I'll see how to improve that too :)



Best,
Rodrigo


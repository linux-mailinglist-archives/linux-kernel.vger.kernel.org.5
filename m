Return-Path: <linux-kernel+bounces-66078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A82B855651
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2871F2AE7A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132B425750;
	Wed, 14 Feb 2024 22:47:34 +0000 (UTC)
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [49.12.208.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEFC1DDC1
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 22:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.208.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950853; cv=none; b=OByCOei7wWf0skj1HzyXpg4/5+Md6japXBUbLDXmGn8cZhPbDVjNS0Rj5ex+DzT7eOgCY1NgguKXPXWZVgujk+GB2P+QKmdTGlvw9ZF8qYrbznCy8cMtsQ97eBnjGzNR7hYuKXRgpzZ+lccRdCbr1Hcj82+YjQ6djfA9Eo1ISII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950853; c=relaxed/simple;
	bh=fhhxfV39wKaV2+2iPiwArpo04O6q5/v4jN7WNAfwMNg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kc6nZ7Q/FXZFzJ/CwunJq5HAN0HgY8D40+dF0fyBPKPghAQmVR/XUPYXxJs2Dn5hiJDzA7+wif9NOwOGNjJSKaFW1g61Y+Wz+xDt+whwoMG90C80MoHpe1mAN0oks0uhDFLcMbznnr0QMGBqMdLKzYJCnsP8m6J9S9SS+CfhGOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar; spf=pass smtp.mailfrom=sdfg.com.ar; arc=none smtp.client-ip=49.12.208.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdfg.com.ar
Received: from [192.168.0.26]
	by sdfg.com.ar (chasquid) with ESMTPSA
	tls TLS_AES_128_GCM_SHA256
	(over submission+TLS, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
	; Wed, 14 Feb 2024 22:47:28 +0000
Message-ID: <5bd05f4d-a427-4812-802e-f5adaa30b7ac@sdfg.com.ar>
Date: Wed, 14 Feb 2024 19:47:25 -0300
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
 <10b97cd3-5690-40b2-aa8e-3fea5dd4275f@sdfg.com.ar>
 <197c0910-f1e5-4e55-81a3-59cb2069a1d7@sdfg.com.ar>
In-Reply-To: <197c0910-f1e5-4e55-81a3-59cb2069a1d7@sdfg.com.ar>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/14/24 23:03, Rodrigo Campos wrote:
> On 2/14/24 16:34, Rodrigo Campos wrote:
>> size_t strlcat_rata(char *dst, const char *src, size_t size)
>> {
>>          const char *orig_src = src;
>>          size_t len = 0;
>>          for (;len < size; len++) {
>>                  if (dst[len] == '\0')
>>                          break;
>>          }
> 
> If you think about it, this is strnlen() and what follows is strncat().
> 
>> size_t strlcat_willy_fixed(char *dst, const char *src, size_t size)
>> {
>>          const char *orig_src = src;
>>          size_t len = strlen(dst);
>>          if (size < len)
>>                  len = size;
> 
> Same here.
> 
> We can simplify the code by using them, but the size doesn't seem to be 
> smaller. Let me see what I can do.

Yeap, third option would be this:

size_t strlcat(char *dst, const char *src, size_t size)
{
         size_t len = strnlen(dst, size);
         if(size > len) {
                 strncpy(dst + len, src, size - len - 1);
                 dst[size - 1] = '\0';
         }
         return len + strlen(src);
}

I've tried to use strncpy return code to avoid doing the strlen(src), 
but that is only useful if we copy all of src. Otherwise, we still need 
to go till the end. And the function code ends-up being bigger because 
we can only do it inside the if (and return from there), so we have to 
add code there and keep the strlen(src) outside.

I'm not sure about the size of this variant, as different programs give 
me different sizes.

For example, if I use it in this program:

int main(void) {
         char buf[10] = "test123456";
         buf[4] = '\0';
         char *src = "bar";
         size_t ret = strlcat(buf, src, 9);

         printf("dst is: %s\n", buf);
         printf("ret is: %d\n", ret);

         printf("strlen(buf) is: %d\n", strlen(buf));
         printf("strlen(src) is: %d\n", strlen(src));

	return 0;
}

It is compiled to 74 bytes. This is smaller than the other two options I 
posted.

But if I just use it in a wrapper function, as you suggested, like:

size_t test_strlcat_nlen(char *dst, const char *src, size_t size)
{
         return strlcat(dst, src, size);
}

And compile like this:

	gcc -xc -c -Os -fno-asynchronous-unwind-tables -fno-ident -s -Os  -I 
sysroot/x86/include -include nolibc.h strlcat_sizes.c -o test.o

or even like this, the result is the same:

	gcc -xc -c -Os -I sysroot/x86/include -include nolibc.h strlcat_sizes.c 
-o test.o

The result is 86 bytes, which is similar to the previous versions (81 
and 90 bytes they were).

I haven't checked the assembler generated, I bet it is being smart and 
taking advantage of the set size param when it makes it so much smaller. 
I've tried calling it with more numbers than just "9", in lot of cases 
it is smaller than 86 bytes.

I have the gut-feeling that for the types of programs that us nolibc, 
all params might be known (dst, src, size) and we won't need to keep a 
generic version of the function, the compiler will optimize it. Even 
calling it several times in the compiled program, forcing it out and 
inside the "if size > len)" case, the optimized version is still in the 
76 bytes or so.

So, the code is so simple, the size is almost the same and it seems the 
compiler has a better time optimizing it. I lean towards this version here.


What do you think?


Best,
Rodrigo


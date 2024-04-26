Return-Path: <linux-kernel+bounces-160397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 408818B3D0E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45461F23FC0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A87158DAB;
	Fri, 26 Apr 2024 16:45:44 +0000 (UTC)
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [49.12.208.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099A82B9AF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.208.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714149944; cv=none; b=bKEGWzRUP26axZKE5E3gb6sDCejJ77gYUPfYGFt/LlZA0svIwuQTiKrieTT7PcRZsOYBVdgZo875ZeQsj6/7iVSSdi17uAeJ4byReC6AXN18VbbjU7gnVvpZZUjP947Bx+JN0VfE/+4q1lO7yWSgng++XLfiWGZ+mE1udI7ml/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714149944; c=relaxed/simple;
	bh=hysiaFhfj1/CD6tXHxV36rXKGiuGpu+6Up+x096SWwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1bEjoZqrONDhk8JRIIBIkyAKNBwXN+7umn2gsUXgpGTv7KtsJOobYSiPUrbOOAoFqySEjkLhnPXK+BwzKuCK6VqL4NRAaU8hgZXcC0ENHu/klI3gRLWlT6ETeQWWiVLKULf37HrhTdaq13KzuKzB4vaJG3D9oZM0OcM4reXg2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar; spf=pass smtp.mailfrom=sdfg.com.ar; arc=none smtp.client-ip=49.12.208.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdfg.com.ar
Received: from [IPV6:2a02:8109:aa26:4b00:1a1e:9a1e:44f7:a3cd]
	by sdfg.com.ar (chasquid) with ESMTPSA
	tls TLS_AES_128_GCM_SHA256
	(over submission+TLS, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
	; Fri, 26 Apr 2024 16:43:20 +0000
Message-ID: <df7a2fde-9f6e-45bc-b691-3964b406db7c@sdfg.com.ar>
Date: Fri, 26 Apr 2024 17:43:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] selftests/nolibc: Add tests for strlcat() and
 strlcpy()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Shuah Khan <skhan@linuxfoundation.org>, "Paul E. McKenney"
 <paulmck@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
References: <20240218195110.1386840-1-rodrigo@sdfg.com.ar>
 <20240218195110.1386840-5-rodrigo@sdfg.com.ar>
 <172d25cf-cfd7-4069-8c26-df2e81ffbad1@t-8ch.de>
Content-Language: en-US
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
In-Reply-To: <172d25cf-cfd7-4069-8c26-df2e81ffbad1@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/23/24 10:18 AM, Thomas Weißschuh wrote:
>> +#define EXPECT_STRBUFEQ(cond, expr, buf, val, cmp)				\
>> +	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_str_buf_eq(expr, buf, val, llen, cmp); } while (0)
>> +
>> +static __attribute__((unused))
>> +int expect_str_buf_eq(size_t expr, const char *buf, size_t val, int llen, const char *cmp)
>> +{
>> +	llen += printf(" = %lu <%s> ", expr, buf);
> 
> This introduces a compiler warning on 32bit:
> 
>      i386-linux-gcc -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -W -Wall -Wextra -fno-stack-protector -m32 -mstack-protector-guard=global -fstack-protector-all  -o nolibc-test \
>        -nostdlib -nostdinc -static -Isysroot/i386/include nolibc-test.c nolibc-test-linkage.c -lgcc
>      nolibc-test.c: In function 'expect_str_buf_eq':
>      nolibc-test.c:610:30: error: format '%lu' expects argument of type 'long unsigned int', but argument 2 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
>        610 |         llen += printf(" = %lu <%s> ", expr, buf);
>            |                            ~~^         ~~~~
>            |                              |         |
>            |                              |         size_t {aka unsigned int}
>            |                              long unsigned int
>            |                            %u
> 
> 
> It is easy enough to fix through a cast to "unsigned long".

Thanks for fixing it! Of course, don't hesitate to let me know if there 
is something I can help with :)



Best,
Rodrigo


Return-Path: <linux-kernel+bounces-62944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D32852838
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F791C224B0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94BD11C87;
	Tue, 13 Feb 2024 05:28:01 +0000 (UTC)
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [49.12.208.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597DC8825
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.208.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707802081; cv=none; b=mveAx4ytGcL6+00+uItN8pJmO5L+m7QwHhN5hoPAiPtbq1UGnVsGiahyZGO/+cU+QHtyJmWeLcG03oSnGdd49Ev5QAgpggQAgvPWkWRk1GkgnU+VxWT24hVSHyGm18cd/ewQ0YSkyKuyCxAUBfsj8fluLWjILKe6n+os5fc13pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707802081; c=relaxed/simple;
	bh=3dUs2/5nG/bSrFIP3kEgJvOQyNcyFyvxHsGRPHm+oSM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cTnYFIeteSQG04DfX+yuI3IArBJwoMAaNjZZrgqF1eVrjRlXn0LsTNnZzOpMfg0iPOTWk6F8Mq5GTx9FjIPSLJHgThIo1+taeuwEIA6uj+2QU9LcJA+XV8iW8ERvo+i6FEqEjyX6glDMh3wA4e0tXnOQGWO2HYM+Bw1OQ+bXgiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar; spf=pass smtp.mailfrom=sdfg.com.ar; arc=none smtp.client-ip=49.12.208.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdfg.com.ar
Received: from [192.168.0.26]
	by sdfg.com.ar (chasquid) with ESMTPSA
	tls TLS_AES_128_GCM_SHA256
	(over submission+TLS, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
	; Tue, 13 Feb 2024 05:27:55 +0000
Message-ID: <1ee756a2-3043-43a4-9f20-97773ce3e408@sdfg.com.ar>
Date: Tue, 13 Feb 2024 06:27:52 +0100
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
>> The test inside the loop is going to make this not very efficient. Same
>> for the fact that we're measuring the length of src twice (once via
>> strlen, a second time through the loop). I've just had a look and it
>> compiles to 77 bytes at -Os. A simpler variant would consist in trying

What code are you compiling that uses strlcat?

I've tried dropping almost all the flags to leave only:
	-Os -nostdlib -lgcc

And I still don't see the 77 bytes.


> $ nm --size -t x test.o
>      0000000000000004 V errno
>      0000000000000006 t strlcat.constprop.0
>      0000000000000008 V _auxv
>      0000000000000008 V environ
>      000000000000000e W strlen
>      000000000000000f W _start
>      0000000000000018 W raise
>      000000000000001b W abort
>      000000000000004c T main
>      000000000000005a t u64toa_r.isra.0
>      0000000000000095 W _start_c
>      00000000000002a8 t printf
> 
> How are you measuring it there?

btw, sorry for the late reply. I was on a flight that was rebooked, it 
took me some days to arrive. But I finally arrived and have internet now :)

The constprop seems to be some gcc optimization to simplify things.

I see what happens. The example I was compiling was left with size=0 (a 
leftover from when I was testing the code). That is very easy for gcc to 
optimize it all out. That is why it can make it so small.

If I compile the example from my original email, though, I still don't 
see the 77 bytes you mention. I see 31 in the nm output, that in decimal 
is 49 bytes.

Maybe tomorrow with some sleep after the long flight, I see what else is 
happening :)



Best,
Rodrigo


Return-Path: <linux-kernel+bounces-120169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2239A88D3A3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A2D305350
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 01:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775241CD23;
	Wed, 27 Mar 2024 01:15:36 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id E5EB417554;
	Wed, 27 Mar 2024 01:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711502136; cv=none; b=uuKxF5znhN+KoMkyWVUBP79lisYM2m4Pi3/05ZinEKDh5plP5FfowYYxqahsu7/+k1kM8YMgFRliZgZIZgWsHrPFC/qmYzmJc3rTec/A1JohyjLDTdei2roaHQ+2TVPzTSdPJRh0xvEODhm6tSbCGh3oNKQmh/dxzHviRyng1Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711502136; c=relaxed/simple;
	bh=vlAURbsX5wpvGXqFwL0Rpdj7KYf37DTQ2Jtnu3oSU2o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:In-Reply-To:
	 Content-Type; b=c4gYT7ahV3DbABDXdJsIK5WWJfv/Uejnt/MwaOTQO3C6C1ukvqSXRj2uQrvbrO0NhtXoyeZvNkY48GguZ1reOHN9VoolHUelSYH09lD+ltdJV3BWFAxCbHwi5M/m0Ced/ltT/vuOjXAatARL5rK2mSQ7cgIBdsoScznzYI1gZPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.11.106] (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 3E1AC6019C949;
	Wed, 27 Mar 2024 09:15:19 +0800 (CST)
Message-ID: <a9bc4138-df79-112a-6470-90c86ba5bc95@nfschina.com>
Date: Wed, 27 Mar 2024 09:15:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] ASoC: sti: uniperif: fix the undefined bitwise shift
 behavior problem
Content-Language: en-US
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: arnaud.pouliquen@foss.st.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, nathan@kernel.org, ndesaulniers@google.com,
 morbo@google.com, justinstitt@google.com, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
In-Reply-To: <e70c65b0-2e0d-613f-4f05-bda61377fc01@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

This is a kindly resend email.
Sorry for the error style of last email :(
On 2024/3/26 13:30, Su Hui wrote:
> Hi,
> On 2024/3/25 22:25, Dan Carpenter wrote:
>> On Mon, Mar 25, 2024 at 11:40:33AM +0800, Su Hui wrote:
>>> --- a/sound/soc/sti/uniperif.h
>>> +++ b/sound/soc/sti/uniperif.h
>>> @@ -12,17 +12,28 @@
>>>   
>>>   #include <sound/dmaengine_pcm.h>
>>>   
>>> +#define SR_SHIFT(a, b)		({unsigned long __a = (a); \
>>> +				unsigned int __b = (b); \
>>> +				__b < BITS_PER_LONG ? \
>>> +				__a >> __b : 0; })
>> The code definitely looks buggy, but how do you know your solution is
>> correct without testing it?
> I only test some cases like SR_SHIFT(1, -1),SR_SHIFT(8,1), it seems have a right result.
> Oh, maybe I understand it. When 'a' is a negative value like '(int)-1', SR_SHIFT(a, b) will
> have some bugs.
>> I don't like this solution at all.  This is basically a really
>> complicated way of writing "if (b != -1)".  Instead of checking for -1,
>> the better solution is to just stop passing -1.  If you review that
>> file, every time it uses "-1" that's either dead code or a bug...
> Agreed，some are dead codes which can be removed, but what should we do with the
> following error codes like this one?
> sound/soc/sti/uniperif.h
>   415 #define UNIPERIF_CONFIG_BACK_STALL_REQ_SHIFT(ip) \
>   416         ((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? 7 : -1)
>   ...
>   423 #define SET_UNIPERIF_CONFIG_BACK_STALL_REQ_DISABLE(ip) \
>   424         SET_UNIPERIF_REG(ip, \
>   425                 UNIPERIF_CONFIG_OFFSET(ip), \
>   426                 UNIPERIF_CONFIG_BACK_STALL_REQ_SHIFT(ip), \
>                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> How about this solution? If the condition is false, just skip it.
>
> @@ -412,8 +412,7 @@
>                  UNIPERIF_CONFIG_REPEAT_CHL_STS_MASK(ip), 1)
>   
>   /* BACK_STALL_REQ */
> -#define UNIPERIF_CONFIG_BACK_STALL_REQ_SHIFT(ip) \
> -       ((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? 7 : -1)
> +#define UNIPERIF_CONFIG_BACK_STALL_REQ_SHIFT(ip) 7
>   #define UNIPERIF_CONFIG_BACK_STALL_REQ_MASK(ip) 0x1
>   #define GET_UNIPERIF_CONFIG_BACK_STALL_REQ(ip) \
>          GET_UNIPERIF_REG(ip, \
> @@ -421,10 +420,11 @@
>                  UNIPERIF_CONFIG_BACK_STALL_REQ_SHIFT(ip), \
>                  UNIPERIF_CONFIG_BACK_STALL_REQ_MASK(ip))
>   #define SET_UNIPERIF_CONFIG_BACK_STALL_REQ_DISABLE(ip) \
> +       ((ip)->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0 ? -1 : \
>          SET_UNIPERIF_REG(ip, \
>                  UNIPERIF_CONFIG_OFFSET(ip), \
>                  UNIPERIF_CONFIG_BACK_STALL_REQ_SHIFT(ip), \
> -               UNIPERIF_CONFIG_BACK_STALL_REQ_MASK(ip), 0)
> +               UNIPERIF_CONFIG_BACK_STALL_REQ_MASK(ip), 0))
>   #define SET_UNIPERIF_CONFIG_BACK_STALL_REQ_ENABLE(ip) \
>
> Maybe should print some error log here.
> I'm not sure about the safety of skipping SET_UNIPERIF_REG when the condition is false,
>
> Would it be better to make the result of undefined shift equal to zero?
>
> regards,
> Su Hui
>   
>


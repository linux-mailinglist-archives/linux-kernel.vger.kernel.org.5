Return-Path: <linux-kernel+bounces-70593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2DC85998B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 22:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57FE61C20C2C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 21:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006C674295;
	Sun, 18 Feb 2024 21:41:36 +0000 (UTC)
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [49.12.208.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3D4EAD7
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 21:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.208.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708292495; cv=none; b=orCe1oQIcc9TkeKYElq/CMJEFiQ/T4f2oVOl83Jj786kDl2pVRZuzGUQwWNk+cwKCd2YxtfAYDD53DGul4d1kXA230zhw43XukEYpo8csPG/ZmSR9UguIrOu1JFjNaanAcO52cVtr9AskIDBmRrTIZtZurjJL9VAECY1073D0Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708292495; c=relaxed/simple;
	bh=rYfS4umXbZLyw3B01TnvMyHbj0ts6WaxoocFw8ZCMUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFz9KEC+z4k8fTgM6MucV7U7BlSq5+S097ZDO1Ekc55P3VWnCzjwlJo4WCIoJVD1mTyY51ZgTmYA57C2nxsqyNZW9vcV8W2dJ2bql3H7uIjXrXI+5G5hOwF8DM61ZB2bTMcIdvCQhfCEl6wTeutxsVwpN/rzNrTWFiAcOOgwG/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar; spf=pass smtp.mailfrom=sdfg.com.ar; arc=none smtp.client-ip=49.12.208.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdfg.com.ar
Received: from [192.168.0.26]
	by sdfg.com.ar (chasquid) with ESMTPSA
	tls TLS_AES_128_GCM_SHA256
	(over submission+TLS, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
	; Sun, 18 Feb 2024 21:41:30 +0000
Message-ID: <a808b0f7-1e41-450d-83d2-2062f931fee2@sdfg.com.ar>
Date: Sun, 18 Feb 2024 18:41:25 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] selftests/nolibc: Add tests for strlcat() and
 strlcpy()
Content-Language: en-US
To: Willy Tarreau <w@1wt.eu>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 linux-kernel@vger.kernel.org
References: <20240218195110.1386840-1-rodrigo@sdfg.com.ar>
 <20240218195110.1386840-5-rodrigo@sdfg.com.ar>
 <2e1378df-ce3d-4f72-bbd6-6ba7654016bc@sdfg.com.ar>
 <20240218211131.GA5056@1wt.eu>
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
In-Reply-To: <20240218211131.GA5056@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/18/24 18:11, Willy Tarreau wrote:
> On Sun, Feb 18, 2024 at 05:39:03PM -0300, Rodrigo Campos wrote:
>> On 2/18/24 16:51, Rodrigo Campos wrote:
>>> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
>>> index 6ba4f8275ac4..d373fc14706c 100644
>>> --- a/tools/testing/selftests/nolibc/nolibc-test.c
>>> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
>>> @@ -600,6 +600,25 @@ int expect_strne(const char *expr, int llen, const char *cmp)
>>>    /* declare tests based on line numbers. There must be exactly one test per line. */
>>>    #define CASE_TEST(name) \
>>> @@ -991,6 +1010,14 @@ int run_stdlib(int min, int max)
>>>    	for (test = min; test >= 0 && test <= max; test++) {
>>>    		int llen = 0; /* line length */
>>> +		/* For functions that take a long buffer, like strlcat()
>>
>> Ouch, I didn't leave a "/*\n" for this comment :(
> 
> No worries, if you want I'll address it myself, just let me know, no
> need to respin a series for this.

Please do, thanks! :)



Best,
Rodrigo


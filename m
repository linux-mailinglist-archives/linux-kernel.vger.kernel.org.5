Return-Path: <linux-kernel+bounces-107220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973CD87F973
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49425282D48
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5041654646;
	Tue, 19 Mar 2024 08:23:02 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5FA5381D;
	Tue, 19 Mar 2024 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836581; cv=none; b=R9863ajLmSX6WCjURH9nat/kw/9B9fCsSGDmB1JL+lyuhH2WwW6NC3h30k9C2mYhRSCoyOPLcoEvhKhDIPedWvqvaKvmpMQdTZHPWnOOU2VvcdvuPh7YnFigsMaOtdVzVL0CRFy+WJiMUJE83h5GcY/kn1Ef1N71R9Mn66qpnik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836581; c=relaxed/simple;
	bh=2SFz89yAkAWvPswrpO+79T3cLeMOEzJVPjffwpyCHtY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dPxSGwntfOdyWJk1B/KpSepfknh3e2wIVuWQmZqKSM5IgXOdr9tlBhbj35YWx2xijHV40m7dpn69A9ZcP/5+npLuPWIfpYa23/Qs2JacmwPlhDDX0M/KkBLOG1TsSLaO4gPkUiFRgK7c2+Lmrp1I30ScMiAehggLKR/J1Jj60DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.79.255) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 19 Mar
 2024 11:22:49 +0300
Subject: Re: [PATCH v2] fbmon: prevent division by zero in
 fb_videomode_from_videomode()
To: Roman Smirnov <r.smirnov@omp.ru>, Helge Deller <deller@gmx.de>, Daniel
 Vetter <daniel@ffwll.ch>
CC: Thomas Zimmermann <tzimmermann@suse.de>, Karina Yankevich
	<k.yankevich@omp.ru>, "linux-fbdev@vger.kernel.org"
	<linux-fbdev@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
References: <20240305135150.23240-1-r.smirnov@omp.ru>
 <64bbc4dd-b617-4f3d-809e-763bedf37fb7@gmx.de>
 <9688d1d453b0472cb90f5e2151cbd2f8@omp.ru>
 <b5d52c4c-534f-4897-ab96-351f09bee89a@gmx.de>
 <57b3f6a6cc184c8ead51ecc50669b503@omp.ru>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <e730b2cd-5f29-8685-7427-8a798066e111@omp.ru>
Date: Tue, 19 Mar 2024 11:22:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <57b3f6a6cc184c8ead51ecc50669b503@omp.ru>
Content-Type: text/plain; charset="koi8-r"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 03/19/2024 08:06:05
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 184251 [Mar 19 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 10 0.3.10
 53c821b925e16276b831986eabc71d60ab82ee60
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.79.255 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.79.255
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/19/2024 08:10:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 3/19/2024 6:00:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 3/19/24 11:12 AM, Roman Smirnov wrote:
[...]

>>>> On 3/5/24 14:51, Roman Smirnov wrote:
>>>>> The expression htotal * vtotal can have a zero value on
>>>>> overflow.
>>>>
>>>> I'm not sure if those always results in zero in kernel on overflow.
>>>> Might be architecture-depended too, but let's assume it
>>>> can become zero, ....
>>>>
>>>>> It is necessary to prevent division by zero like in
>>>>> fb_var_to_videomode().
>>>>>
>>>>> Found by Linux Verification Center (linuxtesting.org) with Svace.
>>>>>
>>>>> Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
>>>>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>>>> ---
>>>>>    V1 -> V2: Replaced the code of the first version with a check.
>>>>>
>>>>>    drivers/video/fbdev/core/fbmon.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
>>>>> index 79e5bfbdd34c..b137590386da 100644
>>>>> --- a/drivers/video/fbdev/core/fbmon.c
>>>>> +++ b/drivers/video/fbdev/core/fbmon.c
>>>>> @@ -1344,7 +1344,7 @@ int fb_videomode_from_videomode(const struct videomode *vm,
>>>>>         vtotal = vm->vactive + vm->vfront_porch + vm->vback_porch +
>>>>>                  vm->vsync_len;
>>>>>         /* prevent division by zero */
>>>>> -     if (htotal && vtotal) {
>>>>> +     if (htotal && vtotal && (vm->pixelclock / htotal >= vtotal)) {
>>>>
>>>> why don't you then simply check for
>>>>          if .. ((htotal * vtotal) == 0) ...
>>>> instead?
>>>>
>>>> Helge
>>>
>>> Thomas Zimmermann from the previous discussion said:
>>> On Tue, 5 Mar 2024 11:18:05 +0100 Thomas Zimmerman wrote:
>>>> Maybe use
>>>>
>>>>     if (htotal && vtotal && (vm->pixelclock / htotal >= vtotal))
>>>>
>>>> for the test. That rules out overflowing multiplication and sets
>>>> refresh to 0 in such cases.
>>>
>>> This prevents overflow, which is also a problematic case.
>>
>> I don't like adding another division here and I doubt we have
>> a problem with possible overflow.
>> So, I suggest to keep it simple, something like:
>>        ...
>>        total = htotal * vtotal;
>>        if (total)
>>                fbmode->refresh = vm->pixelclock / total;
>>        else...
> 
> Okay, I'll prepare a third version with that change:
> 
>     if (htotal && vtotal && (htotal * vtotal))

   I think the 1st 2 checks here are now redundant. Also, the inner
parens are not necessary...

> I think that will be enough.

   More than enough. :-)

MBR, Sergey


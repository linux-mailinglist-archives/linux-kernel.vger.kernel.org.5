Return-Path: <linux-kernel+bounces-106420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5293287EE6A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 705721C20FFC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B6E55C01;
	Mon, 18 Mar 2024 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="am7QO7fk"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD205578E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 17:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781662; cv=none; b=SYKuWSlmgsfseD6pE0zZr79sZoWx6Sq9dllB6xOT4adfr6/U4GAKSXzLAlAl49olLSsWAaYVJ+C5zJcXHdt+kncVL/p/iA42ckK/FiP54H5EKNuF+T4KKYK9WbfM/+aYNjtNNVtR7gek4Zjqqaokw5MPhEvYhWrCmmUAG7waZB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781662; c=relaxed/simple;
	bh=iw44JYMdpRhnvUSLK2BkH4jibuZa/JCBTRlLI+djmyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=th/k6tc11/Zg66XLwSYVn3lLUs7m0E+zl8sKamKEjQz83tT5R/zkUhNHBCa4WC/XaAmryQ6UMOaTKoAl/KevApsF0w1G9rHuSFwKjXvoO2VVJ0YB0XUmnqerKvAnCku5/U4c6ebyrWAcKt3MohhWFtJMykzIRg8ntsgbFcFb4ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=am7QO7fk; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56aa63bd94cso278263a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710781659; x=1711386459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RQXiBvps7/vhp9jm0e7FEbfRyxZWtxROwZJ9DzCuQWw=;
        b=am7QO7fkw8WSBZUkVodwEGdmkiuPuhfJn9b0ZVdIUjY2GBoNc63Z5CwQJP9mHsDHG4
         V3LZCKMdfpf7u+Y9wWGyHzOqYEMJgek8BsUI0zrPHWbfkmhkRsR9qc4B98dZrCXoKUgh
         GpcQb5WfnJmv2a/wR4m5eN53XtJldzysfFNHOxSJGCKDsKYg7vmKYyvZwxljGgQ/0lpW
         9gu+kNu4ElraIRlW/RKr5vr9EY8aRzDbP2Vic6CNyLD7Ay67tuaeFjxn8Mmku1c5r4ba
         lRxkBqmz4EFgy8JfDPrAfvXFdaE2OzjMj3Uh0LFfHsCUOawtvk09ZO1/X8toi9y0CWeh
         M9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710781659; x=1711386459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RQXiBvps7/vhp9jm0e7FEbfRyxZWtxROwZJ9DzCuQWw=;
        b=jzY5bInzkd0WKqLigz4iGCO/XOkX5EG1ycJnQxwsPNzHu7Rbd+b0Zq4eU4MpYJkzTE
         eHxsTmIBml9gBsas0bRWSboZnQJ+zH+JCzbOKfGFRjipTg/Mk1vSwZFF6DBn7lybOVg1
         fK/xxTP9alJ2CjA1sngveMg3Uh2wx0/zHeNgcMd+kkmwUywcnrqMckKpzKylekXKjZu7
         H1H6tFcUELysffXPx9iUdpAWDgF5xna6ktPyCqfrsOsU9nDBqrJY1999U1J3jcoArxR4
         XmxYgPxeox1n6YXhFTQ8oYI+M3jInSZKJ2lhAQrs6nl+zru6sSrr6xEz0hnOoB7EUWvM
         ECbg==
X-Forwarded-Encrypted: i=1; AJvYcCVJbOZxrTki9piWbMxwYo0dO0YChHDHeTpTuVEAkvk/pOgGnxMWMSFdNxsRfhDongoJBZ0RlZasNI/4rpWpBise4eckAavwqVHfDzCk
X-Gm-Message-State: AOJu0Yw9Ex2ThheJ5pd5+gqyfQNQ/6Q+g+s1oo5195eVcxj82wHr8jZ0
	BRL4YIVVknwKtM6flVjaWCICYjwPGX6/oesjdIHrv1oKNQNw6c0g
X-Google-Smtp-Source: AGHT+IGuaU6uzyYeX6jSGyfcME0djstfNqJmUWGI6VUkVW/mutim/j1ZGboBusSrwRLn6uTqmrHtLw==
X-Received: by 2002:a05:6402:3212:b0:568:8b4d:ad91 with SMTP id g18-20020a056402321200b005688b4dad91mr34361eda.0.1710781658985;
        Mon, 18 Mar 2024 10:07:38 -0700 (PDT)
Received: from [192.168.1.101] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id c1-20020a056402100100b0056b8345e10csm516764edu.6.2024.03.18.10.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 10:07:38 -0700 (PDT)
Message-ID: <5fa18cb8-3c51-4ac6-811e-63ae74f82f17@gmail.com>
Date: Mon, 18 Mar 2024 18:07:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] staging: wlan-ng: Driver broken since kernel 5.15
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Lee Jones <lee@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Johannes Berg <johannes@sipsolutions.net>, Kalle Valo <kvalo@kernel.org>,
 Julia Lawall <julia.lawall@inria.fr>
References: <6dc14151-e71e-4118-826d-3ca5c8ee907f@gmail.com>
 <fba3951f-00b7-41af-8ef4-1e7c86e0cb48@moroto.mountain>
 <6c772d15-d249-4175-93f4-ca523006129b@gmail.com>
 <5716d138-ace0-4621-ab34-118610255207@app.fastmail.com>
 <cbdb25ca-f419-4afe-9b58-7d274445aefd@moroto.mountain>
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cbdb25ca-f419-4afe-9b58-7d274445aefd@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/18/24 09:01, Dan Carpenter wrote:
> On Sun, Mar 17, 2024 at 09:20:34PM +0100, Arnd Bergmann wrote:
>> On Sun, Mar 17, 2024, at 21:07, Philipp Hortmann wrote:
>>> On 3/11/24 08:04, Dan Carpenter wrote:
>>>> On Sat, Mar 09, 2024 at 11:09:24PM +0100, Philipp Hortmann wrote:
>>> You are right with the statement that it is this commit.
>>> commit ea82ff749587807fa48e3277c977ff3cec266f25 (HEAD)
>>> Author: Lee Jones <lee.jones@linaro.org>
>>> Date:   Wed Apr 14 19:10:39 2021 +0100
>>>
>>>       staging: wlan-ng: cfg80211: Move large struct onto the heap
>>>
>>>       Fixes the following W=1 kernel build warning(s):
>>>
>>>        drivers/staging/wlan-ng/cfg80211.c: In function ‘prism2_scan’:
>>>        drivers/staging/wlan-ng/cfg80211.c:388:1: warning: the frame size
>>> of 1296 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>>>
>>> But It is not depending on the line you pointed to.
>>
>> Right, the kzalloc() already clears the data, so the memset
>> is not needed.
>>
> 
> No, it's inside a loop so it needs to be cleared on each iteration.
> 
>>> I need another week to look into this.
>>
>> I'm fairly sure this fixes the bug, the problem here was that
>> the cast to (u8 *) hides the incorrect conversion:
>>
>> diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
>> index 471bb310176f..9d6a2dd35ba9 100644
>> --- a/drivers/staging/wlan-ng/cfg80211.c
>> +++ b/drivers/staging/wlan-ng/cfg80211.c
>> @@ -350,7 +350,7 @@ static int prism2_scan(struct wiphy *wiphy,
>>   		msg2->msgcode = DIDMSG_DOT11REQ_SCAN_RESULTS;
>>   		msg2->bssindex.data = i;
>>   
>> -		result = p80211req_dorequest(wlandev, (u8 *)&msg2);
>> +		result = p80211req_dorequest(wlandev, (u8 *)msg2);
> 
> Ah, well done.
> 
> It feels like this is the kind of bug which should be caught with
> static analysis.  One of the things that people want from static
> analysis is looking at what a patch does.  So if we pass &msg2 and the
> patch moved msg from the stack to be kmalloc()ed, then print a warning.
> It's not something that Smatch does.
> 
> I have my rename_rev.pl script (https://github.com/error27/rename_rev)
> which I use to filter out variable renames or see if (1 << foo) is
> converted to BIT(foo) correctly.  Maybe I could extend that to check
> "move stack to heap" patches...
> 
> regards,
> dan carpenter
> 

Hi,

This change alone.

+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -350,7 +350,7 @@ static int prism2_scan(struct wiphy *wiphy,
                 msg2->msgcode = DIDMSG_DOT11REQ_SCAN_RESULTS;
                 msg2->bssindex.data = i;

-               result = p80211req_dorequest(wlandev, (u8 *)&msg2);
+               result = p80211req_dorequest(wlandev, (u8 *)msg2);
                 if ((result != 0) ||
                     (msg2->resultcode.data != 
P80211ENUM_resultcode_success)) {
                         break;
makes the driver work again under latest kernel.

I can only use unencrypted transmission. Throughput is 200 to 800kByte/s
WEP would need further investigation.

Thanks for your support.

Bye Philipp









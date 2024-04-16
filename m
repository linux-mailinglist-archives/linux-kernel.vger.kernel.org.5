Return-Path: <linux-kernel+bounces-147285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2A88A71F7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE2981C213C9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084881332B6;
	Tue, 16 Apr 2024 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BTFw3A44"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A86E130AE6;
	Tue, 16 Apr 2024 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713287373; cv=none; b=kkjBRdpHkFSMs6bSeVFP12pQZUiVHeP7CtvoP6dZxp7HGcBOCG4OS+en9ar73pWSa6ljb3zsbQptkWRmsXJpE14SR6E5XpIJLf3ZbUxDNVOJPTyv/QWlNx0XtRsAWlHPkuD/z/IjIt8h75EtE5412He6q2FZbhgUCKySl5tzLvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713287373; c=relaxed/simple;
	bh=m/Tcz8R++mISom9mrEtKMuE4r704qsJcDo93SFLFcY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GHY7KDnMCvyYQ2MQ+6miG04qjXSua84d7Fbvw9qKwoTJ2Zyjc8yuDgj5SUt1iXhFP06TRDIFOjBXlUctW5vfe2ToH1Iyi6rBXEr+F+++gWWXKyidVdvm1z2G+bbn3UTwhcalrRewWNOnEdrjMWPUlfuR6vbfp5r1iQKjqJQyR7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BTFw3A44; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43GH8pt2048641;
	Tue, 16 Apr 2024 12:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713287331;
	bh=g7hmgb1jOpj4IRDr/inmA1TTBWR//ZWwh/OsLMd5UZ8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=BTFw3A44FKCKcc4mtAio6BztildVoS9yqe6eMWVDz4sb++KRfWrgX6/WIl2h7+5SQ
	 ngzF2hmRCS0RDg6lJaugBdRNXu05zL+4/C0LsRgtjd8YAX273DzofixYxHUdmDSWRr
	 cCjyfclJtZ5YxTnG2ApiOWfCMo86uGpiaepHNX1w=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43GH8pk2003997
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 16 Apr 2024 12:08:51 -0500
Received: from lewvowa01.ent.ti.com (10.180.75.79) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 Apr 2024 12:08:51 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by lewvowa01.ent.ti.com
 (10.180.75.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Tue, 16 Apr
 2024 12:08:51 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 Apr 2024 12:08:51 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43GH8oNF012621;
	Tue, 16 Apr 2024 12:08:50 -0500
Message-ID: <fce93a8b-7225-4775-b265-d283a863f969@ti.com>
Date: Tue, 16 Apr 2024 12:08:50 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/31] Remove use of i2c_match_id in HWMON
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>
CC: Jean Delvare <jdelvare@suse.com>, Juerg Haefliger <juergh@proton.me>,
        "Riku Voipio" <riku.voipio@iki.fi>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240403203633.914389-1-afd@ti.com>
 <0e43aa83-2e02-49e2-96b8-24cac0362a7b@roeck-us.net>
 <77b2f8ce-0b71-4a7a-81bc-a64a1af3566d@ti.com>
 <fcafe904-383c-49c0-b576-81cbcde045c5@roeck-us.net>
 <cd6ae1f7-33e7-4e1b-bac8-c5566b22b392@roeck-us.net>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <cd6ae1f7-33e7-4e1b-bac8-c5566b22b392@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 4/16/24 9:16 AM, Guenter Roeck wrote:
> On Mon, Apr 08, 2024 at 04:49:43AM -0700, Guenter Roeck wrote:
>> On Wed, Apr 03, 2024 at 05:06:43PM -0500, Andrew Davis wrote:
>>> On 4/3/24 4:30 PM, Guenter Roeck wrote:
>>>> On Wed, Apr 03, 2024 at 03:36:02PM -0500, Andrew Davis wrote:
>>>>> Hello all,
>>>>>
>>>>> Goal here is to remove the i2c_match_id() function from all drivers.
>>>>> Using i2c_get_match_data() can simplify code and has some other
>>>>> benefits described in the patches.
>>>>>
>>>>
>>>> The return value from i2c_match_id() is typically an integer (chip ID)
>>>> starting with 0. Previously it has been claimed that this would be
>>>> unacceptable for i2c_get_match_data(), and chip IDs were changed to start
>>>> with 1. Commit ac0c26bae662 ("hwmon: (lm25066) Use i2c_get_match_data()")
>>>> is an example. Either this series is wrong, or the previous claim that
>>>> chip IDs (i.e., the content of .driver_data or .data) must not be 0 was
>>>> wrong. Which one is it ? I find it very confusing that the chip type for
>>>> some drivers now starts with 1 and for others with 0. Given that, I am not
>>>> inclined to accept this series unless it is explained in detail why the
>>>> chip type enum in, for example, drivers/hwmon/pmbus/lm25066.c has to start
>>>> with one but is ok to start with 0 for all drivers affected by this
>>>> series. Quite frankly, even if there is some kind of explanation, I am not
>>>> sure if I am going to accept it because future driver developers won't
>>>> know if they have to start chip types with 0 or 1.
>>>>
>>>
>>> i2c_get_match_data() has no issue with returning 0 when the driver_data
>>> for the match is also 0 (as it will be when the chip type is 0 here).
>>>
>>> The confusion might be that returning 0 is also considered a failure code.
>>> This is a problem in general with returning errors in-band with data, and
>>> that is nothing new as i2c_match_id() does the same thing.
>>>
>>> Actually, i2c_match_id() is worse as most of these drivers take the result
>>> from that and immediately dereference it. Meaning if i2c_match_id() ever did
>>> failed to find a match, they would crash before this series. Luckily i2c_match_id()
>>> can't fail to find a match as far as I can tell, and so for the same reason
>>> neither can i2c_get_match_data(), which means if 0 is returned it is always
>>> because the chip ID was actually 0.
>>>
>>> At some point we should switch all the *_get_match_data() functions to
>>> return an error code and put the match if found as a argument pointer.
>>> Forcing everyone to changing the chip type to avoid 0 as done in
>>> ac0c26bae662 is the wrong way to fix an issue like that.
>>>
>>
>> That doesn't really answer my question. It does not explain why it was
>> necessary to change the chip ID base for other drivers from 0 to 1,
>> but not for the drivers in this series. I fail to see the difference,
>> and I have to assume that others looking into the code will have the
>> same problem.
>>
> 
> Just to follow up: I am not going to apply this series until I understand
> why the chip ID range had to be changed from 0.. to 1.. for other hardware
> monitoring drivers (lm25066, nct6775) but not for the drivers changed
> in this series. I have been telling people that chip IDs need to start
> with 1 if i2c_get_match_data() is used. I'll need understand when and
> why this is needed to be able to provide guidance to other developers.
> 

I was hoping one of those patch authors that made those 0->1 changes
would speak up (+Rob), I can't know what their thinking was, only
offer my best guess as I did above.

Andrew

> Guenter


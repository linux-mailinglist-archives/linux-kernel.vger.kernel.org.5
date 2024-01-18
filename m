Return-Path: <linux-kernel+bounces-30158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AD4831AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86F091F22A93
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF3F25559;
	Thu, 18 Jan 2024 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="UVDwdd11"
Received: from smtp91.iad3b.emailsrvr.com (smtp91.iad3b.emailsrvr.com [146.20.161.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211BF1E531
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705585043; cv=none; b=ad/CET2CwNqX9fxUu5P4TnNsaKJ0Xw4sMrOy19PBjTjuthMtzxg/BHi1kF0q7AbO+gm/SIdti8p6Stb8KkBLUD1ZYCBGCFK2Ywkp2YsfoE3M/15fEScPoLmbdJx9UBJoUd9eZHtPaScIuSgsG1NST38qhEbGyOmCEUoVjDlbHKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705585043; c=relaxed/simple;
	bh=mXbhgCRiRp5xRyUf9RHxphlLEbt4CPMBAZblbL0e3ms=;
	h=DKIM-Signature:X-Auth-ID:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Classification-ID; b=C79bZ2VIHpZaFc4veHRhMEwNF4VmHuRJNH/f1WIA4y4spcjvdp3v+hDs8n4tbWYyRAZgK6f9gF+t7eOQjLxhL0VT1DC1OBOu+7Ua4bZXryv+iwZKcre17IngDjrrXtQcE5CJvJCEMKYhrfcFkkp5IWsNTTMv1Z+Ys3A670idkeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=UVDwdd11; arc=none smtp.client-ip=146.20.161.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1705576280;
	bh=mXbhgCRiRp5xRyUf9RHxphlLEbt4CPMBAZblbL0e3ms=;
	h=Date:Subject:To:From:From;
	b=UVDwdd11HZBATTYkvTjJBkt2gDMiUA1xvCW/586+YsyRZZSLp3xWJeSt0YxD3PyLQ
	 /pg56IDpprZIpL765MIbg+U9zTntPcKPo2kyEdxCryUVGeTdzPubcAqp2GAvCoxFzA
	 7oJYyh4t2xbODpYvkoWgkLLJkgSMBPpebnpBzUVs=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp4.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 808D720071;
	Thu, 18 Jan 2024 06:11:19 -0500 (EST)
Message-ID: <ccb81bc5-3c5c-46df-9f52-d6b6de790e1e@mev.co.uk>
Date: Thu, 18 Jan 2024 11:11:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: drivers: ni_tio: Fix arithmetic expression
 overflow
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Denis Arefev <arefev@swemel.ru>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>,
 open list <linux-kernel@vger.kernel.org>, lvc-project@linuxtesting.org
References: <20240118073619.40538-1-arefev@swemel.ru>
 <2024011831-morphine-showroom-bc8f@gregkh>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <2024011831-morphine-showroom-bc8f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 337302d2-9ce4-4154-b6ec-dfafa35740e1-1-1

On 18/01/2024 09:32, Greg Kroah-Hartman wrote:
> On Thu, Jan 18, 2024 at 10:36:19AM +0300, Denis Arefev wrote:
>> The value of an arithmetic expression period_ns * 1000 is subject
>> to overflow due to a failure to cast operands to a larger data
>> type before performing arithmetic
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
>> Signed-off-by: Denis Arefev <arefev@swemel.ru>
>> ---
>>   drivers/comedi/drivers/ni_tio.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/comedi/drivers/ni_tio.c b/drivers/comedi/drivers/ni_tio.c
>> index da6826d77e60..acc914903c70 100644
>> --- a/drivers/comedi/drivers/ni_tio.c
>> +++ b/drivers/comedi/drivers/ni_tio.c
>> @@ -800,7 +800,7 @@ static int ni_tio_set_clock_src(struct ni_gpct *counter,
>>   				GI_PRESCALE_X2(counter_dev->variant) |
>>   				GI_PRESCALE_X8(counter_dev->variant), bits);
>>   	}
>> -	counter->clock_period_ps = period_ns * 1000;
>> +	counter->clock_period_ps = period_ns * 1000UL;
> 
> Can period_ns ever be "too big" to cause such an overflow?

The period_ns value comes from user-space and could be any unsigned int 
value.  It's used to let the driver know the period of an external clock 
source.

> And what commit id does this fix?

Fixes: 3e90b1c7ebe9 ("staging: comedi: ni_tio: tidy up 
ni_tio_set_clock_src() and helpers")
Cc: <stable@vger.kernel.org> # v5.15+

The first affected kernel version is v3.17.  This patch should apply 
cleanly to v5.13 onwards (when comedi was moved out of drivers/staging), 
but earlier stable/longterm kernels would require a backported patch.

@Denis, if you could add the above Fixes: and Cc: lines to a v2 patch, 
that would be great!

> 
> thanks,
> 
> greg k-h

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-



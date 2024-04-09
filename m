Return-Path: <linux-kernel+bounces-136608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF56E89D61D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644461F2440D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8FD85631;
	Tue,  9 Apr 2024 09:57:08 +0000 (UTC)
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A5F81727;
	Tue,  9 Apr 2024 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.14.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712656627; cv=none; b=nUiVB8sc7HwWO2Yeq3JzYs1HwOcRGXn3Kbm5KYo6RceJuhpLrDtLlh8/N1ryDlvEplNgEusz+J+gZDxBfvgAX70Jwynj1h23XA7RuCM7WD1qVr6DKq6BRjZYMI/67gOhcTjJjb/zwRJSHkWVgWt3H5FxUOQNvdieb+26YY5ItMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712656627; c=relaxed/simple;
	bh=Nev6clutsLuoZ3tdEcecuIJhvQs7KonqvYFmWzWrYno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VihqYpVVtyOTKtv89JMyGJ9oueK5rtViTVOibys4PaKQtK63OlwU42lmO6JAXju+nFqC/u4larHc9B9IAMwSusmuiNxBAsUdze98IMHSnXLsWT+qybV7Nisk59qJ3o1qTU3CCkJLhbyCNNu8rjAUWRUZ51rnOoeS6cdI0Go7SA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org; spf=pass smtp.mailfrom=gpxsee.org; arc=none smtp.client-ip=37.205.14.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpxsee.org
Received: from [192.168.4.14] (unknown [62.77.71.229])
	by mx.gpxsee.org (Postfix) with ESMTPSA id 4A437440C7;
	Tue,  9 Apr 2024 11:57:02 +0200 (CEST)
Message-ID: <36d9063f-0133-4a88-8120-f41e5fd85d89@gpxsee.org>
Date: Tue, 9 Apr 2024 11:57:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] media: mgb4: Fixed signal frame rate limit
 handling
To: Hans Verkuil <hverkuil@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Martin_T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
References: <20240322151005.3499-1-tumic@gpxsee.org>
 <20240322151005.3499-4-tumic@gpxsee.org>
 <8a0cf515-e450-41b8-950c-4356f2fb9879@xs4all.nl>
Content-Language: en-US
From: =?UTF-8?Q?Martin_T=C5=AFma?= <tumic@gpxsee.org>
In-Reply-To: <8a0cf515-e450-41b8-950c-4356f2fb9879@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08. 04. 24 12:47, Hans Verkuil wrote:

>> diff --git a/Documentation/admin-guide/media/mgb4.rst b/Documentation/admin-guide/media/mgb4.rst
>> index 2977f74d7e26..6fff886003e2 100644
>> --- a/Documentation/admin-guide/media/mgb4.rst
>> +++ b/Documentation/admin-guide/media/mgb4.rst
>> @@ -228,8 +228,12 @@ Common FPDL3/GMSL output parameters
>>       open.*
>>   
>>   **frame_rate** (RW):
>> -    Output video frame rate in frames per second. The default frame rate is
>> -    60Hz.
>> +    Output video signal frame rate limit in frames per second. Due to
>> +    the limited output pixel clock steps, the card can not always generate
>> +    a frame rate perfectly matching the value required by the connected display.
>> +    Using this parameter one can limit the frame rate by "crippling" the signal
>> +    so that the lines are not equal but the signal appears like having the exact
>> +    frame rate to the connected display. The default frame rate limit is 60Hz.
> 
> It's not clear what is meant with 'crippling'. Normally when dealing with video
> framerates the driver will pick the closest video timing to the requested framerate.
> It is understood that you can't always get the exact framerate, so drivers can
> make adjustments.
> 

By "crippling" I mean the signal is modified in a obscure way so that a 
frame has not all lines equal. The HW somehow (the exact way is not 
known to me, the documentation is very sparse on this - before my 
investigation it stated only "frames per second" which was very 
confusing and the reason this patch exists) modifies the last 
line(lines?) so that the overall clock ticks per frame is the desired 
value. Some blanking stuff (the porches?) you have set are not equal for 
all the frame lines.

What I'm trying to do is to change the original documentation which is 
definitely wrong (the users are confused how you can set the timings AND 
the frame rate with different values at the same time) without saying 
too much about the exact algorithm as it is not exactly known and may 
even slightly change in different FW versions.

Does that all make sense to you now?


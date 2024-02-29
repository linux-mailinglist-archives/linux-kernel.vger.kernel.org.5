Return-Path: <linux-kernel+bounces-87161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81EA86D074
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D4F28628D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DC36CC16;
	Thu, 29 Feb 2024 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RweJnD1J"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F75F4AECF;
	Thu, 29 Feb 2024 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227378; cv=none; b=S9gZ7Ep1cDG0Tx/TnRU4lfOtK4fQ6ePa3khDQjyM79uDaMHgSndJL1AqDxDoBtK+mZI+5LyDU+TTgpkV3g1TOwbcOZSK2q48pcHvNeKRElvEC7L9eyMfEiCjWIOKnnE3tUubVfzbCOS2q99TSuitLUOg3QPHv9V4a4go6LJUH98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227378; c=relaxed/simple;
	bh=SQbsvdu0cE2Ik/fBRCrlAO/Q4tea0oky+nUL5VmextQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iqGqCrn/yZgglGiPoWtWKni4LRfohsdh4044NrfpnLkP3Q8lyrr0ex1VkP0eYleM4sAQHyFnWDwrmdgMn0k8r+N1ssQ+QK0nNbHGGrttfa43NbqA/2ffYFCmoZEZ+otj5Zp8y9cBLZE5aqsdbX2Q4L/B7anCDrZvNaQsKOspEyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RweJnD1J; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33de6da5565so668084f8f.2;
        Thu, 29 Feb 2024 09:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709227375; x=1709832175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OklTFrhYXGCqleMpBHtH1y+bu7HTN31ZIOzM6nBjKdg=;
        b=RweJnD1JgCaRrIaDoaoT64ZJKOxS1ixNCshr+f/ufnIIZXdoymoSYx2f0kkthXC7ey
         LlqReKi9sfcv86flfnYo0btcyl8eUYe+MXwipCC8zUOHbUBlKiGZNsGI471zj3j0dFVF
         W4bLEexDQGszSScRAH7Yh7v7ngApVyrip9Wy8BRm3F1j+ZftUjZsfeMWOYLX/lG0M+hg
         Ha+b7INKQyLlup+TTkxRZc1OqH23wwrcjYwzkPYIUq2oVMJWm2hFJUq4lGcgAk16JclR
         N51SlEyeFnUfcYUB2y/KMuy/cSGbJ2+am3vEsQjtm0Q3SJDyRQZdk/SNnWueyQ7wSMO4
         iNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709227375; x=1709832175;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OklTFrhYXGCqleMpBHtH1y+bu7HTN31ZIOzM6nBjKdg=;
        b=UWxe1SAZlEzub26B0FOn8mCEOuOItvjlxV/NN4V28eAr67VleHttF8z70kaMyGjBUA
         4aMQr56GmZcy3ylpDRZ3ab1JKwOQ7Oo/Wt27nwvR+zsUXJoOl7HZLv0znxQ6X1+VylLX
         8AP7faoKU8jYpu6D1aAX1CiL2QpIAmY4kiFJXAPpWIkRJ8KMMH0s+xudDC6yU1ST+WK+
         peO8Xw8ivD/psLpTJV2ZZwvR6QcRdNxXuOA2F4nOiHWIoceJr78GJCMvtcbK22fUERGl
         33XGn7B4Y1NzkQwHacxNlGfYo1KCMflM03hIl1ja8RKoeX7KAUEIaK3eOQZ+czOCYwu3
         JMeA==
X-Forwarded-Encrypted: i=1; AJvYcCWw6/B9actMDJR80OaUfRPadOgx24srRm69CyGpjtDrNCeUs9w38iJXnrUNx5yh5Yo3A+bkQ3ud2lVLzTX6/F7rd90KJ8T0KqEPeFvia/ZAMIskoil84S7tgXAFHsiM2OxYg4q7KuLWR9JaB6mG
X-Gm-Message-State: AOJu0YzALQCbKmxB/JYVwD8oRwuEBHLzeOedrvvro76xwysquun2jeLZ
	jdF7paelGcWO9B1O7XB6IGBVHVJyo0rSJq3HUK4SI/ZNrPDZ97/A
X-Google-Smtp-Source: AGHT+IHWTt6rjRxOqBV5Im6+I/dsQJ6kYbTSypm3wfepuXBXRGFF9dZ2SpnW45gfNfDja78qG5JKHQ==
X-Received: by 2002:a05:6000:1e81:b0:33d:284a:401 with SMTP id dd1-20020a0560001e8100b0033d284a0401mr1674096wrb.68.1709227375232;
        Thu, 29 Feb 2024 09:22:55 -0800 (PST)
Received: from [192.168.0.101] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id bw1-20020a0560001f8100b0033db0c866f7sm2318693wrb.11.2024.02.29.09.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 09:22:54 -0800 (PST)
Message-ID: <5e705d83-871e-4403-a77f-ec197eefb7c4@gmail.com>
Date: Thu, 29 Feb 2024 17:22:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] f2fs: Fix two spelling mistakes in f2fs_zone_status
 array
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240229091449.105032-1-colin.i.king@gmail.com>
 <ZeC64dDr-nBGlsli@google.com>
From: "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <ZeC64dDr-nBGlsli@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/02/2024 17:12, Jaegeuk Kim wrote:
> Hi Colin,
> 
> Thank you for the fix. If you don't mind, can I integrate this fix
> into the original patch?

Sure. No problem.

Colin
> 
> Thanks,
> 
> On 02/29, Colin Ian King wrote:
>> The array f2fs_zone_status contains two spelling mistakes in
>> literal strings. Fix them.
>>
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>> ---
>>   fs/f2fs/segment.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index bdb27e4a604b..072c4355d3d3 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -4921,8 +4921,8 @@ static int sanity_check_curseg(struct f2fs_sb_info *sbi)
>>   const char *f2fs_zone_status[BLK_ZONE_COND_OFFLINE + 1] = {
>>   	[BLK_ZONE_COND_NOT_WP]		= "NOT_WP",
>>   	[BLK_ZONE_COND_EMPTY]		= "EMPTY",
>> -	[BLK_ZONE_COND_IMP_OPEN]	= "IMPLICITE_OPEN",
>> -	[BLK_ZONE_COND_EXP_OPEN]	= "EXPLICITE_OPEN",
>> +	[BLK_ZONE_COND_IMP_OPEN]	= "IMPLICIT_OPEN",
>> +	[BLK_ZONE_COND_EXP_OPEN]	= "EXPLICIT_OPEN",
>>   	[BLK_ZONE_COND_CLOSED]		= "CLOSED",
>>   	[BLK_ZONE_COND_READONLY]	= "READONLY",
>>   	[BLK_ZONE_COND_FULL]		= "FULL",
>> -- 
>> 2.39.2



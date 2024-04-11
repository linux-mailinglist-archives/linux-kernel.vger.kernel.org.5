Return-Path: <linux-kernel+bounces-141326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 912818A1CAF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0EA71C22AAA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1C71B75A6;
	Thu, 11 Apr 2024 16:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OZozFB0y"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7F1A38FC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853138; cv=none; b=A+lwzAC0CkT/G+CNEYrOU90pwFf1Eaz0fT3JQ+yXPuDX9TW/rPa7JTuzrMRL/9ms31LsfM0qWB4M2JRPtXGsbZCzZygKjYxYmjM5oKynVD+TskJSMlmUFDKOqpqbMAq+BeRpIm9ZWITiG474vnsT5u6dTFuXCfySkFsF/TlF7So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853138; c=relaxed/simple;
	bh=TXxB6kiWTqAInfPhaNCRZTdrQCMlHjJn5YTjVSLODLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XfhxgllWS7tbGkPFFLQhInbiNPSXDLHWOxda/0JpAu17aOpmewePJpzUomFT/ZIZpkPs+Hd+JC8e5wJN7XAMwWtFJDgIbQ4i7nQs9v9iF05k/RmvDKcpvskbfoPbkn5D/KAK7QLcnoGujF7RABOotMhwCvIHa1swjgCg1hQBoRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OZozFB0y; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so171416139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712853134; x=1713457934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oy7UYOl/fNFnTeFLniF5v2aTFzXlpEmr1JZ5cOgbrD4=;
        b=OZozFB0yDWiOPPpACsf8u5QGS2eL9Nf0b/2cq4aPJCuAu29cv9cFBC4x5II7tnmTy2
         viHaHL91jJSkUBJ8WJpjTtmSz4lGxXddD5cIPt/f9YVjUxbG1jIbAmLawMHQMsO5tq4g
         BqCdCwqC9TRa8yR1Oou1AfvHf1F1t14kROsXF5Aitz+xm+9lPHO+bPhf3P+vVy4omJG/
         6FxOnjlV144sSeZ3CNxP5PFae1R2Z66xHvVVTzUz1IAxShyl8H95JHWqXw9WYx5Sq/U+
         zal5qno5JI9RJQkTDeM+q1yakqp+wNvEUVHQMU2XRfcSXG76LE+EsuLru3eIX9b5j+kF
         MhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712853134; x=1713457934;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oy7UYOl/fNFnTeFLniF5v2aTFzXlpEmr1JZ5cOgbrD4=;
        b=Lajvj5xlQYAbjJtaBBM0X3ueD8/jMx4SR3g4NxY9Q9oZeQvYL43qArlDwjd4TBdiKz
         ev1YbXJ2hlT4h3kj+DlVkWtJNz/+f9E9HUJTT736MKIm5a/CvrYHqbvxa+9qnKiIPL3P
         dN4/knqZiTyiqyiNhInNyPRyZ3GpS/CiCffMC8f2kKaKm9GlPNgjpVyWtgf8Q4Ch0jo2
         W7x21R0f3GXvf1j8uN4n4OeL8RiH/WJqk27QfcQTAfT43jnPK+WmWg3LMx8yKMienziF
         GNLBBYA3UI7PTPZ/2KWiZpnerJ0FpHXN5lpiv0xMwnfh1CBlaDN5sUtEFd+3ml1N6X6b
         qyPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtABHdMWCe4ne9G/i7hQ5zDzISy9eucsqkre99yiVNMTNOyLgXkzGjGctLQaG0dNzoQyf9H8EVR5A+tiZEApbPWljcuIIT4MYaT00a
X-Gm-Message-State: AOJu0Yw+kZvJjHOBtAsKQ8VhXzdl8Za7ey4P3rTrqd/bq4VrpeCDafqS
	DK3w9Rm+5A+j4qPaBE0XMtvhiOhRgExSp3F7abUT7HUqt03XHG2k1AkoxhsMNfnjbQw/W1koOuJ
	c
X-Google-Smtp-Source: AGHT+IF7FnIFBdVgpJmIKF42aEt7swonFqyMyJf6euNzLNtg7mFozJPp8HnPzmLyt+gtTM9buj7GBQ==
X-Received: by 2002:a05:6e02:c8f:b0:36a:f9aa:5757 with SMTP id b15-20020a056e020c8f00b0036af9aa5757mr24038ile.2.1712853134561;
        Thu, 11 Apr 2024 09:32:14 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id dt3-20020a056e021fe300b00369fd0b4595sm458963ilb.59.2024.04.11.09.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 09:32:13 -0700 (PDT)
Message-ID: <813d33ec-a462-48a9-b2f3-d890969dca1b@kernel.dk>
Date: Thu, 11 Apr 2024 10:32:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] timerfd: convert to ->read_iter()
Content-Language: en-US
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <20240409152438.77960-1-axboe@kernel.dk>
 <20240409152438.77960-3-axboe@kernel.dk>
 <1a1c00fb-c83f-44e7-bc6a-cfe52d780c35@kernel.dk>
 <CGME20240411114048eucas1p21707a2d0bfb9c5a21f3e8aa76c0d82c1@eucas1p2.samsung.com>
 <528e184b-9cb1-40a7-b757-db11a852dd59@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <528e184b-9cb1-40a7-b757-db11a852dd59@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/24 5:40 AM, Marek Szyprowski wrote:
> Hi,
> 
> On 11.04.2024 00:27, Jens Axboe wrote:
>> On 4/9/24 9:22 AM, Jens Axboe wrote:
>>> @@ -312,8 +313,8 @@ static ssize_t timerfd_read(struct file *file, char __user *buf, size_t count,
>>>   		ctx->ticks = 0;
>>>   	}
>>>   	spin_unlock_irq(&ctx->wqh.lock);
>>> -	if (ticks)
>>> -		res = put_user(ticks, (u64 __user *) buf) ? -EFAULT: sizeof(ticks);
>>> +	if (ticks && !copy_to_iter_full(&ticks, sizeof(ticks), to))
>>> +		res = -EFAULT;
>>>   	return res;
>>>   }
>> Dumb thinko here, as that should be:
>>
>> if (ticks) {
>> 	res = copy_to_iter(&ticks, sizeof(ticks), to);
>> 	if (!res)
>> 		res = -EFAULT;
>> }
>>
>> I've updated my branch, just a heads-up. Odd how it passing testing,
>> guess I got stack lucky...
> 
> The old version got its way into today's linux-next and bisecting the 
> boot issues directed me here. There is nothing more to report, but I can 
> confirm that the above change indeed fixes the problems observed on 
> next-20240411.

Yeah sorry about that :(

> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks!

> I hope that tomorrow's linux-next will have the correct version of this 
> patch.

It should, the branches have been updated.

-- 
Jens Axboe



Return-Path: <linux-kernel+bounces-107129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 917F887F7E3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF85281A5A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E838E5102A;
	Tue, 19 Mar 2024 06:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhewyzF/"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E315450A73;
	Tue, 19 Mar 2024 06:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710831569; cv=none; b=bcyz3+oSd28yjZFgBxnSo9/CHhUyZ76mqf286kn6j2ULm16ShmBtXxRNedVSVDIUi3MPaKTIfg6Foq4zE0T5v+ExV+blpJDcddPj5INpMQH2S85Ydr3p5fh59NY4V67Q/qr5guZOCnsiaFuy3W7dyjo/6gso/RPT686k0vveM5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710831569; c=relaxed/simple;
	bh=AIm9eviEi3P0eyCT+yS25nZjVcga1ARn9xwEwLrT2z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGgE1beBt0R//zqp1sObchryM44rcjz0A6y3wLK8L2jA4wcLxXIV5/UtqZkNaQ4A5EF/9FvcndLKaEqddTm0emG7Dm/TY6yaEqHnx+frWcJ3KVATq558ikmCtCxe9KckCcU0oS/mDWzSxLcRNdITNOW0aCzt3xxl9M+bbib6ns0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhewyzF/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1df01161b39so25575245ad.3;
        Mon, 18 Mar 2024 23:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710831567; x=1711436367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sMcKfZi1xz5eaYp9NuQfLHyNEpRw2+4mgzvyh4Nj45M=;
        b=QhewyzF/Jn+Z1v9mHxuUMSfyzkvgXVoacIY2h4W0CuJgQ6tzh52oGHf3LgfGFCucsU
         o93cc+Zd6nAl2V8c0NB+2QF0vVYYnRL4mB8d3Nno81GkelyVM8J93FRugkcGs37+qkU6
         UPUQyqhLwmdvdDwWV6yapypvAtIOM4BNbQMkl+8/8h5oG1QZ9t+0PLl82Gwldb/ixIUV
         KTnhZBUD8JzJWeKAZ86DD9r2Cgb8x/vvoujmxKEYx2SnpKT2xzVf8kkxxsECV4hR9sa5
         ySMLjCtkFhp8QP711lBAfRjhwHx2S15ZsJMgcQdjMTNZMk2i3i5Ni1n4s3c6eYCjELer
         TqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710831567; x=1711436367;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sMcKfZi1xz5eaYp9NuQfLHyNEpRw2+4mgzvyh4Nj45M=;
        b=Qzl4WcSTmcxKG/6QZ/k9UoHfNsvG1cPtd5TQIYhW2qcrhuxxC25LrG4xatzGj3e2ok
         57srK5YYlnr7wycYXZmrxzWU+fYREFRfU8ZiGDSmmWaUjOsiLn0dOGvtbPxvOKutxfdx
         ZQA7WqDCw9Z7jLutkEyuj2K5dPjWxw96vQ9brcV6GGIA14KvIAZvznIlOfX7LOzLj/yS
         m0TAekZYnSrILLoeiQ8JoFkbK6VTHcv8lvYAm9AWHnwtkfejurflXnb4X7n00tnw5FQF
         UlIqoVoHDuxGt4LpdhEKw/SvuvOcO/oQH71OAnAdz9D6CL8p0RherxtVBp37wJMAiHBD
         Nthw==
X-Forwarded-Encrypted: i=1; AJvYcCXkmbqL4d9CENbHEMpnR6YOk//X+bfY3u7UWq8xljhwlbHyP8B2grbfQWPXUk/SxWKZtF90a8DiAHFW0jx/YLugBIeibUklt9OopsGXZwNHcE0WMKLX7AG7SVmaoYNHhUP3e8libctnyQT6RV/oDhlU1DOCI5g1g11ADM1ge6/G/qnhQn6apk54z0tg0SSbLgcsqnpj/uGZhp2BxUUXdftx6g==
X-Gm-Message-State: AOJu0Yzon5b7V8Z8s/NDyfZpZXxmMdEiwvb/4Ha3Bq3Bj89Eqj6BmNj4
	savS96a5NdnqFLM6HQ4qGOiXHsHT7Tiw8aSE1Zd1ijjITsYZn9w/
X-Google-Smtp-Source: AGHT+IEPaXPncig+2mfJueHot0LijD4BGVGO0GUG1oH2eSfMb7KVBv96LoNJAMJa6u8EF69x5xL/1g==
X-Received: by 2002:a17:903:230a:b0:1de:f6aa:c991 with SMTP id d10-20020a170903230a00b001def6aac991mr14909604plh.34.1710831567041;
        Mon, 18 Mar 2024 23:59:27 -0700 (PDT)
Received: from [172.16.116.58] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id u16-20020a170903125000b001dd8e1db1b1sm10509163plh.175.2024.03.18.23.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 23:59:26 -0700 (PDT)
Message-ID: <28a5e314-30ba-4fc4-9228-51adb63e7aaa@gmail.com>
Date: Tue, 19 Mar 2024 12:29:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] mikrobus: Add mikrobus driver
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-kernel@vger.kernel.org
Cc: jkridner@beagleboard.org, robertcnelson@beagleboard.org,
 Vaishnav M A <vaishnav@beagleboard.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jiri Slaby <jirislaby@kernel.org>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, greybus-dev@lists.linaro.org
References: <20240315184908.500352-1-ayushdevel1325@gmail.com>
 <20240315184908.500352-8-ayushdevel1325@gmail.com>
 <8799b216-57a7-451b-80a3-3d4ae9693e0b@linaro.org>
 <402d1296-0a0c-4f85-a096-be7993869f94@gmail.com>
 <81d55f10-c538-494f-8274-6ea8c4366ab2@linaro.org>
From: Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <81d55f10-c538-494f-8274-6ea8c4366ab2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/24 11:02, Krzysztof Kozlowski wrote:

> On 16/03/2024 14:06, Ayush Singh wrote:
>>   > Are you sure this fits in Linux coding style limit (not checkpatch
>> limit, but the limit expressed by Linux coding style)?
>>
>>
>> Well, I am just using clang-format with column width of 100 instead of
>> 80. The docs now say 80 is prefered rather than mandatory, so well I was
> So you introduce your own style? Then consider it mandatory...
>
>> using 100 since I prefer that. If 80 is necessary or would make review
>> easier than I can just switch to it.
> You do not choose your own coding style.
>
>>
>> I will remove serdev, pwm, clickID and send a new patch with the minimal
>> driver and better commit messages as suggested with Vaishnav. It is
>> important to have good support for mikroBUS boards without clickID as well.
> Best regards,
> Krzysztof
>

I mean after the whole discussion about 80 vs 100 column line limit a 
few years ago, and change in checkpatch behavior, I thought 100 was an 
acceptable column length in the kernel, but I guess was mistaken, and 80 
character is still mandatory? Not sure why there was a change in 
checkpatch and docs though.

Regardless, I have switched 80 in the next patch since it is mandatory, 
and I do not care as long as I can format using a formatter.


Ayush Singh



Return-Path: <linux-kernel+bounces-107108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89DE87F794
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B86D281C20
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA57554664;
	Tue, 19 Mar 2024 06:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrDxmQ5J"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA45D53E3B;
	Tue, 19 Mar 2024 06:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710830073; cv=none; b=iVBR0/IQp46w4aDtAH2qQil/sETLmn989C0bhNruqLK0tykAL3lmth4f3pUyaEUfCmEnvc1KCpob3OTBcO5G5k8fdmRNW4N6ujmOpdl5hvLt6LPJj+Nd/1f51oEQKXaslL3JdcSauD8IR4Aq8DM8xg17eqy0Wr6rnznn+O5AVZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710830073; c=relaxed/simple;
	bh=pRf8TvoYF8JNJ5Thdif3hhC2RUUwmwcP7kipJbjOdv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XeDJ/3MB43eRNwjGYgPmcItlt8H52PI87aB+7Im7Tel4oqctcFB6yc/dYbRfI29HXPqofkgBS+Mz3ncq6fYtKhEcUKTV1LG7+hpC9ld03g4VAyIXB1mBYEUuZnFFg3+yYgsQWTJYx0AIY/mzxRe0RRAF4RZQmDp4N7nvAJ1rw48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrDxmQ5J; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c38d76384cso707240b6e.2;
        Mon, 18 Mar 2024 23:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710830070; x=1711434870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6i7aoJ1vHA+2Toojra4EO+vaFmcLOGaxt4dt9iW58AU=;
        b=XrDxmQ5JYqZJ6izWvfhHfeyb69qoAtDh+4qSL7AsyAcgOFJkaUWvwQLaPZDTORHQIF
         MiLf3swp9x4gRM9tX7uhHA9YFsanyfkfxnNBy4GQTcOAQmZrtCIGpxrnr784lt5h5nPz
         X7NrW852brjeqNBqJaqdguCH7NjH4vP5Oa5TQhMNUAJIaD9lNchD5rzHvxWkjyzCafIU
         MbkOnSKMZlqQPkNUqKDAuUglsz4/FpgqJjPfg9ooRkBmHW1a0HZ2li1Q7R29J7blre7m
         l43ef1aiekLA80wW8HeBCay5opa4z4qAtth46J0sxluSYI89bsKjqva+ISuTO2f+vJ0b
         eq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710830070; x=1711434870;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6i7aoJ1vHA+2Toojra4EO+vaFmcLOGaxt4dt9iW58AU=;
        b=PVPKjKGCGH7T32i3kV4Csk5dsCJAqYdwWLIC8BHUYma8SA7HIjZIOes8ap4Fo01QYz
         PGSNSA8Uh9W6Pjp6qW2jdCa5L4kOUWDrYT0XF/vmrhG8/FRsR+3PpNf9LtxSQX7I4tRC
         HcLccX9zi4DGJz6ReQKhxkeeQOzb0CYgWcqelEMN2DavpRljC/+ez0pm2NiFJ+vvDI0x
         3fNblLgVSiTIGvg8O+auzUHGMXNfV78A53NzfkRELNIHn+DM7SunMRWKgs9s4Fmd4lJJ
         V6iIoN1tElH8P38FgcJb8uvaZf1Ip9WqyS27XfI2Anwf8tlfTNkGrpHpHpQv5sYFJx0R
         lzPg==
X-Forwarded-Encrypted: i=1; AJvYcCWJdzsZPJCs4c2x1DSogLkpiT5r7qhuYpM6NglO8MSGUmDoT/xjAlu/rR9tyi3jTN2TbiC3yTfVwojPXYn+wC2DJCqG0De+Ch6mxWiLsy4KRWTFXB7k96AVFfP1qqDyTZsiRfDp4MNqyo/p/uvdTtPg8OlmMAUKRzDdYbj4AF+5o0H5FQ==
X-Gm-Message-State: AOJu0YwhImvD8/8vVYm3is8BWkio2bE+u/vpGJCaJ05RCxf1suC3yTJT
	ehu/o59eoFSmZe186FDFmCpdIYu+0zA0bh5iRr9w+M///GkuKr7Q
X-Google-Smtp-Source: AGHT+IGuQNKk/56j6/1OgRfV+KuiHjrbg9qcyLSSf4NVGqlYs9w0eVzrJxbIdhfaTJLPhN/H3r/twA==
X-Received: by 2002:a05:6871:3403:b0:222:649a:a932 with SMTP id nh3-20020a056871340300b00222649aa932mr14307687oac.7.1710830069957;
        Mon, 18 Mar 2024 23:34:29 -0700 (PDT)
Received: from [172.16.116.58] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id p13-20020a62ab0d000000b006e53cc789c3sm8958908pff.107.2024.03.18.23.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 23:34:29 -0700 (PDT)
Message-ID: <3ed8c487-544b-4d72-b1e0-edb5baa8119b@gmail.com>
Date: Tue, 19 Mar 2024 12:04:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] dts: ti: k3-am625-beagleplay: Add mikroBUS
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: jkridner@beagleboard.org, robertcnelson@beagleboard.org,
 lorforlinux@beagleboard.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vaishnav M A <vaishnav.a@ti.com>, Mark Brown <broonie@kernel.org>,
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
 "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
 Vaishnav M A <vaishnav@beagleboard.org>
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
 <20240317193714.403132-6-ayushdevel1325@gmail.com>
 <889fb174-076c-44d1-9c6f-c3b967cd01ea@linaro.org>
From: Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <889fb174-076c-44d1-9c6f-c3b967cd01ea@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/19/24 11:29, Krzysztof Kozlowski wrote:
> On 17/03/2024 20:37, Ayush Singh wrote:
>> DONOTMERGE
> Why? Explain then the purpose of this patch.

Well, it was suggested to have DONOTMERGE by Vaishnav in the patches 
until dt bindings have been approved, since this patch touches different 
subsystems. Here is the full context from v3:

> The reasoning behind this is that these patches go in to separate  maintainer trees and without the bindings merged first the device tree changes cannot be validated, thus it is a usual practice to get the bindings and driver merged first and the device tree changes to go in the next cycle. Another alternative is you can point to your fork with  all the changes together.

>> this patch depends on patch 1
> How? I don't see any dependency.

I think it is not allowed to have code in device tree unless a 
corresponding dt-binding exists for the device. And thus every time the 
dt-binding changes, this patch also needs to change.So I thought it is 
dependent on patch 1.

>> Add mikroBUS connector support for Beagleplay.
>>
>> Co-developed-by: Vaishnav M A <vaishnav@beagleboard.org>
>> Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
>> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
>> ---
>>   .../arm64/boot/dts/ti/k3-am625-beagleplay.dts | 80 +++++++++++++++++--
>>   1 file changed, 72 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
>> index a34e0df2ab86..e1dce1b80153 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
>> @@ -29,6 +29,7 @@ aliases {
>>   		i2c3 = &main_i2c3;
>>   		i2c4 = &wkup_i2c0;
>>   		i2c5 = &mcu_i2c0;
>> +		mikrobus0 = &mikrobus0;
>>   		mmc0 = &sdhci0;
>>   		mmc1 = &sdhci1;
>>   		mmc2 = &sdhci2;
>> @@ -230,6 +231,38 @@ simple-audio-card,codec {
>>   		};
>>   	};
>>   
>
> Best regards,
> Krzysztof


Link: 
https://lore.kernel.org/lkml/CALudOK5v_uCUffxHGKS-jA-DKLNV7xwmKkxJwjHaMWWgDdPDqA@mail.gmail.com/ 
Patch v3


Ayush Singh



Return-Path: <linux-kernel+bounces-157774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056C88B1604
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A08B1C21D0B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB3D16131C;
	Wed, 24 Apr 2024 22:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="ksOCj8nx"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB30E15687F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 22:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713997048; cv=none; b=fDZh3AMT7pHV8msN4JpfhL0+vaaKmPfcvt4xECqvSPf+bs+sGGBSwZLR6OHF0R6owLSQTQUxabqTkX9uMUZcXGENrXJ+QmzpesZaKHb5BkwJgyzz8mKNh+9HHdbmtUZnlK2aqLxQk1POzFo1Mtn5OBFSA8BGrNlrsYAV38wbWyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713997048; c=relaxed/simple;
	bh=GE8/DfGkNpeccnn7ctlLW9aQh1xnvrJHQprFymjvhgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LlSle59Q+32/OmBerif1Y/4SzDcwd0CElPQmcwOJILl8TiJ+ZQ3i7Gfae5ndQU93affXEu8dco12Qvm3sTDeuVrwNKbHGWla9+nTM2HAqdIocxBzEnHGX2bXRzoNz5CLkiOIKcVZFcua+eJOdzcDXNcQNazmdF8qnrwVquZ6EpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=ksOCj8nx; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed0e9ccca1so411226b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713997046; x=1714601846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+87ElqgV6reNQU5hAVnWYAATmj8Ga4df6MNiPH7XWCI=;
        b=ksOCj8nxgMh9WDFWfBztYD0TKHOYXAL4Ify3uPzqCyEafbLVte2mV9AaMIg6du+v76
         FnTno9iMtu+jqqE4fU/DGh/NzPjWRfsQV39PPMnLIYzbZ9dDBB8thlCzosCw+IJnbL0N
         eNW5HtQc0Yj5hX1kLadNTBNN0vTSOlgref3EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713997046; x=1714601846;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+87ElqgV6reNQU5hAVnWYAATmj8Ga4df6MNiPH7XWCI=;
        b=giwjPATiNBkKNkcDNXXQilXL8LkE7pskkNKZEiJHLsTvFv0XLYNkwGOu+dk41YGgnB
         VoI2ggPnbReIWKLsB/c5P3oF6PXnYbLyjsPiCQtmnbPO/w7hgflhwCA0WbGWrzD6PV36
         Dj09aOVU4HWgj+e7HlGfxF+HY0UTqIVEyNdQV8+3ZFo0tEVgvbt6NA7N8vJtBPsX5UAG
         pMxU2BnHqxAGxPkp3xcqNtFijo567N72ZAXt0b/qYHMUuEuSMN8DIbGXPyMdGKytt2uG
         A6OCfLZJOPjfUFiMtpkqSYh1B74b5Z2bE6sODBZaT+zUOTN0uVV3tsQsVNHlMCntoWMq
         0+Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWq+K2Ewz0LPDzrcD3sLCMTVbFzq2ipmZ4vm3BfzfDzqj5rDPkSYUpyIqMeYP0xhOiPge4v1ClzZHBGlo6I/sv2VUcQ3JXCSHEBhBOj
X-Gm-Message-State: AOJu0Yxdqiym+8nGF/E3RJHsM2OgWj8+Un7+dk89bLT+eTld82HA0FJ+
	XVz3Xcj7IGnDUwRAPLskkdZyMtyQBQ/dHFlhLU/D2HrRnG+8EUfr/VolzbvHLw==
X-Google-Smtp-Source: AGHT+IF37PCqcFYIP47bLz+LqfAcHhY/dxAFdY0Det+52UZ3kWJyXu++W2djITgeCIx3Fs7wN+D7MA==
X-Received: by 2002:a05:6a21:1798:b0:1a9:c2da:f2ab with SMTP id nx24-20020a056a21179800b001a9c2daf2abmr3817988pzb.0.1713997046078;
        Wed, 24 Apr 2024 15:17:26 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id kv13-20020a17090328cd00b001e0a28f61d0sm12401265plb.70.2024.04.24.15.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 15:17:25 -0700 (PDT)
Message-ID: <aea85118-060a-4451-a1f1-d8e634f1aab7@penguintechs.org>
Date: Wed, 24 Apr 2024 15:17:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned
 by gpiod_get_optional()
Content-Language: en-US
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: quic_zijuhu <quic_zijuhu@quicinc.com>, Bartosz Golaszewski
 <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240422130036.31856-1-brgl@bgdev.pl>
 <99242a7c-53bf-4227-9623-7bc092f564b3@penguintechs.org>
 <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com>
 <b982b73d-0540-409c-a6e2-0e03ecb11715@penguintechs.org>
 <0381f39c-38ba-4a2b-915c-f14c5f911eb9@penguintechs.org>
 <CAMRc=MfnEct7ThQhCA3AoY7hxq8j1mmFLNNkK17+RSvJxs67XQ@mail.gmail.com>
 <2371f538-ec53-4037-b171-c62bf4e06eb1@penguintechs.org>
 <CACMJSeunUaj0cxLaN4MpFmX5vTOx_vnWjBN4Y2FavdQoQxFRkg@mail.gmail.com>
 <4c33304a-5dbc-450a-b874-e04ba9e93150@penguintechs.org>
 <CAMRc=MeDQFHX9r-sHNxqkfpi=LkHoRSL7i6dWokB-J+J03rBEg@mail.gmail.com>
 <93e15ecf-252f-4789-a23b-a28280f6aa84@quicinc.com>
 <e64b89b3-a8f5-44e7-ae7f-fc4298841f1c@penguintechs.org>
 <CACMJSet1wjEive0-Z=0_eiY7umBoSF_VX3QvVgiwqxhTSDZg6g@mail.gmail.com>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <CACMJSet1wjEive0-Z=0_eiY7umBoSF_VX3QvVgiwqxhTSDZg6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/24/24 6:53 AM, Bartosz Golaszewski wrote:
> On Wed, 24 Apr 2024 at 15:26, Wren Turkal <wt@penguintechs.org> wrote:
>>
>> On 4/24/24 6:12 AM, quic_zijuhu wrote:
>>> On 4/24/2024 8:27 PM, Bartosz Golaszewski wrote:
>>>> On Wed, Apr 24, 2024 at 2:24 PM Wren Turkal <wt@penguintechs.org> wrote:
>>>>>>>>
>>>>>>>> That's OK, we have the first part right. Let's now see if we can reuse
>>>>>>>> patch 2/2 from Zijun.
>>>>>>>
>>>>>>> I'm compiling it right now. Be back soon.
>>>>>>>
>>>>>>
>>>>>> Well I doubt it's correct as it removed Krzysztof's fix which looks
>>>>>> right. If I were to guess I'd say we need some mix of both.
>>>>>
>>>>> Patch 2/2 remove K's fix? I thought only 1/2 did that.
>>>>>
>>>>> To be specific, I have applied your patch and Zijun's 2/2 only.
>>>>>
>>>>
>>>> No, patch 1/2 from Zijun reverted my changes. Patch 2/2 removes
>>>> Krzysztof's changes and replaces them with a different if else. This
>>>> patch is a better alternative to Zijun's patch 1/2. For 2/2, I'll let
>>>> Krzysztof handle it.
>>>>
>>> do you really realize what do you talk about?
>>> do you really listen what do @Wren says?
>>>
>>> he says that my patch 2/2 is right based on several verification results.
>>
>> she, not he
>>
>>> BTW, my 2/2 fix don't have anything about DTS usage.
>>
>> I think the problem with your 2/2 patch is that it removes the
>> conditional bailing if the device is shutdown or not open.
>>
>> Maybe this patch instead?
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 2f7ae38d85eb..fcac44ae7898 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -2456,6 +2456,10 @@ static void qca_serdev_shutdown(struct device *dev)
>>                       !test_bit(HCI_RUNNING, &hdev->flags))
>>                           return;
>>
>> +               if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP,
>> &hdev->quirks) ||
>> +                   hci_dev_test_flag(hdev, HCI_SETUP))
>> +                       return;
>> +
>>                   serdev_device_write_flush(serdev);
>>                   ret = serdev_device_write_buf(serdev, ibs_wake_cmd,
>>                                                 sizeof(ibs_wake_cmd));
>>
>>> he maybe be a DTS expert but not BT from his present fix history for
>>> bluetooth system.
>>
>>
> 
> Did you test it? Does it work? If so, please consider sending it
> upstream for review.
> 
> You can keep Zijun's authorship but add your own SoB tag at the end
> and mention what you did. Something like this:
> 
> [Wren: kept Krzysztof's fix]
> Signed-off-by: Wren...
> 
> Bartosz

@Bartosz, I have tested this, and it works functionally for my setup. I 
cannot detect a difference between this and Zijun's logic when I compile 
a kernel with this patch.

@Zijun, I think you have objections to this patch. I would like to make 
sure I hear your concern. Can you please take through it like I'm a 5 
year old who barely knows C? In retrospect, I guess that I would be a 
pretty precocious 5 year old. LOL.

In all seriousness, @Zijun, I really appreciate the work you did on 
this. I would like to understand why you assert that removing the logic 
of Krzysztof is appropriate. Again, I am not a kernel developer, so this 
stuff is really outside my wheelhouse. Having said that, by my reading, 
which may very well be worng, it seems like you are just adding another 
case that is orthogonal to K's conditions. I'd like to truly understand 
you position to know if the patch I am suggesting is somehow harmful. 
This is an earnest question. I really want to respect your expertise 
here, and I really want you to know how much I appreciate your work.

wt
-- 
You're more amazing than you think!


Return-Path: <linux-kernel+bounces-157940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04E08B18F1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE08282EE5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CFB17578;
	Thu, 25 Apr 2024 02:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="Op3dc7LX"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A88171D2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 02:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714012500; cv=none; b=CFiLcin85uPy0/pbqq0AjIVVoIQG3iJVmDjWBSYJOy+PbOQS0uEDpbfiEDsuj3wsqX4J73qTop2dwe9nBme3ij+7ga87MoFFlBufLQEZPY2G3g54HJhZY9vt4wWvPLY5oY/mNWMRra8Sg/Sz8NteOrCSYvbmdt9AHZ1dkPpgVTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714012500; c=relaxed/simple;
	bh=CgBXfg5Mk5RbfPCdeDK02qZqwHHQ271f2kh/2Y1MC9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4d/wEinQfevkqbgF6JD4ahReyrAmQF4Lpoz4+cmLWgazkPL2OFfRRuXxZvCtlLRSlSXZi1P+0UraD0nWnn1SScofTZ/isKhygfp9nTOy1X6sCMDvkk5DsTw4rng2OtZbhEXecyQRfaU0lWouRAdJ5V/G2f32xJ1mztPjo76bSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=Op3dc7LX; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ed32341906so565494b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 19:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1714012497; x=1714617297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r3ernF+LASJT/mtGe/8C/gLwYdsREquYsjflSpJtU7A=;
        b=Op3dc7LX9Wyox9rCc8SHlsb51RpcaSvGpqd1oYHlfgiy2Fn9H8wSHYCTlP4wD9GJON
         +FdupfS/Q+2yzX+A5K9ByDvuR+/FKC6M9pqg9lHyzT9YawyInszklfrmUAQmc2qzuJt0
         QnTZYJYq2LcwNb/4cTjTygoY9D188KRi0hKv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714012497; x=1714617297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r3ernF+LASJT/mtGe/8C/gLwYdsREquYsjflSpJtU7A=;
        b=LrIFyeZhfrMn1CjwSpmfJk5vWIvr9STavcaKxNpQ2oLylXW+ICReYDTz5SF7IJ9M7f
         DBmm/5K3R2T0nL5oEDW+aUuiUjoXyLABiqPyQ2B1xLwuOcPCZT7GuTmRVgL6266Ijpce
         a80VDwO8OJnlfO+uRxPLTk4W7FFsDtJjLe+Oj4Bg8QrpzWym5/yXvDV5uy+h40qQ18wY
         V/I1tvb4TvPcCe1JuBAHozHwstMz49pPvA5InWbpDsiM6L+3talpU4/tUahSTOXD+kSc
         8J1P6Ac0cZVIrEoySOq8Z6lXooGALi5ur4l1YuvuJ9G4G5tqcm5wI9lbIscDJio2XuoR
         7u2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSPjQawOFUULW4FMg8lTlwtp84GFyBrjsFX7ya23CnA3b8FXgNb9sIZTuhTwNfkFs0wKtchLfPo4N78BZU2Jm4jeUgCpY2MdZcaPiH
X-Gm-Message-State: AOJu0YxJkXyvvIRm3jQVc+/bI3ch5D4qD4ivmXp+UhAAdDK4Az7IBCfx
	/LQ/sFInOaWpEG5sfs36/Sz19Iif+Doo17T2O+agCOvgT2j9u6X02rYW1tExmQ==
X-Google-Smtp-Source: AGHT+IEkctLKmrDqP8g15fGfAse0RyhjZ6yGuijuomsWfWxli16Q+jlhflJwQgPadhZvXTZuvtO3fg==
X-Received: by 2002:a05:6a00:815:b0:6ec:ebf4:439a with SMTP id m21-20020a056a00081500b006ecebf4439amr5277025pfk.5.1714012497455;
        Wed, 24 Apr 2024 19:34:57 -0700 (PDT)
Received: from [10.41.138.200] ([153.18.172.57])
        by smtp.gmail.com with ESMTPSA id q3-20020a056a00084300b006ecc6c1c67asm12092110pfk.215.2024.04.24.19.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 19:34:56 -0700 (PDT)
Message-ID: <ea3b68e6-b2b6-4ae3-b85f-9b45bdaba916@penguintechs.org>
Date: Wed, 24 Apr 2024 19:34:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned
 by gpiod_get_optional()
To: quic_zijuhu <quic_zijuhu@quicinc.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org,
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
 <aea85118-060a-4451-a1f1-d8e634f1aab7@penguintechs.org>
 <1d0878e0-d138-4de2-86b8-326ab9ebde3f@quicinc.com>
Content-Language: en-US
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <1d0878e0-d138-4de2-86b8-326ab9ebde3f@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/24/24 4:35 PM, quic_zijuhu wrote:
> On 4/25/2024 6:17 AM, Wren Turkal wrote:
>> On 4/24/24 6:53 AM, Bartosz Golaszewski wrote:
>>> On Wed, 24 Apr 2024 at 15:26, Wren Turkal <wt@penguintechs.org> wrote:
>>>>
>>>> On 4/24/24 6:12 AM, quic_zijuhu wrote:
>>>>> On 4/24/2024 8:27 PM, Bartosz Golaszewski wrote:
>>>>>> On Wed, Apr 24, 2024 at 2:24 PM Wren Turkal <wt@penguintechs.org>
>>>>>> wrote:
>>>>>>>>>>
>>>>>>>>>> That's OK, we have the first part right. Let's now see if we
>>>>>>>>>> can reuse
>>>>>>>>>> patch 2/2 from Zijun.
>>>>>>>>>
>>>>>>>>> I'm compiling it right now. Be back soon.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Well I doubt it's correct as it removed Krzysztof's fix which looks
>>>>>>>> right. If I were to guess I'd say we need some mix of both.
>>>>>>>
>>>>>>> Patch 2/2 remove K's fix? I thought only 1/2 did that.
>>>>>>>
>>>>>>> To be specific, I have applied your patch and Zijun's 2/2 only.
>>>>>>>
>>>>>>
>>>>>> No, patch 1/2 from Zijun reverted my changes. Patch 2/2 removes
>>>>>> Krzysztof's changes and replaces them with a different if else. This
>>>>>> patch is a better alternative to Zijun's patch 1/2. For 2/2, I'll let
>>>>>> Krzysztof handle it.
>>>>>>
>>>>> do you really realize what do you talk about?
>>>>> do you really listen what do @Wren says?
>>>>>
>>>>> he says that my patch 2/2 is right based on several verification
>>>>> results.
>>>>
>>>> she, not he
>>>>
>>>>> BTW, my 2/2 fix don't have anything about DTS usage.
>>>>
>>>> I think the problem with your 2/2 patch is that it removes the
>>>> conditional bailing if the device is shutdown or not open.
>>>>
>>>> Maybe this patch instead?
>>>>
>>>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>>>> index 2f7ae38d85eb..fcac44ae7898 100644
>>>> --- a/drivers/bluetooth/hci_qca.c
>>>> +++ b/drivers/bluetooth/hci_qca.c
>>>> @@ -2456,6 +2456,10 @@ static void qca_serdev_shutdown(struct device
>>>> *dev)
>>>>                        !test_bit(HCI_RUNNING, &hdev->flags))
>>>>                            return;
>>>>
>>>> +               if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP,
>>>> &hdev->quirks) ||
>>>> +                   hci_dev_test_flag(hdev, HCI_SETUP))
>>>> +                       return;
>>>> +
>>>>                    serdev_device_write_flush(serdev);
>>>>                    ret = serdev_device_write_buf(serdev, ibs_wake_cmd,
>>>>                                                  sizeof(ibs_wake_cmd));
>>>>
>>>>> he maybe be a DTS expert but not BT from his present fix history for
>>>>> bluetooth system.
>>>>
>>>>
>>>
>>> Did you test it? Does it work? If so, please consider sending it
>>> upstream for review.
>>>
>>> You can keep Zijun's authorship but add your own SoB tag at the end
>>> and mention what you did. Something like this:
>>>
> 
> [V7 2/2] as shown by below link is the formal fix.
> https://patchwork.kernel.org/project/bluetooth/patch/1713932807-19619-3-git-send-email-quic_zijuhu@quicinc.com/
> 
> this fix logic was introduced from the very beginning when i saw your
> issue description as shown by below link
> https://lore.kernel.org/all/1713095825-4954-3-git-send-email-quic_zijuhu@quicinc.com/#t

This is not quite fully correct. You did introduce that logic. However, 
you also removed the other conditional. That is what K.K. was objecting 
to. I literally copied your logic without deleting K.K.'s logic. My 
specific question is does that make my change incorrect in some way.

>>> [Wren: kept Krzysztof's fix]
>>> Signed-off-by: Wren...
>>>
>>> Bartosz
>>
>> @Bartosz, I have tested this, and it works functionally for my setup. I
>> cannot detect a difference between this and Zijun's logic when I compile
>> a kernel with this patch.
>>
>> @Zijun, I think you have objections to this patch. I would like to make
>> sure I hear your concern. Can you please take through it like I'm a 5
>> year old who barely knows C? In retrospect, I guess that I would be a
>> pretty precocious 5 year old. LOL.
>>
>> In all seriousness, @Zijun, I really appreciate the work you did on
>> this. I would like to understand why you assert that removing the logic
>> of Krzysztof is appropriate. Again, I am not a kernel developer, so this
>> stuff is really outside my wheelhouse. Having said that, by my reading,
>> which may very well be worng, it seems like you are just adding another
>> case that is orthogonal to K's conditions. I'd like to truly understand
>> you position to know if the patch I am suggesting is somehow harmful.
>> This is an earnest question. I really want to respect your expertise
>> here, and I really want you to know how much I appreciate your work.
>> you maybe see all replies of [2/2] patch for this issue within below
> link. i believe you will understand it. the bottom of the link includes
> all reply history.
> https://lore.kernel.org/all/fe1a0e3b-3408-4a33-90e9-d4ffcfc7a99b@quicinc.com/
I read through the discussion again.

Can you please define VSC? I'm not sure what that means.

With regard to your change's logic.

First a kernel dev newbie question, does "hci_dev_test_flag(hdev, 
HCI_SETUP)" test whether the hardware has ever been setup? The rest of 
my discussions assumes that is the case.

So, basically, the logic in your change is something like this:

if dev_must_be_setup_every_time_opened || dev_is_in_setup_state
     bail out on shutdown logic

If I am getting this correctly, you're saying that any device that must 
be setup is already by definition not needing setup and should not have 
shutdown logic run on it.

Okay, so question: Is it possible for a device to need setup (both not 
have the quirk and "hci_dev_test_flag(hdev, HCI_SETUP)" to have BT off 
or not be running?

Assuming the answer to that question is, "It is not possible." How do we 
know that? I think that may be what K.K. is saying is not obvious.

If the code ever gets into that state, shouldn't we at least log that 
the state is not an expected state?

I am now worried that allowing an unexpected state through could result 
in a unintended logic executing. How do I know I don't need to worry 
about that?

wt
-- 
You're more amazing than you think!


Return-Path: <linux-kernel+bounces-156953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFD88B0ACF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE511F2334A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D305415B99E;
	Wed, 24 Apr 2024 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="O2VAJ1BJ"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE5C15B56E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965201; cv=none; b=BOneZr1f+0/tiTipouI9+z5xxUXbXil9U3uD/iD6kfN8Gq9/w+ADGBCkPNfiTZVC6N5RwYcIUSqPDlcY2Sr8QsaLGPTMlJt4S1QmpXidAFye82/Qasoc3Irly8orgQosIZA+vBuNoyq7/qinywomFoGJSAQb53vc8j44DmncFa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965201; c=relaxed/simple;
	bh=upkiPFeY4gOlFNfrHS+s59WFRcN7Obi+CyjrknLF2IM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hcJLpzAHk5+54QcTtetyKlNindjr3VSe5Gm9TdzzQ95dWoQpjy3MBAGt+qh3+vTROg9nQa9n4j2nWgJAwTcwuingw6Th0TP84neszLFm9lEprBD8yHLq4+s381pqCXcoNIjMedUAwWIr2yudc6AfCNaFJ0V9zbdE6Mi3JVlTdwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=O2VAJ1BJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e3ff14f249so6799565ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713965199; x=1714569999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TSGXOI0VRPvW66ltK2Glv7t9yJa2xJky2rTsE+Vh6jw=;
        b=O2VAJ1BJ8RMBZCPugbzeJqZYwqxDYm+d6eNDsEr+qvsFc9GUN7PSeCpMLMclx1MpP6
         PJxTMPrFuca8qo6lrjXfZASPwm5Kilgy5EjRFrJ+Qt7YbQ7vqHwFYy43G/K9cYoG4sw9
         QC5Te/WSLJpAy4h27Z863SmDV3RTeyUYJMFis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713965199; x=1714569999;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSGXOI0VRPvW66ltK2Glv7t9yJa2xJky2rTsE+Vh6jw=;
        b=JdmADCdmUw6ng2cIZLXeuHX/mv7kJSo4i0sCidtMYZqh1FwsJtsjwjvK7Jme0DtGps
         1WpgwntNj5Bbd1P1YP5Lp1hQiUoGfKrbK0SsFppBhs09hqZvqiloezMqfhkxGGQ7HUXZ
         JF7jVpk+i7aGzlu9ytaK3on+/Az4FLeY7ZSgdqS+jF9tt5Qkghxgs3uVgGAGWXisR+RZ
         0w8k2v6C0W5uITKAbHbFiLOS7+dhaU6GcD40kHpNdIkpXp97G+6WNUf7zw7EyaiKFKRD
         QXjUMGNxMA7bXSq9Rj4ZETfVfLeO8d6rDA6bGPUvY8mCiBSm67OQrAico2JYobj5ragT
         SAjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjRObhvgDRzCh4xCxwyqzbCFgi7D6HYSWsrweJSEW1yLhbjqIZzDdMtnaawAgIGsIPQtsujdxOpSsdGyjCXwQZqmdx1OcQ9DyexPJU
X-Gm-Message-State: AOJu0Yyj5zVdOpevVcKp6pFLo8jLjs55koBvkTEy0EnAhZoai3yybmwI
	XqgidPKDMIYM3mXRN8HvULMv5AQlyMfA7cvGpMCvU2jnf8KdbcDaDF5RGX5B4A==
X-Google-Smtp-Source: AGHT+IFV1ZZVW8gQwGzT3tw14MF9IXRdLP9572VFmEjINdTk2wZUDLdpLpwGtGTTnbZaL2k74BPhbA==
X-Received: by 2002:a17:902:ea07:b0:1e0:c0b9:589e with SMTP id s7-20020a170902ea0700b001e0c0b9589emr8599237plg.25.1713965199171;
        Wed, 24 Apr 2024 06:26:39 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id a8-20020a170902ecc800b001e944fc9248sm7672099plh.194.2024.04.24.06.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 06:26:38 -0700 (PDT)
Message-ID: <e64b89b3-a8f5-44e7-ae7f-fc4298841f1c@penguintechs.org>
Date: Wed, 24 Apr 2024 06:26:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wren Turkal <wt@penguintechs.org>
Subject: Re: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned
 by gpiod_get_optional()
To: quic_zijuhu <quic_zijuhu@quicinc.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Marcel Holtmann <marcel@holtmann.org>,
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
Content-Language: en-US
In-Reply-To: <93e15ecf-252f-4789-a23b-a28280f6aa84@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/24/24 6:12 AM, quic_zijuhu wrote:
> On 4/24/2024 8:27 PM, Bartosz Golaszewski wrote:
>> On Wed, Apr 24, 2024 at 2:24 PM Wren Turkal <wt@penguintechs.org> wrote:
>>>>>>
>>>>>> That's OK, we have the first part right. Let's now see if we can reuse
>>>>>> patch 2/2 from Zijun.
>>>>>
>>>>> I'm compiling it right now. Be back soon.
>>>>>
>>>>
>>>> Well I doubt it's correct as it removed Krzysztof's fix which looks
>>>> right. If I were to guess I'd say we need some mix of both.
>>>
>>> Patch 2/2 remove K's fix? I thought only 1/2 did that.
>>>
>>> To be specific, I have applied your patch and Zijun's 2/2 only.
>>>
>>
>> No, patch 1/2 from Zijun reverted my changes. Patch 2/2 removes
>> Krzysztof's changes and replaces them with a different if else. This
>> patch is a better alternative to Zijun's patch 1/2. For 2/2, I'll let
>> Krzysztof handle it.
>>
> do you really realize what do you talk about?
> do you really listen what do @Wren says?
> 
> he says that my patch 2/2 is right based on several verification results.

she, not he

> BTW, my 2/2 fix don't have anything about DTS usage.

I think the problem with your 2/2 patch is that it removes the 
conditional bailing if the device is shutdown or not open.

Maybe this patch instead?

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 2f7ae38d85eb..fcac44ae7898 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2456,6 +2456,10 @@ static void qca_serdev_shutdown(struct device *dev)
                     !test_bit(HCI_RUNNING, &hdev->flags))
                         return;

+               if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, 
&hdev->quirks) ||
+                   hci_dev_test_flag(hdev, HCI_SETUP))
+                       return;
+
                 serdev_device_write_flush(serdev);
                 ret = serdev_device_write_buf(serdev, ibs_wake_cmd,
                                               sizeof(ibs_wake_cmd));

> he maybe be a DTS expert but not BT from his present fix history for
> bluetooth system.


-- 
You're more amazing than you think!


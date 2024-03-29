Return-Path: <linux-kernel+bounces-124290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD36F89151E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4B51C22132
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9D04A99C;
	Fri, 29 Mar 2024 08:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McOTllFQ"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EBA4F5E6;
	Fri, 29 Mar 2024 08:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711700461; cv=none; b=uDU4e6PFq+WbeNlNge5lIC7uQlTf7bN1jt3wI32GM82mRPYrSP2YyoV3zlUbW/tfE6VQiNcDSTJw5C1RYzW1JwKCgiydRYkjFdY2t08VzVj3aygy5GeM1j5WHzHRywOlFXycLZ5UTwmgiMuID1xyaVJ+ex5wsKUCKfuFlhHitlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711700461; c=relaxed/simple;
	bh=poB3GYiK3s4vTpd3sNI2EcQXWhWfyJmfEh2lhmTKKVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iCxaEoCBHxITf5hlMkma9q5EThrexDU7ZvrusScV4pJ39cmGXx8MAip6iF2xr6Af+wzvfsyHZsG9z5ILOoqM8BSdTyZNVClFhIcXVh8fKd/3yiQrGcRuliKQm8hPsrPprHlkqtTE9vgdhoo+WhVX97XmdJ4xzyngnmYOAvM8GYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McOTllFQ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d6ee81bc87so15972841fa.1;
        Fri, 29 Mar 2024 01:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711700458; x=1712305258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bKMfJF+33MfslrzqDI8Y93Z4dJtyyr9HeqUkZdA00xI=;
        b=McOTllFQz1qe4fTOj3SzRFIUKdX/ksNAugkdD6SzSRN1Yr6opw/rQHJZiE/d0+OoWB
         nwrQWvG8CQv3B53VHo986Zxrcfh/QU5jgnE1Uixmax8Y3LRgYe0cGhjA3ZH58K/xdFru
         BBeGzTOMahauMJ6luS0J7RpyMaBEZy1bEEuaVgs2949E64ISATXGvNSzaW5Wq8ZNhQQj
         VlziTzy1yvP7M+EBYW2asYDxW92MB2a5goLtGL912jixv9IilhvOZIEeUUIGOzzWeEKw
         VM8eS6t7bVXmK03+lBVtByg3LCN0xMMwshn6MHr4dsyGOI2cTtFJSPe807X/rg4pCxS+
         8dfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711700458; x=1712305258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bKMfJF+33MfslrzqDI8Y93Z4dJtyyr9HeqUkZdA00xI=;
        b=TePzJl47iREEmrhqiz1HG64J1JXkPThmUKspXWSOfAQDU0cByo70WPSXC+CpQoFOYw
         l+jtIMbqMoJe35oQpdBMmB2dC6zfMAtzbWP+IO1NT5hv+aISU7kNTM8CRlAY6L69TJ3T
         HOLdAGinXeANY/1AvR2ejG8ek3MyvD6GvhCgHb3TrSv02VXmGbbH7657VSztILqdk2Ut
         ZDUwGxZfioouMCGmNpA2PHK9vdQXxMQJ8FnMzwXDdGlIqmDL04mX1UC4KZs9NgiAgj91
         EcXOxmwGh8xceYhWY+y9x649gxIoQtncRNsdHfyypABbdUxraAU4OueLmYDkyBdGEwpZ
         Wimw==
X-Forwarded-Encrypted: i=1; AJvYcCVLFyfUoejjtP2YvhOYWz1d6tC5RCJU9OrtD8S4zVygRLh4p7TZFsBcNj7RKoaJv2Vilyk2v8jtAXkdSddR6EKw/KNo+F4AVBRWsF5t5z7NIwiKUcrliGNPJrpi7MC7dNQem0XIa4ekCZ/YfsN8cDI07g==
X-Gm-Message-State: AOJu0Yz3P6hhuXyA3jBNQltHrh888qvptfSDc4Bg8nMb4tBsiTrTLTSo
	/M9eEcEA9AEFjQRXd/nLnZkCgn61iqMUmNuC3PvKOMuNwO0ue1Nx
X-Google-Smtp-Source: AGHT+IFj4y0LM+XREESddz/IWd30+cWnfGRfidj2jse+o3VrCEQwP4+D0QjMB+BxyC173Lbvy91jtw==
X-Received: by 2002:a2e:a7c8:0:b0:2d4:77c0:d61c with SMTP id x8-20020a2ea7c8000000b002d477c0d61cmr973284ljp.35.1711700457942;
        Fri, 29 Mar 2024 01:20:57 -0700 (PDT)
Received: from [172.25.56.57] ([213.87.93.36])
        by smtp.gmail.com with ESMTPSA id s10-20020a05651c048a00b002d46863583bsm560173ljc.110.2024.03.29.01.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 01:20:57 -0700 (PDT)
Message-ID: <9c4cfaf8-7738-4ba8-951e-5b91a3414f37@gmail.com>
Date: Fri, 29 Mar 2024 11:20:49 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: panasonic-laptop: fix NULL dereference
To: Armin Wolf <W_Armin@gmx.de>, Kenneth Chan <kenneth.t.chan@gmail.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Len Brown <len.brown@intel.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Harald Welte <laforge@gnumonks.org>, Matthew Garrett <mjg@redhat.com>,
 Ivan Kapranov <i.kapranov@securitycode.ru>, lvc-project@linuxtesting.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240328103518.169604-1-korotkov.maxim.s@gmail.com>
 <da442a04-9db8-4951-98b4-3e149ea06415@gmx.de>
Content-Language: en-US
From: Maxim Korotkov <korotkov.maxim.s@gmail.com>
In-Reply-To: <da442a04-9db8-4951-98b4-3e149ea06415@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
On 29.03.2024 03:21, Armin Wolf wrote:
>> Added a pointer check to ensure that it is valid
>> before using it for pcc initialization.
> 
> Hi,
> 
> is this check even needed? I think the ACPI driver core takes care
> of passing a valid ACPI device pointer to acpi_pcc_hotkey_remove().
> 
> Thanks,
> Armin Wolf

I proceeded from the assumption that the current check was not redundant.
Kuppuswamy correctly noted in the message that the device would most 
likely be valid for the function of removal.

However, in my opinion, checking for NULL is a good coding practice, and 
has now been implemented incorrectly in this case.

Eliminating NULL checks could potentially cause bugs in this context.

Best regards, Max


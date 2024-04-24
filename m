Return-Path: <linux-kernel+bounces-156821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BB98B08AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45C0CB22AAA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9692315AD85;
	Wed, 24 Apr 2024 11:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="JIzU5i9A"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9223A15A4AF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959622; cv=none; b=KHyeeY91I/FsphhpI9W3JmJFtR7hAvY1TcouRlpmfnLjusaGvmbKtrPfueLw4+X4AdH96jvEis83RTZ+l36mqeErKJxQjECay8GjWnlQ73+9AmGxCRHt38wSrbaIYQxFPVcimULzRI8GpGLPO49aqhsjqoswntAb6cLSZ9TSSf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959622; c=relaxed/simple;
	bh=YFNLjOPodXIZAk7bSKe+D/OG5BR3XabtjXoCwBD0DHo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=try2zwvbVspZVV9bH3GCIqtYo7aCEmRP6jOk7Plvkho822p4AxJmckRsT/SAxpM4DHqS6Ad0TRwvLQL3CT18LNvnPErXCrk6dDvu1uFyv/cAuwvff/ws3cBkZwJpSzXc18gNozccpSO6eGm7an6Bf2wu5gb6b6EWOUTn97oNACg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=JIzU5i9A; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e411e339b8so51882245ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 04:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713959621; x=1714564421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rwZyaPs9McWxI87/vvTK6aImXsJSYDFPcH2DF29hD3I=;
        b=JIzU5i9AqvE2UFiCe/BMI90LQhaFv4cPOhisZIqA8DA/SDjAe+fWLFR8nUCPUBfdTc
         veqNxWIwEMs1aeKNKjCNOwGySahoZMdPvj2lH47y+34B6RGJLSd+cBC4CljO6wb3VWYZ
         Fn7boDc6jlp+2FgwcfrcNIP4cyIP9bcJ5GyGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713959621; x=1714564421;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rwZyaPs9McWxI87/vvTK6aImXsJSYDFPcH2DF29hD3I=;
        b=wJ1jaqGARY0hSMC1bfAEu1xKe9FmEezGOv4z0QhzQQQY7WBFgR4FPhWC+Pg+I4W/f0
         TyE4sSwz5uH4LPbOi5BIuMvD8pVcEBq5Ce5xZzWkr1SUnJYpdFFrZs8hqMp3hJaWF41+
         3bw2RTP2PFqSvZLgb9967mLC/twWu9M6jIHUyc5jrkSKlOeP9VitOZN+jWdgJ0lSKFr7
         0RsAdeInxMIaE39+TH3amYn4ST61+qfbK9aJAaRrTXMEALMzF67oZJaKZdauwhSZHpjz
         H4xMDPpyd58gf+lQJAJD9w57q8PHYaBZtgJ0w9nTo5tMnWPI8gcWq84Igp/WFd9MfLLN
         pzAw==
X-Forwarded-Encrypted: i=1; AJvYcCUFXsi3mrrO1HH5XdG+TSbHuU8KO2fA/4L1ibKKc5bmsRtmSoY4ea0nk8iWoRQqyuhzmWgwxjTmhUNuZgjzhBfAIJw0MyBXfBJGnlK/
X-Gm-Message-State: AOJu0Yy5HS9h4g8r7rukis242T6zqUmyh2Pv7tkk3o0yHlEfrcSDfl4Y
	wXyvdXuOpVle8jao3sO8jxFc2lgWEr+QKMYVFK9tsq5wlgsQ7FnlbEwGVOgqSw==
X-Google-Smtp-Source: AGHT+IH4Nko8GnerSuNDV2aT5ZF017QJoGS8ITlFNBiB8GCY9KXHTuzQmOI3EUDeaxltfqvtCMt5Ag==
X-Received: by 2002:a17:902:7445:b0:1ea:cc:b59e with SMTP id e5-20020a170902744500b001ea00ccb59emr2129527plt.19.1713959620624;
        Wed, 24 Apr 2024 04:53:40 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090322c100b001e503c555afsm6052038plg.97.2024.04.24.04.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 04:53:40 -0700 (PDT)
Message-ID: <0381f39c-38ba-4a2b-915c-f14c5f911eb9@penguintechs.org>
Date: Wed, 24 Apr 2024 04:53:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned
 by gpiod_get_optional()
From: Wren Turkal <wt@penguintechs.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Zijun Hu <quic_zijuhu@quicinc.com>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240422130036.31856-1-brgl@bgdev.pl>
 <99242a7c-53bf-4227-9623-7bc092f564b3@penguintechs.org>
 <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com>
 <b982b73d-0540-409c-a6e2-0e03ecb11715@penguintechs.org>
Content-Language: en-US
In-Reply-To: <b982b73d-0540-409c-a6e2-0e03ecb11715@penguintechs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/24 4:16 AM, Wren Turkal wrote:
> On 4/24/24 2:04 AM, Bartosz Golaszewski wrote:
>> On Wed, 24 Apr 2024 07:07:05 +0200, Wren Turkal<wt@penguintechs.org>  
>> said:
>>> On 4/22/24 6:00 AM, Bartosz Golaszewski wrote:
>>>> From: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>
>>>>
>>>> Any return value from gpiod_get_optional() other than a pointer to a
>>>> GPIO descriptor or a NULL-pointer is an error and the driver should
>>>> abort probing. That being said: commit 56d074d26c58 ("Bluetooth: 
>>>> hci_qca:
>>>> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
>>>> power_ctrl_enabled on NULL-pointer returned by
>>>> devm_gpiod_get_optional(). Restore this behavior but bail-out on 
>>>> errors.
>>> Nack. This patch does fixes neither the disable/re-enable problem nor
>>> the warm boot problem.
>>>
>>> Zijun replied to this patch also with what I think is the proper
>>> reasoning for why it doesn't fix my setup.
>>>
>> Indeed, I only addressed a single issue here and not the code under the
>> default: label of the switch case. Sorry.
>>
>> Could you give the following diff a try?
> 
> I had a feeling that was what was going on. I'll give the patch a shot.
> 
> wt

Considering this patch is basically equivalent to patch 1/2 from Zijun, 
I am not surprised that is works similarly. I.e. on a cold boot, I can 
disable/re-enable bluetooth as many time as I want.

However, since this patch doesn't include the quirk fix from Zijun's 
patchset (patch 2/2), bluetooth fails to work after a warm boot.

@Zijun, this patch looks more idiomatic when I look at the surrounding 
code than your patch 1/2. Notice how it doesn't use the "else if" 
construct. It does the NULL test separately after checking for errors.

-- 
You're more amazing than you think!


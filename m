Return-Path: <linux-kernel+bounces-40217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F70283DCA4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0071F2B434
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9BD1C693;
	Fri, 26 Jan 2024 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MIYqPVOw"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A45C1BDF8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706280261; cv=none; b=azjVs8ZnE7EAEzenBArdjHdkqCDASVLBIllnO4ewuftxdl70uslc6gYKJxhg3cxx/DN9YLJsgqyj1qeRHzYpyiJpekQZqqW879GSS+geFIXx4EeHNJKWNYhJz1gk8xrHkmA1lER5xklVy2n2v9BR/TzM5vG0681AnSGbvUfIDG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706280261; c=relaxed/simple;
	bh=hHQdoIZ7VlUib1GYkkvTIRWDHU7nvqtsSBGy7EHWP4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nOsvsR3VKXCg1AKJOInj7JtBRJzGSS3KHCt4GI+EFwM5BYQwc3oTtvx6s0hP6eL93cTe7UmnHxGtzhtDPTRbDrpaMO+X60p9p5XOhncBR6f5yshTGBGyWvGKpekJ3SMUNj5/AmoSL8mslLGy2YQYhM5venSd4/1XOTlMHMLWx1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MIYqPVOw; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5100cb238bcso822157e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 06:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706280258; x=1706885058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yhxsc3ZvfErMuA2OU77vZ9+Nmhmoa72VnFOALwS5xI8=;
        b=MIYqPVOwBOfw6wGCF1WQ/Uhf5DNW4twWxGKUU1ujUdHpxZm0COTqz2vq/WyptmRSQl
         fBX2WmuVaZ14qLCpfUc8/mdtc0Ax4GcMcW3sAiIoqu9iYNRouR8ejLCukEaJNhtFquh5
         8fdswamMmtg2ye8qOsYVzEZ5KwCPapvgIWVAjauJcFNqqCUEo2BkvexhK0ZOZaVBivjU
         de5M28j2cEt1+mC1WRscBFR2mZb3gHt1FNKEtrOtacU9zkf+Tr8eCrVFVimirayzyW4y
         vws1D5iolv1qTSfJmiBi+NL5MOhBVkKcTCq4IIfxLkwK6RbJm5T9LE2LdOvs+jhcaP2x
         eehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706280258; x=1706885058;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yhxsc3ZvfErMuA2OU77vZ9+Nmhmoa72VnFOALwS5xI8=;
        b=tk9kiVPw0l/MPnHXoPbeQh4MGjt8Q8QcCLZ/a6VohcMViHrd/Ce6hDSfmhbFSkIkx8
         9Ik6kqpDW3tTJlUb1hzfg2ezFXh/j3cJaJ3aWQiLYuNEo5aRP9TitMh7hdCdDdfPUV09
         nj1xG89AI1fEphNTWuHxfdpZqZ5QEwdy9ZOGom+VAzSUFHfV2lD+guSfFoNN7JwSlVDd
         EkFNRiCZ8W8EgLCJu7mwIu7JlR16hiiEYRb2YCbgOI26jWGrsZt92R+sA+mzoTq7+jQk
         7AneAyE+osSjpOOXs2tvPna9S4oTd5sNpX61+BFpfkeCcXMYTiHO5V3HwCuvfYL+ylPx
         d4ow==
X-Gm-Message-State: AOJu0YySn5e9EuIjDBU2+NQtZqmsvfQgchx5I7W8a0gxlvy5JXW7Eya7
	3FeBG9wDd3HyrVyCSKRaZ30uO2k8ryUkm5llWBZiZp6Ze4hAdH0eaUntOdhr/1w=
X-Google-Smtp-Source: AGHT+IFKqrHw6xFuQbufj1vF3RjQN0vds2se+NOi9nrQ7pyJBHf0QPpUwAwiLCzgQvx848vZALQBsg==
X-Received: by 2002:a05:651c:2107:b0:2cf:348c:776b with SMTP id a7-20020a05651c210700b002cf348c776bmr1005696ljq.67.1706280258073;
        Fri, 26 Jan 2024 06:44:18 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id t23-20020a056402241700b00558b0c513e0sm659888eda.61.2024.01.26.06.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 06:44:17 -0800 (PST)
Message-ID: <33e2fdb7-0de3-4840-988a-59d3d46810bc@linaro.org>
Date: Fri, 26 Jan 2024 15:44:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] ASoC: codecs: tx-macro: correct TX SMIC MUXn
 widgets on SM8350+
Content-Language: en-US
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Banajit Goswami <bgoswami@quicinc.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20240125153110.410295-1-krzysztof.kozlowski@linaro.org>
 <4d377c8e-8cef-4da3-9b25-fc91a7dc3d49@linaro.org>
 <518642ba-56e1-4648-a253-2a841a787ee0@linaro.org>
 <62b6b3d1-d54a-46ab-8400-c1f48238b1db@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <62b6b3d1-d54a-46ab-8400-c1f48238b1db@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/01/2024 15:42, Srinivas Kandagatla wrote:
> 
> 
> On 26/01/2024 13:23, Krzysztof Kozlowski wrote:
>> On 26/01/2024 14:21, Srinivas Kandagatla wrote:
>>>
>>>
>>> On 25/01/2024 15:31, Krzysztof Kozlowski wrote:
>>>> Hi,
>>>>
>>>> Changelog in individual patches.
>>>>
>>>> v1:
>>>> https://lore.kernel.org/all/20230717140138.201745-1-krzysztof.kozlowski@linaro.org/
>>>>
>>>
>>> Unfortunately this is breaking mic on X13s.
>>
>> Did you update also your mixer? I was asking last time about this as well...
> 
> Updating to new mixer setting fixes the issue.
> 
> This is going to be a issue with the existing ucm which becomes broken 
> with this new patches.
> 
> Are you going to send patches to fix the ucm too?

I could, but we should really think whether affecting sc8280xp is worth.
AFAIK, the microphones work there, so we do not need to fix them even
though fix is correct. It's the other platforms which need the fix.

Best regards,
Krzysztof



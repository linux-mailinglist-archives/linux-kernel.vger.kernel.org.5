Return-Path: <linux-kernel+bounces-40216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F179B83DC9C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308FB1C21C36
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B492B1CD1F;
	Fri, 26 Jan 2024 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JzY4UAQd"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626311D52A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706280170; cv=none; b=juCkq2ZQhkjBVVnpVmAoF7EGN0u8MZnAD/UuO9wPQkNiDPve/hD9w+pNG1w+/Bb66ce8FKRI55Xqe1/6DFvcL5/Wh/xMw/A6WhKnim3ugaSthml8sPGLnUwnQphq4o86leYuQw8SQ80xBXckKqtaKofbigTXZ5EYVbnvJhWFOCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706280170; c=relaxed/simple;
	bh=pZU5cerxpfnJuyuLwtQOHnp1b2colsTPucYdr9OgnOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Zzxei+2U6hvWYAC8lUu17T82z9vKYWGq7+Z9ocaUT0bZgKxmvORG8b+Fpx1uPSBve9YMBSzjO9X3OISjKD0XgErtlCfNYoqa9vcROl+V5PXs10GUKcKis2NwTqSG+gg/Zd1V61ZRg6Wo8GWIbvjXMELOuY6pwC8cv+Ixi/qlrYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JzY4UAQd; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55cec718c30so390075a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 06:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706280166; x=1706884966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P3kVk1oYE66zS3iDNGxJ8XOI7Kqo05wmoZaZQizgeiI=;
        b=JzY4UAQdH77uf0F+nmQ0UqGPQc0lkYUMC9/SpXjD9B2FzGXBkCoBtgHt9zsM1xTNuM
         R9FmW7IR3k2gK5lRdB+grfr+Hah58tzC79WiYxC/P+1WNyyWp4NqIZqKmsFJltfhuYQ7
         XaIoZ+d/qXASf/cFYndentcpByX8zaMt5oNiLK2Nghm4o9fQJJ+cgdhr5IYRK37d5AWl
         if3Y1dU5mYdb3OoJu+tDX8/z10krn1F9Apc5BfT8PTcGliUlFIAUWemdKBi7JF0O6zAE
         /hwnU35MQdLBVbwD+IFvgu/JVSPDpIs5X44GAdcXZMbHySvz1vm+vjyzZHPdTsNctFPw
         FW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706280166; x=1706884966;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P3kVk1oYE66zS3iDNGxJ8XOI7Kqo05wmoZaZQizgeiI=;
        b=SRIDw5+RM8Xf8QR00ZWsGz6I+yC5F3gFj6blLtqDbPdOvrHbkqFxmSBVKg5ra+r/MG
         ebch+IJsdwXKw6y0if4o3bXjGweTclgOylIojaroQE0cPaW/X8c62TSlfS8GPLnNbsVd
         6GXvoV/clrhXUo/SVYW3h4zEXAT0v1gLsjBkOi+x6RM897TV2gzy6kDQhRTuFqMMIIlW
         wlU09XDv5UGnKOenTAlkAdanidZdSwoWywPmpTWkQQyz+7q9dtNZj75CBDZ2SBkSpbcK
         jOkQURpnNWqwHeLgoqVU1bfTfK+9WA6e4S8k5rkfZs784qOOsV4xLMAimj1HE+oKRep5
         puSw==
X-Gm-Message-State: AOJu0YygoRpUDwyCp5GqBGjj7niY+DjZSwNYDNvZZ9OQGcynGQw8iO47
	bSq3tzRp0QgM6Lr84Qq+D85nQMaXr67Hnmlzz/6jYuEaVNCg5ltBv5w96t6qLGk=
X-Google-Smtp-Source: AGHT+IH+54VGVgQVbGjjMLZWU5u/Ibwj/BPMN7C7YtaQVLFrflo+VeSw6N8Q7m9ligrRRAGBgbzH9Q==
X-Received: by 2002:a05:6402:1bcd:b0:55c:fe2b:9973 with SMTP id ch13-20020a0564021bcd00b0055cfe2b9973mr970017edb.13.1706280166457;
        Fri, 26 Jan 2024 06:42:46 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ij13-20020a056402158d00b0055a451463c5sm655015edb.58.2024.01.26.06.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 06:42:45 -0800 (PST)
Message-ID: <62b6b3d1-d54a-46ab-8400-c1f48238b1db@linaro.org>
Date: Fri, 26 Jan 2024 14:42:45 +0000
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
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Banajit Goswami <bgoswami@quicinc.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20240125153110.410295-1-krzysztof.kozlowski@linaro.org>
 <4d377c8e-8cef-4da3-9b25-fc91a7dc3d49@linaro.org>
 <518642ba-56e1-4648-a253-2a841a787ee0@linaro.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <518642ba-56e1-4648-a253-2a841a787ee0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/01/2024 13:23, Krzysztof Kozlowski wrote:
> On 26/01/2024 14:21, Srinivas Kandagatla wrote:
>>
>>
>> On 25/01/2024 15:31, Krzysztof Kozlowski wrote:
>>> Hi,
>>>
>>> Changelog in individual patches.
>>>
>>> v1:
>>> https://lore.kernel.org/all/20230717140138.201745-1-krzysztof.kozlowski@linaro.org/
>>>
>>
>> Unfortunately this is breaking mic on X13s.
> 
> Did you update also your mixer? I was asking last time about this as well...

Updating to new mixer setting fixes the issue.

This is going to be a issue with the existing ucm which becomes broken 
with this new patches.

Are you going to send patches to fix the ucm too?


--srini
> 
> Best regards,
> Krzysztof
> 


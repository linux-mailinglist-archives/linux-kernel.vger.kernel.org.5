Return-Path: <linux-kernel+bounces-94267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9716B873C3A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A2A1C23BD4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D31B137775;
	Wed,  6 Mar 2024 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jj1RDJb9"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0052D1369B6
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709742464; cv=none; b=KgMujUFb8yLT6kbCT40BfqCqPnXT5pcwsy2ouWns3KP+0qI1l3BISLZNaMYD7wPmboOEhR3OGRhd1oAg1xDPfjuNZ+nZGvZeQ+Zi36DUCmWPpEcRNrxfTkeQpiXFJdWa/jrbnkuarjHU9YLcX2ax64oqWtOu1EGl/ub3NnffQGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709742464; c=relaxed/simple;
	bh=yEXFKs84hTr0UyD4ojePo0Svlb29UBTd8UFd7uJjn1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aENqXYz1fHoe3F3JuIflWcygNGF9sJgDOJSix/3dIua5+DE+lqevwBzJAiRO3mVdlPzb3mHr2WiU7bzjLbpj03fLulgwZ44q339VRy5WGtabjsnb/DzQePFeFOKJQZywxc5VRp55uE6zY4sTtIb8ZFTZdikWYI2IMsG3TWXZU/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jj1RDJb9; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5135ab96dcbso1262348e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 08:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709742461; x=1710347261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tAZMCH8J07QiijNq8o/NNBXhy5JhnjDlTuZhK1cgvds=;
        b=Jj1RDJb9ClKBaKQm/HIvqaNeCwKFo1gfELy63XVtFcQYczE46C8WAGHDSpsK/VhBjX
         YMpCF+O6j8Ytq8AFirexXjIu2d9eA2Xj2id67kkJpsWozTQnifW08oFNQuwOYEHlMVS1
         WCz5BseurrMKngRZ7i5Q+bpDLztOrkw1Kkguhn//8ZudRuLzq9HYco01y47h/AnwZ2QA
         uv1LtWmTuHGuxmkV1Ww4xmbL2x7Ny0FWJVZf0H5/mJRBmLGyWyg9UsGTTaqsdOy4utdT
         W5w31ctIEQgIlrvjEiSXnpKdvtkYMTR1acepcPKXAD5lyRexJriosAf6mpN4kr5NeBBV
         5DDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709742461; x=1710347261;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tAZMCH8J07QiijNq8o/NNBXhy5JhnjDlTuZhK1cgvds=;
        b=cXM5taF5209ZKA9k8HEBtBPPsywSdHJN3u6DmBi+0W8wh8RDBYajxbJgpEmNJIuOny
         2FLouPmLr4b70o3IRdXJNqn3XK1k9AbpoUfdL2iW35zVdzI/TaEaFrA7Q+HhB6zFE4Xh
         tm7J0w29KE+Cca0R+QQRGl00C4Rg05HaF0TBlxYhpjkpTAQpin3Pzp3NzCvPc8FSAfbU
         //d4QZKnlJxwGcXQv7AmX54XByLPiYJ58ItAyGNb1Eo5RoUnZg74iWcoFV4Rwr/iWWh2
         r6KGFHQU/tEW0Cp19pdIqP0HRFgLuS8w+vJFVubTDSGQJ1ziH3vUNahwczaKxcDggt4l
         wIfA==
X-Forwarded-Encrypted: i=1; AJvYcCXe61khKIajBSYcG04Wl9YJw3+hPlyc+Fle18BtNc+ycGLBzWTcf9ht0gS8WN28Z9W02p0ard3Ws0yWvHIIpd1/4ulNqhfuYnJETxEE
X-Gm-Message-State: AOJu0Yy1mAcArkUqJh5kPNWivckMIkpmeo9y7PeoOqYfWt0OFCK9OFoY
	qh4IOIi7eRGPdN6YBIzxiUsGSe4SSnK5tW45qWnGnKIMdqmXoG0g55Qr+BxHMyc=
X-Google-Smtp-Source: AGHT+IHFSt5jWo2bCyn5EXHjWo85KHHEtu2g3w+sAhUaXX7yL60kB98Uk0rzf0XF8spju2KcgjvxlQ==
X-Received: by 2002:a05:6512:ba5:b0:513:5bbe:7b29 with SMTP id b37-20020a0565120ba500b005135bbe7b29mr1708191lfv.1.1709742461054;
        Wed, 06 Mar 2024 08:27:41 -0800 (PST)
Received: from [87.246.221.128] (netpanel-87-246-221-128.pol.akademiki.lublin.pl. [87.246.221.128])
        by smtp.gmail.com with ESMTPSA id u25-20020a196a19000000b00513588ac414sm561395lfu.161.2024.03.06.08.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 08:27:40 -0800 (PST)
Message-ID: <19176685-898b-4aeb-b819-fec54a126233@linaro.org>
Date: Wed, 6 Mar 2024 17:27:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] spi: spi-qpic: Add qpic spi nand driver support
Content-Language: en-US
To: Md Sadre Alam <quic_mdalam@quicinc.com>, andersson@kernel.org,
 broonie@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, manivannan.sadhasivam@linaro.org,
 linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
 <20240215134856.1313239-4-quic_mdalam@quicinc.com>
 <d1c80d3f-3b70-4630-8f7d-b00983b487dd@linaro.org>
 <f5177fad-214f-1b60-46ba-1dc0a4fb059e@quicinc.com>
 <3e544d37-b1d2-9c58-3130-9e6950430671@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <3e544d37-b1d2-9c58-3130-9e6950430671@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/6/24 07:01, Md Sadre Alam wrote:
> Konrad,
> 
> On 2/20/2024 5:44 PM, Md Sadre Alam wrote:
>>>> +    ecc_cfg->cfg0 = (cwperpage - 1) << CW_PER_PAGE
>>>> +                | ecc_cfg->cw_data << UD_SIZE_BYTES
>>>> +                | 1 << DISABLE_STATUS_AFTER_WRITE
>>>> +                | 3 << NUM_ADDR_CYCLES
>>>> +                | ecc_cfg->ecc_bytes_hw << ECC_PARITY_SIZE_BYTES_RS
>>>> +                | 0 << STATUS_BFR_READ
>>>> +                | 1 << SET_RD_MODE_AFTER_STATUS
>>>> +                | ecc_cfg->spare_bytes << SPARE_SIZE_BYTES;
>>>
>>> Let me introduce you to FIELD_PREP/GET and GENMASK().. Many assignments
>>> in this file could use these.
>>
>>   Ok
> 
> While doing the change i realized that it will impact raw nand driver as well.
> Shall I post this change as separate patch. Is this ok? Please let me know.

One patch per file/topic, yes, please

Konrad


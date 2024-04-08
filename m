Return-Path: <linux-kernel+bounces-135129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCBE89BB73
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C544E1F23037
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D52847F4A;
	Mon,  8 Apr 2024 09:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p+HA3Y1u"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F75C47794
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567821; cv=none; b=AZyBqEQQ6uqySYnA2C5Kpi8VkR83gZut5/DP3/nBCR6OpqD3aTjD8wVguwF7ln1wq/Ojz1LvAeGKaq/Ohc8T5noZJHjG1XRrAAAm6TYG+UdcfzTWOnodi9sLzDw43gF3QdiWBERlBNpVlv94K1IhzAgkEihTVC2ctsJvFjy+5qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567821; c=relaxed/simple;
	bh=ydZJw7d35Ff9MPe3LKMKV9TaBpQgVGBrz9NBba+U30U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rFw1KOzXA7pDJLOYiq139SfkMoBnFbm0rFw8bAJgVR6XpNJiJXOudJLyryXc5q4dXMAdGzwr3a6W8G7LPl2BnBOlgvJn3JE58hoWyk4dG/7bhF4Lp8nOlXPVPPN8hAp2+znxG+QI6XA61ldqBYIwB5FsA2rrbvrgssK2fpxdGO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p+HA3Y1u; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-343f8fc5c69so1460311f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 02:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712567818; x=1713172618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kyn/nAbJTaoSC8qDBWXGUmDfOwA1IOLpAo8aFHObHYE=;
        b=p+HA3Y1uGsNot0aTz+OdufmZB4YkQPySa3c4TJFx0rmI4E2PAgDSotgYw5J6nv8Ka5
         pBC5b71Kpdu+DBeBhta0Akk3N4lmR296RQViEfKenMNtNEnCefGlX7Zm2jrL1/eG9X25
         UMQubMkIoTEFnuxrNUMDjw6sBE7DvZyHRM+8zqMM8Mgdkuiktf+7+FFHiXVWgY1LmlBh
         BsHJQKV1P0v5ma4qeKi9cmdcCTRUMMbIo1GNOsR7I8bAN9PbHOE/GdaUHRu1UE7URovu
         CV2TQeyg3iQn14kN9A3T1sSwPHENxKnjxiCFR5aqXpmagGmxzqdNOAqKZG5pvIQTLOFV
         g8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712567818; x=1713172618;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kyn/nAbJTaoSC8qDBWXGUmDfOwA1IOLpAo8aFHObHYE=;
        b=sb2JceboEA9XXsY4PiHum7vRqysxmzvM84bEGdYPLeIrTRdtE6gOMfr9Vb5ZD+pKDI
         25A96Ldv1QWtOyPpjvaFvplmvbUbzO/Z8uUVn9qclkYiyuYZnm+T+LL1mhKoEti6Zx89
         /3FbgnH+Jst3c/JmO0bXnpguSlOjR9G8tJc/YFbtl4eRK91QSzG8lSSAG3MCg+GuPmq9
         mvjuqVJw59cUunOkcLK1oQVQ8BgaFvY+Uh3/oBYWMT+tVgGHGWTULjv+HmjCEM3w7sr/
         oXbtm36zyGxtxjALNes6XNn874nXaDGvdjp+edV1KdkQ2YZRIU+wf12UrysFeqxlgOQR
         dupw==
X-Forwarded-Encrypted: i=1; AJvYcCUcNzCPsV+Dg1RmzlLwGUkuSx/tXZkjlopq3dwgb0iUkHifQbDdRo6U5xBEdp5jn77jZ2cIE4d22RSBT0fXRnT6dA+bzk6erL4UQpsb
X-Gm-Message-State: AOJu0YzF5hp/CZES3ojQqJO1SPho60wThXqJNiqnY7QvitnLqTufxPwp
	a02MQD14UQjOk/m6o1EFp44b1Km274PQTEyTBEBWik5kBNsS/sRIwCERvMXUYqk=
X-Google-Smtp-Source: AGHT+IFbW+GZvWtDNwC+hUfv0CeQti5p0/4Lt39sOJliVc7683eESlFh87O+IacxG6iRBQDyz+nk9A==
X-Received: by 2002:adf:f28e:0:b0:33e:3bf3:a097 with SMTP id k14-20020adff28e000000b0033e3bf3a097mr5598241wro.26.1712567818504;
        Mon, 08 Apr 2024 02:16:58 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id q8-20020adfea08000000b00341c6440c36sm8586391wrm.74.2024.04.08.02.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 02:16:58 -0700 (PDT)
Message-ID: <499dc405-a292-44c2-860f-db78ad7becc8@linaro.org>
Date: Mon, 8 Apr 2024 10:16:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v3 0/2] Add support for QCM6490 and QCS6490
To: Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com
References: <20240408042331.403103-1-quic_mohs@quicinc.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240408042331.403103-1-quic_mohs@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/04/2024 05:23, Mohammad Rafi Shaik wrote:
> This patchset adds support for sound card on Qualcomm QCM6490 IDP and
> QCS6490 RB3Gen2 boards.
> 
> Changes since v2:
> 	- Modify qcm6490 compatible name as qcm6490-idp. Suggested by Dmitry
> 
> Changes since v1:
> 	- Use existing sc8280xp machine driver instead of separate driver.
> 	- Modify qcs6490 compatible name as qcs6490-rb3gen2.
> 
> Mohammad Rafi Shaik (2):
>    ASoC: dt-bindings: qcom,sm8250: Add QCM6490 snd QCS6490 sound card
>    ASoC: qcom: sc8280xp: Add support for QCM6490 and QCS6490
> 

LGTM,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini
>   Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 2 ++
>   sound/soc/qcom/sc8280xp.c                                | 2 ++
>   2 files changed, 4 insertions(+)
> 


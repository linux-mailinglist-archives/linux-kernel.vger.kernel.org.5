Return-Path: <linux-kernel+bounces-155510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D96F8AF35D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392741F23C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5327913CA80;
	Tue, 23 Apr 2024 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iee/kygf"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD8D13BC30
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888001; cv=none; b=UxxSxIyuBnwbO/9BXD2HpNhC/tUsMJbnnX5lS8ucDcsNjlPj7KOw0KMu+W9Cr8eZwi3O69rutKtqu01DRpfYSiudiDF3FT9PTK6PoQeQuSvP2EkJpQBSsDkJMnpFiecqjPDYh+YUChoz0tt4ys8HkD23Ch2Mo1fbykDR29rAOu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888001; c=relaxed/simple;
	bh=3Qvx6ZIZdmr8NJplnmb0hbaXLf/X2TLHnkAAFtsM10Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dAgmyfN+a4NVxhZE5/vRfBYM3LYCY9oXPtl3bgw68ap80d2ZhOLliD8zw9NLELgzq5mEZ9O9Fso+NC+PgN3K7az0Iu6o2C7N1w3t2pE8UQsG2THYQ/Qe2s/24zXCMHRiuNO8ApNkQk94LVhFnvjwJmYWz/Hs4u61OZMtioDHwxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iee/kygf; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2dd19c29c41so41003691fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713887998; x=1714492798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GVOk/dzku39M7HZHzSD7vBdGj96SEMQyCyLR6xoJWus=;
        b=iee/kygfyTuwV4J94M8DvDxkYAE0+K0Q+y1xJz3HmCoosUQEc1OZKeQASYlS2U5dqQ
         H6aE9uIi78OzPH3/NixGduYCfY2Z2SaTUPt47HHE9shMCwexVnWz9tFEHJG8kysZOSeZ
         OUejiiMeP/V3/TPFruMP9JajHMBcCrRSZzCabW3n8NBbufkq2cNoPCrGeVUTBF2l5xib
         F7KjsHfXgJNWBDQvkBlL1oy5BrvS4Vdoab5MbHl7f67/nSosQYbBd0V0jMvvOaX5b6z/
         pZ+ZUOhf/hn2BSc9MempxcWQO5xjZlw5pPXpd/Tq3X5AlV63nLkFw5evk9r08tZwmyew
         hcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713887998; x=1714492798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVOk/dzku39M7HZHzSD7vBdGj96SEMQyCyLR6xoJWus=;
        b=SKSab0WZuxdewy1lubPIZqszQRIa4wojScWxQ8KourICwaXwN1vElukwIn0uYrnDPd
         zyF1BK3IUDk2qiQtc5szpvFc03+//eJ2IliAUOiDSWmlB/eG00n6oUOYa3+OD/qwbfLO
         NOS1Z6VtH0JQUaHZ+tRrYRGHAmMkfx4uZK4miW/hoKgaO+x9i0hCeBldRoVSHlyA4SaM
         FbSNgHD0GCsCgRfNZX7kWsEMLN6lWgVZrAqREFZBt/1j354Nj6h5Wz7DU8RQ4rIxbZ2l
         izRbcbzGA2LieykqDUX2jRfFXDp4yvd2iRS/icfWSWUoWLaHPKu4JWsFRIdcAfVF3DW0
         HibA==
X-Forwarded-Encrypted: i=1; AJvYcCUaMWHQGxnfb9qQW1ZhmDgfbVVeK8VeyRrFJpf0kLov3ab1TNoGSOeUBPbbRQRZO7J1VB240MePjPA6LkmAf/fLavdpLlGVbKefRux/
X-Gm-Message-State: AOJu0YzdwfoNW3YHgvAn87Kowko42220UJroxn8+bpUcPwb+8ioy7RMg
	x8qQQZXj1sOh1UVGg/tvTpmZ6W7xKf7fIaEQAxWt80nQVTd85AOuefz7QK376iA=
X-Google-Smtp-Source: AGHT+IE7rfyobENugLknJtFA4JtMXmdI87sZdOD2xUpd2VfgYAUPzUpKbTcfy6qEYe07Zp9bNAsYCg==
X-Received: by 2002:a05:651c:1682:b0:2dc:bd10:2944 with SMTP id bd2-20020a05651c168200b002dcbd102944mr7462872ljb.53.1713887997962;
        Tue, 23 Apr 2024 08:59:57 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id bi8-20020a05600c3d8800b0041a9c441f69sm4188267wmb.16.2024.04.23.08.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 08:59:57 -0700 (PDT)
Message-ID: <fc3d849d-3a7e-439a-8d71-2b70ac75ae86@linaro.org>
Date: Tue, 23 Apr 2024 16:59:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] ASoC: qcom: display port changes
To: Johan Hovold <johan@kernel.org>
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Bjorn Andersson <quic_bjorande@quicinc.com>
References: <20240422134354.89291-1-srinivas.kandagatla@linaro.org>
 <ZieihZRKe7OtP-nV@hovoldconsulting.com>
 <92b02fd3-5eba-42a7-a166-21b14724b10c@linaro.org>
 <ZifMlc_rLV6_LhUy@hovoldconsulting.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <ZifMlc_rLV6_LhUy@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/04/2024 15:58, Johan Hovold wrote:
>> It is absolutely possible to run all the streams in parallel from the
>> Audio hardware and DSP point of view.
>>
>> One thing to note is, On Qualcomm DP IP, we can not read/write registers
>> if the DP port is not connected, which means that we can not send data
>> in such cases.
>>
>> This makes it challenging to work with sound-servers like pipewire or
>> pulseaudio as they tend to send silence data at very early stages in the
>> full system boot up, ignoring state of the Jack events.
> This bit sounds like it can and should be worked around by the driver to
> avoid hard-coding policy which would prevent use cases such as the ones
> mentioned above.
This is not simple as you say. We have to fit these into a proper DPCM.
Either we have a dummy Backend connected for each of these pcm 
sub-devices when DP port is not connected and then switch back to DP 
when its connected.

Or somehow find a way to not let the pipewire talk to devices which are 
not connected.


thanks,
srini



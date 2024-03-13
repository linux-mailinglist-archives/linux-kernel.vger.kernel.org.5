Return-Path: <linux-kernel+bounces-101509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692EB87A80E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDABBB21EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F09405FB;
	Wed, 13 Mar 2024 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kXsSJdn0"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2ED4205A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710335186; cv=none; b=RTTL3WXuLrX0qP+/XGADh/vS1NjA3dm/TkMRwOvK9FVef53aL68VLAHbK1hbK4n4rSmAIxbEPJtqqHxwc7fiORbTwxZB8GwHDgGsJyJnkEYDzOAGnE8Agtnpmop86GPQjLjIgQxc3eSso5hRubcsQHE9HnarvXL+O8u72HB+QbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710335186; c=relaxed/simple;
	bh=nu2TU/efmJVyyNzdPZmhd4lX/ZlvA6rNHIqxiz0oydA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pt8vteNacpqbWO7TwETdLSb/ifE8GubZN8Ead7EHYnR8KInySWflAFT+mRjWlUlIUij6H9yRtirdAK4/zgWLopJ+0tOcP4Wj8f5d7uexLaVzooKrVy5nytmIaJlcqg8VzboKUlUGW9viS1W/gqxGzUCEEbntnU+SvQj2cQcjnCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kXsSJdn0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-413ea2c7fcfso3244985e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 06:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710335183; x=1710939983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M4NpWuidE/6XLSodKBBeg9UI/bSbAFivtpB+E/WZivo=;
        b=kXsSJdn0zpgvJUENwPnovJmkrcdx5f3wcKrVe4lE0UE12bVzHZFsTIJRc7NrABlacG
         aeMm0EMsWXowzFEz0XvBHaPuBA0mDK+CDXBw/47084sDW1vhj5FXKI6RfIjU9jRcJyXz
         /8m08C+dkq9AMGpPC01k+vXXL/tIIeefFOrmi9knkRxEvEGrs/GS5u0Rq7jQA+Ca7jTj
         7QLvO8Jo5QRGfx2cLSJNBYB3GvGwz1s/nCuvT1t2fq+24rdeRPXyK054ntH0+HZTrNxv
         vWSK8VvebUHHdYb5H/W24fPDJ4O5GriLn9U4AhUWBm35w4c3WkrKiqi85psGqjCiI/B6
         U/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710335183; x=1710939983;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M4NpWuidE/6XLSodKBBeg9UI/bSbAFivtpB+E/WZivo=;
        b=GOtTd1d1OlIPC2sZB9rqkwsKDXboI7gmEPOM1Qg1IvNFtNJlT4jvx9zI2kYuOdNge4
         3OmL9uNSDwlUGt0OBv7KxZxpj1ayLPAOQfCjCKdBT3GyE8EPJrDJxmmUTsLZd0IRoBU8
         RU0tfl4A0RQElvoPlHFCsqeLLIcns74MCpYwVTBTLC15hhWXcupytgwTUsXd3oSNHZ65
         7fNbfUeu9//huMicFe8EgwozRKNRN7Mrhn7T7P8rakS+GmIWUh/2K9QZ5aisYDaDAuvb
         rlaVZpObN1yK/xiqeNMKwglTt6WZORStU2HuzYUD1zVWoMYmmWZ03Q7YQBk3meSzeWfu
         jagA==
X-Forwarded-Encrypted: i=1; AJvYcCUiF37pX9mcSPHNUkc3/xfv7ukyKefzwzCiNnJphRufymhNnSTjv1wPFYjL5trxef587GmOEgtykGh8rbZXbjJidtXIy9jyfiZ0DuPH
X-Gm-Message-State: AOJu0YwUJlWJjtzdTyrhnTwpJ3VBFSRSPj6QhzYJ7rvQaGZOcdSTQW+w
	vJprgwSJT3HP1EoIkOpJMHserlnk2WLA7emvZ1OZs73VKbZjTfLTzdxRLA3ug2s=
X-Google-Smtp-Source: AGHT+IGa1okwKTE1e2wF6mpSHWKi5YQtwtGwhXyfrBB3D3LwsSoevUjXgSUkdVD+/wK963THVidm5Q==
X-Received: by 2002:a05:600c:1c05:b0:412:fe95:b6c5 with SMTP id j5-20020a05600c1c0500b00412fe95b6c5mr3950944wms.7.1710335183472;
        Wed, 13 Mar 2024 06:06:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600012cf00b0033ce727e728sm11589432wrx.94.2024.03.13.06.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 06:06:23 -0700 (PDT)
Message-ID: <e2a98098-8ccd-4b8f-9a4b-1cbc0776a9c2@linaro.org>
Date: Wed, 13 Mar 2024 14:06:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: net: add new property st,ext-phyclk
 in documentation for stm32
Content-Language: en-US
To: Christophe ROULLIER <christophe.roullier@foss.st.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>, Jose Abreu
 <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240307135957.303481-1-christophe.roullier@foss.st.com>
 <20240307135957.303481-3-christophe.roullier@foss.st.com>
 <578f421c-ca06-45d4-8380-8b2b423d4d47@linaro.org>
 <50ee6122-b160-48ea-8c44-1046b5907d7c@foss.st.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <50ee6122-b160-48ea-8c44-1046b5907d7c@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/03/2024 11:39, Christophe ROULLIER wrote:
> 
> On 3/8/24 09:28, Krzysztof Kozlowski wrote:
>> On 07/03/2024 14:59, Christophe Roullier wrote:
>>> Add property st,ext-phyclk to manage cases when PHY have no cristal/quartz
>>> This property can be used with RMII phy without cristal 50Mhz and when we
>>> want to select RCC clock instead of ETH_REF_CLK
>>> Can be used also with RGMII phy with no cristal and we select RCC clock
>>> instead of ETH_CLK125
>>>
>> Nothing improved here. You say you add new property (wrote it explicitly
>> in the subject), but where is it? Where is the user?
>>
>> I think we talked about this. Rob also asked quite clear:
>>
>>> That is obvious from the diff. What is not obvious is why we need a new
>>> property and what is the problem with the existing ones.
>> How did you solve it?
> 
> Hi,
> 
> I do not understand your questions.

OK, I will clarify some questions, but are you sure that this question:
"How did you solve it?"
needs clarification?

If so, then let me clarify:
Rob pointed issue. How did you resolve Rob's comment? How did you
address it? What changed in your patch, that Rob's comment should be
considered as addressed/resolved/done?

Now about my other question:
"but where is it? Where is the user?"

Your subject and commit message claim you add new property. This means
such property was not existing so far in the Linux kernel. If you add
new property in the binding, then I expect adding the user of that
binding, thus my question: where is the user of that binding?

> 
> That I would like to do, it is property "st,ext-phyclk" was introduced 
> in driver
> 
> "drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c" in 2020, and YAML 
> was not updated at the time.

Are you saying you document existing property or add a new one?

> 
> Goal of this patch it is to update YAML to avoid dtbs check issue if 
> someone use this property :
> 
>   dtbs check issue : views/kernel/upstream/net-next/arch/arm/boot/dts/st/stm32mp157c-dk2.dtb:
> ethernet@5800a000: Unevaluated properties are not allowed
> ('st,ext-phyclk' was unexpected)

So DTS uses it?

Are my questions now clear? BTW, I asked some of them before and you
just sent the same patch, so looks like ignored my questions.

Best regards,
Krzysztof



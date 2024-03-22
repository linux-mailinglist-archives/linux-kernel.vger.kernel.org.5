Return-Path: <linux-kernel+bounces-111671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8CB886F58
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B7D1F2213E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7364D11B;
	Fri, 22 Mar 2024 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PuHsPXeR"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A960E482F3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119753; cv=none; b=XWgnjWOfyxerphVFXbf1oq4bDi3JQuXkhCF3YnFsB664rswMAMMg7OITzKyjza9lku5LV6OwGTOCozgivyLgYBVhbSWgkiVs6lRqtmKx79alv+xpAUyMT5nTmv5dkzITQOWd1ZXp2DssSuPTzIEhKvjuk4ZDCZUurNECsg/doQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119753; c=relaxed/simple;
	bh=13VYmmRjtYhc7yWBpuY9K29jKbTHtGh4LZSU9Bbvxl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwxwYeAVShrfkpFY/+fA7OXNW/FGIbU+n+I5xbRDAsyDwIEkewLaKahZEiFeGY2LvaJOV/aI6XM+8H3QbxYNXkaDG0LeRkyku2T29oBR9In/Z4HmC8riG03Yev+GgZ4csjMNi9Y+7PufTcpDjg4RyrF6uLC3w4iFp4R7XZdetbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PuHsPXeR; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a466e53f8c0so314181066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711119750; x=1711724550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YYKS5KJg3lRASq82tox31NEtiC4E3JWUe9CPtzuJId4=;
        b=PuHsPXeRbn1WojIL2sxdMesvGbECylZQMjRaqfV5oUZhxJpDiVdRjyPAtTu/0RuPEX
         y1Tvmeshi1iOUh/vM83i5CPcZ12EC4U6oPQJr0g013pQaMBcaS39gdB9uDSf/UHaRCfB
         zr5qehxuvJVH+KRoRK9K+GoEd+e1//zzL8aVVxBySdFeWdWOe2w0SsfiZXYIguVBKAwN
         LA4IwEcMS+I3tenPF5XK9kfdOqaSbyi4/3Abv5AOGdR7gYJJt0uS19vF0wLlhrflXQcu
         I/U+4VYEfp67SS8BBoRX2vr7E8ZyCW5l9CAN5DtDJK3hYin/DhugZEUFqK1uKBexUMze
         GdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711119750; x=1711724550;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYKS5KJg3lRASq82tox31NEtiC4E3JWUe9CPtzuJId4=;
        b=fzMQNQTk3yECGYK5+YpeWxk9aZl7PEGubM0rY2HyAOxZSo8Dbp5szDAAUch2MqyRth
         hqe9MPjlRqSS8ZX8kCuCBeqKB1DLu+MEm2kdiWHMaR5nsKO0Cd6ShMifoF94NJy/4ICD
         i80EnvtKDxPYBfw9hyehB8AtUyHlLIC0O0lTuX/7NRsjgQVCFOarBS8IuX0bBN7txVvI
         TO3SFHGIMZXdboPWbeCa7EASndPfLL5w1MsQcHLUqk6d+GCaJpeLARajJZARZcfVxAfw
         PZ6+H823lm7Dzgz34feY5x5sBUbALtypIl85HWbb5/LJrAGjLkb2T+kvNMVbOhSt3Ywe
         knVA==
X-Forwarded-Encrypted: i=1; AJvYcCUhLWOiJY4tdaDrKk4iBgFg/zUBGQlQtL2PqRobCp0GWBHDOK7kfS3Tu1RmIFXZEJohfGe7tzoqW3cjCKBuxfjKpm0IHcxjGG1CtOsN
X-Gm-Message-State: AOJu0YzTZBQcu4v4XiXwB1+PDy7fxTA6gumhiFR6lmDt+ZhWsjahzqfQ
	aQIdHkZbTzolwuR/ClkLPYZXAjvvhPHFOBml4TBsLSKqooa5MtoaDC561XJnyJ8=
X-Google-Smtp-Source: AGHT+IHtjq6+na4gutOpkChrRwOxy4MSg4c4wA4AjFYZIhmh2K9m3TRq+mrt1jGOud6h+pFMO4owxg==
X-Received: by 2002:a17:906:11d2:b0:a46:da84:471a with SMTP id o18-20020a17090611d200b00a46da84471amr1865858eja.63.1711119749877;
        Fri, 22 Mar 2024 08:02:29 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id s24-20020a170906169800b00a46aba003eesm1087947ejd.215.2024.03.22.08.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 08:02:29 -0700 (PDT)
Message-ID: <f360ab66-1ee5-485a-84a9-f431b0c248a3@linaro.org>
Date: Fri, 22 Mar 2024 16:02:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] dt-bindings: mmc: fsl-imx-esdhc: add NXP S32G3
 support
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Chester Lin <chester62515@gmail.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Matthias Brugger <mbrugger@suse.com>, NXP S32 Linux Team <s32@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, Marco Felsch <m.felsch@pengutronix.de>,
 Gregor Herburger <gregor.herburger@ew.tq-group.com>,
 Marek Vasut <marex@denx.de>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Matthias Schiffer <matthias.schiffer@tq-group.com>,
 Stefan Wahren <stefan.wahren@chargebyte.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Schenker <philippe.schenker@toradex.com>,
 Yannic Moog <y.moog@phytec.de>, Li Yang <leoyang.li@nxp.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-serial@vger.kernel.org
References: <20240321154108.146223-1-wafgo01@gmail.com>
 <20240321154108.146223-4-wafgo01@gmail.com>
 <00174dc3-65a7-4a2e-b48d-a974336a3f18@linaro.org>
 <20240322094526.GA7097@bhlegrsu.conti.de>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240322094526.GA7097@bhlegrsu.conti.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/03/2024 10:45, Wadim Mueller wrote:
> On Thu, Mar 21, 2024 at 06:53:34PM +0100, Krzysztof Kozlowski wrote:
>> On 21/03/2024 16:41, Wadim Mueller wrote:
>>> Add a compatible string for the SDHC binding of NXP S32G3 platforms. Here
>>> we use "nxp,s32g2-usdhc" as fallback since the s32g2-usdhc
>>> driver works also on S32G3 platforms.
>>>
>>> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
>>> ---
>>>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
>>> index 82eb7a24c857..b42b4368fa4e 100644
>>> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
>>> @@ -35,6 +35,7 @@ properties:
>>>            - fsl,imx8mm-usdhc
>>>            - fsl,imxrt1050-usdhc
>>>            - nxp,s32g2-usdhc
>>> +          - nxp,s32g3-usdhc
>>>        - items:
>>>            - const: fsl,imx50-esdhc
>>>            - const: fsl,imx53-esdhc
>>> @@ -90,6 +91,9 @@ properties:
>>>            - enum:
>>>                - fsl,imxrt1170-usdhc
>>>            - const: fsl,imxrt1050-usdhc
>>> +      - items:
>>> +          - const: nxp,s32g3-usdhc
>>> +          - const: nxp,s32g2-usdhc
>>
>> No, that's just wrong. G3 is not and is compatible with G2? There is no
>> dualism here. Either it is or it is not. Not both.
>>
> 
> I am trying to understand your statement but I am not sure whether I get
> it right.
> 
> Let me try to explain what I understand is wrong with this patch. 
> 
> Having nxp,s32g2-usdhc and nxp,s32g2-usdhc in one enum
> 
>>>            - nxp,s32g2-usdhc
>>> +          - nxp,s32g3-usdhc
> 
> would mean that those are 
> __not__ compatible with each other, whereas the anouther item
> 
>>> +      - items:
>>> +          - const: nxp,s32g3-usdhc
>>> +          - const: nxp,s32g2-usdhc
>>
> 
> where both const entries are side by side means that those are compatible. Which is
> paradox. Is this undersanding correct?

Yes, you placed the same compatible in two separate places. It has two
separate meanings.

> 
> So if I want to have the follwing im my DTS for the mmc node
> 
> usdhc0: mmc@402f0000 {
> 			compatible = "nxp,s32g3-usdhc",
> 				     "nxp,s32g2-usdhc";
> 				     ...
> }
> 
> The schema update should contain just this part?
> 
> i@@ -90,6 +90,9 @@ properties:
>            - enum:
>                - fsl,imxrt1170-usdhc
>            - const: fsl,imxrt1050-usdhc
> +      - items:
> +          - const: nxp,s32g3-usdhc
> +          - const: nxp,s32g2-usdhc
>  
>    reg:
>      maxItems: 1
> 
> 
> Is this correct?

Yes.



Best regards,
Krzysztof



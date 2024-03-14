Return-Path: <linux-kernel+bounces-103380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44ACE87BEC4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9702AB21CCA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF306FE1A;
	Thu, 14 Mar 2024 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FhpmI86F"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F91A6FE03
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710426044; cv=none; b=d0h6taV5ZulFVV2dF6I5oqf54cCNXCamVUVXtXQUKvgr8rCOPomU4KagTDFtu0ozOPE3tfwGc24IHE8rCW1uqhCkxQ6P47B1UHmcdlNM+Oj4k3y0nagnmZhliCtRftwH1gUt07sNEBTiBB6SBpVWX8UB112KN5iBxLGsdeQpzZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710426044; c=relaxed/simple;
	bh=aSq9sMuVYcx05iRQOKWfoFgeibFQrlN+p59sPu5U58A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IoULNQRNcgj95HGwnmPrsGDfjsq66buPzNB1SXanhyId5w8mT4cDAoMCZ29TE/zRjOJOESp62CAkaJflVTJ9MgUQNhPGjVvKGQZSfJTEDAdtkzCdRLZdHCZXGhP+wvwQBrjKtkPZcsSbf0RwND8UHh39q5JlaBGBy2O6eTBbq1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FhpmI86F; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-413eb7cf7dfso6850955e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710426040; x=1711030840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NfhA2rcacs4IE2CXjPGRD2+G776hpGDEtkL4YcYM5Ig=;
        b=FhpmI86FIT03YyQU8mcX+/k9e4GdOMOnZw8olk7ay/VKmq9ApN3NbHv7tXwfeNTjzu
         1qD2Smesl2fUgyiymiCQ57esAk+Z+s0WspLY3xc7NJsIaOk6WclJFuui5WKr/VPOBWNJ
         2AqfpavkkUVkvYQT/MCLvrMpM3ht5em7omqNHGm/VBJIrv2usDKU3du0n8OEAMqINUo4
         9+YYjehmWguW0tuvHqGjgHC5453Yr1AMQASXgEEvOWrcKUJuuS5GDNC1/FJBopGySK3X
         77HBYl/GzdHhBVWTQeaNxSOmnI3iUT+iaKq4/Ph9nb30odjpkq/cOOxXUNtrNMk7W9iE
         J63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710426040; x=1711030840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NfhA2rcacs4IE2CXjPGRD2+G776hpGDEtkL4YcYM5Ig=;
        b=w94VC/Wch996UDAyobWQQfs6TReOBA9GPKoutkYmmr5sJcv+nCBnf8qeUDP7Uf+I9B
         Q2KHA/qI0JYzC15z+IpJWaZbI7+v7FjiH7rXjSCX+KlhWkk2uQlo+25p9nLU/yep7uOi
         H/LHXnuLk0UpHXGPKyUvdR08tL+2A9hBKJktHTflhxup+CjWNdah1hiuKIORhZGgZ1lM
         onYnujJr7scvLEzhgE/0pdi/Fc1wMFiOP77RsGPV0bsdfgG8sBTockjlUv2ehh3I+vJE
         6/mKrnVMfKjXWUp7VcX4WLOpEsIiB6Fum0wDtJUUsvDBWvycmmWVLAASMuhuK3C+jGLj
         VYZg==
X-Forwarded-Encrypted: i=1; AJvYcCXl4mfFxBW+iW6Zjs1TS2brKGtfqTdnmTEQqmbybRCuy3nXPZlKgb1zCpZ0d4LuA2HmYr/KpfTUsG/yDhOHDPDuj9rnZnPkgjG2Gk5P
X-Gm-Message-State: AOJu0YxK1FLU3PvMXeN5dFicxRaQ4xzXqzv8aKRGxasBatkY4Cw0leTz
	Imb9SrZFZNDfL7YzKWxeSmE+rmIta0LfKZ/0uVBLOxtpbCY1sc+h20aOmuQRlLC/5EnY1ztQjlv
	v
X-Google-Smtp-Source: AGHT+IHkGwyJQaOjxzAn/h0Hw8KEduL+99EUU5TnzJA1fh7kH1MCPQ+RoIlJDqkZKMILpKwSNp8oKw==
X-Received: by 2002:a05:600c:5026:b0:413:e93b:cdf with SMTP id n38-20020a05600c502600b00413e93b0cdfmr2123996wmr.13.1710426039834;
        Thu, 14 Mar 2024 07:20:39 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b00412f016a151sm2606983wmq.9.2024.03.14.07.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 07:20:39 -0700 (PDT)
Message-ID: <f6f317d9-830d-4c38-998f-b229b3d9f95a@linaro.org>
Date: Thu, 14 Mar 2024 14:20:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: qcom: Update DT bindings for multiple
 DT
Content-Language: en-US
To: Amrit Anand <quic_amrianan@quicinc.com>, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, kernel@quicinc.com, peter.griffin@linaro.org,
 linux-riscv@lists.infradead.org, chrome-platform@lists.linux.dev,
 linux-mediatek@lists.infradead.org, Simon Glass <sjg@chromium.org>
References: <1710418312-6559-1-git-send-email-quic_amrianan@quicinc.com>
 <1710418312-6559-3-git-send-email-quic_amrianan@quicinc.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <1710418312-6559-3-git-send-email-quic_amrianan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Amrit,

On 14/03/2024 12:11, Amrit Anand wrote:
> Qualcomm produces a lot of "unique" boards with slight differences in
> SoC's and board's configuration. For eg, there can be SM8150v1 on MTPv1,
> SM8150v1 on MTPv2, SM8150v2 on MTPv2, SM8150v2 on MTPv2 with a different
> PMIC, SM8150v2 with no modem support and so on. For instance, suppose we
> have 3 SoC, each with 4 boards supported, along with 2 PMIC support for
> each case which would lead to total of 24 DTB files. Along with these
> configurations, OEMs may also add certain additional board variants. Thus
> a mechanism is required to pick the correct DTB for the corresponding board.
> 
> Introduce mechanism to select required DTB using newly introduced device
> tree properties "board-id" and "board-id-type". "board-id" will contain
> the list of values of "qcom,soc-id", "qcom,board-id", "qcom,pmic-id" or
> "qcom,oem-id". "board-id-types" contains the type of parameter which is
> entered. It can be either "qcom,soc-id", "qcom,board-id", "qcom,pmic-id"
> or "qcom,oem-id".

Thanks for working on this, it's nice to finally see this logic
documented in the kernel.
> 
> Qualcomm based bootloader will use these properties to pick the best
> matched DTB to boot the device with.
> 
> Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 90 +++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 7f80f48..dc66ae9 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -1100,6 +1100,76 @@ properties:
>        kernel
>        The property is deprecated.
>  
> +  board-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    minItems: 2
> +    description: |
> +      Qualcomm specific bootloader uses multiple different identifiers
> +      (qcom,soc-id, qcom,board-id, qcom,pmic-id, qcom,oem-id) to select
> +      single Devicetree among list of Devicetrees. For different identifiers,
> +      the selection can be done either based on exact match (where the
> +      identifiers information coming from firmware should exactly match
> +      the ones described in devicetree) or best match (firmware provided
> +      identifier information closely matches with the one of the Devicetree).
> +      Below table describes matching criteria for each identifier::
> +      |----------------------------------------------------------------------|
> +      |  DT property  |  Individual fields   |   Exact  |  Best  |  Default  |
> +      |----------------------------------------------------------------------|
> +      | qcom,soc-id   |                                                      |
> +      |               |  Chipset Id          |     Y    |    N   |     -     |
> +      |               |  SoC Revision        |     N    |    Y   |     -     |
> +      | qcom,board-id |                                                      |
> +      |               |  Board Id            |     Y    |    N   |     -     |
> +      |               |  Board Major         |     N    |    Y   |     -     |
> +      |               |  Board Minor         |     N    |    Y   |     -     |
> +      |               |  Subtype             |     Y    |    N   |     0     |
> +      |               |  DDRtype             |     Y    |    N   |     0     |
> +      |               |  BootDevice Type     |     Y    |    N   |     0     |
> +      | qcom,pmic-id  |                                                      |
> +      |               |  Slave Id            |     Y    |    N   |     0     |
> +      |               |  PMIC Id             |     Y    |    N   |     0     |
> +      |               |  PMIC Major          |     N    |    Y   |     0     |
> +      |               |  PMIC Minor          |     N    |    Y   |     0     |
> +      | qcom,oem-id   |                                                      |
> +      |               |  OEM Id              |     Y    |    N   |     0     |
> +      |----------------------------------------------------------------------|
> +      For best match, identifiers are matched based on following priority order::
> +      SoC Revision > Board Major > Board Minor > PMIC Major > PMIC Minor
> +
> +  board-id-types:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description:
> +       Each field and helper macros are defined at include/dt-bindings/arm/qcom,ids.
> +    minItems: 2
> +    items:
> +       oneOf:
> +         - const: qcom,soc-id
> +           description:
> +              Matches Qualcomm Technologies, Inc. boards with the specified SoC.
> +              2 integers are needed to describe a soc-id. The first integer is the
> +              SoC ID and the second integer is the SoC revision.
> +              qcom,soc-id = <soc-id  soc-revision>
> +         - const: qcom,board-id
> +           description: |
> +              Matches Qualcomm Technologies, Inc. boards with the specified board.
> +              2 integers are needed to describe a board-id. The first integer is the
> +              board ID. The second integer is the board-subtype.
> +              qcom,board-id = <board-id  board-subtype>
> +         - const: qcom,pmic-id
> +           description: |
> +              Qualcomm boards can be attached to multiple PMICs where slave-id (SID)
> +              indicates the address of the bus on which the PMIC is attached. It can be
> +              any number. The model for a PMIC indicates the PMIC name attached to bus
> +              described by SID along with  major and minor version. 2 integers are needed
> +              to describe qcom,pmic-id. The first integer is the slave-id and the second integer
> +              is the pmic model.
> +              qcom,pmic-id = <pmic-sid pmic-model>
> +         - const: qcom,oem-id
> +           description: |
> +              Matches Qualcomm Technologies, Inc. boards with the specified OEM ID.
> +              1 integer is needed to describe the oem-id.
> +              qcom,oem-id = <oem-id>
> +
>  allOf:
>    # Explicit allow-list for older SoCs. The legacy properties are not allowed
>    # on newer SoCs.
> @@ -1167,4 +1237,24 @@ allOf:
>  
>  additionalProperties: true
>  
> +examples:
> +  - |
> +    #include <dt-bindings/arm/qcom,ids.h>
> +    / {
> +         model = "Qualcomm Technologies, Inc. sc7280 IDP SKU1 platform";
> +         compatible = "qcom,sc7280-idp", "google,senor", "qcom,sc7280";
> +
> +         #board-id-cells = <2>;
> +         board-id = <QCOM_SOC_ID(SC7280) QCOM_SOC_REVISION(1)>,
> +                    <QCOM_SOC_ID(SC7280) QCOM_SOC_REVISION(2)>,
> +                    <QCOM_BOARD_ID(IDP, 1, 0) QCOM_BOARD_SUBTYPE(UFS, ANY, 1)>;
> +         board-id-types = "qcom,soc-id",
> +                          "qcom,soc-id",
> +                          "qcom,board-id";
Forgive me if this is a particularly cynical view, but this seems
incredibly blatant, the "qcom,board-id" property is deprecated for
various good reasons, just using a key/value map where "qcom,board-id"
is a key doesn't change that. There are two main issues I have with the
proposal here:

1. This breaks backwards compatibility, millions of production devices
with bootloaders that will never receive another update might be
compatible with the downstream "qcom,board-id" property, but they won't
work with this.
2. A top level board-id property that isn't namespaced implies that it
isn't vendor specific, but the proposed implementation doesn't even
pretend to be vendor agnostic.

U-Boot also has some ideas around this issue, there you can pass in
multiple DTBs and provide some board specific "best match" function.
I think there's definitely some value in exposing this information, but
there's no good reason to define the same data as `qcom,board-id` while
breaking production bootloaders.
> +
> +         #address-cells = <2>;
> +         #size-cells = <2>;
> +    };
> +
> +
>  ...

-- 
// Caleb (they/them)


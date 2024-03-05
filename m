Return-Path: <linux-kernel+bounces-92869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB74872740
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F1A4B2499F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069FD1C2BD;
	Tue,  5 Mar 2024 19:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L676/Vmm"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C4F1B81D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 19:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665432; cv=none; b=bkQIh21FEWg1sienfXMLZ39uc+cn6FvuIHX7xX3z+o8e92Yqs5kuGjjt5r1DtdbTJxG+LX+dNKoQp8MZ0hsIyRmmuswmi2GjtivC2zibFBIOogSV+ixosW3Pk7RNJ2mUHUiGuvVeNVFQKqr+cE2YXEGwY+H5IuP6FfIG3/pwC/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665432; c=relaxed/simple;
	bh=nFR4TtmFsAlAIreWQ4YESZrHvsrp/UDDXLgsdNPfX+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uOP3fVSusEFJlj7Qdfrj1RrvFAROS/jnX1DEkqTdQAvqZYWf3M0iRfDnnYpzsT4BW+9hBcSnwjRx/QJj986IoWU6lInvvLtvwAWa98nzrF1q46NtPjT8WkMpJzYIMZ8A9RgwxkISpVyCZrcvn/W1xV1RNisdGwvQOfspIA/jCnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L676/Vmm; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60974cb1cd7so54338107b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 11:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709665428; x=1710270228; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tj9v4Vuf7/2y1AftgKzFRQDegcxDIOospQ+FfL86Eno=;
        b=L676/VmmmLy70P35DZW6kuet8lJt/ZSxZG/i/F+v8O0gPfJDf89y7wuvazA0/IJPlL
         SmD/XhVwvqRCo4VoEmgdiJMlghCB+p+aLctJo/eIAvvnsUXKV0g684qx1+8Uk92eiCQ1
         FdNXPVu1z0vrRuq3r46rRBwdsH/avm0IMtSogW4tiXP765Fq0GBwGBjoDkkr+je708am
         Pd3zHP6hKipnSNgn79Y04wfhh8akFh+3x0GCgbqCbUujs0mt4sKO3e2TCtTS4xwKzlyH
         TZuMdJrnQ87f/EYbUQTaNyIbjUHKV5DNh9sz3cYsfjuF61nOn7kbeeEbyRsYSV2vfJd0
         BP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709665428; x=1710270228;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tj9v4Vuf7/2y1AftgKzFRQDegcxDIOospQ+FfL86Eno=;
        b=vvAt/hwCyrPyM1y+WsqCMsbYQD7Qq92jfF4btr1neOQeRoT49V2geXJmggsIOgmZh4
         5rtL4LxuH0kXq3U4Nmc6qWY0n8+naKFPjZjKjmB5oc0PSrqsKL5fbTNfTohbjj2Z+yiD
         UzXe6QubCvGPCqlYzL1bLvDzxUn6mIc2oXkpQwY2gbEjnfSpKTABBOBqjf5gjzw2ul1r
         MtXmilAgGDUtfPRUVl3pnSTPKAbNwf7pMWAsmlr6G/IsAkwyC4PH7pfLiUTxByArcMAq
         yW2r3JCWBcfL+h0I0iBkeUJAv/7d9j/dg2LjgCkeSs1Uh9WQG/0J3PR8FX2R/V9Z1Rfz
         8fkA==
X-Forwarded-Encrypted: i=1; AJvYcCWfsMeHI7IMByik+ujBg7TkMCbe1CnIGi5mZ44/t9UDIpVMFbcOcWWuqHQXacgsY/J4B/D/pBt+8KbHGeBPUqeQNX1y5+yK9fyRnXbE
X-Gm-Message-State: AOJu0YykyyO32xB4Q/69+g3Hb7zKccC81IwJx0B9G9MVRWRnlkNHA3aC
	SNuVejSoxLebKqOl3J9q3uNwrcdvWA42G1h04va0jXi1JJY2qRQz6QHT8Arlf2D52/ZkqFY33Ti
	nLNxqX1it2qWwvppX6VZ6a+uURzRhixUhe11Y1Q==
X-Google-Smtp-Source: AGHT+IGKTqAbWKDABfsvILiDuIbYZg+R6nM3PamcUphV0IunTEH42BYl3u2kfBq9aXyR4Rztu5fz84oLGcZHxGyJ0GY=
X-Received: by 2002:a0d:e24c:0:b0:607:6ad3:8746 with SMTP id
 l73-20020a0de24c000000b006076ad38746mr12668467ywe.46.1709665427665; Tue, 05
 Mar 2024 11:03:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1709657858-8563-1-git-send-email-quic_sriramd@quicinc.com> <1709657858-8563-2-git-send-email-quic_sriramd@quicinc.com>
In-Reply-To: <1709657858-8563-2-git-send-email-quic_sriramd@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 5 Mar 2024 21:03:36 +0200
Message-ID: <CAA8EJpph+R2oJjABvNQYwp=pZLxQPzzs41Hhw4feOdQ3eU-6UA@mail.gmail.com>
Subject: Re: [RFC 1/3] dt-bindings: usb: qcom,dwc3: Add support for multiple power-domains
To: Sriram Dash <quic_sriramd@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org, 
	kishon@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, gregkh@linuxfoundation.org, quic_wcheng@quicinc.com, 
	Thinh.Nguyen@synopsys.com, p.zabel@pengutronix.de, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, quic_psodagud@quicinc.com, quic_nkela@quicinc.com, 
	manivannan.sadhasivam@linaro.org, ulf.hansson@linaro.org, 
	sudeep.holla@arm.com, quic_shazhuss@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Mar 2024 at 18:58, Sriram Dash <quic_sriramd@quicinc.com> wrote:
>
> Some target systems allow multiple resources to be managed by firmware.
> On these targets, tasks related to clocks, regulators, resets, and
> interconnects can be delegated to the firmware, while the remaining
> responsibilities are handled by Linux.
>
> To support the management of partial resources in Linux and leave the rest
> to firmware, multiple power domains are introduced. Each power domain can
> manage one or more resources, depending on the specific use case.
>
> These power domains handle SCMI calls to the firmware, enabling the
> activation and deactivation of firmware-managed resources.
>
> Signed-off-by: Sriram Dash <quic_sriramd@quicinc.com>
> ---
>  .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        | 74 ++++++++++++++++------
>  .../bindings/phy/qcom,usb-snps-femto-v2.yaml       | 49 ++++++++++++--
>  .../devicetree/bindings/usb/qcom,dwc3.yaml         | 37 ++++++++++-
>  3 files changed, 130 insertions(+), 30 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> index 1e2d4dd..53b9ba9 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> @@ -44,7 +44,32 @@ properties:
>      maxItems: 5
>
>    power-domains:
> -    maxItems: 1
> +    description: specifies a phandle to PM domain provider node
> +    minItems: 1
> +    maxItems: 2
> +
> +  power-domain-names:
> +    description:
> +      A list of power domain name strings sorted in the same order as the
> +      power-domains property.
> +
> +      For platforms where some resource are firmware managed, the name
> +      corresponding to the index of an SCMI domain provider can be
> +      "usb_core" or "usb_transfer".
> +    items:
> +      - const: usb_core
> +      - const: usb_transfer
> +
> +  qmp,fw-managed:
> +    description:
> +      Some targets allow multiple resources to be managed by firmware.
> +      On these targets, tasks related to clocks, regulators, resets, and
> +      interconnects can be delegated to the firmware, while the remaining
> +      responsibilities are handled by Linux.
> +
> +      Decide if the target resources will be managed by firmware or High level
> +      OS.
> +    type: boolean
>
>    resets:
>      maxItems: 2
> @@ -70,14 +95,6 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - clocks
> -  - clock-names
> -  - resets
> -  - reset-names
> -  - vdda-phy-supply
> -  - vdda-pll-supply
> -  - "#clock-cells"
> -  - clock-output-names
>    - "#phy-cells"
>
>  allOf:
> @@ -86,6 +103,33 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,sa8775p-qmp-usb3-uni-phy
> +              - qcom,sc8280xp-qmp-usb3-uni-phy
> +              - qcom,x1e80100-qmp-usb3-uni-phy
> +    then:
> +      required:
> +        - power-domains
> +
> +  - if:
> +      not:
> +        required:
> +          - qmp,fw-managed
> +    then:
> +      required:
> +        - clocks
> +        - clock-names
> +        - resets
> +        - reset-names
> +        - vdda-phy-supply
> +        - vdda-pll-supply
> +        - clock-output-names
> +        - "#clock-cells"
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
>                - qcom,ipq6018-qmp-usb3-phy
>                - qcom,ipq8074-qmp-usb3-phy
>                - qcom,ipq9574-qmp-usb3-phy
> @@ -144,18 +188,6 @@ allOf:
>              - const: com_aux
>              - const: pipe
>
> -  - if:
> -      properties:
> -        compatible:
> -          contains:
> -            enum:
> -              - qcom,sa8775p-qmp-usb3-uni-phy
> -              - qcom,sc8280xp-qmp-usb3-uni-phy
> -              - qcom,x1e80100-qmp-usb3-uni-phy
> -    then:
> -      required:
> -        - power-domains
> -
>  additionalProperties: false
>
>  examples:
> diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> index 0f200e3..ad2f08f 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> @@ -49,6 +49,34 @@ properties:
>      items:
>        - const: ref
>
> +  power-domains:
> +    description: specifies a phandle to PM domain provider node
> +    minItems: 1
> +    maxItems: 2
> +
> +  power-domain-names:
> +    description:
> +      A list of power domain name strings sorted in the same order as the
> +      power-domains property.
> +
> +      For platforms where some resource are firmware managed, the name
> +      corresponding to the index of an SCMI domain provider can be
> +      "usb_core" or "usb_transfer".
> +    items:
> +      - const: usb_core
> +      - const: usb_transfer
> +
> +  hsphy,fw-managed:
> +    description:
> +      Some targets allow multiple resources to be managed by firmware.
> +      On these targets, tasks related to clocks, regulators, resets, and
> +      interconnects can be delegated to the firmware, while the remaining
> +      responsibilities are handled by Linux.
> +
> +      Decide if the target resources will be managed by firmware or High level
> +      OS.
> +    type: boolean
> +
>    resets:
>      items:
>        - description: PHY core reset
> @@ -154,12 +182,21 @@ required:
>    - compatible
>    - reg
>    - "#phy-cells"
> -  - clocks
> -  - clock-names
> -  - resets
> -  - vdda-pll-supply
> -  - vdda18-supply
> -  - vdda33-supply
> +
> +
> +allOf:
> +  - if:
> +      not:
> +        required:
> +          - hsphy,fw-managed
> +    then:
> +      required:
> +        - clocks
> +        - clock-names
> +        - resets
> +        - vdda-pll-supply
> +        - vdda18-supply
> +        - vdda33-supply
>
>  additionalProperties: false
>
> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> index 63d150b..5bf3a29 100644
> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> @@ -64,7 +64,31 @@ properties:
>
>    power-domains:
>      description: specifies a phandle to PM domain provider node
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
> +
> +  power-domain-names:
> +    description:
> +      A list of power domain name strings sorted in the same order as the
> +      power-domains property.
> +
> +      For platforms where some resource are firmware managed, the name
> +      corresponding to the index of an SCMI domain provider can be
> +      "usb_core" or "usb_transfer".
> +    items:
> +      - const: usb_core
> +      - const: usb_transfer
> +
> +  qcom,fw-managed:
> +    description:
> +      Some targets allow multiple resources to be managed by firmware.
> +      On these targets, tasks related to clocks, regulators, resets, and
> +      interconnects can be delegated to the firmware, while the remaining
> +      responsibilities are handled by Linux.
> +
> +      Decide if the target resources will be managed by firmware or High level
> +      OS.
> +    type: boolean

I think this is an overkill. You know that SA8775 is going to use
SCMI-based clocks / PD management. Thus I'd suggest adding new
bindings file targeting qcom,sa8775-dwc3. Also you can drop the
qcom,fw-managed property at all, let the driver decide basing on the
compat string.


>
>    required-opps:
>      maxItems: 1
> @@ -148,13 +172,20 @@ required:
>    - "#address-cells"
>    - "#size-cells"
>    - ranges
> -  - clocks
> -  - clock-names
>    - interrupts
>    - interrupt-names
>
>  allOf:
>    - if:
> +      not:
> +        required:
> +          - qcom,fw-managed
> +    then:
> +      required:
> +        - clocks
> +        - clock-names
> +
> +  - if:
>        properties:
>          compatible:
>            contains:
> --
> 2.7.4
>
>


--
With best wishes
Dmitry


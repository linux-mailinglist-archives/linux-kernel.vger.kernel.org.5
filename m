Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31A67A07BC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240390AbjINOsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240356AbjINOsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:48:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7FD1FD8;
        Thu, 14 Sep 2023 07:48:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDCBC433C9;
        Thu, 14 Sep 2023 14:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694702889;
        bh=y75UZV7IrEfaRshsSKNFVB5QqnbIpnAX2/2OZFpAm1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZO9RHGVbtpfHNXzviqAu345MBTfgs3Mj0JvziDHVFd6VP7DHN8BXPZl8fQlMTSUv3
         VdGNxQLmXJceXc5QounrVyFFRQFSIQt8Y3AxrVvQm2hN+5/PncJhz7SQavQkdtpW+6
         ZbKUY3ZNT8Z6U+MhhNxxxkgbdsWLlLI3nWA/KKU2tCrX4DNJzNi8mg/QeqEm2SeI+Q
         6TNPDoWo87fv4nYUjLQ7A/aq6IYGNwR/ziTksXiOcjMmSjU/pwaopBjq00MGFWLLm4
         Z09dOwpHXjB/rdY5QPnW1uHMkb63BLy6GJTyjEOhSuwYl675BCY2+w0Tqc7yFtXuOu
         p/lP27OPtGgww==
Received: (nullmailer pid 1271313 invoked by uid 1000);
        Thu, 14 Sep 2023 14:48:07 -0000
Date:   Thu, 14 Sep 2023 09:48:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: phy: qcom,snps-eusb2-repeater: Add
 magic tuning overrides
Message-ID: <20230914144807.GA1267899-robh@kernel.org>
References: <20230830-topic-eusb2_override-v2-0-7d8c893d93f6@linaro.org>
 <20230830-topic-eusb2_override-v2-1-7d8c893d93f6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830-topic-eusb2_override-v2-1-7d8c893d93f6@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 11:53:23AM +0200, Konrad Dybcio wrote:
> The EUSB2 repeater requires some alterations to its init sequence,
> depending on board design.
> 
> Add support for making the necessary changes to that sequence to make USB
> functional on SM8550-based Xperia 1 V.
> 
> They all have lackluster description due to lack of information.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/phy/qcom,snps-eusb2-repeater.yaml      | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
> index 029569d5fcf3..24c733c10e0e 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
> @@ -32,6 +32,27 @@ properties:
>  
>    vdd3-supply: true
>  
> +  qcom,tune-usb2-disc-thres:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description: High-Speed disconnect threshold
> +    minimum: 0
> +    maximum: 7
> +    default: 0
> +
> +  qcom,tune-usb2-amplitude:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description: High-Speed trasmit amplitude
> +    minimum: 0
> +    maximum: 15
> +    default: 8
> +
> +  qcom,tune-usb2-preem:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description: High-Speed TX pre-emphasis tuning
> +    minimum: 0
> +    maximum: 7
> +    default: 5

For what it is worth, the mediatek,tphy.yaml binding has the same 
properties...

Acked-by: Rob Herring <robh@kernel.org>

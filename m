Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BE7799E08
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 14:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346611AbjIJMRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 08:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjIJMRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 08:17:53 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EC8CCA;
        Sun, 10 Sep 2023 05:17:47 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 833011BF204;
        Sun, 10 Sep 2023 12:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694348265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3etqNy1GpuK5gKJllyzmZhLeMXr+j2Y5akCC+GBT6bk=;
        b=H+jeAprd0dd5V5ArgrOSBRhfqbpmPnFrRVxFyaPKU+NtlqbBIv5aZTpiywfAe9YIEMBdYC
        hDKrbhlNJ6pbxPXwtR/8DLTfD7zSx0KS+6WNP3ud9TE+X0xJiMVRDwgmcbdPvTmF5c9Duz
        toy/LStYUXhv1JIJD2UdUQs1QXYonA5QThR76AG6Fb9cUr/jOr5RKVl+iuAvFsCEFLQi9c
        cGTBhZfOUrtK4aj5HynWPlSgE7fhsVTvPPABazp+YouHJqheuN3TI+FmqzKlyySKsWCSl5
        oHX4WU1Ix2FJw89pTtF+gnnGfGXoY1NBiuS9MYaGswglcZ5bFvij5obfiDheOg==
Date:   Sun, 10 Sep 2023 14:17:44 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chris Verges <chrisv@cyberswitching.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: rtc: pcf2123: convert to YAML
Message-ID: <202309101217447eae4bc4@mail.local>
References: <20230907-topic-pcf2123_yaml-v1-1-40e82bed2066@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907-topic-pcf2123_yaml-v1-1-40e82bed2066@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/2023 13:00:27+0200, Javier Carrasco wrote:
> Convert the existing txt binding to the preferred YAML format.
> 
> The pcf2123 node may contain SPI settings such as spi-cs-high and
> spi-max-frequency, which keeps it from being added to the trivial-rtc
> binding with its current definition. Add a reference to
> spi-peripheral-props.yaml to account for that.
> 
> The "interrupts" property was missing in the binding although it is
> already supported. Add the missing property in the new binding.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  .../devicetree/bindings/rtc/nxp,pcf2123.yaml       | 45 ++++++++++++++++++++++
>  .../devicetree/bindings/rtc/nxp,rtc-2123.txt       | 17 --------
>  2 files changed, 45 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf2123.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf2123.yaml
> new file mode 100644
> index 000000000000..013e5e5dc0ae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf2123.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/nxp,pcf2123.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP PCF2123 SPI Real Time Clock
> +
> +maintainers:
> +  - Chris Verges <chrisv@cyberswitching.com>

Is Chris willing to maintain the binding?

> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - $ref: rtc.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,pcf2123
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        rtc@3 {
> +            compatible = "nxp,pcf2123";
> +            reg = <3>;
> +            spi-cs-high;
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/rtc/nxp,rtc-2123.txt b/Documentation/devicetree/bindings/rtc/nxp,rtc-2123.txt
> deleted file mode 100644
> index 7371f525a687..000000000000
> --- a/Documentation/devicetree/bindings/rtc/nxp,rtc-2123.txt
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -NXP PCF2123 SPI Real Time Clock
> -
> -Required properties:
> -- compatible: should be: "nxp,pcf2123"
> -                      or "microcrystal,rv2123"
> -- reg: should be the SPI slave chipselect address
> -
> -Optional properties:
> -- spi-cs-high: PCF2123 needs chipselect high
> -
> -Example:
> -
> -pcf2123: rtc@3 {
> -	compatible = "nxp,pcf2123"
> -	reg = <3>
> -	spi-cs-high;
> -};
> 
> ---
> base-commit: 535a265d7f0dd50d8c3a4f8b4f3a452d56bd160f
> change-id: 20230907-topic-pcf2123_yaml-2ce57f4e77d7
> 
> Best regards,
> -- 
> Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

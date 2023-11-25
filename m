Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968CF7F8C17
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 16:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjKYPfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 10:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjKYPfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 10:35:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B36AA
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:35:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20148C433C7;
        Sat, 25 Nov 2023 15:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700926543;
        bh=9XcsX/rqDUE/4rKkKOqkuc0WCIhP5kbJTDOZF+yyUdA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YfDFye/96iTRHnHeNU8ERa87yaX1BE1X8OKGpDaGtpH/vBdMyetR3HhPJiYJ9w0cW
         shnam6A6V5JY2ryE5t//mOE2an0DiUVmc9JKrmgQcnUyjUwr0MfWMaRoffY4OSPTu1
         IBhEgaplHK7KfIOEVUSUkrtFBoCRep02HN41QXwyrhBoyU5KTxHLwa+z5pkTjQQnPJ
         OUvSWD0mgsbZaU6laBOQO6eh636rsSPouTImiS0Z7Xgym2drr9qacRiebnyVKAeZVx
         BpoQrUR1P5Pd906CZkETmg1tY8CvquxV5OXIKqkEJZyKXjouyApjs20TRLCrkOvdHf
         y19Ket1nYSszg==
Date:   Sat, 25 Nov 2023 15:35:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Kim Seer Paller <kimseer.paller@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Crt Mori <cmo@melexis.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: frequency: add admfm2000
Message-ID: <20231125153535.08045a2e@jic23-huawei>
In-Reply-To: <20231124105116.5764-1-kimseer.paller@analog.com>
References: <20231124105116.5764-1-kimseer.paller@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2023 18:51:15 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> Dual microwave down converter module with input RF and LO frequency
> ranges from 0.5 to 32 GHz and an output IF frequency range from 0.1 to
> 8 GHz. It consists of a LNA, mixer, IF filter, DSA, and IF amplifier
> for each down conversion path.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 
Hi,

Sorry I'm late to the party.

Long term we might want to support cases where some of the pins are hard wired,
but that can happen when someone comes along with such a board.

Only thing I wonder is if the gpios could be moved under the child nodes
as I think they only apply to specific channels?  Would make the
driver a little more complex but the binding cleaner.

Thanks Krzysztof for all your reviews btw
(in general, rather than just this!)

Follow on comments inline...


> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> new file mode 100644
> index 000000000..037438737
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> @@ -0,0 +1,154 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2023 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,admfm2000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADMFM2000 Dual Microwave Down Converter
> +
> +maintainers:
> +  - Kim Seer Paller <kimseer.paller@analog.com>
> +
> +description:
> +  Dual microwave down converter module with input RF and LO frequency ranges
> +  from 0.5 to 32 GHz and an output IF frequency range from 0.1 to 8 GHz.
> +  It consists of a LNA, mixer, IF filter, DSA, and IF amplifier for each down
> +  conversion path.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,admfm2000
> +
> +  switch1-gpios:
> +    items:
> +      - description: B15 GPIO, when high (and B16 low) channel 1 is in
> +          Direct IF mode.
> +      - description: B16 GPIO, when high (and B15 low) channel 1 is in
> +          Mixer mode.
> +
> +  switch2-gpios:
> +    items:
> +      - description: K14 GPIO, when high (and L14 low) channel 2 is in
> +          Mixer mode.
> +      - description: L14 GPIO, when high (and K14 low) channel 2 is in
> +          Direct IF mode.
> +
> +  attenuation1-gpios:
> +    description: |
> +      Choice of attenuation:
> +      D15 D14 C16 C15 C14
I don't think there is a useful public data sheet, but normally I'd expect
these to have friendly names rather than pin coords.
chan0-att0, chan0-att1 or something like that.
Hopefully with something like that we could combine the docs if we can push
the GPIOs down into the child nodes.

> +      1   1   1   1   1   0 dB
> +      1   1   1   1   0   -1 dB
> +      1   1   1   0   1   -2 dB
> +      1   1   0   1   1   -4 dB
> +      1   0   1   1   1   -8 dB
> +      0   1   1   1   1   -16 dB
> +      0   0   0   0   0   -31 dB
> +
> +    items:
> +      - description: C14 GPIO
> +      - description: C15 GPIO
> +      - description: C16 GPIO
> +      - description: D14 GPIO
> +      - description: D15 GPIO
> +
> +  attenuation2-gpios:
> +    description: |
> +      Choice of attenuation:
> +      M16 M15 M14 L16 L15
> +      1   1   1   1   1   0 dB
> +      1   1   1   1   0   -1 dB
> +      1   1   1   0   1   -2 dB
> +      1   1   0   1   1   -4 dB
> +      1   0   1   1   1   -8 dB
> +      0   1   1   1   1   -16 dB
> +      0   0   0   0   0   -31 dB
> +
> +    items:
> +      - description: L15 GPIO
> +      - description: L16 GPIO
> +      - description: M14 GPIO
> +      - description: M15 GPIO
> +      - description: M16 GPIO
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "^channel@[0-1]$":
> +    type: object
> +    description: Represents a channel of the device.
> +
> +    additionalProperties: false
> +
> +    properties:
> +      reg:
> +        description:
> +          The channel number.
> +        minimum: 0
> +        maximum: 1
> +
> +      adi,mode:
> +        description:
> +          RF path selected for the channel.
> +            0 - Direct IF mode
> +            1 - Mixer mode
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1]
> +
> +    required:
> +      - reg
> +      - adi,mode
> +
> +required:
> +  - compatible
> +  - switch1-gpios
> +  - switch2-gpios
> +  - attenuation1-gpios
> +  - attenuation2-gpios




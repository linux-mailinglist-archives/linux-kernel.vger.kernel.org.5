Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB2A7A6A8D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 20:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjISSRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 14:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjISSRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 14:17:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58E290;
        Tue, 19 Sep 2023 11:17:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57882C433C7;
        Tue, 19 Sep 2023 18:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695147445;
        bh=9FOIOMjuXWZZMZl0MaBnALuWtI8U/oLy+w1/i6LR79s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TIpPVkzEHywAfBLYCt1PKj0q8enbxL0kMbj10QyKj2tMi9bogm3khvdZX1vZHx6t1
         nEZb7tURdTFnlk+CTvq3XEq+qsftzViqW5GDj4zhZ+rMVhF1/hNhyMfr3rg0lE46Y6
         TmGWEX+BNOKHI8frwBDXeZmRsQha3QdBsn5mpi2FCf1x9X1V6efeFhp9SHghAvxd+y
         kWEVCfsX78aUMmf3yxul90xnL1T9Bs8IcE6DitOL5hlLR9ESmt9HIkwwbhgOgU9DZ0
         zPlQRX3anZ3Vzvpr9aL8pQfz+MRQGqMDzEkWijpX+B40XA9YK4Gakda+ugS+CcT6yg
         +FjRtB40HNJlg==
Received: (nullmailer pid 4178543 invoked by uid 1000);
        Tue, 19 Sep 2023 18:17:23 -0000
Date:   Tue, 19 Sep 2023 13:17:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tylor Yang <tylor_yang@himax.corp-partner.google.com>
Cc:     dmitry.torokhov@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        poyuan_chang@himax.corp-partner.google.com, jingliang@chromium.org,
        hbarnor@chromium.org
Subject: Re: [PATCH V2 1/2] dt-bindings: input: Introduce Himax HID-over-SPI
 device
Message-ID: <20230919181723.GA4169859-robh@kernel.org>
References: <20230919024943.3088916-1-tylor_yang@himax.corp-partner.google.com>
 <20230919024943.3088916-2-tylor_yang@himax.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919024943.3088916-2-tylor_yang@himax.corp-partner.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 10:49:42AM +0800, Tylor Yang wrote:
> The Himax HID-over-SPI framework support for Himax touchscreen ICs
> that report HID packet through SPI bus. The driver core need reset
>  pin to meet reset timing spec. of IC. An interrupt pin to disable
> and enable interrupt when suspend/resume. An optional power control
> pin if target board needed. Panel id pins for identify panel is also
> an option.
> 
> Additional optional arguments:
> ic-det-delay-ms and ic-resume-delay-ms are using to solve runtime
> conditions.
> 
> This patch also add maintainer of this driver.
> 
> Signed-off-by: Tylor Yang <tylor_yang@himax.corp-partner.google.com>
> ---
>  .../bindings/input/himax,hid-over-spi.yaml    | 109 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +
>  2 files changed, 115 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/himax,hid-over-spi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/himax,hid-over-spi.yaml b/Documentation/devicetree/bindings/input/himax,hid-over-spi.yaml
> new file mode 100644
> index 000000000000..3ee3a89842ac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/himax,hid-over-spi.yaml
> @@ -0,0 +1,109 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/himax,hid-over-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Himax TDDI devices using SPI to send HID packets
> +
> +maintainers:
> +  - Tylor Yang <tylor_yang@himax.corp-partner.google.com>
> +
> +description: |
> +  Support the Himax TDDI devices which using SPI interface to acquire
> +  HID packets from the device. The device needs to be initialized using
> +  Himax protocol before it start sending HID packets.
> +
> +properties:
> +  compatible:
> +    const: himax,hid-over-spi

Doesn't look like a specific device. Compatibles are generally based on 
part numbers.

'over-spi' is redundant as the parent would be a spi controller.

> +
> +  reg:
> +    maxItems: 1
> +

> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0

These are for child nodes, but you don't have any.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  himax,rst-gpio:
> +    maxItems: 1
> +    description: Reset device, active low signal.

Use standard reset-gpios.

(-gpio is deprecated)

> +
> +  himax,irq-gpio:
> +    maxItems: 1
> +    description: Interrupt request, active low signal.

You have the interrupt already, why do you need this?

> +
> +  himax,3v3-gpio:
> +    maxItems: 1
> +    description: GPIO to control 3.3V power supply.

This should be a regulator supply. Then use gpio-regulator if it happens 
to be GPIO controlled.

> +
> +  himax,id-gpios:
> +    maxItems: 8
> +    description: GPIOs to read physical Panel ID. Optional.
> +
> +  spi-cpha: true
> +  spi-cpol: true
> +
> +  himax,ic-det-delay-ms:
> +    description:
> +      Due to TDDI properties, the TPIC detection timing must after the
> +      display panel initialized. This property is used to specify the
> +      delay time when TPIC detection and display panel initialization
> +      timing are overlapped. How much milliseconds to delay before TPIC
> +      detection start.
> +
> +  himax,ic-resume-delay-ms:
> +    description:
> +      Due to TDDI properties, the TPIC resume timing must after the
> +      display panel resumed. This property is used to specify the
> +      delay time when TPIC resume and display panel resume
> +      timing are overlapped. How much milliseconds to delay before TPIC
> +      resume start.

These should be implied by the compatible. Unless they are board 
specific and not device specific.

Rob

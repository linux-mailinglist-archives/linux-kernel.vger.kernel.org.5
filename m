Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4AA7B5955
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238613AbjJBRAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238598AbjJBRAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:00:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E78CD9
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:00:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EA1C433C8;
        Mon,  2 Oct 2023 17:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696266028;
        bh=3UbyqZIFaU6RJC2KOuQvJj8u1FhIUKRifoIKRVKlW9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oe7AKrswQVKt5UlDiKVSxuiRD2QnAnHROWGMNBPHHdFj6b3rzg71vcTho3JhcVpsJ
         EQj/R+RDo3YeYG/I7SMUvMI/WkfXl5pDsWO40OyzoWY6AJnkW8/4cMYv9qbyq/Ly9/
         /EyvByBCPqTrQ1iVbv0oUG1vE4Hv0vUVoDglY5NZne5XaIz8YUJfClfz8caBlHvTZy
         4poorrJtt3NdkTsnEWCDrdYShiBq+NmrlbiPJBnXPuDAQLKGbSeF9u/xTf4pGvS7C1
         wQKOoVsi6SfgJcOtpmUBrY5LbynOLWobJ1JIF2gZkbJ2ABeR8YREvJlCr0vqcuYii3
         KYCpwq72VoR8g==
Received: (nullmailer pid 1934730 invoked by uid 1000);
        Mon, 02 Oct 2023 17:00:25 -0000
Date:   Mon, 2 Oct 2023 12:00:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Piyush Mehta <piyush.mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, michal.simek@amd.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        peter.chen@kernel.org, linus.walleij@linaro.org,
        paul@crapouillou.net, arnd@arndb.de, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com
Subject: Re: [RFC PATCH 1/3] dt-binding: usb: ulpi-phy: add ulpi-phy binding
Message-ID: <20231002170025.GA1928031-robh@kernel.org>
References: <20230929064852.16642-1-piyush.mehta@amd.com>
 <20230929064852.16642-2-piyush.mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929064852.16642-2-piyush.mehta@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 12:18:50PM +0530, Piyush Mehta wrote:
> Create an ulpi-phy binding to read and write PHY registers with explicit
> control of the address and data using the usb.VIEWPORT register.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> ---
> This binding patch was created to support generic platforms. This binding
> will be modified in accordance with patch [3/3] procedures. One of the
> approch may be Create a zynq phy platform driver in "driver/usb/phy" with
> driver source "phy-ulpi-zynq-usb.c" and then the binding will be particular
> to the Xilinx/AMD zynq platform.
> 
> This binding was built with the Zynq hardware design example in consideration
> of as a generic platform. The viewport provide access the Chipidea controller
> to interface with the ULPI PHY.
> ---
>  .../devicetree/bindings/usb/ulpi-phy.yaml     | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/ulpi-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/ulpi-phy.yaml b/Documentation/devicetree/bindings/usb/ulpi-phy.yaml
> new file mode 100644
> index 000000000000..490b2f610129
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/ulpi-phy.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/ulpi-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ULPI PHY- Generic platform
> +
> +maintainers:
> +  - Piyush Mehta <piyush.mehta@amd.com>
> +
> +properties:
> +  compatible:
> +    const: ulpi-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#phy-cells':
> +    const: 0
> +
> +  external-drv-vbus:
> +    description:
> +      If present, configure ulpi-phy external supply to drive 5V on VBus.
> +    type: boolean
> +
> +  view-port:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Address to read and write PHY registers with explicit control of
> +      the address and data using the usb.VIEWPORT register.
> +
> +required:
> +  - compatible
> +  - reg
> +  - view-port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    phy0@e0002000 {
> +        compatible = "ulpi-phy";
> +        #phy-cells = <0x00>;
> +        reg = <0xe0002000 0x1000>;
> +        view-port = <0x170>;

I don't understand. Do you have an MMIO address and the VIEWPORT 
address to the PHY? You need both?

There's already a defined binding for ULPI bus:

Documentation/devicetree/bindings/usb/ulpi.txt

Why can't you use/expand that?

Rob

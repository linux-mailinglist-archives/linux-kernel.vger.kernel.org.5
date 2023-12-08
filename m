Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0937D80A076
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjLHKAd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Dec 2023 05:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjLHKAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:00:31 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1661720
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:00:38 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1rBXee-0002TW-Ni; Fri, 08 Dec 2023 11:00:20 +0100
Message-ID: <83ca3d88cdaa7bc6e6bd3c4e88518b155a6b0f05.camel@pengutronix.de>
Subject: Re: [PATCH 2/4] dt-bindings: imx6q-pcie: Add host-wake-gpio property
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Sherry Sun <sherry.sun@nxp.com>, hongxing.zhu@nxp.com,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 08 Dec 2023 11:00:19 +0100
In-Reply-To: <20231208091355.1417292-3-sherry.sun@nxp.com>
References: <20231208091355.1417292-1-sherry.sun@nxp.com>
         <20231208091355.1417292-3-sherry.sun@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sherry,

Am Freitag, dem 08.12.2023 um 17:13 +0800 schrieb Sherry Sun:
> Add host-wake-gpio property that can be used to wakeup the host
> processor.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index 81bbb8728f0f..944f0f961809 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -72,6 +72,10 @@ properties:
>        L=operation state) (optional required).
>      type: boolean
>  
> +  host-wake-gpio:

There is only one wake signal in PCIe and it has a defined direction,
so there is no point in specifying that it is a host wakeup. Also GPIO
handles without a traling 's' are deprecated. So this should be

wake-gpios

> +    description: Should specify the GPIO for controlling the PCI bus device
> +      wake signal, used to wakeup the host processor. Default to active-low.

The description is wrong. For the RC complex case (which is the binding
you are modifying here) the controller does not control the wake
signal, but instead uses it as a input. The description should reflect
that.

The default is also quite useless, as your implementation does not
allow to change it. Please translate the GPIO active flags from the DT
to the proper IRQ flags and drop this default here. The DT should
simply carry the proper polarity.

Regards,
Lucas

> +
>  required:
>    - compatible
>    - reg


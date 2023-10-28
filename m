Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAD67DA69B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 12:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjJ1K7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 06:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJ1K7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 06:59:40 -0400
Received: from connect.vanmierlo.com (fieber.vanmierlo.com [84.243.197.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ABCB4;
        Sat, 28 Oct 2023 03:59:35 -0700 (PDT)
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by connect.vanmierlo.com (Kerio Connect 10.0.2 patch 1) with ESMTPA;
        Sat, 28 Oct 2023 12:59:28 +0200
MIME-Version: 1.0
Date:   Sat, 28 Oct 2023 12:59:28 +0200
From:   m.brock@vanmierlo.com
To:     Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc:     git@amd.com, michal.simek@amd.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org, linux-arm-kernel@lists.infradead.org,
        radhey.shyam.pandey@amd.com, srinivas.goud@amd.com,
        shubhrajyoti.datta@amd.com, manion05gk@gmail.com
Subject: Re: [PATCH V3 1/2] dt-bindings: Add optional gpio property to uartps
 node to support rs485
In-Reply-To: <20231024144847.2316941-2-manikanta.guntupalli@amd.com>
References: <20231024144847.2316941-1-manikanta.guntupalli@amd.com>
 <20231024144847.2316941-2-manikanta.guntupalli@amd.com>
Message-ID: <ea3ee738155af7a0f19c2fef3a482a7d@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manikanta Guntupalli schreef op 2023-10-24 16:48:
> Add optional gpio property to uartps node and reference to rs485.yaml
> 
> On Xilinx/AMD Kria SOM KD240 board rs485 connects via TI ISOW1432
> Transceiver device, where one GPIO is used for driving DE/RE signals.
> With rs485 half duplex configuration, DE and RE are shorted to each 
> other,
> and at a time, any node acts as either a driver or a receiver.
> 
> Here,
> DE - Driver enable. If pin is floating, driver is disabled.
> RE - Receiver enable. If pin is floating, receiver buffer is disabled.
> 
> For more deatils, please find below link which contains Transceiver
> device(ISOW1432) datasheet
> https://www.ti.com/lit/ds/symlink/isow1432.pdf?ts=1682607122706&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FISOW1432%252Fpart-details%252FISOW1432DFMR%253FkeyMatch%253DISOW1432DFMR%2526tisearch%253Dsearch-everything%2526usecase%253DOPN
> 
> rts-gpios is optional property, because it is not required
> for uart console node.
> 
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> ---
> Changes for V2:
> Modify optional gpio name to xlnx,phy-ctrl-gpios.
> Update commit description.
> Changes for V3:
> Modify optional gpio name to rts-gpios.
> Update commit description.
> ---
>  Documentation/devicetree/bindings/serial/cdns,uart.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> index e35ad1109efc..7ee305f9a45f 100644
> --- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> @@ -46,6 +46,11 @@ properties:
>    power-domains:
>      maxItems: 1
> 
> +  rts-gpios:
> +    description: Optional GPIO to control transmit/receive on RS485 
> phy
> +      in halfduplex mode.
> +    maxItems: 1
> +

Why would this be related to RS485? A user could also have a need for a
gpio instead of the native pin to be used as normal rts.
All RS485 references can be removed.

>  required:
>    - compatible
>    - reg
> @@ -55,6 +60,7 @@ required:
> 
>  allOf:
>    - $ref: serial.yaml#
> +  - $ref: rs485.yaml#
>    - if:
>        properties:
>          compatible:

Maarten


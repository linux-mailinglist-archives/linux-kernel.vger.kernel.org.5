Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6507A7F4971
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344140AbjKVOxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjKVOxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:53:51 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5E3112;
        Wed, 22 Nov 2023 06:53:46 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 7C520100DA1D6;
        Wed, 22 Nov 2023 15:53:44 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 373E137FB2; Wed, 22 Nov 2023 15:53:44 +0100 (CET)
Date:   Wed, 22 Nov 2023 15:53:44 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 1/2] dt-bindings: serial: rs485: add rs485-mux-gpios
 binding
Message-ID: <20231122145344.GA18949@wunner.de>
References: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
 <20231120151056.148450-2-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120151056.148450-2-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 04:10:54PM +0100, Rasmus Villemoes wrote:
> Some boards are capable of both rs232 and rs485, and control which
> external terminals are active via a gpio-controlled mux. Allow
> describing that gpio in DT so that the kernel can transparently handle
> the proper setting when the uart is switched between rs232 and rs485
> modes.

Crescent CY Hsieh (+cc) is in parallel trying to add an RS-422 mode bit
to struct serial_rs485:

https://lore.kernel.org/all/20231121095122.15948-1-crescentcy.hsieh@moxa.com/

I don't know whether that makes sense at all (I had thought RS-422 is
the same as RS-485 with full-duplex, i.e. SER_RS485_ENABLED plus
SER_RS485_RX_DURING_TX).

But if that patch gets accepted, we'd have *three* different modes:
RS-232, RS-485, RS-422.  A single GPIO seems insufficient to handle that.
You'd need at least two GPIOs.


> --- a/Documentation/devicetree/bindings/serial/rs485.yaml
> +++ b/Documentation/devicetree/bindings/serial/rs485.yaml
> @@ -61,6 +61,11 @@ properties:
>        the active state enables RX during TX.
>      maxItems: 1
>  
> +  rs485-mux-gpios:
> +    description: GPIO pin to control muxing of the SOC signals to the RS485
> +      transceiver.
> +    maxItems: 1

The description doesn't really add much to the name "rs485-mux-gpios".

Suggestion:

    description: selects whether the UART is connect to an RS-232 driver (low)
      or an RS-485 transceiver (high)

Thanks,

Lukas

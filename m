Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1597F5C84
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344697AbjKWKiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjKWKh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:37:59 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49631BF;
        Thu, 23 Nov 2023 02:38:04 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id C2F8730000D0B;
        Thu, 23 Nov 2023 11:38:02 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B3F4C3E732; Thu, 23 Nov 2023 11:38:02 +0100 (CET)
Date:   Thu, 23 Nov 2023 11:38:02 +0100
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
Message-ID: <20231123103802.GA30056@wunner.de>
References: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
 <20231120151056.148450-2-linux@rasmusvillemoes.dk>
 <20231122145344.GA18949@wunner.de>
 <e731c0a9-7a5c-41c3-87aa-d6937b99d01a@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e731c0a9-7a5c-41c3-87aa-d6937b99d01a@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 11:07:16AM +0100, Rasmus Villemoes wrote:
> On 22/11/2023 15.53, Lukas Wunner wrote:
> > But if that patch gets accepted, we'd have *three* different modes:
> > RS-232, RS-485, RS-422.  A single GPIO seems insufficient to handle that.
> > You'd need at least two GPIOs.
> 
> I don't see Crescent introducing any new gpio that needs to be handled.
> In fact, I can't even see why from the perspective of the software that
> rs422 isn't just rs232; there's no transmit enable pin that needs to be
> handled. But maybe the uart driver does something different in rs422
> mode; I assume he must have some update of some driver, since otherwise
> the new rs422 bit should be rejected by the core. So I can't really see
> the whole picture of that rs422 story.

The question is, could we conceivably have the need to support
switching between the three modes RS-232, RS-485, RS-422.
If yes, then the GPIO mux interface should probably allow for that.

As a case in point, the Siemens IOT 2040 has two serial ports
which can be set to either of those three modes.  The signals
are routed to the same D-sub socket, but the pins used are
different.  See page 46 and 47 of this document:

https://cache.industry.siemens.com/dl/files/658/109741658/att_899623/v1/iot2000_operating_instructions_enUS_en-US.pdf

The driver for this product is 8250_exar.c.  It's an Intel-based
product, so no devicetree, but it shows that such use cases exist.

Thanks,

Lukas

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A5E775145
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 05:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjHIDNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 23:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjHIDM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 23:12:59 -0400
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2151BEF;
        Tue,  8 Aug 2023 20:12:56 -0700 (PDT)
Received: from pecola.lan (unknown [159.196.93.152])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 4317A20187;
        Wed,  9 Aug 2023 11:12:52 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1691550774;
        bh=i9oOIE6u25Hq6JcvLXnIndm0EgUPWueH7dpZORcm6s0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=BfoxO+o34AYXS6056PPsw4uzxqv0EsEoUSObxAmlPjdJwdn4eKucLcrZBjra1e80o
         cx0MTHGXvzFP2uC9B4okjn8ErRFg0+MbcxbpezxFGglsH/OmChpVGB6kYGic8/U0oe
         jJk7zTl7pHzYUdgrfKQBJMLMT5hXOyY6V5coM71OPc+XqshcsDrgTpM8B/GZVCDg+n
         sYJJBN6ZXfNNXbJG0rcadMH3sty2NEVaxH+DakbqPJwQZRW8WsLUDogoF46p7cOcB7
         YN/fxxaD5e/8x5bA5PBVmaZYKCPrsMNJ7R1h0zCU1o7JDGmvEA7hgKUowgXumnbUfe
         fk4Kz4fHI2KFg==
Message-ID: <ee48336f94f7e32de81e1f07facf0663c70091b0.camel@codeconstruct.com.au>
Subject: Re: [PATCH 0/3] Add Aspeed AST2600 I3C support
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     Dylan Hung <dylan_hung@aspeedtech.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     BMC-SW <BMC-SW@aspeedtech.com>,
        "kobedylan@gmail.com" <kobedylan@gmail.com>
Date:   Wed, 09 Aug 2023 11:12:51 +0800
In-Reply-To: <TYZPR06MB65674B8AA26D959254101A749C12A@TYZPR06MB6567.apcprd06.prod.outlook.com>
References: <20230808154241.749641-1-dylan_hung@aspeedtech.com>
         <d8d577e91779e045d5a2c7d701f65133a15b5d64.camel@codeconstruct.com.au>
         <TYZPR06MB65674B8AA26D959254101A749C12A@TYZPR06MB6567.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dylan,

> Thank you for your review. I3C1 and I3C2 can only operate in low
> voltage (1.0V/1.2V), which is why there are no HVI3C1 and HVI3C2
> pinctrl definitions.

Yep, and that was config that I hadn't tested (so hadn't proposed
pinctrl definitions for those).

> > For 2/3 and 3/3, you're adding a reset control for the global
> > register block within the per-controller driver, but we can already
> > do that on a global basis with the existing syscon device. Hence
> > this earlier change:
> =C2=A0
> I followed your recommendation and verified that it worked on my end.

OK, excellent!

> Should I resend the pinctrl patch as a stand-alone submission?

Yes, and feel free to add:

Reviewed-by: Jeremy Kerr <jk@codeconstruct.com.au>

Did your test use my i3c DTS definitions? If so, that's a decent
datapoint that the config works (on something other than my setup), and
so I'll submit upstream. Alternatively, feel free to include it with
your pinctrl change, if you like.

Cheers,


Jeremy

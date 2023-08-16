Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960C477E591
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344321AbjHPPtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344317AbjHPPsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:48:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373E326AD;
        Wed, 16 Aug 2023 08:48:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C07C566BA7;
        Wed, 16 Aug 2023 15:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A47C433C8;
        Wed, 16 Aug 2023 15:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692200930;
        bh=ghdt6AdH41KfTAlcIYsIHq+2Avnbydm6LpFq1rVtzKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CjjdoitglGByeou9WTbrVXAXxjl3ps/NoZUYYfxSlcSssaH8IcK4e4gv0dFvP71ff
         ODSf75T4FdeTxx0SQHXhUM/0SAo+GtsBCvhD1qKtFzjDBE28KhzIwgcPbwg5WU520A
         OUUiYWsWAYz8j58R0g2yELoawNtj7O4YaId719DY9zuCEoTTKf1S+irKxddcO2zqG0
         zMrwS3p4QRTuoDSz/+JO/7qzZnOzbH+MYfclv2rmjt50EuexM5GraIP+iFS1WrU4Uz
         JfB8AVybCtwMoPJKdhO3xmt3wjyxVsZGyCfIafz9tfw2iAWwTqkAw12QGKBt2OA91u
         4mhz9QvNJ2LIQ==
Date:   Wed, 16 Aug 2023 23:36:51 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 09/10] dt-bindings: net: snps,dwmac: add per
 channel irq support
Message-ID: <ZNztE0xM3eQCzLnq@xhacker>
References: <20230807164151.1130-1-jszhang@kernel.org>
 <20230807164151.1130-10-jszhang@kernel.org>
 <20230808-clapper-corncob-0af7afa65752@spud>
 <ZNUJSvJi+9QsWhAf@xhacker>
 <20230810-opossum-constable-719273142ce3@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230810-opossum-constable-719273142ce3@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 05:15:26PM +0100, Conor Dooley wrote:
> On Thu, Aug 10, 2023 at 11:59:06PM +0800, Jisheng Zhang wrote:
> > On Tue, Aug 08, 2023 at 08:39:58AM +0100, Conor Dooley wrote:
> > > On Tue, Aug 08, 2023 at 12:41:50AM +0800, Jisheng Zhang wrote:
> > > > The IP supports per channel interrupt, add support for this usage case.
> > > > 
> > > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > > ---
> > > >  .../devicetree/bindings/net/snps,dwmac.yaml   | 33 +++++++++++++++++++
> > > >  1 file changed, 33 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > > index 5d81042f5634..5a63302ad200 100644
> > > > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > > @@ -109,6 +109,7 @@ properties:
> > > >        - description: The interrupt that occurs when Rx exits the LPI state
> > > >        - description: The interrupt that occurs when Safety Feature Correctible Errors happen
> > > >        - description: The interrupt that occurs when Safety Feature Uncorrectible Errors happen
> > > > +      - description: All of the rx/tx per-channel interrupts
> > > >  
> > > >    interrupt-names:
> > > >      minItems: 1
> > > > @@ -118,6 +119,38 @@ properties:
> > > >        - const: eth_lpi
> > > >        - const: sfty_ce
> > > >        - const: sfty_ue
> > > > +      - const: rx0
> > > > +      - const: rx1
> > > > +      - const: rx2
> > > > +      - const: rx3
> > > > +      - const: rx4
> > > > +      - const: rx5
> > > > +      - const: rx6
> > > > +      - const: rx7
> > > > +      - const: rx8
> > > > +      - const: rx9
> > > > +      - const: rx10
> > > > +      - const: rx11
> > > > +      - const: rx12
> > > > +      - const: rx13
> > > > +      - const: rx14
> > > > +      - const: rx15
> > > > +      - const: tx0
> > > > +      - const: tx1
> > > > +      - const: tx2
> > > > +      - const: tx3
> > > > +      - const: tx4
> > > > +      - const: tx5
> > > > +      - const: tx6
> > > > +      - const: tx7
> > > > +      - const: tx8
> > > > +      - const: tx9
> > > > +      - const: tx10
> > > > +      - const: tx11
> > > > +      - const: tx12
> > > > +      - const: tx13
> > > > +      - const: tx14
> > > > +      - const: tx15
> > > 
> > > I don't think Rob's comment about having added 2 interrupts but 32
> > > interrupt names has been resolved.
> > 
> > I misunderstood Rob's comment. Now I'm not sure whether dt-binding
> > can support regex or something or not, or let ask for advice in the
> > following way: how could I write the dt-binding in this case? I didn't
> > find similar examples so far. I'm not sure listing possible
> > description and const properties for all channel interrupts is suitable.
> 
> I'm not sure that there is a better way. Rob maybe has a suggestion.
> 
> > > Did you actually test putting this many interrupts into a node?
> > > AFAICT, any more than 6 will cause complaints.
> > 
> > I tried 12rx and 12tx interrupts in a node, didn't see dtc warning.
> > so I guess the complaints are from dtb check? I will try to reproduce
> > them.
> 
> I triggered some by putting more entries into the example in this
> binding & doing dt binding check.

I reproduced the complaints and fixed them by adding additionalItems
and maxItems.

PS: those per-channel and safety irqs are optional.

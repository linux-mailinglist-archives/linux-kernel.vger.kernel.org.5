Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D4977B0BB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 07:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjHNF0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbjHNF0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:26:02 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05F59E77;
        Sun, 13 Aug 2023 22:26:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0C25D80A0;
        Mon, 14 Aug 2023 05:26:00 +0000 (UTC)
Date:   Mon, 14 Aug 2023 08:25:58 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: input: gpio-keys: Allow optional
 dedicated wakeirq
Message-ID: <20230814052558.GN11676@atomide.com>
References: <20230811110432.3968-1-tony@atomide.com>
 <20230811151048.GA3452914-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811151048.GA3452914-robh@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Rob Herring <robh@kernel.org> [230811 15:10]:
> On Fri, Aug 11, 2023 at 02:04:31PM +0300, Tony Lindgren wrote:
> > Allow configuring optional dedicated wakeirq that some SoCs have.
> > Let's use the interrupt naming "irq" and "wakeup" that we already have
> > in use for some drivers and subsystems like i2c.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  .../devicetree/bindings/input/gpio-keys.yaml      | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> > --- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
> > +++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> > @@ -31,7 +31,17 @@ patternProperties:
> >          maxItems: 1
> >  
> >        interrupts:
> > -        maxItems: 1
> > +        description:
> > +          Optional interrupts if different from the gpio interrupt
> > +        maxItems: 2
> > +
> > +      interrupt-names:
> > +        description:
> > +	  Optional interrupt names, can be used to specify a separate
> > +	  dedicated wake-up interrupt
> > +        items:
> > +          -const: irq
> > +          -const: wakeup
> 
> Also need a space after '-'.

Oops sorry about that, obviously I did not run make dtbs_check on this
binding. I guess I just grepped so we don't have interrupt-names in use
right now.

> >  
> >        label:
> >          description: Descriptive name of the key.
> > @@ -130,6 +140,9 @@ examples:
> >              label = "GPIO Key UP";
> >              linux,code = <103>;
> >              gpios = <&gpio1 0 1>;
> > +            interrupts-extended = <&intc_wakeup 0 IRQ_TYPE_LEVEL_HIGH>;
> > +            interrupt-names = "wakeup";
> 
> That's not what your schema allows. You need:
> 
> minItems: 1
> items:
>   - enum: [ irq, wakeup ]
>   - const: wakeup
> 
> (repeating 'wakeup' is disallowed globally for ".*-names".)

OK

> > +            wakeup-source;
> 
> Of course with this, a single interrupt is the wake-up source and 
> doesn't need a name. So you could define that 'interrupt-names' is only 
> used when there are 2 interrupts. In that case, the schema is right and 
> the example is wrong.

OK. So here's what gpio-keys currently allows:

1. gpios property with no interrupt in the dts, the driver tries to
   find the interrupt based on the gpio

2. gpios property with one interrupts property and no interrupt-names

And here's what we could allow in the binding with the wakeirq support
added:

1. gpios property with no interrupt in the dts, the driver tries to
   find the interrupt based on the gpio

2. gpios property with one interrupts property and no interrupt-names

3. gpios property with one interrupts property and interrupt-names = "irq"

4. gpios property with one wakeirq and interrupt-names = "wakeirq", the
   driver tries to find the io interrupt based on the gpio

5. gpios property with two interrupts and interrupt-names =
   "irq", "wakeirq"

So yeah we could only allow interrupt-names if there are two interrupts
like the attempted binding has. This would leave out #3 and #4 options
above. No need to limit these options from driver point of view though.
Any preferences on what the binding should have?

Regards,

Tony

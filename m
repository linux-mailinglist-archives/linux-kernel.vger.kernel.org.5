Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797C177928D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbjHKPK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjHKPK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:10:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501AC171F;
        Fri, 11 Aug 2023 08:10:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB76F636C8;
        Fri, 11 Aug 2023 15:10:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5B2C433C8;
        Fri, 11 Aug 2023 15:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691766655;
        bh=6tHNIakzOZTnV2MOtkXv7C8ojWN7aUtx68pmKRMzzRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C80Js42W/FnbCqP9zx+wVB425khcAuZo+ePYydFT3XnUBVXkKTkTYEEQPbiTD3Chs
         DuxqrCw5rzCcRMry/bmGEu6N6V04XWeDyVzVKzDVy+Z90LHh+RnIhrCXUPwNHYxHFh
         Hn4cKtxo66ri9PDrVH2kNPn+x2kqzNqst0R6656MC+FFRDUcYBQWN/oRmYJq/YZnhG
         8FzR8m7Tz9lDbxd7aRr5wkLI+LGAUmJCHEgS3gljKaMeZ8Wf5dfvacadNgTEr5hSms
         zu9PAGzIX6ntgztRShFxr2DJ5KfOOxGeUl4FhJS8aBar9cRNEVBniHtP2nY6Wm1Zm4
         lDpOg7EYcjKDA==
Received: (nullmailer pid 3474643 invoked by uid 1000);
        Fri, 11 Aug 2023 15:10:48 -0000
Date:   Fri, 11 Aug 2023 09:10:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: input: gpio-keys: Allow optional
 dedicated wakeirq
Message-ID: <20230811151048.GA3452914-robh@kernel.org>
References: <20230811110432.3968-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811110432.3968-1-tony@atomide.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 02:04:31PM +0300, Tony Lindgren wrote:
> Allow configuring optional dedicated wakeirq that some SoCs have.
> Let's use the interrupt naming "irq" and "wakeup" that we already have
> in use for some drivers and subsystems like i2c.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  .../devicetree/bindings/input/gpio-keys.yaml      | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> --- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
> +++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> @@ -31,7 +31,17 @@ patternProperties:
>          maxItems: 1
>  
>        interrupts:
> -        maxItems: 1
> +        description:
> +          Optional interrupts if different from the gpio interrupt
> +        maxItems: 2
> +
> +      interrupt-names:
> +        description:
> +	  Optional interrupt names, can be used to specify a separate
> +	  dedicated wake-up interrupt
> +        items:
> +          -const: irq
> +          -const: wakeup

Also need a space after '-'.

>  
>        label:
>          description: Descriptive name of the key.
> @@ -130,6 +140,9 @@ examples:
>              label = "GPIO Key UP";
>              linux,code = <103>;
>              gpios = <&gpio1 0 1>;
> +            interrupts-extended = <&intc_wakeup 0 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "wakeup";

That's not what your schema allows. You need:

minItems: 1
items:
  - enum: [ irq, wakeup ]
  - const: wakeup

(repeating 'wakeup' is disallowed globally for ".*-names".)

> +            wakeup-source;

Of course with this, a single interrupt is the wake-up source and 
doesn't need a name. So you could define that 'interrupt-names' is only 
used when there are 2 interrupts. In that case, the schema is right and 
the example is wrong.

Rob

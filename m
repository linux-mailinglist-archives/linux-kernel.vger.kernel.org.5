Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013157C032D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbjJJSN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbjJJSNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:13:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE68A99
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 11:13:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A951BC433C8;
        Tue, 10 Oct 2023 18:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696961631;
        bh=Y0jSZ418VJCO23r2Ek0he1ittaMBBbZlWHmICY7boL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qEAQjv4aEejMBWqYn38S2+3PR80PHRXRWNK1Dx95Y5A6yom9zyOIeEF6cFo+twTeq
         uZ4/xPF99dXObMnNONMVZoSxJwoA39XBiL1bCmTfF7slAs4HyYifhsmeFnYGsmHpOJ
         z7/17TuRZorVYQyesRcajWcQHAsB6VFr7hJtS0qLbwFqHn9wKhMZTktuM92okWRKr6
         2Zueo5eY/OjrQhpsTfGqH+9d9G3BHTukY6l1RSWt5sUADUIiz1OZMkUEohNOrbR8eI
         V7zLxZIQ+SQnZhH1PfuXb3EBG9SLb0BSZpzLkQA3cz/+4wuRiIl4glNLZz2CnBS2s7
         Oea/EP+68pMbA==
Received: (nullmailer pid 1210705 invoked by uid 1000);
        Tue, 10 Oct 2023 18:13:49 -0000
Date:   Tue, 10 Oct 2023 13:13:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/3] regulator: dt-bindings: fixed-regulator: Add
 under-voltage interrupt support
Message-ID: <20231010181349.GA1183365-robh@kernel.org>
References: <20231010085906.3440452-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010085906.3440452-1-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 10:59:04AM +0200, Oleksij Rempel wrote:
> Add under-voltage interrupt support. This can be used with simple
> regulators having no other way to communicate an under-voltage event
> except as by toggling some GPIO line.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
> index ac0281b1cceb..0f8760ed2fb1 100644
> --- a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
> @@ -100,6 +100,14 @@ properties:
>    vin-supply:
>      description: Input supply phandle.
> 
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Under-voltage interrupt
> +
> +  interrupt-names:
> +    const: under-voltage

No need for a name. If there's ever a 2nd, it should be a specific 
binding, not fixed-regulator.

> +
>  required:
>    - compatible
>    - regulator-name
> ---
>  .../devicetree/bindings/regulator/fixed-regulator.yaml    | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
> index ac0281b1cceb..0f8760ed2fb1 100644
> --- a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml

I think you've got some problems with your setup...

> @@ -100,6 +100,14 @@ properties:
>    vin-supply:
>      description: Input supply phandle.
>  
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Under-voltage interrupt
> +
> +  interrupt-names:
> +    const: under-voltage
> +
>  required:
>    - compatible
>    - regulator-name
> -- 
> 2.39.2
> 

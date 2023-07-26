Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E494763AF0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbjGZPYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjGZPYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:24:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF76D1FF0;
        Wed, 26 Jul 2023 08:24:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D83461B54;
        Wed, 26 Jul 2023 15:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8ED6C433C7;
        Wed, 26 Jul 2023 15:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690385081;
        bh=XtQHPjwlUAYxGYo7V7WNdtEo+xDINh3xf8oWKZdFtPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ajWOBzMzGhBoqzfc5/DW9aF/gzYa0wM+vSx2pxzmI/7dY0miIeIIjqjyBGxE0JzWb
         0+Be9ZPNi4QMYnzvKxNL06mLMrPnlHI6r1AFOiBDJf0fub79NUx64XIhQxnbfb0qAS
         0D2Qj+MXNiJeESeORBdztPo+ffbinai/Z+J5lIIuGm3cxF998g2HPKBJc4e4AKgdHr
         SWC1FzJ4EbDQNDK/SsYHmtcsCxrAyNLRVB7/n0Be8lW9ED2pkKPxE56jwkFYjX1z3x
         FdGILD3G7swQqW17sCU6lryDnJAMjG5uHjqnHSQ90YgI369/OKpvKUMfyTRSF281Do
         G3Z8h4PW665iA==
Received: (nullmailer pid 1474009 invoked by uid 1000);
        Wed, 26 Jul 2023 15:24:39 -0000
Date:   Wed, 26 Jul 2023 09:24:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 09/10] dt-bindings: net: snps,dwmac: add per
 channel irq support
Message-ID: <20230726152439.GA1471409-robh@kernel.org>
References: <20230723161029.1345-1-jszhang@kernel.org>
 <20230723161029.1345-10-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230723161029.1345-10-jszhang@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 12:10:28AM +0800, Jisheng Zhang wrote:
> The IP supports per channel interrupt, add support for this usage case.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index bb80ca205d26..525210c2c06c 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -101,6 +101,11 @@ properties:
>      minItems: 1
>      maxItems: 2
>  
> +  snps,per-channel-interrupt:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Indicates that Rx and Tx complete will generate a unique interrupt for each channel

Can't you determine this based on the number of interrupts or interrupt 
names?

> +
>    interrupts:
>      minItems: 1
>      items:
> @@ -109,6 +114,8 @@ properties:
>        - description: The interrupt that occurs when Rx exits the LPI state
>        - description: The interrupt that occurs when Safety Feature Correctible Errors happen
>        - description: The interrupt that occurs when Safety Feature Uncorrectible Errors happen
> +      - description: All of the rx per-channel interrupts
> +      - description: All of the tx per-channel interrupts

You added 2 interrupts here and...

>  
>    interrupt-names:
>      minItems: 1
> @@ -118,6 +125,22 @@ properties:
>        - const: eth_lpi
>        - const: sfty_ce_irq
>        - const: sfty_ue_irq
> +      - const: rx0
> +      - const: rx1
> +      - const: rx2
> +      - const: rx3
> +      - const: rx4
> +      - const: rx5
> +      - const: rx6
> +      - const: rx7
> +      - const: tx0
> +      - const: tx1
> +      - const: tx2
> +      - const: tx3
> +      - const: tx4
> +      - const: tx5
> +      - const: tx6
> +      - const: tx7

And 16 here?

>  
>    clocks:
>      minItems: 1
> -- 
> 2.40.1
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A5280CBA9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343746AbjLKNxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343790AbjLKNw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:52:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3876B10C8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702302764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rAKJhgDZFjppnOq8yVAY97GiR5RWWlY/Hz8yw7/jdJE=;
        b=J5rmR3tQi2M13PXqVKbiu0qKRCqPDiYfxjNKcfnUPTBk6hL8rfYQdW6oug3Y4mKq+TqNtZ
        zlbZOcwzDCVecUh7VvJAzh+N/Z/jzCfv1LvO+yIWnKtAKOuZBwmhdZ4fMrc02uBal82WrF
        vdLbXexObBBurpDn7dTHIIKE3TvnAw4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-7QkdT2GbNcOqZRo4dE_ZSA-1; Mon, 11 Dec 2023 08:52:41 -0500
X-MC-Unique: 7QkdT2GbNcOqZRo4dE_ZSA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-67ee1ca3b05so1808246d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:52:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702302761; x=1702907561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAKJhgDZFjppnOq8yVAY97GiR5RWWlY/Hz8yw7/jdJE=;
        b=Bt9gDQb7I2D+oe32D8sXFNn0mDQLi+564hDBmcNy5OhKRFvJQflf94OWm0mMvRkHLK
         NJtBcBEG96FSX/pWk+0ssiOVGNJtvYPm3vh3mtNeYx5f1zo5kySchecXX/dbbKV5DPyS
         tWkZF4TK/94ioS64Gip45PDp2n77FO4PNg8vcNPfUsdamkAKLtUK1GswIwsYVwPpup51
         OzkZy7EDd6Q2Fvq+Yt4+1bdKHKGDQALKw8LIYjdxug9jYK5P/o53jBgIRKG1QrJp+NIq
         sfLtbcGBM0oKonhv0KNQoeyoR3JOJjXFqkFYkE8/lMMb1QzdvFoHmKKunuLA+tkaSHFo
         OKXg==
X-Gm-Message-State: AOJu0YyNE3+ZYxbvkTrey/xknQY7cbMpBUgeEcX95hBYEC4TAGIpAvSo
        KTQbFc9UWAHO1NO3l6UcDb7VDGHlxaN/0xPPybdsXg/ie4dWM5E4nhbNYCKFdVuSIS/sQhWnCFS
        m3WDdxOiEky/sAhFZ4NxDONEh
X-Received: by 2002:ad4:452a:0:b0:67a:5887:b55d with SMTP id l10-20020ad4452a000000b0067a5887b55dmr4932134qvu.49.1702302760910;
        Mon, 11 Dec 2023 05:52:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzx/nt6T6DLUCU49cSJD+NhxTBsGn6eVt/zPBsL7ZgqtW6sJsBZ5K+Q5WGQkXV6vBLIadoeg==
X-Received: by 2002:ad4:452a:0:b0:67a:5887:b55d with SMTP id l10-20020ad4452a000000b0067a5887b55dmr4932121qvu.49.1702302760605;
        Mon, 11 Dec 2023 05:52:40 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id tc6-20020a05620a2cc600b0077db614cb7fsm2936968qkn.8.2023.12.11.05.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 05:52:40 -0800 (PST)
Date:   Mon, 11 Dec 2023 07:52:37 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Suraj Jaiswal <quic_jsuraj@quicinc.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Rob Herring <robh@kernel.org>, kernel@quicinc.com
Subject: Re: [PATCH net-next v5 1/3] dt-bindings: net: qcom,ethqos: add
 binding doc for safety IRQ for sa8775p
Message-ID: <2ihncgvnfxgzj5kfm3eedvj3jvru7fokpno5pdzgtnuuy2mpqf@sfuzuugeuxzh>
References: <20231211080153.3005122-1-quic_jsuraj@quicinc.com>
 <20231211080153.3005122-2-quic_jsuraj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211080153.3005122-2-quic_jsuraj@quicinc.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 01:31:51PM +0530, Suraj Jaiswal wrote:
> Add binding doc for safety IRQ. The safety IRQ will be
> triggered for ECC(error correction code), DPP(data path
> parity), FSM(finite state machine) error.
> 
> Signed-off-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>

Rob gave you his Reviewed-by over here on the last revision:

    https://lore.kernel.org/netdev/170206782161.2661547.16311911491075108498.robh@kernel.org/

in the future if someone gives you a tag you should add it to the patch
for the next revision you send out (assuming you have to send out
another version, otherwise the maintainers will collect the tags when
they merge that version of the series). If the patches change a lot then
it makes sense to remove the tag since it wasn't what they reviewed, but
in this case you've only expanded a comment in the commit message so it is
appropriate to be present.

> ---
>  Documentation/devicetree/bindings/net/qcom,ethqos.yaml | 9 ++++++---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml  | 6 ++++--
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
> index 7bdb412a0185..93d21389e518 100644
> --- a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
> @@ -37,12 +37,14 @@ properties:
>      items:
>        - description: Combined signal for various interrupt events
>        - description: The interrupt that occurs when Rx exits the LPI state
> +      - description: The interrupt that occurs when HW safety error triggered
>  
>    interrupt-names:
>      minItems: 1
>      items:
>        - const: macirq
> -      - const: eth_lpi
> +      - enum: [eth_lpi, safety]
> +      - const: safety
>  
>    clocks:
>      maxItems: 4
> @@ -89,8 +91,9 @@ examples:
>                 <&gcc GCC_ETH_PTP_CLK>,
>                 <&gcc GCC_ETH_RGMII_CLK>;
>        interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
> -                   <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
> -      interrupt-names = "macirq", "eth_lpi";
> +                   <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 782 IRQ_TYPE_LEVEL_HIGH>;
> +      interrupt-names = "macirq", "eth_lpi", "safety";
>  
>        rx-fifo-depth = <4096>;
>        tx-fifo-depth = <4096>;
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 5c2769dc689a..3b46d69ea97d 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -107,13 +107,15 @@ properties:
>        - description: Combined signal for various interrupt events
>        - description: The interrupt to manage the remote wake-up packet detection
>        - description: The interrupt that occurs when Rx exits the LPI state
> +      - description: The interrupt that occurs when HW safety error triggered
>  
>    interrupt-names:
>      minItems: 1
>      items:
>        - const: macirq
> -      - enum: [eth_wake_irq, eth_lpi]
> -      - const: eth_lpi
> +      - enum: [eth_wake_irq, eth_lpi, safety]
> +      - enum: [eth_wake_irq, eth_lpi, safety]
> +      - enum: [eth_wake_irq, eth_lpi, safety]
>  
>    clocks:
>      minItems: 1
> -- 
> 2.25.1
> 


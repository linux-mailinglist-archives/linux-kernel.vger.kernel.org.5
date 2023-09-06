Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE8C793B36
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239718AbjIFL2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239789AbjIFL2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:28:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94548E43;
        Wed,  6 Sep 2023 04:28:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E76C433C8;
        Wed,  6 Sep 2023 11:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693999668;
        bh=q9ciEOHMnsTFO7RAfeTUxUw+CAerD715PLa94O5dEw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s3QAcRz5pHayE+Km2AtBpMf8EhBY2b4mtvkXbYR9y22Oso1Rn97Ub940VCPQioqzS
         P2acX6JMW6HkR3/xoHozZAMjzeyBwg0lvzEYRt4QSLsM7Z6LoDJBK61rFr/DWPaH6h
         SHoSyKmkyGgE1Afy3zRKNUlb7GFBwr9iHebXzL2eaU6MMR+rfOOpqOozUyA6CpQyr9
         RZ34lx+CbY09ksmw15SdkzOk3zfRl+so22kC0gicp50cS9HNpJs2BlGUnvE+tHUhbH
         z+9dy75OiqkolsEDG4MXj3UGhtidzJp7dhGi/7b1heZSiMG/Z+biFSXjLC/UBuh0x4
         E/Zp7YgJ1oKvg==
Date:   Wed, 6 Sep 2023 13:27:43 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fang Xiang <fangxiang3@xiaomi.com>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller: arm,gic-v3:
 Add dma-noncoherent property
Message-ID: <ZPhiL3jyfmHqNqfP@lpieralisi>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20230906094139.16032-1-lpieralisi@kernel.org>
 <20230906094139.16032-2-lpieralisi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906094139.16032-2-lpieralisi@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 11:41:38AM +0200, Lorenzo Pieralisi wrote:
> The GIC v3 specifications allow redistributors and ITSes interconnect
> ports used to access memory to be wired up in a way that makes the
> respective initiators/memory observers non-coherent.
> 
> Add the standard dma-noncoherent property to the GICv3 bindings to
> allow firmware to describe the redistributors/ITSes components and
> interconnect ports behaviour in system designs where the redistributors
> and ITSes are not coherent with the CPU.
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/interrupt-controller/arm,gic-v3.yaml    | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
> index 39e64c7f6360..c9bc9aad93f1 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
> @@ -106,6 +106,12 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      maximum: 4096
>  
> +  dma-noncoherent:
> +    description:
> +      Present if the GIC redistributors permit programming shareability
> +      and cacheability attributes but are connected to a non-coherent
> +      downstream interconnect.
> +
>    msi-controller:
>      description:
>        Only present if the Message Based Interrupt functionality is
> @@ -193,6 +199,12 @@ patternProperties:
>        compatible:
>          const: arm,gic-v3-its
>  
> +      dma-noncoherent:
> +        description:
> +          Present if the GIC ITS permits programming shareability and
> +          cacheability attributes but are connected to a non-coherent

s/are/is

Sorry, I will update the patch accordingly.

Lorenzo

> +          downstream interconnect.
> +
>        msi-controller: true
>  
>        "#msi-cells":
> -- 
> 2.34.1
> 

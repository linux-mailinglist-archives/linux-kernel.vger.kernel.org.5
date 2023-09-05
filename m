Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5000792F9A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242713AbjIEUJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242637AbjIEUIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:08:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D6913E;
        Tue,  5 Sep 2023 13:08:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BD0C433AB;
        Tue,  5 Sep 2023 18:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693938202;
        bh=f5XQvJk5/c9p3k+Qxl5FlmeLFvNUh3n8mq/IZU94fJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gw97UJ3GEAtKV8c69QUg+iqlVSpKPc2+dI1OI3EsH0vmJxF5mNA5np+wr7r+Y/+XZ
         9pWlIZrKoMrC9mF/tkdb3SChF5FpdBOmpcS/Z/WgMysa/pXaHkQg+lhpyKqsFXNbZK
         Ths6hTai/Q3atThScl2ZHNmsYdCh8Ws9l7Pw+Jj5tH1LhIWgYtX1yXpxTZXjEz2QrE
         NpHtNFP10ms39tJyLqpHtxvOx4Dhg9mz1FN6hPfu1ZI5rp4CJepcheGk94xMMdSGCj
         cx/EytwRqPS1Zh4NCAjmJkTLhd5t1xUHxmn9iTp+/Xy2c9EmDf8LVkYs36/L7sAk2h
         jD4+1KO0jHRBw==
Received: (nullmailer pid 3751384 invoked by uid 1000);
        Tue, 05 Sep 2023 18:23:20 -0000
Date:   Tue, 5 Sep 2023 13:23:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Fang Xiang <fangxiang3@xiaomi.com>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: interrupt-controller: arm,gic-v3: Add
 dma-noncoherent property
Message-ID: <20230905182320.GA3744871-robh@kernel.org>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20230905104721.52199-2-lpieralisi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905104721.52199-2-lpieralisi@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 12:47:20PM +0200, Lorenzo Pieralisi wrote:
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
>  .../bindings/interrupt-controller/arm,gic-v3.yaml         | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
> index 39e64c7f6360..0a81ae4519a6 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
> @@ -106,6 +106,10 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      maximum: 4096
>  
> +  dma-noncoherent:
> +    description: |

Don't need the '|' if no formatting to preserve.

> +      Present if the GIC redistributors are not cache coherent with the CPU.
> +
>    msi-controller:
>      description:
>        Only present if the Message Based Interrupt functionality is
> @@ -193,6 +197,10 @@ patternProperties:
>        compatible:
>          const: arm,gic-v3-its
>  
> +      dma-noncoherent:
> +        description: |
> +          Present if the GIC ITS is not cache coherent with the CPU.
> +
>        msi-controller: true
>  
>        "#msi-cells":
> -- 
> 2.34.1
> 

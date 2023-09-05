Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298A6792B1F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241058AbjIEQsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354392AbjIELSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:18:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC6EC1AE;
        Tue,  5 Sep 2023 04:18:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31E9611FB;
        Tue,  5 Sep 2023 04:18:39 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF5BA3F64C;
        Tue,  5 Sep 2023 04:17:59 -0700 (PDT)
Message-ID: <932355b4-7d43-a465-a2da-8dded8e2d069@arm.com>
Date:   Tue, 5 Sep 2023 12:17:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: interrupt-controller: arm,gic-v3: Add
 dma-noncoherent property
Content-Language: en-GB
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fang Xiang <fangxiang3@xiaomi.com>,
        Marc Zyngier <maz@kernel.org>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20230905104721.52199-2-lpieralisi@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230905104721.52199-2-lpieralisi@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2023 11:47 am, Lorenzo Pieralisi wrote:
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
>   .../bindings/interrupt-controller/arm,gic-v3.yaml         | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
> index 39e64c7f6360..0a81ae4519a6 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
> @@ -106,6 +106,10 @@ properties:
>       $ref: /schemas/types.yaml#/definitions/uint32
>       maximum: 4096
>   
> +  dma-noncoherent:
> +    description: |
> +      Present if the GIC redistributors are not cache coherent with the CPU.

I wonder if it's worth being a bit more specific here, e.g. "if the GIC 
{redistributors,ITS} permit programming cacheable inner-shareable memory 
attributes, but are connected to a non-coherent downstream 
interconnect." That might help clarify why the negative property, which 
could seem a bit backwards at first glance, and that it's not so 
important in the cases where the GIC itself is fundamentally 
non-coherent anyway (which *is* software-discoverable).

Otherwise, this is the same approach that I like and have previously 
lobbied for, so obviously I approve :)

(plus I do think it's the right shape to be able to slot an equivalent 
field into ACPI MADT entries without *too* much bother)

Thanks,
Robin.

> +
>     msi-controller:
>       description:
>         Only present if the Message Based Interrupt functionality is
> @@ -193,6 +197,10 @@ patternProperties:
>         compatible:
>           const: arm,gic-v3-its
>   
> +      dma-noncoherent:
> +        description: |
> +          Present if the GIC ITS is not cache coherent with the CPU.
> +
>         msi-controller: true
>   
>         "#msi-cells":

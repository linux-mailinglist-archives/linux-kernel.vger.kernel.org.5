Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645B2792B2B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242961AbjIEQtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354533AbjIEMWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:22:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706681A8;
        Tue,  5 Sep 2023 05:22:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05AB660686;
        Tue,  5 Sep 2023 12:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9ADC433C7;
        Tue,  5 Sep 2023 12:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693916567;
        bh=SoNW2HIc86v/ID8fpk0tLx5Hbits5RDiuL3Og0Y11Fs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M91M2qjYeHxPHsS+sEAzDLTaa25Cp66UkgL/p5L0b9ufh1drfgHSzZ6FQ/1DZr+ey
         QbnrPvUeEWQSguEWNg34rKqKqxxwyhvXBoaqCpTG3gCIswqLR5FBuVcoWljYaYanH3
         E7TNBDkAUXzzO8UrTLUyfPtOhGGLU5LF7iwD68oQJRHKMkB1cnYpdmcgHLsTFsFPWb
         +9e28y1UXEINMQpTxiEiRvky+cuwmElTZiLARmV85SmDdB6MME8Ng3y1U0sIsAu63E
         y1zb0CAGseuP4pD8O0h8Fmce62dW+rcL3ps/qri/EYYyjZnycN9wgPQIGFtaKRzBL1
         zg2uEle1EpS4g==
Date:   Tue, 5 Sep 2023 14:22:42 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fang Xiang <fangxiang3@xiaomi.com>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: interrupt-controller: arm,gic-v3: Add
 dma-noncoherent property
Message-ID: <ZPcdkob6L8RbUVP3@lpieralisi>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20230905104721.52199-2-lpieralisi@kernel.org>
 <932355b4-7d43-a465-a2da-8dded8e2d069@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <932355b4-7d43-a465-a2da-8dded8e2d069@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 12:17:51PM +0100, Robin Murphy wrote:
> On 05/09/2023 11:47 am, Lorenzo Pieralisi wrote:
> > The GIC v3 specifications allow redistributors and ITSes interconnect
> > ports used to access memory to be wired up in a way that makes the
> > respective initiators/memory observers non-coherent.
> > 
> > Add the standard dma-noncoherent property to the GICv3 bindings to
> > allow firmware to describe the redistributors/ITSes components and
> > interconnect ports behaviour in system designs where the redistributors
> > and ITSes are not coherent with the CPU.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Rob Herring <robh@kernel.org>
> > ---
> >   .../bindings/interrupt-controller/arm,gic-v3.yaml         | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
> > index 39e64c7f6360..0a81ae4519a6 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
> > @@ -106,6 +106,10 @@ properties:
> >       $ref: /schemas/types.yaml#/definitions/uint32
> >       maximum: 4096
> > +  dma-noncoherent:
> > +    description: |
> > +      Present if the GIC redistributors are not cache coherent with the CPU.
> 
> I wonder if it's worth being a bit more specific here, e.g. "if the GIC
> {redistributors,ITS} permit programming cacheable inner-shareable memory
> attributes, but are connected to a non-coherent downstream interconnect."

In my opinion it is and I wanted to elaborate on what I wrote but then I
thought that this is a standard DT property, I wasn't sure whether we
really need to explain what it is there for.

We are using the property to plug a hole so I agree with you, we should
be as clear as possible in the property definition but I will rely on
Rob/Marc's opinion, I don't know what's the DT policy for this.

> That might help clarify why the negative property, which could seem a bit
> backwards at first glance, and that it's not so important in the cases where
> the GIC itself is fundamentally non-coherent anyway (which *is*
> software-discoverable).

Is it ? Again, see above, are we defining "dma-noncoherent" to fix a bug
or to fix the specs ? The shareability bits are writeable and even a
fundamentally non-coherent GIC design could allow writing them, AFAIU.

I would avoid putting ourselves into a corner where we can't use
this property because the binding itself is too strict on what it is
solving.
 
> Otherwise, this is the same approach that I like and have previously lobbied
> for, so obviously I approve :)
> 
> (plus I do think it's the right shape to be able to slot an equivalent field
> into ACPI MADT entries without *too* much bother)

We are in agreement, let's see what others think.

Thanks,
Lorenzo

> 
> Thanks,
> Robin.
> 
> > +
> >     msi-controller:
> >       description:
> >         Only present if the Message Based Interrupt functionality is
> > @@ -193,6 +197,10 @@ patternProperties:
> >         compatible:
> >           const: arm,gic-v3-its
> > +      dma-noncoherent:
> > +        description: |
> > +          Present if the GIC ITS is not cache coherent with the CPU.
> > +
> >         msi-controller: true
> >         "#msi-cells":
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

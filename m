Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACF1793AFA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238779AbjIFLX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbjIFLX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:23:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE34519BA;
        Wed,  6 Sep 2023 04:23:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74098C433C8;
        Wed,  6 Sep 2023 11:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693999415;
        bh=NRdLoNKhI8PWwsTXFAHLBFbX98sCx24HY9qcuOQXDrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J/cktlELZjjFahQnUXwth9JUwqt0zVB8hl4mjsD38asMKwfIO6h0ESe0N21OLwfql
         vrb9qQpj667aDi5/TR7UiZURX5jxJPBU+q4uC78G/1gU57abzufMBeMbzEClls9/ry
         lA6qeCiuhBL4KGSWa9f8HhZLEs0ls/XMUevagvIiPCu0yqmjWOomzQ1w4N0VdmFqa5
         EdesLxbYag3193XemqEnlsqHEdDsJt8N+XyAx3LVwUUsko12huWHl25uJ6p0oxPbvr
         0HRW3wbXSfX4yHzTTzPufTv7zV4sWm5PFYb+sAFrU6r/ge1o4xXhI3Bo2vGpr0El0z
         DQ7SGMsW8mwhA==
Date:   Wed, 6 Sep 2023 13:23:30 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fang Xiang <fangxiang3@xiaomi.com>
Subject: Re: [PATCH v2 0/2] irqchip/gic-v3: Enable non-coherent GIC designs
 probing
Message-ID: <ZPhhMvyx8lChHE0v@lpieralisi>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20230906094139.16032-1-lpieralisi@kernel.org>
 <6f94c6d38f00031bf7c59e0cb8baf04c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f94c6d38f00031bf7c59e0cb8baf04c@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 10:52:01AM +0100, Marc Zyngier wrote:
> On 2023-09-06 10:41, Lorenzo Pieralisi wrote:
> > This series is v2 of a previous version[1].
> > 
> > v1 -> v2:
> > 	- Updated DT bindings as per feedback
> > 	- Updated patch[2] to use GIC quirks infrastructure
> > 
> > [1]
> > https://lore.kernel.org/all/20230905104721.52199-1-lpieralisi@kernel.org
> > 
> > Original cover letter
> > ---
> > The GICv3 architecture specifications provide a means for the
> > system programmer to set the shareability and cacheability
> > attributes the GIC components (redistributors and ITSes) use
> > to drive memory transactions.
> > 
> > Albeit the architecture give control over shareability/cacheability
> > memory transactions attributes (and barriers), it is allowed to
> > connect the GIC interconnect ports to non-coherent memory ports
> > on the interconnect, basically tying off shareability/cacheability
> > "wires" and de-facto making the redistributors and ITSes non-coherent
> > memory observers.
> > 
> > This series aims at starting a discussion over a possible solution
> > to this problem, by adding to the GIC device tree bindings the
> > standard dma-noncoherent property. The GIC driver uses the property
> > to force the redistributors and ITSes shareability attributes to
> > non-shareable, which consequently forces the driver to use CMOs
> > on GIC memory tables.
> > 
> > On ARM DT DMA is default non-coherent, so the GIC driver can't rely
> > on the generic DT dma-coherent/non-coherent property management layer
> > (of_dma_is_coherent()) which would default all GIC designs in the field
> > as non-coherent; it has to rely on ad-hoc dma-noncoherent property
> > handling.
> > 
> > When a consistent approach is agreed upon for DT an equivalent binding
> > will
> > be put forward for ACPI based systems.
> 
> What is the plan for this last point? I'd like to see at least
> a proposal before taking this series in.

Absolutely, I am starting a thread on related MADT changes, should not take
too long.

Lorenzo

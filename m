Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9897AA2D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjIUVew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjIUVeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:34:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A68855AD6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:17:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BADC3278E;
        Thu, 21 Sep 2023 10:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695291104;
        bh=AdutLBV21eG6/I5c7ck2kz5+kkufzxzMbnOhofwlRNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FWi/MotY0IkufMUjM3uKZhdm+J7+OHxVMKxpp9S4ULn+0QBoAqNetS57FJt/Z82Jj
         O4jZOEpZ3K3DMsxVN+AsCK9an9VanRO9LUCPf2MBL+cJpjENamWN9SyImsDiZcXI9M
         m/tL9UhfOGgSLpLh2gRs6oovaNH1q5HV9y/R/oWLEwq2s5zLxtdLlG9agn0VqQhJiG
         4zdLRFTvjZau67sD0cWB/t3ORDx8iPIqHJOL3U47iHQx+k5Fv7q0/+lvXkWbeAnYgD
         B8+L/gxKzFZDKtMqiOqOSatrbOTGqf6csrNnPMWYgsj50Ls9fgs4iFIk4auWYhyVOr
         x+I/nBQXLndPw==
Date:   Thu, 21 Sep 2023 12:11:39 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fang Xiang <fangxiang3@xiaomi.com>
Subject: Re: [PATCH v2 0/2] irqchip/gic-v3: Enable non-coherent GIC designs
 probing
Message-ID: <ZQwW286bqB8dE2XN@lpieralisi>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20230906094139.16032-1-lpieralisi@kernel.org>
 <6f94c6d38f00031bf7c59e0cb8baf04c@kernel.org>
 <ZPhhMvyx8lChHE0v@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPhhMvyx8lChHE0v@lpieralisi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 01:23:30PM +0200, Lorenzo Pieralisi wrote:
> On Wed, Sep 06, 2023 at 10:52:01AM +0100, Marc Zyngier wrote:
> > On 2023-09-06 10:41, Lorenzo Pieralisi wrote:
> > > This series is v2 of a previous version[1].
> > > 
> > > v1 -> v2:
> > > 	- Updated DT bindings as per feedback
> > > 	- Updated patch[2] to use GIC quirks infrastructure
> > > 
> > > [1]
> > > https://lore.kernel.org/all/20230905104721.52199-1-lpieralisi@kernel.org
> > > 
> > > Original cover letter
> > > ---
> > > The GICv3 architecture specifications provide a means for the
> > > system programmer to set the shareability and cacheability
> > > attributes the GIC components (redistributors and ITSes) use
> > > to drive memory transactions.
> > > 
> > > Albeit the architecture give control over shareability/cacheability
> > > memory transactions attributes (and barriers), it is allowed to
> > > connect the GIC interconnect ports to non-coherent memory ports
> > > on the interconnect, basically tying off shareability/cacheability
> > > "wires" and de-facto making the redistributors and ITSes non-coherent
> > > memory observers.
> > > 
> > > This series aims at starting a discussion over a possible solution
> > > to this problem, by adding to the GIC device tree bindings the
> > > standard dma-noncoherent property. The GIC driver uses the property
> > > to force the redistributors and ITSes shareability attributes to
> > > non-shareable, which consequently forces the driver to use CMOs
> > > on GIC memory tables.
> > > 
> > > On ARM DT DMA is default non-coherent, so the GIC driver can't rely
> > > on the generic DT dma-coherent/non-coherent property management layer
> > > (of_dma_is_coherent()) which would default all GIC designs in the field
> > > as non-coherent; it has to rely on ad-hoc dma-noncoherent property
> > > handling.
> > > 
> > > When a consistent approach is agreed upon for DT an equivalent binding
> > > will
> > > be put forward for ACPI based systems.
> > 
> > What is the plan for this last point? I'd like to see at least
> > a proposal before taking this series in.
> 
> Absolutely, I am starting a thread on related MADT changes, should not
> take too long.

Quick update, bindings filed, I will code against it but we should
not merge anything till it is approved (could be missing v6.7 timeline).

https://bugzilla.tianocore.org/show_bug.cgi?id=4557

Lorenzo

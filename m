Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1867F7938E2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbjIFJwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbjIFJwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:52:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BD2E45;
        Wed,  6 Sep 2023 02:52:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91CEC433C7;
        Wed,  6 Sep 2023 09:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693993923;
        bh=mmp8U7p0dsAb7N7ZOUIzbHp3mn89D9lJHI7IHcFjwRo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fTuiTzK78yx9q/vHwz/EqLAO9mj/Zi2bgCReid1F9tXrrAW+oFQX7uwbKbZeXG8e8
         edCZTS8PfSjdDiNcOxPPCm+lo+fSwTqFRFlS71EOBr2YUZLfIw2Lq6ZXdVqxOPIRkV
         XOUEDtYBdxXkKpvBU/oH9cKEB9ki0XCqRRdAQT6uvrkq8ae7XKpM/Or1kEy72wjeDD
         XXmTRfTbdu6FWQMPV+k2eJDHwQ0v4n2zzXxAPmVxFVlH1dkUxit57eht6G8NEU3xEg
         8z/YaxBmRarOMcRLWhWN1FGN02pSyttK+8BF0IfotpB43Szu5qtNlyD2udfi9fiu1R
         WQx23mXUpZH0Q==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1qdpCb-00ApB2-9E;
        Wed, 06 Sep 2023 10:52:01 +0100
MIME-Version: 1.0
Date:   Wed, 06 Sep 2023 10:52:01 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fang Xiang <fangxiang3@xiaomi.com>
Subject: Re: [PATCH v2 0/2] irqchip/gic-v3: Enable non-coherent GIC designs
 probing
In-Reply-To: <20230906094139.16032-1-lpieralisi@kernel.org>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20230906094139.16032-1-lpieralisi@kernel.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <6f94c6d38f00031bf7c59e0cb8baf04c@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: lpieralisi@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, mark.rutland@arm.com, robin.murphy@arm.com, robh+dt@kernel.org, fangxiang3@xiaomi.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-06 10:41, Lorenzo Pieralisi wrote:
> This series is v2 of a previous version[1].
> 
> v1 -> v2:
> 	- Updated DT bindings as per feedback
> 	- Updated patch[2] to use GIC quirks infrastructure
> 
> [1] 
> https://lore.kernel.org/all/20230905104721.52199-1-lpieralisi@kernel.org
> 
> Original cover letter
> ---
> The GICv3 architecture specifications provide a means for the
> system programmer to set the shareability and cacheability
> attributes the GIC components (redistributors and ITSes) use
> to drive memory transactions.
> 
> Albeit the architecture give control over shareability/cacheability
> memory transactions attributes (and barriers), it is allowed to
> connect the GIC interconnect ports to non-coherent memory ports
> on the interconnect, basically tying off shareability/cacheability
> "wires" and de-facto making the redistributors and ITSes non-coherent
> memory observers.
> 
> This series aims at starting a discussion over a possible solution
> to this problem, by adding to the GIC device tree bindings the
> standard dma-noncoherent property. The GIC driver uses the property
> to force the redistributors and ITSes shareability attributes to
> non-shareable, which consequently forces the driver to use CMOs
> on GIC memory tables.
> 
> On ARM DT DMA is default non-coherent, so the GIC driver can't rely
> on the generic DT dma-coherent/non-coherent property management layer
> (of_dma_is_coherent()) which would default all GIC designs in the field
> as non-coherent; it has to rely on ad-hoc dma-noncoherent property 
> handling.
> 
> When a consistent approach is agreed upon for DT an equivalent binding 
> will
> be put forward for ACPI based systems.

What is the plan for this last point? I'd like to see at least
a proposal before taking this series in.

         M.
-- 
Jazz is not dead. It just smells funny...

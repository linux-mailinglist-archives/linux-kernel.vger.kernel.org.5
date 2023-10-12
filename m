Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7AC7C6E39
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378525AbjJLMfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378198AbjJLMfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:35:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F41C0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:35:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BC2C433C8;
        Thu, 12 Oct 2023 12:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697114148;
        bh=gB8zPjeOXQPwfuELYundQoAY/96rhccCXFynL9ryD2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XZvoS9CGAOVcf6PYMQh+L/pEifbtHxh5jKqFlCbuHw68AockQbpki2L7v6s7FjpUd
         tHYxnrgxorK6R3EeK0LDrnLBNL+cl/P3TzOO8XO3YCU9Ci1y6qxV3RZyhemh10jG0B
         Mie57WfYWOh2XPgjnDQ4FyvOQgozkt7C+jbherHEwbLvolY43MM1uTxqibtHwjw/4H
         SzcUg+x3w0BDQ2BMIl48RLgs3tRji9VCquXi+3p+DM+V214yTXmmO6S+RNlmgOmuls
         b7s99r9BukUf8/GMqgJNgE73IQ+MsaFNewphhmABRFO19JWwD4gj/YyxvE1sHkmkNA
         suPmwPXJAaLxA==
Date:   Thu, 12 Oct 2023 13:35:41 +0100
From:   Will Deacon <will@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>, ankita@nvidia.com,
        maz@kernel.org, oliver.upton@linux.dev, aniketa@nvidia.com,
        cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
        vsethi@nvidia.com, acurrid@nvidia.com, apopple@nvidia.com,
        jhubbard@nvidia.com, danw@nvidia.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <20231012123541.GB11824@willie-the-truck>
References: <20230907181459.18145-1-ankita@nvidia.com>
 <20230907181459.18145-3-ankita@nvidia.com>
 <ZP8q71+YXoU6O9uh@lpieralisi>
 <ZP9MQdRYmlawNsbC@nvidia.com>
 <ZQHUifAfJ+lZikAn@lpieralisi>
 <ZQIFfqgR5zcidRR3@nvidia.com>
 <ZRKW6uDR/+eXYMzl@lpieralisi>
 <ZRLiDf204zCpO6Mv@arm.com>
 <ZR6IZwcFNw55asW0@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR6IZwcFNw55asW0@lpieralisi>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 11:56:55AM +0200, Lorenzo Pieralisi wrote:
> On Tue, Sep 26, 2023 at 02:52:13PM +0100, Catalin Marinas wrote:
> 
> [...]
> 
> > Anyway, the text looks fine to me. Thanks for putting it together
> > Lorenzo.
> 
> Thanks !
> 
> > One thing not mentioned here is that pci-vfio still maps such memory as
> > Device-nGnRnE in user space and relaxing this potentially creates an
> > alias. But such alias is only relevant of both the VMM and the VM try to
> > access the same device which I doubt is a realistic scenario.
> 
> A revised log, FWIW:

Thanks for putting this together, Lorenzo. Just one thing below:

> ---
> Currently, KVM for ARM64 maps at stage 2 memory that is
> considered device (ie it is not RAM) with DEVICE_nGnRE
> memory attributes; this setting overrides (as per the ARM
> architecture [1]) any device MMIO mapping present at stage
> 1, resulting in a set-up whereby a guest operating system
> can't determine device MMIO mapping memory attributes on its
> own but it is always overriden by the KVM stage 2 default.
> 
> This set-up does not allow guest operating systems to select
> device memory attributes on a page by page basis independently
> from KVM stage-2 mappings (refer to [1], "Combining stage 1 and stage
> 2 memory type attributes"), which turns out to be an issue in that
> guest operating systems (eg Linux) may request to map
> devices MMIO regions with memory attributes that guarantee
> better performance (eg gathering attribute - that for some
> devices can generate larger PCIe memory writes TLPs)
> and specific operations (eg unaligned transactions) such as
> the NormalNC memory type.
> 
> The default device stage 2 mapping was chosen in KVM
> for ARM64 since it was considered safer (ie it would
> not allow guests to trigger uncontained failures
> ultimately crashing the machine) but this turned out
> to be imprecise.
> 
> Failures containability is a property of the platform
> and is independent from the memory type used for MMIO
> device memory mappings (ie DEVICE_nGnRE memory type is
> even more problematic than NormalNC in terms of containability
> since eg aborts triggered on loads cannot be made synchronous,
> which make them harder to contain); this means that,
> regardless of the combined stage1+stage2 mappings a
> platform is safe if and only if device transactions cannot trigger
> uncontained failures; reworded, the default KVM device
> stage 2 memory attributes play no role in making device
> assignment safer for a given platform and therefore can
> be relaxed.
> 
> For all these reasons, relax the KVM stage 2 device
> memory attributes from DEVICE_nGnRE to NormalNC.

The reasoning above suggests to me that this should probably just be
Normal cacheable, as that is what actually allows the guest to control
the attributes. So what is the rationale behind stopping at Normal-NC?

Will

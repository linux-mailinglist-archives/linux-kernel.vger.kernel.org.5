Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B948279ECC3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjIMP0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjIMP0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:26:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F246CCD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:26:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5FEC433C7;
        Wed, 13 Sep 2023 15:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694618768;
        bh=yOHswlBysKg87afd+mgohyR0HpbPj/30+jTjDMiUzYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oMdYAkSW2m3K6zOSCqenPM2sjOJZstO8AxjUjIviwSwR8PCBck1K/RyOqoZo+SlnG
         b6bQZMbeFUd/loupZPy9xCHkJOH7nBRlqoQUg/ihC6Mv2mVxZ1UYRs35/zlgczKJdR
         ew/GnaKQDJptOyv624zYWAprPtjw0UZX/kmnKdOh/bt1aP9quvLlbhkIjvO/vVzDL+
         wP7JI6ETqsXtceyi/K077dqswSfGX3uwwnRtnintvQYT06SeG07HjfmK2Ro8LrxyZW
         gRLF/KKt9764HwlbY/3iYF0YhZmCxblfsRq8BBDw8ddzfHsCbLePs2ghle7BmQASCZ
         kavuu3hkTFk7Q==
Date:   Wed, 13 Sep 2023 17:26:01 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     ankita@nvidia.com, maz@kernel.org, oliver.upton@linux.dev,
        catalin.marinas@arm.com, will@kernel.org, aniketa@nvidia.com,
        cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
        vsethi@nvidia.com, acurrid@nvidia.com, apopple@nvidia.com,
        jhubbard@nvidia.com, danw@nvidia.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <ZQHUifAfJ+lZikAn@lpieralisi>
References: <20230907181459.18145-1-ankita@nvidia.com>
 <20230907181459.18145-3-ankita@nvidia.com>
 <ZP8q71+YXoU6O9uh@lpieralisi>
 <ZP9MQdRYmlawNsbC@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZP9MQdRYmlawNsbC@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 02:20:01PM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 11, 2023 at 04:57:51PM +0200, Lorenzo Pieralisi wrote:
> > On Thu, Sep 07, 2023 at 11:14:59AM -0700, ankita@nvidia.com wrote:
> > > From: Ankit Agrawal <ankita@nvidia.com>
> > > 
> > > Linux allows device drivers to map IO memory on a per-page basis using
> > > "write combining" or WC. This is often done using
> > > pgprot_writecombing(). The driver knows which pages can support WC
> > 
> > pgprot_writecombine() ?
> > 
> > > access and the proper programming model to generate this IO. Generally
> > > the use case is to boost performance by using write combining to
> > > generate larger PCIe MemWr TLPs.
> > 
> > First off, this changeset does not affect *only* Linux guests, obviously.
> 
> I think everyone understands that. It can be clarified.

OK, this is not a Linux guest fix *only*, everyone understands that
but I would rather make sure that's crystal clear.

> > I understand that's the use case you are after but this change is
> > targeting all VMs, it must be clear.
> > 
> > Then WC and mapping to PCI TLPs, either you describe that in details
> > (NormalNC vs device-nGnRE and resulting SystemBus<->PCI transactions) or
> > you don't describe it at all, as it stands I don't know how to use
> > this information.
> 
> How about another pargraph:
> 
>  KVM prevents all VMs (including Linux) from accessing NORMAL_NC
>  mappings, which is how Linux implements pgprot_writecombine(). This
>  prevents using this performance optimization within VMs.
> 
> I don't think we need to go into details how it works beyond that it
> requires NORMAL_NC.

I think it is worth summarizing the discussion that led to this change,
I can write something up.

> > > Allow VMs to select DEVICE_* or NORMAL_NC on a page by page basis for
> > > all IO memory. This puts the VM in charge of the memory attributes,
> > > and removes the KVM override to DEVICE_nGnRE.
> > > 
> > > Ultimately this makes pgprot_writecombing() work correctly in VMs and
> > 
> > pgprot_writecombine() ?
> > 
> > > allows drivers like mlx5 to fully operate their HW.
> > > 
> > > After some discussions with ARM and CPU architects we reached the
> > > conclusion there was no need for KVM to prevent the VM from selecting
> > > between DEVICE_* and NORMAL_NC for IO memory in VMs. There was a fear
> > > that NORMAL_NC could result in uncontained failures, but upon deeper
> > > analysis it turns out there are already possible cases for uncontained
> > > failures with DEVICE types too. Ultimately the platform must be
> > > implemented in a way that ensures that all DEVICE_* and NORMAL_NC
> > > accesses have no uncontained failures.
> > 
> > I would reorder/rephrase this changelog as follows:
> > 
> > - Describe what the problem is (ie KVM default s2 mappings)
> 
> The problem is that pgprot_writecombine() doesn't work in Linux
> VMs. That is the first pagraph.

s/pagraph/paragraph

Well to me that's how the problem was spotted but OK, I can rewrite
the log and post it here, NP.

> > - Describe how you are solving it
> 
> That is the middle paragraph "Allow VMs to select DEVICE_* or
> NORMAL_NC on a page by page basis"
> 
> > - Add a link to the documentation that states why it is safe to do
> >   that and the resulting s1/s2 mappings combination
> 
> AFAIK there is no documentation beyond the combining rules. Exactly
> what should happen in various error conditions is implementation
> defined. Catalin did you ever find anything?
> 
> > It must be clear why from a legacy standpoint this is a safe change
> > to apply.
> 
> This is why:
>  
> > > Fortunately real platforms do tend to implement this.

Is it possible please to describe what "this" is in details ?

What does "real platforms" mean ?

Let's describe what HW/SW should be implemented to make this
safe.

> It is why it is safe today, because real platforms don't throw

"real platforms", I have a problem with that, see above.

> uncontained errors from typical PCI accesses that VFIO allows. I think
> the conclusions was it turns out that is just because they don't do
> errors at all, not because DEVICE_* prevents it.
> 
> > Remove this sentence, it adds no information for someone who
> > is chasing bugs or just wants to understand the change itself.
> 
> So, if you hit a bug here you might evaluate if there is something
> wrong with your platform, ie it is allowing uncontained errors in
> unexpected places.

Developers looking at commit log in the future must be able to
understand why it was a sound change to make. As it stands IMO
the commit log does not explain it fully.

I can write up the commit log and post it if I manage to summarize
it any better - more important the review on the code (that was already
provided), I will try to write something up asap.

Thanks,
Lorenzo

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9517811FA8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 21:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378934AbjLMUFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 15:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLMUFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 15:05:34 -0500
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A496EDC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 12:05:38 -0800 (PST)
Date:   Wed, 13 Dec 2023 20:05:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1702497936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bs3RmWkkBEnHpfKuSLQmU1XdcllYwTl+oGw2E3qh8dc=;
        b=jJcnDy5bHbUQZ++rOn61pjWjrjxub6x7tQGxN6Q/n2e8x8QqbvQBN0WMjqMDzS9KbV0iYs
        wCgSpmwEUbVv6YEq3zCdtU1qGuTE6IwHyJzcoTRQw4SP/Qsfm9Sz/cIkb2d4mN4aAQUtts
        tgUEit1z6/gIrWV69f2FgtcachFAZYI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, ankita@nvidia.com,
        maz@kernel.org, suzuki.poulose@arm.com, yuzenghui@huawei.com,
        will@kernel.org, alex.williamson@redhat.com, kevin.tian@intel.com,
        yi.l.liu@intel.com, ardb@kernel.org, akpm@linux-foundation.org,
        gshan@redhat.com, linux-mm@kvack.org, lpieralisi@kernel.org,
        aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
        targupta@nvidia.com, vsethi@nvidia.com, acurrid@nvidia.com,
        apopple@nvidia.com, jhubbard@nvidia.com, danw@nvidia.com,
        mochs@nvidia.com, kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/2] kvm: arm64: set io memory s2 pte as normalnc for
 vfio pci devices
Message-ID: <ZXoOieQN7rBiLL4A@linux.dev>
References: <20231208164709.23101-1-ankita@nvidia.com>
 <20231208164709.23101-3-ankita@nvidia.com>
 <ZXicemDzXm8NShs1@arm.com>
 <20231212181156.GO3014157@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212181156.GO3014157@nvidia.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry, a bit late to the discussion :)

On Tue, Dec 12, 2023 at 02:11:56PM -0400, Jason Gunthorpe wrote:
> On Tue, Dec 12, 2023 at 05:46:34PM +0000, Catalin Marinas wrote:
> > should know the implications. There's also an expectation that the
> > actual driver (KVM guests) or maybe later DPDK can choose the safe
> > non-cacheable or write-combine (Linux terminology) attributes for the
> > BAR.
> 
> DPDK won't rely on this interface

Wait, so what's the expected interface for determining the memory
attributes at stage-1? I'm somewhat concerned that we're conflating two
things here:

 1) KVM needs to know the memory attributes to use at stage-2, which
    isn't fundamentally different from what's needed for userspace
    stage-1 mappings.

 2) KVM additionally needs a hint that the device / VFIO can handle
    mismatched aliases w/o the machine exploding. This goes beyond
    supporting Normal-NC mappings at stage-2 and is really a bug
    with our current scheme (nGnRnE at stage-1, nGnRE at stage-2).

I was hoping that (1) could be some 'common' plumbing for both userspace
and KVM mappings. And for (2), any case where a device is intolerant of
mismatches && KVM cannot force the memory attributes should be rejected.

AFAICT, the only reason PCI devices can get the blanket treatment of
Normal-NC at stage-2 is because userspace has a Device-* mapping and can't
speculatively load from the alias. This feels a bit hacky, and maybe we
should prioritize an interface for mapping a device into a VM w/o a
valid userspace mapping.

I very much understand that this has been going on for a while, and we
need to do *something* to get passthrough working well for devices that
like 'WC'. I just want to make sure we don't paint ourselves into a corner
that's hard to get out of in the future.

-- 
Thanks,
Oliver

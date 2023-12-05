Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8533C805C3E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjLEQYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjLEQYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:24:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686F2122
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:24:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D01CC433C8;
        Tue,  5 Dec 2023 16:24:25 +0000 (UTC)
Date:   Tue, 5 Dec 2023 16:24:22 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Marc Zyngier <maz@kernel.org>, ankita@nvidia.com,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>, oliver.upton@linux.dev,
        suzuki.poulose@arm.com, yuzenghui@huawei.com, will@kernel.org,
        ardb@kernel.org, akpm@linux-foundation.org, gshan@redhat.com,
        aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
        targupta@nvidia.com, vsethi@nvidia.com, acurrid@nvidia.com,
        apopple@nvidia.com, jhubbard@nvidia.com, danw@nvidia.com,
        mochs@nvidia.com, kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/1] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <ZW9OtrUa_fPA0_Ns@arm.com>
References: <20231205033015.10044-1-ankita@nvidia.com>
 <86fs0hatt3.wl-maz@kernel.org>
 <ZW8MP2tDt4_9ROBz@arm.com>
 <20231205130517.GD2692119@nvidia.com>
 <ZW81mT4WqKqtLnid@lpieralisi>
 <20231205144417.GE2692119@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205144417.GE2692119@nvidia.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 10:44:17AM -0400, Jason Gunthorpe wrote:
> On Tue, Dec 05, 2023 at 03:37:13PM +0100, Lorenzo Pieralisi wrote:
> > On Tue, Dec 05, 2023 at 09:05:17AM -0400, Jason Gunthorpe wrote:
> > > On Tue, Dec 05, 2023 at 11:40:47AM +0000, Catalin Marinas wrote:
> > > > > - Will had unanswered questions in another part of the thread:
> > > > > 
> > > > >   https://lore.kernel.org/all/20231013092954.GB13524@willie-the-truck/
> > > > > 
> > > > >   Can someone please help concluding it?
> > > > 
> > > > Is this about reclaiming the device? I think we concluded that we can't
> > > > generalise this beyond PCIe, though not sure there was any formal
> > > > statement to that thread. The other point Will had was around stating
> > > > in the commit message why we only relax this to Normal NC. I haven't
> > > > checked the commit message yet, it needs careful reading ;).
> > > 
> > > Not quite, we said reclaiming is VFIO's problem and if VFIO can't
> > > reliably reclaim a device it shouldn't create it in the first place.
> > 
> > I think that as far as device reclaiming was concerned the question
> > posed was related to memory attributes of transactions for guest
> > mappings and the related grouping/ordering with device reset MMIO
> > transactions - it was not (or wasn't only) about error containment.
> 
> Yes. It is VFIO that issues the reset, it is VFIO that must provide
> the ordering under the assumption that NORMAL_NC was used.

And does it? Because VFIO so far only assumes Device-nGnRnE. Do we need
to address this first before attempting to change KVM? Sorry, just
questions, trying to clear the roadblocks.

-- 
Catalin

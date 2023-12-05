Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C2F8057D8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345989AbjLEOhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345881AbjLEOhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:37:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D010B129
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:37:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A7EC433C8;
        Tue,  5 Dec 2023 14:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701787042;
        bh=G92HElO7wu4W9h4mKuFM3rR7BN9XZu1dQCy7HpY/B+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UGoYessHIwz2m7jHfu2pPKOnbp9BDf8Bh8Z/Z+tn0XDdCxB5WTkX9KuivDGbOLx+O
         bDqEuv7A39oidE257H8+FHh6T7HyMTiDfVCU6qXUuj2rFZ5dnFTBnB836wlgmSw+Qf
         LzhaToDjYucI2vhVp8LEhLa/ukuT/nm1kD7lDvRSscgskjqdK2MlGc4/LhMb7Zdoql
         acy4h9yeo1EdoXdy2xaQ86/uMaOEn+UmBtWWJbg+w/moLmPC5NrQDdu8PvU/Ilu58t
         RBgbTXVzu9uKRMxFPzvXgPUGciFA5D2IWUBAp3bWKKAF+2artu7Pqqu5Kx/l8X9uqo
         UGLVoFzH+77sQ==
Date:   Tue, 5 Dec 2023 15:37:13 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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
Message-ID: <ZW81mT4WqKqtLnid@lpieralisi>
References: <20231205033015.10044-1-ankita@nvidia.com>
 <86fs0hatt3.wl-maz@kernel.org>
 <ZW8MP2tDt4_9ROBz@arm.com>
 <20231205130517.GD2692119@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205130517.GD2692119@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 09:05:17AM -0400, Jason Gunthorpe wrote:
> On Tue, Dec 05, 2023 at 11:40:47AM +0000, Catalin Marinas wrote:
> > > - Will had unanswered questions in another part of the thread:
> > > 
> > >   https://lore.kernel.org/all/20231013092954.GB13524@willie-the-truck/
> > > 
> > >   Can someone please help concluding it?
> > 
> > Is this about reclaiming the device? I think we concluded that we can't
> > generalise this beyond PCIe, though not sure there was any formal
> > statement to that thread. The other point Will had was around stating
> > in the commit message why we only relax this to Normal NC. I haven't
> > checked the commit message yet, it needs careful reading ;).
> 
> Not quite, we said reclaiming is VFIO's problem and if VFIO can't
> reliably reclaim a device it shouldn't create it in the first place.

I think that as far as device reclaiming was concerned the question
posed was related to memory attributes of transactions for guest
mappings and the related grouping/ordering with device reset MMIO
transactions - it was not (or wasn't only) about error containment.

Thanks,
Lorenzo

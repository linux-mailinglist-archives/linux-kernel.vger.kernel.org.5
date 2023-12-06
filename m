Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BEB8074DF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379276AbjLFQX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379155AbjLFQXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:23:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E97C12F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 08:23:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4457C433C8;
        Wed,  6 Dec 2023 16:23:27 +0000 (UTC)
Date:   Wed, 6 Dec 2023 16:23:25 +0000
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
Message-ID: <ZXCf_e-ACqrj6VrV@arm.com>
References: <ZW8MP2tDt4_9ROBz@arm.com>
 <20231205130517.GD2692119@nvidia.com>
 <ZW9OSe8Z9gAmM7My@arm.com>
 <20231205164318.GG2692119@nvidia.com>
 <ZW949Tl3VmQfPk0L@arm.com>
 <20231205194822.GL2692119@nvidia.com>
 <ZXCJ3pVbKuHJ3LTz@arm.com>
 <20231206150556.GQ2692119@nvidia.com>
 <ZXCQrTbf6q0BIhSw@lpieralisi>
 <20231206153809.GS2692119@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206153809.GS2692119@nvidia.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 11:38:09AM -0400, Jason Gunthorpe wrote:
> On Wed, Dec 06, 2023 at 04:18:05PM +0100, Lorenzo Pieralisi wrote:
> > On Wed, Dec 06, 2023 at 11:05:56AM -0400, Jason Gunthorpe wrote:
> > > On Wed, Dec 06, 2023 at 02:49:02PM +0000, Catalin Marinas wrote:
> > > > BTW, on those Mellanox devices that require different attributes within
> > > > a BAR, do they have a problem with speculative reads causing
> > > > side-effects? 
> > > 
> > > Yes. We definitely have had that problem in the past on older
> > > devices. VFIO must map the BAR using pgprot_device/noncached() into
> > > the VMM, no other choice is functionally OK.
> > 
> > Were those BARs tagged as prefetchable or non-prefetchable ? I assume the
> > latter but please let me know if I am guessing wrong.
> 
> I don't know it was quite old HW. Probably.
> 
> Just because a BAR is not marked as prefetchable doesn't mean that the
> device can't use NORMAL_NC on subsets of it.

What about the other way around - would we have a prefetchable BAR that
has portions which are unprefetchable?

-- 
Catalin

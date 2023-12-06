Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7158072FD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442111AbjLFOtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379090AbjLFOtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:49:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D99D65
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:49:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07D3C433C8;
        Wed,  6 Dec 2023 14:49:04 +0000 (UTC)
Date:   Wed, 6 Dec 2023 14:49:02 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Marc Zyngier <maz@kernel.org>, ankita@nvidia.com,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>, oliver.upton@linux.dev,
        suzuki.poulose@arm.com, yuzenghui@huawei.com, will@kernel.org,
        ardb@kernel.org, akpm@linux-foundation.org, gshan@redhat.com,
        aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
        targupta@nvidia.com, vsethi@nvidia.com, acurrid@nvidia.com,
        apopple@nvidia.com, jhubbard@nvidia.com, danw@nvidia.com,
        mochs@nvidia.com, kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        lpieralisi@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/1] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <ZXCJ3pVbKuHJ3LTz@arm.com>
References: <20231205033015.10044-1-ankita@nvidia.com>
 <86fs0hatt3.wl-maz@kernel.org>
 <ZW8MP2tDt4_9ROBz@arm.com>
 <20231205130517.GD2692119@nvidia.com>
 <ZW9OSe8Z9gAmM7My@arm.com>
 <20231205164318.GG2692119@nvidia.com>
 <ZW949Tl3VmQfPk0L@arm.com>
 <20231205194822.GL2692119@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205194822.GL2692119@nvidia.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 03:48:22PM -0400, Jason Gunthorpe wrote:
> On Tue, Dec 05, 2023 at 07:24:37PM +0000, Catalin Marinas wrote:
> > On Tue, Dec 05, 2023 at 12:43:18PM -0400, Jason Gunthorpe wrote:
> > > What if we change vfio-pci to use pgprot_device() like it already
> > > really should and say the pgprot_noncached() is enforced as
> > > DEVICE_nGnRnE and pgprot_device() may be DEVICE_nGnRE or NORMAL_NC?
> > > Would that be acceptable?
> > 
> > pgprot_device() needs to stay as Device, otherwise you'd get speculative
> > reads with potential side-effects.
> 
> I do not mean to change pgprot_device() I mean to detect the
> difference via pgprot_device() vs pgprot_noncached(). They put a
> different value in the PTE that we can sense. It is very hacky.

Ah, ok, it does look hacky though (as is the alternative of coming up
with a new specific pgprot_*() that KVM can treat differently).

BTW, on those Mellanox devices that require different attributes within
a BAR, do they have a problem with speculative reads causing
side-effects? If not, we might as well map the whole BAR in user as
Normal NC but have the guest use the appropriate attributes within the
BAR. The VMM wouldn't explicitly access the BAR but we'd get the
occasional speculative reads.

-- 
Catalin

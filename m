Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CFD805C90
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346128AbjLERdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346120AbjLERdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:33:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54481B9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:33:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC45C433C8;
        Tue,  5 Dec 2023 17:33:03 +0000 (UTC)
Date:   Tue, 5 Dec 2023 17:33:01 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, ankita@nvidia.com,
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
Message-ID: <ZW9ezSGSDIvv5MsQ@arm.com>
References: <20231205033015.10044-1-ankita@nvidia.com>
 <86fs0hatt3.wl-maz@kernel.org>
 <ZW8MP2tDt4_9ROBz@arm.com>
 <20231205130517.GD2692119@nvidia.com>
 <ZW9OSe8Z9gAmM7My@arm.com>
 <20231205164318.GG2692119@nvidia.com>
 <86bkb4bn2v.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86bkb4bn2v.wl-maz@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 05:01:28PM +0000, Marc Zyngier wrote:
> On Tue, 05 Dec 2023 16:43:18 +0000,
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> > On Tue, Dec 05, 2023 at 04:22:33PM +0000, Catalin Marinas wrote:
> > > That's an argument to restrict this feature to PCIe. It's really about
> > > fewer arguments on the behaviour of other devices. Marc did raise
> > > another issue with the GIC VCPU interface (does this even have a vma in
> > > the host VMM?). That's a class of devices where the mapping is
> > > context-switched, so the TLBI+DSB rules don't help.
> 
> There is no vma. The CPU interface is entirely under control of KVM.
> Userspace only provides the IPA for the mapping.

That's good to know. We can solve the GIC issue by limiting the
relaxation to those mappings that have a user vma. Ideally we should do
this for vfio only but we don't have an easy way to convey this to KVM.

-- 
Catalin

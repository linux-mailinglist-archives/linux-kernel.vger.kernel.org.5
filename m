Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F817C6FC1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235570AbjJLNxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjJLNx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:53:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81412BA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:53:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4D7C433C9;
        Thu, 12 Oct 2023 13:53:23 +0000 (UTC)
Date:   Thu, 12 Oct 2023 14:53:21 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>, ankita@nvidia.com,
        maz@kernel.org, oliver.upton@linux.dev, aniketa@nvidia.com,
        cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
        vsethi@nvidia.com, acurrid@nvidia.com, apopple@nvidia.com,
        jhubbard@nvidia.com, danw@nvidia.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <ZSf6Ue09IO6QMBs1@arm.com>
References: <20230907181459.18145-1-ankita@nvidia.com>
 <20230907181459.18145-3-ankita@nvidia.com>
 <ZP8q71+YXoU6O9uh@lpieralisi>
 <ZP9MQdRYmlawNsbC@nvidia.com>
 <ZQHUifAfJ+lZikAn@lpieralisi>
 <ZQIFfqgR5zcidRR3@nvidia.com>
 <ZRKW6uDR/+eXYMzl@lpieralisi>
 <ZRLiDf204zCpO6Mv@arm.com>
 <ZR6IZwcFNw55asW0@lpieralisi>
 <20231012123541.GB11824@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012123541.GB11824@willie-the-truck>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 01:35:41PM +0100, Will Deacon wrote:
> On Thu, Oct 05, 2023 at 11:56:55AM +0200, Lorenzo Pieralisi wrote:
> > For all these reasons, relax the KVM stage 2 device
> > memory attributes from DEVICE_nGnRE to NormalNC.
> 
> The reasoning above suggests to me that this should probably just be
> Normal cacheable, as that is what actually allows the guest to control
> the attributes. So what is the rationale behind stopping at Normal-NC?

It's more like we don't have any clue on what may happen. MTE is
obviously a case where it can go wrong (we can blame the architecture
design here) but I recall years ago where a malicious guest could bring
the platform down by mapping the GIC CPU interface as cacheable.

Not sure how error containment works with cacheable memory. A cacheable
access to a device may stay in the cache a lot longer after the guest
has been scheduled out, only evicted at some random time. We may no
longer be able to associate it with the guest, especially if the guest
exited. Also not sure about claiming back the device after killing the
guest, do we need cache maintenance?

So, for now I'd only relax this if we know there's RAM(-like) on the
other side and won't trigger some potentially uncontainable errors as a
result.

-- 
Catalin

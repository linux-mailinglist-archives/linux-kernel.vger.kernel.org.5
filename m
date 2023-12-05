Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B61F80535E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347021AbjLELtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345333AbjLELs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:48:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414F5A7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:49:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6136C433C7;
        Tue,  5 Dec 2023 11:48:59 +0000 (UTC)
Date:   Tue, 5 Dec 2023 11:48:57 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     ankita@nvidia.com
Cc:     jgg@nvidia.com, maz@kernel.org, oliver.upton@linux.dev,
        suzuki.poulose@arm.com, yuzenghui@huawei.com, will@kernel.org,
        ardb@kernel.org, akpm@linux-foundation.org, gshan@redhat.com,
        aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
        targupta@nvidia.com, vsethi@nvidia.com, acurrid@nvidia.com,
        apopple@nvidia.com, jhubbard@nvidia.com, danw@nvidia.com,
        mochs@nvidia.com, kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/1] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <ZW8OKZHpXeVjoNo6@arm.com>
References: <20231205033015.10044-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205033015.10044-1-ankita@nvidia.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 09:00:15AM +0530, ankita@nvidia.com wrote:
> From: Ankit Agrawal <ankita@nvidia.com>
> 
> Currently, KVM for ARM64 maps at stage 2 memory that is considered device
> (i.e. it is not RAM) with DEVICE_nGnRE memory attributes; this setting
> overrides (as per the ARM architecture [1]) any device MMIO mapping
> present at stage 1, resulting in a set-up whereby a guest operating
> system cannot determine device MMIO mapping memory attributes on its
> own but it is always overridden by the KVM stage 2 default.
> 
> This set-up does not allow guest operating systems to select device
> memory attributes independently from KVM stage-2 mappings
> (refer to [1], "Combining stage 1 and stage 2 memory type attributes"),
> which turns out to be an issue in that guest operating systems
> (e.g. Linux) may request to map devices MMIO regions with memory
> attributes that guarantee better performance (e.g. gathering
> attribute - that for some devices can generate larger PCIe memory
> writes TLPs) and specific operations (e.g. unaligned transactions)
> such as the NormalNC memory type.
> 
> The default device stage 2 mapping was chosen in KVM for ARM64 since
> it was considered safer (i.e. it would not allow guests to trigger
> uncontained failures ultimately crashing the machine) but this
> turned out to be asynchronous (SError) defeating the purpose.
> 
> Failures containability is a property of the platform and is independent
> from the memory type used for MMIO device memory mappings.
> 
> Actually, DEVICE_nGnRE memory type is even more problematic than
> Normal-NC memory type in terms of faults containability in that e.g.
> aborts triggered on DEVICE_nGnRE loads cannot be made, architecturally,
> synchronous (i.e. that would imply that the processor should issue at
> most 1 load transaction at a time - it cannot pipeline them - otherwise
> the synchronous abort semantics would break the no-speculation attribute
> attached to DEVICE_XXX memory).
> 
> This means that regardless of the combined stage1+stage2 mappings a
> platform is safe if and only if device transactions cannot trigger
> uncontained failures and that in turn relies on platform capabilities
> and the device type being assigned (i.e. PCIe AER/DPC error containment
> and RAS architecture[3]); therefore the default KVM device stage 2
> memory attributes play no role in making device assignment safer
> for a given platform (if the platform design adheres to design
> guidelines outlined in [3]) and therefore can be relaxed.
> 
> For all these reasons, relax the KVM stage 2 device memory attributes
> from DEVICE_nGnRE to Normal-NC. Add a new kvm_pgtable_prot flag for
> Normal-NC.
> 
> The Normal-NC was chosen over a different Normal memory type default
> at stage-2 (e.g. Normal Write-through) to avoid cache allocation/snooping.
> 
> Relaxing S2 KVM device MMIO mappings to Normal-NC is not expected to
> trigger any issue on guest device reclaim use cases either (i.e. device
> MMIO unmap followed by a device reset) at least for PCIe devices, in that
> in PCIe a device reset is architected and carried out through PCI config
> space transactions that are naturally ordered with respect to MMIO
> transactions according to the PCI ordering rules.
> 
> Having Normal-NC S2 default puts guests in control (thanks to
> stage1+stage2 combined memory attributes rules [1]) of device MMIO
> regions memory mappings, according to the rules described in [1]
> and summarized here ([(S1) - stage1], [(S2) - stage 2]):
> 
> S1           |  S2           | Result
> NORMAL-WB    |  NORMAL-NC    | NORMAL-NC
> NORMAL-WT    |  NORMAL-NC    | NORMAL-NC
> NORMAL-NC    |  NORMAL-NC    | NORMAL-NC
> DEVICE<attr> |  NORMAL-NC    | DEVICE<attr>
> 
> It is worth noting that currently, to map devices MMIO space to user
> space in a device pass-through use case the VFIO framework applies memory
> attributes derived from pgprot_noncached() settings applied to VMAs, which
> result in device-nGnRnE memory attributes for the stage-1 VMM mappings.
> 
> This means that a userspace mapping for device MMIO space carried
> out with the current VFIO framework and a guest OS mapping for the same
> MMIO space may result in a mismatched alias as described in [2].
> 
> Defaulting KVM device stage-2 mappings to Normal-NC attributes does not
> change anything in this respect, in that the mismatched aliases would
> only affect (refer to [2] for a detailed explanation) ordering between
> the userspace and GuestOS mappings resulting stream of transactions
> (i.e. it does not cause loss of property for either stream of
> transactions on its own), which is harmless given that the userspace
> and GuestOS access to the device is carried out through independent
> transactions streams.
> 
> [1] section D8.5 - DDI0487_I_a_a-profile_architecture_reference_manual.pdf
> [2] section B2.8 - DDI0487_I_a_a-profile_architecture_reference_manual.pdf
> [3] sections 1.7.7.3/1.8.5.2/appendix C - DEN0029H_SBSA_7.1.pdf
> 
> Applied over next-20231201
> 
> History
> =======
> v1 -> v2
> - Updated commit log to the one posted by
>   Lorenzo Pieralisi <lpieralisi@kernel.org> (Thanks!)
> - Added new flag to represent the NORMAL_NC setting. Updated
>   stage2_set_prot_attr() to handle new flag.
> 
> v1 Link:
> https://lore.kernel.org/all/20230907181459.18145-3-ankita@nvidia.com/
> 
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

In the light of having to keep this relaxation only for PCIe devices, I
will withdraw my Ack until we come to a conclusion.

Thanks.

-- 
Catalin

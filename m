Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA0E7AEE2A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 15:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbjIZNwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 09:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjIZNw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 09:52:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA80AF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 06:52:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24545C433C7;
        Tue, 26 Sep 2023 13:52:15 +0000 (UTC)
Date:   Tue, 26 Sep 2023 14:52:13 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, ankita@nvidia.com,
        maz@kernel.org, oliver.upton@linux.dev, will@kernel.org,
        aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
        targupta@nvidia.com, vsethi@nvidia.com, acurrid@nvidia.com,
        apopple@nvidia.com, jhubbard@nvidia.com, danw@nvidia.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <ZRLiDf204zCpO6Mv@arm.com>
References: <20230907181459.18145-1-ankita@nvidia.com>
 <20230907181459.18145-3-ankita@nvidia.com>
 <ZP8q71+YXoU6O9uh@lpieralisi>
 <ZP9MQdRYmlawNsbC@nvidia.com>
 <ZQHUifAfJ+lZikAn@lpieralisi>
 <ZQIFfqgR5zcidRR3@nvidia.com>
 <ZRKW6uDR/+eXYMzl@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZRKW6uDR/+eXYMzl@lpieralisi>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 10:31:38AM +0200, Lorenzo Pieralisi wrote:
> Currently, KVM for ARM64 maps at stage 2 memory that is
> considered device (ie using pfn_is_map_memory() to discern
> between device memory and memory itself) with DEVICE_nGnRE
> memory attributes; this setting overrides (as per the ARM
> architecture [1]) any device MMIO mapping present at stage
> 1, resulting in a set-up whereby a guest operating system
> can't determine device MMIO mapping memory attributes on its
> own but it is always overriden by the KVM stage 2 default.
> 
> This set-up does not allow guest operating systems to map
> device memory on a page by page basis with combined attributes
> other than DEVICE_nGnRE,

Well, it also has the option of DEVICE_nGnRnE ;).

> which turns out to be an issue in that
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
> 
> This puts guests in control (thanks to stage1+stage2
> combined memory attributes rules [1]) of device MMIO
> regions memory mappings, according to the rules
> described in [1] and summarized here ([(S1) = Stage1][(S2) = Stage2]):
> 
> �S1���������� |�� S2��������� |� Result
> �NORMAL-WB����|� NORMAL-NC����|� NORMAL-NC
> �NORMAL-WT����|� NORMAL-NC����|� NORMAL-NC
> �NORMAL-NC����|� NORMAL-NC����|� NORMAL-NC
> �DEVICE<attr>�|� NORMAL-NC����|� DEVICE<attr>

Not sure what's wrong with my font setup as I can't see the above table
but I know it from the Arm ARM.

Anyway, the text looks fine to me. Thanks for putting it together
Lorenzo.

One thing not mentioned here is that pci-vfio still maps such memory as
Device-nGnRnE in user space and relaxing this potentially creates an
alias. But such alias is only relevant of both the VMM and the VM try to
access the same device which I doubt is a realistic scenario.

-- 
Catalin

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BEB7BA587
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242306AbjJEQRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240836AbjJEQOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:14:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DB19033
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:42:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173C5C4163D;
        Thu,  5 Oct 2023 09:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696499825;
        bh=PrIjz4gP7mh1DNNI/311t7CyHU+4imq8iF8rKwFrJvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iq9asrIVkhKRp3kH5WXH0cQIwRPvUanUsynih4KtJQ0r5sHgFsJanWSdTBM8ttHMY
         olEV3DafaVDgH5g/oL/3r+iZbkcUSTRFiuVJ/51dpxJ5ldJvV3ETmV3eENE+8CTa4r
         7QO4QC8AeceTkxGoFKQtvDVQgtdPgOv3Y5SzfBQENUtCfJbq/guDNBmBiJOmeOcLrw
         Cf/sMWSGAfYwKmIZAfYehlIUiaHy6Sen90C5Br9LRNWC1vKF0SuToenHdj/vPjGFMu
         6BouzxK0tz7And/yw24m9GdC0oX33LQwUOiZqJjwVEQSlqYjTP8OssWLeVvYMQI1fB
         fWc4WyUOKEJpw==
Date:   Thu, 5 Oct 2023 11:56:55 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, ankita@nvidia.com,
        maz@kernel.org, oliver.upton@linux.dev, will@kernel.org,
        aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
        targupta@nvidia.com, vsethi@nvidia.com, acurrid@nvidia.com,
        apopple@nvidia.com, jhubbard@nvidia.com, danw@nvidia.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <ZR6IZwcFNw55asW0@lpieralisi>
References: <20230907181459.18145-1-ankita@nvidia.com>
 <20230907181459.18145-3-ankita@nvidia.com>
 <ZP8q71+YXoU6O9uh@lpieralisi>
 <ZP9MQdRYmlawNsbC@nvidia.com>
 <ZQHUifAfJ+lZikAn@lpieralisi>
 <ZQIFfqgR5zcidRR3@nvidia.com>
 <ZRKW6uDR/+eXYMzl@lpieralisi>
 <ZRLiDf204zCpO6Mv@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRLiDf204zCpO6Mv@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 02:52:13PM +0100, Catalin Marinas wrote:

[...]

> Anyway, the text looks fine to me. Thanks for putting it together
> Lorenzo.

Thanks !

> One thing not mentioned here is that pci-vfio still maps such memory as
> Device-nGnRnE in user space and relaxing this potentially creates an
> alias. But such alias is only relevant of both the VMM and the VM try to
> access the same device which I doubt is a realistic scenario.

A revised log, FWIW:

---
Currently, KVM for ARM64 maps at stage 2 memory that is
considered device (ie it is not RAM) with DEVICE_nGnRE
memory attributes; this setting overrides (as per the ARM
architecture [1]) any device MMIO mapping present at stage
1, resulting in a set-up whereby a guest operating system
can't determine device MMIO mapping memory attributes on its
own but it is always overriden by the KVM stage 2 default.

This set-up does not allow guest operating systems to select
device memory attributes on a page by page basis independently
from KVM stage-2 mappings (refer to [1], "Combining stage 1 and stage
2 memory type attributes"), which turns out to be an issue in that
guest operating systems (eg Linux) may request to map
devices MMIO regions with memory attributes that guarantee
better performance (eg gathering attribute - that for some
devices can generate larger PCIe memory writes TLPs)
and specific operations (eg unaligned transactions) such as
the NormalNC memory type.

The default device stage 2 mapping was chosen in KVM
for ARM64 since it was considered safer (ie it would
not allow guests to trigger uncontained failures
ultimately crashing the machine) but this turned out
to be imprecise.

Failures containability is a property of the platform
and is independent from the memory type used for MMIO
device memory mappings (ie DEVICE_nGnRE memory type is
even more problematic than NormalNC in terms of containability
since eg aborts triggered on loads cannot be made synchronous,
which make them harder to contain); this means that,
regardless of the combined stage1+stage2 mappings a
platform is safe if and only if device transactions cannot trigger
uncontained failures; reworded, the default KVM device
stage 2 memory attributes play no role in making device
assignment safer for a given platform and therefore can
be relaxed.

For all these reasons, relax the KVM stage 2 device
memory attributes from DEVICE_nGnRE to NormalNC.

This puts guests in control (thanks to stage1+stage2
combined memory attributes rules [1]) of device MMIO
regions memory mappings, according to the rules
described in [1] and summarized here ([(S1) - stage1],
[(S2) - stage 2]):

S1	     |  S2	     | Result
NORMAL-WB    |  NORMAL-NC    | NORMAL-NC
NORMAL-WT    |  NORMAL-NC    | NORMAL-NC
NORMAL-NC    |  NORMAL-NC    | NORMAL-NC
DEVICE<attr> |  NORMAL-NC    | DEVICE<attr>

It is worth noting that currently, to map devices MMIO space to user
space in a device pass-through use case the VFIO framework applies memory
attributes derived from pgprot_noncached() settings applied to VMAs, which
result in device-nGnRnE memory attributes for the stage-1 VMM mappings.

This means that a userspace mapping for device MMIO space carried
out with the current VFIO framework and a guest OS mapping for the same
MMIO space may result in a mismatched alias as described in [2].

Defaulting KVM device stage-2 mappings to Normal-NC attributes does not change
anything in this respect, in that the mismatched aliases would only affect
(refer to [2] for a detailed explanation) ordering between the userspace and
GuestOS mappings resulting stream of transactions (ie it does not cause loss of
property for either stream of transactions on its own), which is harmless
given that the userspace and GuestOS access to the device is carried
out through independent transactions streams.

[1] section D8.5 - DDI0487_I_a_a-profile_architecture_reference_manual.pdf
[2] section B2.8 - DDI0487_I_a_a-profile_architecture_reference_manual.pdf

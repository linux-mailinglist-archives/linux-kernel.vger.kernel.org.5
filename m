Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793237D0E50
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376933AbjJTLWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377034AbjJTLV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:21:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B80D57
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:21:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B91DC433C8;
        Fri, 20 Oct 2023 11:21:53 +0000 (UTC)
Date:   Fri, 20 Oct 2023 12:21:50 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, ankita@nvidia.com,
        maz@kernel.org, oliver.upton@linux.dev, aniketa@nvidia.com,
        cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
        vsethi@nvidia.com, acurrid@nvidia.com, apopple@nvidia.com,
        jhubbard@nvidia.com, danw@nvidia.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <ZTJizmxV4Gtb4g3S@arm.com>
References: <ZR6IZwcFNw55asW0@lpieralisi>
 <20231012123541.GB11824@willie-the-truck>
 <ZSf6Ue09IO6QMBs1@arm.com>
 <20231012144807.GA12374@willie-the-truck>
 <ZSgsKSCv-zWgtWkm@arm.com>
 <20231013092934.GA13524@willie-the-truck>
 <ZSlBOiebenPKXBY4@arm.com>
 <20231013134541.GP3952@nvidia.com>
 <ZTEN_oe97VRWbnHb@arm.com>
 <20231019115142.GQ3952@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019115142.GQ3952@nvidia.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 08:51:42AM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 19, 2023 at 12:07:42PM +0100, Catalin Marinas wrote:
> > Talking to Will earlier, I think we can deem the PCIe scenario
> > (somewhat) safe but not as a generic mechanism for other non-PCIe
> > devices (e.g. platform). With this concern, can we make this Stage 2
> > relaxation in KVM only for vfio-pci mappings? I don't have an example of
> > non-PCIe device assignment to figure out how this should work though.
> 
> It is not a KVM problem. As I implied above it is VFIO's
> responsibility to reliably reset the device, not KVMs. If for some
> reason VFIO cannot do that on some SOC then VFIO devices should not
> exist.
> 
> It is not KVM's job to double guess VFIO's own security properties.

I'd argue that since KVM is the one relaxing the memory attributes
beyond what the VFIO driver allows the VMM to use, it is KVM's job to
consider the security implications. This is fine for vfio-pci and
Normal_NC but I'm not sure we can generalise.

> Specifically about platform the generic VFIO platform driver is the
> ACPI based one. If the FW provides an ACPI method for device reset
> that is not properly serializing, that is a FW bug. We can quirk it in
> VFIO and block using those devices if they actually exist.
> 
> I expect the non-generic VFIO platform drivers to take care of this
> issue internally with, barriers, read from devices, whatver is
> required to make their SOCs order properly. Just as I would expect a
> normal Linux platform driver to directly manage whatever
> implementation specific ordering quirks the SOC may have.

This would be a new requirement if an existing VFIO platform driver
relied on all mappings being Device. But maybe that's just theoretical
at the moment, are there any concrete examples outside vfio-pci? If not,
we can document it as per Lorenzo's suggestion to summarise this
discussion under Documentation/.

-- 
Catalin

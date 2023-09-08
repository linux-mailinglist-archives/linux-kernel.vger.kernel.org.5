Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F48798AC0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 18:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243550AbjIHQlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 12:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjIHQlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:41:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C68D199F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 09:41:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4839DC433C9;
        Fri,  8 Sep 2023 16:40:58 +0000 (UTC)
Date:   Fri, 8 Sep 2023 17:40:55 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     ankita@nvidia.com
Cc:     jgg@nvidia.com, maz@kernel.org, oliver.upton@linux.dev,
        will@kernel.org, aniketa@nvidia.com, cjia@nvidia.com,
        kwankhede@nvidia.com, targupta@nvidia.com, vsethi@nvidia.com,
        acurrid@nvidia.com, apopple@nvidia.com, jhubbard@nvidia.com,
        danw@nvidia.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <ZPtOl7EqLzMusuIX@arm.com>
References: <20230907181459.18145-1-ankita@nvidia.com>
 <20230907181459.18145-3-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230907181459.18145-3-ankita@nvidia.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Lorenzo

On Thu, Sep 07, 2023 at 11:14:59AM -0700, ankita@nvidia.com wrote:
> From: Ankit Agrawal <ankita@nvidia.com>
> 
> Linux allows device drivers to map IO memory on a per-page basis using
> "write combining" or WC. This is often done using
> pgprot_writecombing(). The driver knows which pages can support WC
> access and the proper programming model to generate this IO. Generally
> the use case is to boost performance by using write combining to
> generate larger PCIe MemWr TLPs.
> 
> Allow VMs to select DEVICE_* or NORMAL_NC on a page by page basis for
> all IO memory. This puts the VM in charge of the memory attributes,
> and removes the KVM override to DEVICE_nGnRE.
> 
> Ultimately this makes pgprot_writecombing() work correctly in VMs and
> allows drivers like mlx5 to fully operate their HW.
> 
> After some discussions with ARM and CPU architects we reached the
> conclusion there was no need for KVM to prevent the VM from selecting
> between DEVICE_* and NORMAL_NC for IO memory in VMs. There was a fear
> that NORMAL_NC could result in uncontained failures, but upon deeper
> analysis it turns out there are already possible cases for uncontained
> failures with DEVICE types too. Ultimately the platform must be
> implemented in a way that ensures that all DEVICE_* and NORMAL_NC
> accesses have no uncontained failures.
> 
> Fortunately real platforms do tend to implement this.
> 
> This patch makes the VM's memory attributes behave as follows:
> 
>  S1           |   S2          |  Result
>  NORMAL-WB    |  NORMAL-NC    |  NORMAL-NC
>  NORMAL-WT    |  NORMAL-NC    |  NORMAL-NC
>  NORMAL-NC    |  NORMAL-NC    |  NORMAL-NC
>  DEVICE<attr> |  NORMAL-NC    |  DEVICE<attr>
> 
> See section D8.5.5 of DDI0487_I_a_a-profile_architecture_reference_manual.pdf
> for details.
> 
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>

From the discussions with the hardware people in Arm and Nvidia, we
indeed concluded that relaxing S2 to Normal-NC is not any worse than
Device (and actually Device memory is more prone to generating
uncontained errors, something to do with the Device memory ordering
semantics).

For this change:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin

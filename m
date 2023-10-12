Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19EE7C6E12
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378679AbjJLM1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343987AbjJLM1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:27:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8603CF
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:27:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CABC433C8;
        Thu, 12 Oct 2023 12:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697113628;
        bh=SQ4DA83oo8zZW8hOFhoNCSuNEw8lojzFzyaH6hWe2ng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qS1sHc4yycY+w97RR3dyMgdviAG/YKQSMdqW2U80gRAZzd2RHYgQn7m4kWNfZeW3h
         XCUXsoarntfXd4mRvzZ6Nuxs5sPbATdtpMq174K8ytinLNXqqRitCVW1C6CkIIGLdY
         EF3nlQQKAuCe1Y+oun+vYB4HzMt8rn3/rqmPI2m3cA37cSpe37mfs1YjIpk9NqAade
         mPx8C+jBQB7XVu+mTaa0VvpPg2j/z3VyvgGwW3Nb0n63p0uywbx2DJ+jv3//Du1Fur
         uzio8liB7MCU7Dy4tCTjEkKbqioPro0b3DDbscdqV9EalD+6nSnrj58gYfKWP+dMA9
         zQa1QuM20lfcA==
Date:   Thu, 12 Oct 2023 13:27:01 +0100
From:   Will Deacon <will@kernel.org>
To:     ankita@nvidia.com
Cc:     jgg@nvidia.com, maz@kernel.org, oliver.upton@linux.dev,
        catalin.marinas@arm.com, aniketa@nvidia.com, cjia@nvidia.com,
        kwankhede@nvidia.com, targupta@nvidia.com, vsethi@nvidia.com,
        acurrid@nvidia.com, apopple@nvidia.com, jhubbard@nvidia.com,
        danw@nvidia.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <20231012122701.GA11824@willie-the-truck>
References: <20230907181459.18145-1-ankita@nvidia.com>
 <20230907181459.18145-3-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230907181459.18145-3-ankita@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> ---
>  arch/arm64/include/asm/memory.h | 2 ++
>  arch/arm64/kvm/hyp/pgtable.c    | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index fde4186cc387..c247e5f29d5a 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -147,6 +147,7 @@
>   * Memory types for Stage-2 translation
>   */
>  #define MT_S2_NORMAL		0xf
> +#define MT_S2_NORMAL_NC	0x5
>  #define MT_S2_DEVICE_nGnRE	0x1
>  
>  /*
> @@ -154,6 +155,7 @@
>   * Stage-2 enforces Normal-WB and Device-nGnRE
>   */
>  #define MT_S2_FWB_NORMAL	6
> +#define MT_S2_FWB_NORMAL_NC	5
>  #define MT_S2_FWB_DEVICE_nGnRE	1
>  
>  #ifdef CONFIG_ARM64_4K_PAGES
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index ccd291b6893d..a80949002191 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -696,7 +696,7 @@ static int stage2_set_prot_attr(struct kvm_pgtable *pgt, enum kvm_pgtable_prot p
>  				kvm_pte_t *ptep)
>  {
>  	bool device = prot & KVM_PGTABLE_PROT_DEVICE;
> -	kvm_pte_t attr = device ? KVM_S2_MEMATTR(pgt, DEVICE_nGnRE) :
> +	kvm_pte_t attr = device ? KVM_S2_MEMATTR(pgt, NORMAL_NC) :
>  			    KVM_S2_MEMATTR(pgt, NORMAL);
>  	u32 sh = KVM_PTE_LEAF_ATTR_LO_S2_SH_IS;

I think this is putting the policy into the low-level page-table code,
which isn't where it belongs. KVM_PGTABLE_PROT_DEVICE means that the
mapping should be created with device attributes. If you want other
attributes, then please introduce another entry to 'kvm_pgtable_prot'
and pass that instead (e.g. KVM_PGTABLE_PROT_NC, which coincidentally
we already have in Android [1] ;).

Will

[1] https://android.googlesource.com/kernel/common/+/72cc19df8b71095f9740ff0ca6a75bf7ed27b0cd%5E%21/

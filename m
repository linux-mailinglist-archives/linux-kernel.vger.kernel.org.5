Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B61679BA16
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350630AbjIKVkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240955AbjIKO6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:58:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E7C1B9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:57:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F205AC433C8;
        Mon, 11 Sep 2023 14:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694444278;
        bh=bQfMxb8+0HLBcBK15McAVOoJ4uTK8OsVjnEBuWMDElM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sUsSOGJyRfMKdnb5MxsvDKxeR1+28guLt+j2WSEuS+e+p8RkicfbuGIMJc7m8Patm
         hmBkAKcEjQ2xQQHJaZPQA1owXs45QxDuFAL3rEarN7G+Jo8GrSB7AEN5ATGsen2LCu
         CNaSt/78+JcgNNx+X+23m5wJCZdFZ7cFZjyt15ZvhA4BAzxZBmj9pjMY+9YwyRUKZo
         f7SvOQEADlk7vE2f31yKb6zI3akyx7r10oDUPBRx6a9PP7XITusl3MBE4CWrIYtaG0
         mRkGcl59P+Qm12WVPnExYDR0qdkIixyWZLS9UerXj16PSguyNiY+gByAZBUslgEkHQ
         rDYvj9HinWGPQ==
Date:   Mon, 11 Sep 2023 16:57:51 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     ankita@nvidia.com
Cc:     jgg@nvidia.com, maz@kernel.org, oliver.upton@linux.dev,
        catalin.marinas@arm.com, will@kernel.org, aniketa@nvidia.com,
        cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
        vsethi@nvidia.com, acurrid@nvidia.com, apopple@nvidia.com,
        jhubbard@nvidia.com, danw@nvidia.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <ZP8q71+YXoU6O9uh@lpieralisi>
References: <20230907181459.18145-1-ankita@nvidia.com>
 <20230907181459.18145-3-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230907181459.18145-3-ankita@nvidia.com>
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

pgprot_writecombine() ?

> access and the proper programming model to generate this IO. Generally
> the use case is to boost performance by using write combining to
> generate larger PCIe MemWr TLPs.

First off, this changeset does not affect *only* Linux guests, obviously.

I understand that's the use case you are after but this change is
targeting all VMs, it must be clear.

Then WC and mapping to PCI TLPs, either you describe that in details
(NormalNC vs device-nGnRE and resulting SystemBus<->PCI transactions) or
you don't describe it at all, as it stands I don't know how to use
this information.

> Allow VMs to select DEVICE_* or NORMAL_NC on a page by page basis for
> all IO memory. This puts the VM in charge of the memory attributes,
> and removes the KVM override to DEVICE_nGnRE.
> 
> Ultimately this makes pgprot_writecombing() work correctly in VMs and

pgprot_writecombine() ?

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

I would reorder/rephrase this changelog as follows:

- Describe what the problem is (ie KVM default s2 mappings)
- Describe how you are solving it
- Add a link to the documentation that states why it is safe to do
  that and the resulting s1/s2 mappings combination

It must be clear why from a legacy standpoint this is a safe change
to apply.

> Fortunately real platforms do tend to implement this.

Remove this sentence, it adds no information for someone who
is chasing bugs or just wants to understand the change itself.

> This patch makes the VM's memory attributes behave as follows:

"The resulting stage 1 and stage 2 memory types and cacheability
attributes are as follows":

>  S1           |   S2          |  Result
>  NORMAL-WB    |  NORMAL-NC    |  NORMAL-NC
>  NORMAL-WT    |  NORMAL-NC    |  NORMAL-NC
>  NORMAL-NC    |  NORMAL-NC    |  NORMAL-NC
>  DEVICE<attr> |  NORMAL-NC    |  DEVICE<attr>
> 
> See section D8.5.5 of DDI0487_I_a_a-profile_architecture_reference_manual.pdf
> for details.

D8.5 I assume.

I commented on the log because it must be easy to follow, it is an
important change (and there is a lot of background information
required to understand it - please report it).

The patch itself must be reviewed by arm64/kvm maintainers; the changes
(given the background work that led to them) seem fine to me (please CC
me on next versions).

Thanks
Lorenzo

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
>  
> -- 
> 2.17.1
> 

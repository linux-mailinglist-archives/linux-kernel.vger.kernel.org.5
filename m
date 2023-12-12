Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0502580F4A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376773AbjLLRcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbjLLRcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:32:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B818E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:32:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A85C433C7;
        Tue, 12 Dec 2023 17:32:01 +0000 (UTC)
Date:   Tue, 12 Dec 2023 17:31:59 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     ankita@nvidia.com
Cc:     jgg@nvidia.com, maz@kernel.org, oliver.upton@linux.dev,
        suzuki.poulose@arm.com, yuzenghui@huawei.com, will@kernel.org,
        alex.williamson@redhat.com, kevin.tian@intel.com,
        yi.l.liu@intel.com, ardb@kernel.org, akpm@linux-foundation.org,
        gshan@redhat.com, linux-mm@kvack.org, lpieralisi@kernel.org,
        aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
        targupta@nvidia.com, vsethi@nvidia.com, acurrid@nvidia.com,
        apopple@nvidia.com, jhubbard@nvidia.com, danw@nvidia.com,
        mochs@nvidia.com, kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] kvm: arm64: introduce new flag for non-cacheable
 IO memory
Message-ID: <ZXiZDwaCtHpPGXh6@arm.com>
References: <20231208164709.23101-1-ankita@nvidia.com>
 <20231208164709.23101-2-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208164709.23101-2-ankita@nvidia.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 10:17:08PM +0530, ankita@nvidia.com wrote:
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index c651df904fe3..d4835d553c61 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -718,10 +718,17 @@ static int stage2_set_prot_attr(struct kvm_pgtable *pgt, enum kvm_pgtable_prot p
>  				kvm_pte_t *ptep)
>  {
>  	bool device = prot & KVM_PGTABLE_PROT_DEVICE;
> -	kvm_pte_t attr = device ? KVM_S2_MEMATTR(pgt, DEVICE_nGnRE) :
> -			    KVM_S2_MEMATTR(pgt, NORMAL);
> +	bool normal_nc = prot & KVM_PGTABLE_PROT_NORMAL_NC;
> +	kvm_pte_t attr;
>  	u32 sh = KVM_PTE_LEAF_ATTR_LO_S2_SH_IS;
>  
> +	if (device)
> +		attr = KVM_S2_MEMATTR(pgt, DEVICE_nGnRE);
> +	else if (normal_nc)
> +		attr = KVM_S2_MEMATTR(pgt, NORMAL_NC);
> +	else
> +		attr = KVM_S2_MEMATTR(pgt, NORMAL);

As Will said, maybe a WARN_ON_ONCE(device && normal_nc). It would fall
back to device which I think is fine.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5769675D50A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 21:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjGUTbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 15:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjGUTbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 15:31:09 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB93E68
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 12:31:08 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b8baa836a5so17070155ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 12:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689967868; x=1690572668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f3fNBXK6DdLEjSA1dgCCAp4qYAepk3u3d3m0rz5z1fE=;
        b=kDmWxsg8ZqlraY3EitIJv4Evr2CcqLMRY3qJJ8AcjlKJ3bFOzgBkDnjKefyYbdeSfz
         k86T0qkxGRO51XZTaYeEKipExFEf8j1Hv1UVrlMbeSWAAge69sWytNfaMcA7RqeT6zuL
         3L23q9S/iI50qzztXd/HyH2HoeCpvu0Z2gNnWlaIpHe3ERs66DUZ8IU1MTauRcMdzksf
         ILJCbJ6VdIAYJt/7FJu58WJgwsSS2VgS9zoptDQ2XjWHdUPjgabRgHusalzm4+RsCynb
         dnms2eGvIrcLiBFxG5n4oVrQg7cm8ONAc3J+1xhZDfp15hiSb0l0fBegQfffD1CHZhNd
         TBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689967868; x=1690572668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3fNBXK6DdLEjSA1dgCCAp4qYAepk3u3d3m0rz5z1fE=;
        b=FxophY8thDKER3NV8aMfPjaLbrZSF05SAzLmVPTmX8qE/CQkFI2Q6rSzlCtE5e9lEy
         4c4TrJc9YXdGkGHVT7TBSIyXbS6kGC+BIE1AQhGKqYBE65ua6oazI2+n1RNTZwXejz3Z
         LUDTQzjdyMmdFC7KWwLN07Otdnnu4CXi4Hkrs+0nEpEM3uQT5a4OnY5N1jZ1d30Zftax
         jhjt4tsK2Fh7ZMeupIE/9foaaLUAEDrYMcMCvLQaJ0Dt1pdw72G2H2GYQNAovaJqaqmR
         wCC0krHS4/fMZEkb4FXsDgz8JGWfopkvfWSq3Ysyw8tcyTvC/MIZCPR+Pl0QZ0faHP39
         pnKw==
X-Gm-Message-State: ABy/qLbcrhj+7a/SnC0fBkUzpb95hMPpQQ11JdRGi/+wBbMGNm/8yZRk
        BwbcM6GEvWCkZETKrLvsQfxnRQ==
X-Google-Smtp-Source: APBJJlHihJyY9wXFkjydx/6tfCAtPCW82R9C1y8RYnU52rOS6+M8sM4/6qnSkSyFxd3dSuGWl4EDkw==
X-Received: by 2002:a17:902:b418:b0:1b8:b2c6:7e8d with SMTP id x24-20020a170902b41800b001b8b2c67e8dmr2649069plr.66.1689967868340;
        Fri, 21 Jul 2023 12:31:08 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id r16-20020a170902be1000b001b8422f1000sm3860137pls.201.2023.07.21.12.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 12:31:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qMvqE-003IGg-98;
        Fri, 21 Jul 2023 16:31:06 -0300
Date:   Fri, 21 Jul 2023 16:31:06 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     akpm@linux-foundation.org, ajd@linux.ibm.com,
        catalin.marinas@arm.com, fbarrat@linux.ibm.com,
        iommu@lists.linux.dev, jhubbard@nvidia.com, kevin.tian@intel.com,
        kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        nicolinc@nvidia.com, npiggin@gmail.com, robin.murphy@arm.com,
        seanjc@google.com, will@kernel.org, x86@kernel.org,
        zhi.wang.linux@gmail.com, sj@kernel.org
Subject: Re: [PATCH v3 5/5] mmu_notifiers: Rename invalidate_range notifier
Message-ID: <ZLrc+vEQcCEpI0wd@ziepe.ca>
References: <cover.b24362332ec6099bc8db4e8e06a67545c653291d.1689842332.git-series.apopple@nvidia.com>
 <3cbd2a644d56d503b47cfc35868d547f924f880e.1689842332.git-series.apopple@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cbd2a644d56d503b47cfc35868d547f924f880e.1689842332.git-series.apopple@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 06:39:27PM +1000, Alistair Popple wrote:
> There are two main use cases for mmu notifiers. One is by KVM which
> uses mmu_notifier_invalidate_range_start()/end() to manage a software
> TLB.
> 
> The other is to manage hardware TLBs which need to use the
> invalidate_range() callback because HW can establish new TLB entries
> at any time. Hence using start/end() can lead to memory corruption as
> these callbacks happen too soon/late during page unmap.
> 
> mmu notifier users should therefore either use the start()/end()
> callbacks or the invalidate_range() callbacks. To make this usage
> clearer rename the invalidate_range() callback to
> arch_invalidate_secondary_tlbs() and update documention.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  arch/arm64/include/asm/tlbflush.h               |  6 +-
>  arch/powerpc/mm/book3s64/radix_hugetlbpage.c    |  2 +-
>  arch/powerpc/mm/book3s64/radix_tlb.c            | 10 ++--
>  arch/x86/include/asm/tlbflush.h                 |  2 +-
>  arch/x86/mm/tlb.c                               |  2 +-
>  drivers/iommu/amd/iommu_v2.c                    | 10 ++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 13 ++---
>  drivers/iommu/intel/svm.c                       |  8 +--
>  drivers/misc/ocxl/link.c                        |  8 +--
>  include/linux/mmu_notifier.h                    | 48 +++++++++---------
>  mm/huge_memory.c                                |  4 +-
>  mm/hugetlb.c                                    |  7 +--
>  mm/mmu_notifier.c                               | 20 ++++++--
>  13 files changed, 76 insertions(+), 64 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

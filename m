Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA348014C7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379547AbjLAUsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAUsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:48:14 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5E2FF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 12:48:20 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-58d54fd8c5aso1317931eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 12:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701463700; x=1702068500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sc0mXGdos+flIqYbEOETr4gKaCIcHlnZcTFOmVNNT/s=;
        b=PCPpbHgaHaLzF2YJYe/ymH6Kk3KgLSZlnHvGgCVw+0zWtZ/KRGMpk/g0v5Kxl7mt+F
         ocYzErTRGCkM5yaesc7vmPbyl0yZWZlTQ/pcePv4ipxC6Pc2vpyUVtpDzPgnooWOXQri
         GkvNwno3Y2VNo7dpFPSyZCvSfjn9KIpZGezYXoaGHb2FobCW5/mys7Wlb4fL5VpEfSCz
         XAdiXrMX4WDNed/JU2LoDiRHYHELmbmDpEjcSfda015dwV+2zaMqu6q6BmIiMEGDf+fS
         O7/HSyMAijWE+m4r/ElkDglj18FsMDFdoVr28Q/IOQ75ogmy/rueI6UbxmPZXyjuqar5
         L+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701463700; x=1702068500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sc0mXGdos+flIqYbEOETr4gKaCIcHlnZcTFOmVNNT/s=;
        b=JIPIkhNdezucTYZIsbc4WPBAuGrkUQzV53VcF9/ihbEnqzAGdTeBpbPLsDvCFC7I4O
         CQWwTh1nAg9p96Wo1ZPNYi4mUK/B0FJsfN1qZh4N2avNyDVkj8PWO5uAuGPZQkIfTRwy
         yHaZBvD6NKvfBUe0pXPL3tmpvTr3/Rz+E1YIN9hVPu8t1vq4cdunMqb8qH7QGHdpJRy1
         39+/bjy0rdaU/M38JYELwQOZCeRxw97I+fu74KR7/bUMS80SpHrIFXzk46lBMCsTQrl2
         oR57RRlpCoBUyiGqkLsRwxP74AjQ31aywQVG75BdybF1zSg6GTCzcVawkl3WpXfW6G86
         IL1A==
X-Gm-Message-State: AOJu0YwY0X3apIbgV0QXee6fz9jZGMNRF4BSxbKHY5ggHrzpBocozjMr
        G4DK22OnIZJHg+HH8meMBpji0g==
X-Google-Smtp-Source: AGHT+IEZyyMyYdVZ/U2w+Y1ObRK14n0S0fw+H/3/e0+QnvNoXR/Lw9yKjEGoy++VknK7HJZ3jXY6+w==
X-Received: by 2002:a05:6870:698c:b0:1fa:789a:d12c with SMTP id my12-20020a056870698c00b001fa789ad12cmr337579oab.38.1701463700064;
        Fri, 01 Dec 2023 12:48:20 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id s9-20020a0c8d49000000b0067a245efd3csm1825633qvb.135.2023.12.01.12.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 12:48:19 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r9AQs-006OM7-TF;
        Fri, 01 Dec 2023 16:48:18 -0400
Date:   Fri, 1 Dec 2023 16:48:18 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tina Zhang <tina.zhang@intel.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        torvalds@linux-foundation.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] iommu: Change kconfig around IOMMU_SVA
Message-ID: <20231201204818.GH1489931@ziepe.ca>
References: <20231128021635.5530-1-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128021635.5530-1-tina.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Nov 28, 2023 at 10:16:35AM +0800, Tina Zhang wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Linus suggested that the kconfig here is confusing:
> 
> https://lore.kernel.org/all/CAHk-=wgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhUgvUqjr9Xw@mail.gmail.com/
> 
> Let's break it into three kconfigs controlling distinct things:
> 
>  - CONFIG_IOMMU_MM_DATA controls if the mm_struct has the additional
>    fields for the IOMMU. Currently only PASID, but later patches store
>    a struct iommu_mm_data *
> 
>  - CONFIG_ARCH_HAS_CPU_PASID controls if the arch needs the scheduling bit
>    for keeping track of the ENQCMD instruction. x86 will select this if
>    IOMMU_SVA is enabled
> 
>  - IOMMU_SVA controls if the IOMMU core compiles in the SVA support code
>    for iommu driver use and the IOMMU exported API
> 
> This way ARM will not enable CONFIG_ARCH_HAS_CPU_PASID
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>  arch/Kconfig             | 5 +++++
>  arch/x86/Kconfig         | 1 +
>  arch/x86/kernel/traps.c  | 2 +-
>  drivers/iommu/Kconfig    | 1 +
>  include/linux/iommu.h    | 2 +-
>  include/linux/mm_types.h | 2 +-
>  include/linux/sched.h    | 2 +-
>  kernel/fork.c            | 2 +-
>  mm/Kconfig               | 3 +++
>  mm/init-mm.c             | 2 +-
>  10 files changed, 16 insertions(+), 6 deletions(-)

Try again, you need to cc the mm list and the x86 list

Jason

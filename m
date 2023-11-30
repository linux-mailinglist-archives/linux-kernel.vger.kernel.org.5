Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649237FEEB5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjK3MPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjK3MPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:15:41 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910D3D48
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 04:15:47 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1fa4b632198so388537fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 04:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701346547; x=1701951347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qJCc9G3EC+NAjT0tK5yC9iiI0skMSbzKL4bpKApwWpE=;
        b=FUnWkKAP4PA7/mj9bve8WLIOgLB3WMdkpkAt23MAKMZlc2q8mElaQMBTOwp3lcmXID
         5rgfpcZHXiQDZsrhN4BmleUZAK7jgjORbSRPRpHMTzzqtrIX3kwJbc5U2IvpdBs1vFni
         FVvqtMEhiJGUcGSdAb/Sh3JAyWZQwv/6HyNORrXEyIdAMSFy2PNereIHNh+Bghf/t2eC
         K08Odxd9ayAAnHakdgWSiOr2zvLTmHj9VOSlxuV7Ayw8RAxJkTq/keu+XMeys98VM0fs
         rkYwTk4ZdM/ttFTMBvTHIdrCRgLpRtUD5HvW4kF0mdqEnMD/yPMZo+OzE6JbA86F/Nod
         V9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701346547; x=1701951347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJCc9G3EC+NAjT0tK5yC9iiI0skMSbzKL4bpKApwWpE=;
        b=R0c2kZuw1ntyVgyqsUIiWlm9jHOYdxYyV0IldY5QXBQ6MEkWtSbKbfZ4Rnget3tt6A
         L/BJhQS5NhpXrsMFbxBRKe2sVjieWSPR4KE9U6kk5VV6sace+w+VsD8zplN/Fnb9x3zA
         B/EomTuGE9RMKK53QtxjSAXnR0i23si7ACrTvHOsFw5KVjjUr0Bn+ZUOZg9m0syBSlEY
         /eSRD94s40LZfH1hbDDdjd0MomjaxFxKR7yS6a6eqHwGdPgINu3y/c76gIP830cGRYKU
         iULzp0uvM1Yy+MQBrkC52max2yIz3/6kKa6jcGo1h5y8V1Tsh9uRKPc+g7LROI18mv3A
         jHNQ==
X-Gm-Message-State: AOJu0YzsVoFAb9H1O2eUditzyF9JpRX0hSf7m6RmbSBqNGVpxqdgzrqi
        aRr7lkxjQmer5b8zl9qrLBxmtKQsatX0EcmjOnE=
X-Google-Smtp-Source: AGHT+IH4aK3LYbDZTOXkpMfqtUQj0FJCc/XdP+zPGlT1qcjW2LqvVfNRQxQAJceD1zjJyXpuw++Cpw==
X-Received: by 2002:a05:6870:9e83:b0:1fa:1bf6:b6a3 with SMTP id pu3-20020a0568709e8300b001fa1bf6b6a3mr23299174oab.28.1701346546810;
        Thu, 30 Nov 2023 04:15:46 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id b26-20020a9d6b9a000000b006b74bea76c0sm127412otq.47.2023.11.30.04.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 04:15:45 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r8fxI-005u3o-RF;
        Thu, 30 Nov 2023 08:15:44 -0400
Date:   Thu, 30 Nov 2023 08:15:44 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Omit devTLB invalidation requests when
 TES=0
Message-ID: <20231130121544.GC1394392@ziepe.ca>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
 <20231114011036.70142-2-baolu.lu@linux.intel.com>
 <20231129201020.GK1312390@ziepe.ca>
 <2f2582df-fb56-4b46-8ce3-364879b34734@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f2582df-fb56-4b46-8ce3-364879b34734@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 12:06:59PM +0800, Baolu Lu wrote:
> On 2023/11/30 4:10, Jason Gunthorpe wrote:
> > On Tue, Nov 14, 2023 at 09:10:34AM +0800, Lu Baolu wrote:
> > > The latest VT-d spec indicates that when remapping hardware is disabled
> > > (TES=0 in Global Status Register), upstream ATS Invalidation Completion
> > > requests are treated as UR (Unsupported Request).
> > > 
> > > Consequently, the spec recommends in section 4.3 Handling of Device-TLB
> > > Invalidations that software refrain from submitting any Device-TLB
> > > invalidation requests when address remapping hardware is disabled.
> > > 
> > > Verify address remapping hardware is enabled prior to submitting Device-
> > > TLB invalidation requests.
> > > 
> > > Fixes: 792fb43ce2c9 ("iommu/vt-d: Enable Intel IOMMU scalable mode by default")
> > > Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> > > ---
> > >   drivers/iommu/intel/dmar.c | 18 ++++++++++++++++++
> > >   1 file changed, 18 insertions(+)
> > How did you get to the point where flush_dev_iotlb could even be
> > called if the iommu has somehow been globally disabled?
> > 
> > Shouldn't the attach of the domain compeltely fail if the HW is
> > disabled?
> > 
> > If the domain is not attached to anything why would flushing happen?
> 
> The VT-d hardware can be in a state where the hardware is on but DMA
> translation is deactivated. In this state, the device probe process
> during boot proceeds as follows:
> 
> 1) Initialize the IOMMU contexts: This sets up the data structures that
>    the IOMMU uses to manage address translation for DMA operations.
> 
> 2) Register the IOMMU devices: This registers the IOMMU devices to the
>    core. The core then probes devices on buses like PCI.
> 
> 3) Enable DMA translation: This step activates DMA translation.
> 
> With regard to step 2), the call to iommu_flush_iotlb_all() in
> iommu_create_device_direct_mappings() can potentially cause device TBL
> invalidation when the VT-d DMA translation is deactivated.

You are trying to create an atomic change at boot from non-translating
to DMA translating for HW that doesn't support the identity mode?

This should probably get a comment in this patch..

Jason

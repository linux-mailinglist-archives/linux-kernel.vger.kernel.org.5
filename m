Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200F07AAAFA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjIVH5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjIVH5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:57:21 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D82AFB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:57:15 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32001d16a14so1730138f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695369434; x=1695974234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnFqnWCwcyqa0uxptZjUfiZurm7gKfTYACFMprkcSZc=;
        b=o9Nku1Hj3ZkxrqqVc61TGuxGpxd/tMNhmAQYC5jmIZ5TKMv8jSXWDijWW7OAAauhIL
         MgYHnKrDtYQxr6FahrN65ex6uwMdeyz1xdoyjmdAGWmpVGsueawAwTrYz7/yHSOIZ/H8
         3zZgEItO9gu8r99Vavlv8xlcz0SSEGIt/g01B/ZtaBf0jKg39RqTE+P6Z/9Ct2wen8Fw
         vj3ceau344xlImLtnLL1bk/yB5+DzUmBexz02R5Yr/scv0FItvwXFc/w+NPSuma84ZxY
         gvZoPvnXun092jkFbL3Sh6Vs4BIUkKzoyv2paZDa8L8DlWWtzsXMQqElPYujaEwAqiy/
         1k+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695369434; x=1695974234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnFqnWCwcyqa0uxptZjUfiZurm7gKfTYACFMprkcSZc=;
        b=K2WM3PnMUe7MRHeZK61JMiteZ17IFYr1w3+l6aGkuLA+p3N+OosmDmq3HIv+cRDZvC
         t2G2lG5xkvhe2/vOpadf4JcPG9Ap5ZF0MujLGKkTjLKwvu+lxu/dtk+B+rdsiN59G9aN
         vCV+iggfs1sw3f+F2ysVw4/j2ymGtnvB6LMwjzTA39j1FPCKPQV3TsKtM30LJbOkEhfV
         zWWB7C6bp5nwsyznbgPTo8KmdeH0b/YU+SB9BxSv23PKGJicSo7R5Hk8rCr2t3+1g1NT
         MFJoPCqLLHomdBamWyNiLVvwhI/9WtMfF8eRnCViYrOOk8rdPyzDo4nBHI7rSNTCljSF
         BmJQ==
X-Gm-Message-State: AOJu0YznbdQJHn0GOBWVARbca/7KXAC4xwyIRoFXBhMfKAMmnRp4eLQf
        a/y1WrkL2u9FOUXeqqJLrA6enQ==
X-Google-Smtp-Source: AGHT+IHWcZglriBzW9X2jK5nxXTgqPGq0Rp8QA7W/Rk3EcPZ5Jyf8nkyUbyRRLcvr0oqOvJfnIoUVw==
X-Received: by 2002:adf:f008:0:b0:31f:fab1:c3c3 with SMTP id j8-20020adff008000000b0031ffab1c3c3mr7029007wro.35.1695369433661;
        Fri, 22 Sep 2023 00:57:13 -0700 (PDT)
Received: from myrica ([2a02:c7c:7290:b00:fd32:2b31:6755:400c])
        by smtp.gmail.com with ESMTPSA id y12-20020adffa4c000000b0031f5f0d0be0sm3746610wrr.31.2023.09.22.00.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 00:57:13 -0700 (PDT)
Date:   Fri, 22 Sep 2023 08:57:19 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230922075719.GB1361815@myrica>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
 <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
 <20230919081519.GA3860249@myrica>
 <20230919144649.GT13795@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919144649.GT13795@ziepe.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 11:46:49AM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 19, 2023 at 09:15:19AM +0100, Jean-Philippe Brucker wrote:
> > On Mon, Sep 18, 2023 at 05:37:47PM +0100, Robin Murphy wrote:
> > > > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > > > index 17dcd826f5c2..3649586f0e5c 100644
> > > > --- a/drivers/iommu/virtio-iommu.c
> > > > +++ b/drivers/iommu/virtio-iommu.c
> > > > @@ -189,6 +189,12 @@ static int viommu_sync_req(struct viommu_dev *viommu)
> > > >   	int ret;
> > > >   	unsigned long flags;
> > > > +	/*
> > > > +	 * .iotlb_sync_map and .flush_iotlb_all may be called before the viommu
> > > > +	 * is initialized e.g. via iommu_create_device_direct_mappings()
> > > > +	 */
> > > > +	if (!viommu)
> > > > +		return 0;
> > > 
> > > Minor nit: I'd be inclined to make that check explicitly in the places where
> > > it definitely is expected, rather than allowing *any* sync to silently do
> > > nothing if called incorrectly. Plus then they could use
> > > vdomain->nr_endpoints for consistency with the equivalent checks elsewhere
> > > (it did take me a moment to figure out how we could get to .iotlb_sync_map
> > > with a NULL viommu without viommu_map_pages() blowing up first...)
> 
> This makes more sense to me
> 
> Ultimately this driver should reach a point where every iommu_domain
> always has a non-null domain->viommu because it will be set during
> alloc.
> 
> But it can still have nr_endpoints == 0, doesn't it make sense to
> avoid sync in this case?
> 
> (btw this driver is missing locking around vdomain->nr_endpoints)

Yes, that's on my list

> 
> > They're not strictly equivalent: this check works around a temporary issue
> > with the IOMMU core, which calls map/unmap before the domain is
> > finalized.
> 
> Where? The above points to iommu_create_device_direct_mappings() but
> it doesn't because the pgsize_bitmap == 0:

__iommu_domain_alloc() sets pgsize_bitmap in this case:

        /*
         * If not already set, assume all sizes by default; the driver
         * may override this later
         */
        if (!domain->pgsize_bitmap)
                domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;

Thanks,
Jean

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813AA7A6737
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjISOsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjISOsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:48:16 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE9EBC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 07:48:10 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-6515d44b562so32193896d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 07:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695134890; x=1695739690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EquMz/cfki7kEYJ0MaznRKfaKZ1PqbzvZHpIvKnZUnM=;
        b=Q13uSWPgiPspz8KEcJJbF4aK67uQpFLGUlB5GZkKupKuxM1yt6VoPcNjv1cfV5JOHJ
         ZEDxkKdxvmjcPkfE89Pi7MdgwB3uxIO9QkEp4lNID5janI2puxKUWQst5uYYGoTY98qr
         MGRfj6HqR/MD23wcjJg/LvpY1W4ZLA3Bghabmdj1WLQlTvfxja7CESiZ81m+JdtNqDAt
         PEaXqwdBuim5zCGVIU0jV2abjbuFdaY01P+wAA+Y8g06Lem1JHKc8dZILwglN3lEs295
         fLp0i8XUfXOIvs8d9GjKE2uEXQcpaJUKBPXjIuplPi+7eT9ZTgJbyxFNCN8SkW5GfEow
         o/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695134890; x=1695739690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EquMz/cfki7kEYJ0MaznRKfaKZ1PqbzvZHpIvKnZUnM=;
        b=fbrF9NC6g8XUzKwYq4KKiKf+wraFz3crZK3+0sIfo7z76XGM/j5TSFwkaDbY3W8EoF
         TmgZIAVJqKQ4Lr4K1zq3jKLNgjZRiUs8Om+ktOUBHIJOYGWvtGY3lbkAuNuPNa70SRR6
         frW/whsey8on4CWQ1dCPy/MWr8w9WRu998SBbLB5XTn+W7Vri9Neaoc3RBjevLI0+mte
         nmsdyY/tkrCu6Mf8a2lW4qX0xjwKSLg6IM7PwEi8/Yc0aF65m1kli8LxiDJCIDc6sRRu
         tX0aOozSjW4fRZyFoF0ko2LCDZ6qKvAMjEo+9eDuT+DYQp86YGNz4rHMVC5pvW0Kq/xL
         8kKQ==
X-Gm-Message-State: AOJu0YwozwH1uC2rXlJD2iOcfFUdAtaMc9HDZ3MLCbNYniL4BVESnYiT
        LbxyRVZI55xgFofh71CUpMN8aQ==
X-Google-Smtp-Source: AGHT+IFhbKsrLcKnFuicZOuiJBoQGo+a4wPHjLFimyP3XIPppsptAboML0WRwQZ8AGOCizTCF1f9dQ==
X-Received: by 2002:a05:6214:1192:b0:64f:60e9:9285 with SMTP id t18-20020a056214119200b0064f60e99285mr12393879qvv.30.1695134889866;
        Tue, 19 Sep 2023 07:48:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id w25-20020a0cb559000000b0064f72988fecsm4437544qvd.127.2023.09.19.07.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 07:47:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qic01-000ExN-0m;
        Tue, 19 Sep 2023 11:46:49 -0300
Date:   Tue, 19 Sep 2023 11:46:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230919144649.GT13795@ziepe.ca>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
 <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
 <20230919081519.GA3860249@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919081519.GA3860249@myrica>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 09:15:19AM +0100, Jean-Philippe Brucker wrote:
> On Mon, Sep 18, 2023 at 05:37:47PM +0100, Robin Murphy wrote:
> > > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > > index 17dcd826f5c2..3649586f0e5c 100644
> > > --- a/drivers/iommu/virtio-iommu.c
> > > +++ b/drivers/iommu/virtio-iommu.c
> > > @@ -189,6 +189,12 @@ static int viommu_sync_req(struct viommu_dev *viommu)
> > >   	int ret;
> > >   	unsigned long flags;
> > > +	/*
> > > +	 * .iotlb_sync_map and .flush_iotlb_all may be called before the viommu
> > > +	 * is initialized e.g. via iommu_create_device_direct_mappings()
> > > +	 */
> > > +	if (!viommu)
> > > +		return 0;
> > 
> > Minor nit: I'd be inclined to make that check explicitly in the places where
> > it definitely is expected, rather than allowing *any* sync to silently do
> > nothing if called incorrectly. Plus then they could use
> > vdomain->nr_endpoints for consistency with the equivalent checks elsewhere
> > (it did take me a moment to figure out how we could get to .iotlb_sync_map
> > with a NULL viommu without viommu_map_pages() blowing up first...)

This makes more sense to me

Ultimately this driver should reach a point where every iommu_domain
always has a non-null domain->viommu because it will be set during
alloc.

But it can still have nr_endpoints == 0, doesn't it make sense to
avoid sync in this case?

(btw this driver is missing locking around vdomain->nr_endpoints)

> They're not strictly equivalent: this check works around a temporary issue
> with the IOMMU core, which calls map/unmap before the domain is
> finalized.

Where? The above points to iommu_create_device_direct_mappings() but
it doesn't because the pgsize_bitmap == 0:

static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
					       struct device *dev)
{
	struct iommu_resv_region *entry;
	struct list_head mappings;
	unsigned long pg_size;
	int ret = 0;

	pg_size = domain->pgsize_bitmap ? 1UL << __ffs(domain->pgsize_bitmap) : 0;
	INIT_LIST_HEAD(&mappings);

	if (WARN_ON_ONCE(iommu_is_dma_domain(domain) && !pg_size))

Indeed, the driver should be failing all map's until the domain is
finalized because it has no way to check the IOVA matches the eventual
aperture.

Jason

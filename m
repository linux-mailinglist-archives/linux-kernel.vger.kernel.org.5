Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E87576CCCA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbjHBMgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjHBMgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:36:14 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA93C2718
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:36:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fc0aecf15bso72577015e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 05:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690979769; x=1691584569;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rbAmOgGSom58heLKXqHoWywWj2p9wFTgUgZtDf1f4Ko=;
        b=Bc8QNXVNv4JzI1+uusNzxTMl3TytgywxVKLrLEaa1iu4O7oCM4vDGhp5X3qW6X7IVN
         mYW4jDimo6gQ+kie3eoGk7g7sM4Bm4YX+B42PYqt1cbXHkyE14Bngpog1V17IVmIxxEf
         oV04Qw6myUaxtpFj3SOhyDxL7qRFO2TSBbD5H5eCYSZwotNBOy14tBWCpx26qttZqnCr
         k4qRyl8FAzq/Wau+KiMQo7B4e8VEtHfsd7KDX0praD6/ZEED29XiwtpHFIQ9U99XoWl6
         KIbfG4vswdxCZEPLAzRS3OGpd07e5TxJnsygPNuEtFhJ6Arv7OKhlyDEV0rHKoTsSP/4
         PVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690979769; x=1691584569;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rbAmOgGSom58heLKXqHoWywWj2p9wFTgUgZtDf1f4Ko=;
        b=bvUrdklm63J5+/lx5VQ6IwBld93FPTqwq2AOIKzym2VXP/l9Et35/62ezbXXfhUw6/
         /gPxf5sBN6qd+WcJrYrncKkrxe9H5pqh61bPmndQrCS6nAZH6u3GC+/lAsWubDbFwiF0
         ZI13u6ODLJN0tfW/oUrBqBaY8SBhzn8kHHtRJs+WHQdensagFXgeNf86Z67nZPm88tEN
         fopys1Ef/nFGjwBT7QE6L0pOMl59FXGksaEryJ/FB/q7sC3e8iGYASbyJBoxLtPREEJA
         OueA14ypt1joKOZ+Ur5FAvMLvLb1fGQHbujHfXbbeP3S1l9ZW75Kyboje/OYNTEO8Q9k
         6SRA==
X-Gm-Message-State: ABy/qLZngNfftW5XTDPewT3axZaP+WVla828vVpQcHmuRBVaWZINnMHW
        rrqmflvLtOfp83SLZ/mABHG8Iw==
X-Google-Smtp-Source: APBJJlFTyPZKJlMKY8/+NLtZ2NNJbtwV+d2jE+eNJd0XDn3DC17j0INFbYXy24vZWX4L1greP7YFwA==
X-Received: by 2002:a05:600c:cb:b0:3fb:fef3:53f8 with SMTP id u11-20020a05600c00cb00b003fbfef353f8mr4781948wmm.25.1690979769201;
        Wed, 02 Aug 2023 05:36:09 -0700 (PDT)
Received: from myrica ([2.219.138.198])
        by smtp.gmail.com with ESMTPSA id n16-20020a1c7210000000b003fe1630a8f0sm1578090wmc.24.2023.08.02.05.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 05:36:08 -0700 (PDT)
Date:   Wed, 2 Aug 2023 13:36:12 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC] iommu/virtio: Use single flush queue (EXPERIMENTAL)
Message-ID: <20230802123612.GA6142@myrica>
References: <20230717-dma_iommu-v11-0-a7a0b83c355c@linux.ibm.com>
 <20230726111433.1105665-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230726111433.1105665-1-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

On Wed, Jul 26, 2023 at 01:14:33PM +0200, Niklas Schnelle wrote:
> Just like on paged s390 guests with their virtual IOMMU, syncing
> mappings via virtio-iommu is quite expensive. It can thus benefit from
> queueing unmapped IOVAs and flushing them in batches but less so from
> parallel flushes which is what the shadow_on_flush flag introduced for
> s390 tunes dma-iommu to do.
> 
> For this to work .flush_iotlb_all is implemented. Furthermore
> .iotlb_sync_map is also implemented and used to pull the sync out of the
> mapping operation for some additional batching and performance gain.
> 
> In a basic test with NVMe pass-through to a KVM guest on a Ryzen 3900X
> these changes together lead to about 19% more IOPS in a fio test and
> slightly more bandwidth too.

Nice, thank you for testing this. I played with a NVMe on an Intel desktop
and can confirm similar results. With "sq" meaning single flush queue and
"mq" percpu flush queue, "+map" is with .iotlb_sync_map() enabled.

Multithread block randwrite job [1]:

                         BW compared to host    Confidence
                          (higher better)
              host           100.0%               ±0.0%
          noviommu            99.9                 0.0
    viommu lazy sq +map       99.9                 0.1
    viommu lazy mq +map       99.9                 0.1
    viommu lazy sq            92.2                 0.9
    viommu lazy mq            91.5                 0.9
     viommu strict +map       92.7                 0.9
     viommu strict            81.3                 1.0


Single page randrw:

                        Latency compared to host    Confidence
                           (lower better)
              host            x1.00                   ±.04
          noviommu             1.23                    .04
    viommu lazy sq +map        7.09                    .05
    viommu lazy mq +map        7.07                    .07
    viommu lazy sq             7.15                    .04
    viommu lazy mq             7.11                    .05
     viommu strict +map        8.82                    .05
     viommu strict             8.82                    .04

So with lazy+map we get the maximum bandwidth reachable on this disk
(2.5GiB/s) even with a heavy iommu_map/unmap usage, which is cool.
Random access latency also improves with lazy mode.

The difference between single and percpu flush queue isn't really
measurable in my multithread test. There is a difference between Lazy sq
and mq but the variation between samples outweighs it.

> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> Note:
> The idea of using the single flush queue scheme from my series "iommu/dma: s390
> DMA API conversion and optimized IOTLB flushing"[0] for virtio-iommu was already
> mentioned in the cover letter. I now wanted to explore this with this patch
> which may also serve as a test vehicle for the single flush queue scheme usable
> on non-s390.
> 
> Besides limited testing, this is marked experimental mainly because the use of
> queuing needs to be a concious decision as it allows continued access to
> unmapped pages for up to a second with the currently proposed single flush
> queue mechanism.

It fits with the iommu.strict=0 / CONFIG_IOMMU_DEFAULT_DMA_LAZY setting,
which selects DMA_FQ domains. That option allows a misbehaving device to
access memory that has been freed/reallocated, which is what we're
enabling here. I believe the risk is pretty much the same for deferred
UNMAP as for deferred TLBI, since mappings that we're removing were likely
cached in the TLB. Increasing the timeout does make it easier to exploit,
but I don't think that changes the policy from an admin's perspective:
only enable lazy mode if you trust device and driver.

On bare metal, we disable DMA_FQ for devices that can be easily hotplugged
into unattended machines (through external-facing ports like thunderbolt).
On VMs, the concern isn't really about external devices, since they don't
automatically get plugged into a VM without user intervention. Here I
guess the devices we don't trust will be virtual devices implemented by
other VMs. We don't have any method to identify them yet, so
iommu.strict=1 and CONFIG_IOMMU_DEFAULT_DMA_STRICT is the best we can do
at the moment.

I'm not so sure about enabling shadow_on_flush by default, since the
performance difference was too small in my tests. Maybe a module parameter
for dma-iommu could configure the flush queue?

> Also it might make sense to split this patch to do the
> introduction and use of .iotlb_sync_map separately but as a test vehicle
> I found it easier to consume as a single patch.

Yes, both changes are useful but should be in two patches

Thanks,
Jean

[1] (Running one fio process for each of the two tests, sequentially, 30
    or more times, with 1 warmup.)

    [global]
    filename=/dev/nvme0n1
    runtime=10
    ioengine=libaio
    direct=1
    time_based

    [randwrite_multi]
    group_reporting
    rw=randwrite
    numjobs=16
    iodepth=16
    bs=64k
    size=1G

    [randrw_page]
    rw=randrw
    rwmixread=50
    rwmixwrite=50
    iodepth=128
    bs=4k
    size=1G


> 
> [0]: https://lore.kernel.org/linux-iommu/20230717-dma_iommu-v11-0-a7a0b83c355c@linux.ibm.com/
> 
>  drivers/iommu/virtio-iommu.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 3551ed057774..f29eb4ce2b88 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -843,7 +843,7 @@ static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
>  			.flags		= cpu_to_le32(flags),
>  		};
>  
> -		ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
> +		ret = viommu_add_req(vdomain->viommu, &map, sizeof(map));
>  		if (ret) {
>  			viommu_del_mappings(vdomain, iova, end);
>  			return ret;
> @@ -909,6 +909,27 @@ static void viommu_iotlb_sync(struct iommu_domain *domain,
>  {
>  	struct viommu_domain *vdomain = to_viommu_domain(domain);
>  
> +	if (!vdomain->nr_endpoints)
> +		return;
> +	viommu_sync_req(vdomain->viommu);
> +}
> +
> +static int viommu_iotlb_sync_map(struct iommu_domain *domain,
> +				 unsigned long iova, size_t size)
> +{
> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +
> +	if (!vdomain->nr_endpoints)
> +		return 0;
> +	return viommu_sync_req(vdomain->viommu);
> +}
> +
> +static void viommu_flush_iotlb_all(struct iommu_domain *domain)
> +{
> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +
> +	if (!vdomain->nr_endpoints)
> +		return;
>  	viommu_sync_req(vdomain->viommu);
>  }
>  
> @@ -991,6 +1012,7 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
>  		if (ret)
>  			goto err_free_dev;
>  	}
> +	dev->iommu->shadow_on_flush = 1;
>  
>  	return &viommu->iommu;
>  
> @@ -1037,6 +1059,8 @@ static bool viommu_capable(struct device *dev, enum iommu_cap cap)
>  	switch (cap) {
>  	case IOMMU_CAP_CACHE_COHERENCY:
>  		return true;
> +	case IOMMU_CAP_DEFERRED_FLUSH:
> +		return true;
>  	default:
>  		return false;
>  	}
> @@ -1057,7 +1081,9 @@ static struct iommu_ops viommu_ops = {
>  		.map_pages		= viommu_map_pages,
>  		.unmap_pages		= viommu_unmap_pages,
>  		.iova_to_phys		= viommu_iova_to_phys,
> +		.flush_iotlb_all	= viommu_flush_iotlb_all,
>  		.iotlb_sync		= viommu_iotlb_sync,
> +		.iotlb_sync_map		= viommu_iotlb_sync_map,
>  		.free			= viommu_domain_free,
>  	}
>  };
> 
> base-commit: 5514392fe77cd45b0d33bf239f13ba594a6759e5
> -- 
> 2.39.2
> 
> 

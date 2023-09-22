Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D217AAAD1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjIVHwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjIVHwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:52:33 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78F7CA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:52:26 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-405361bb94eso15052155e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695369145; x=1695973945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hcD2WxWIK5nogl0nPGxwYMClWdYAi/+TaekySrDVVbY=;
        b=Tp1NTSAnZQgaUzGpf1s7W6qFO+/fviGdoCsim3P/IS/8I5S6XpO/WiAbQLpiCvAYFQ
         25kMprY7jub53jAmuGXY/Tbv0O6tItjBsKk/hA/BQo50PekAZHYaF2ujbTxpcJ3I3KO5
         6ytyyB52kccH3Cg6QU7Wv604JGrIdH24ktRxvZ4GeP8yjKl/Y7euJQh1BlYwgnoxnLSt
         ULjsKphrN1H5Kx5UQmiG2PNfIFZSw8cLoIh+t3EBfXxMhdGPKWHoO8I/Uq0F6H7NN+2T
         vlLp6r0WcUxb/6feUmYobdtZVzLZmUvD/DgGH05a6Yl+MXeQfpTXll0rzK7sXufQfIjt
         wQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695369145; x=1695973945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcD2WxWIK5nogl0nPGxwYMClWdYAi/+TaekySrDVVbY=;
        b=QQ+b6Vd/c8nV2I/8ErQSGg7f4kUTIHkk83MqKC2fwsPiUvDUoZegxA6cX6xCq7CLvt
         +1QMJhOe8Lj10a8pGGktwy1lbYcOU7aFgu0RrmHtqsx+Q9/r+Y73vISunqPa6+KssoHL
         fcATkaWGCZtDGoAV0JkhsE+gS+fDt3Se7Q7pjDD/Ow9RHwPOOf2Ce1afCRnRH50HaMOk
         DmTy4nrnPo/XA1GwG2JEhjMrt2YUu4jIcs2sCYuQuxr5Ju/xeIbjulTSgx4I130nsxTR
         Kp2ZJV/34r2QUdRrgVmALhTvo490XAozlm8vQaYxn5y924m7fCV3KEe9dTEZ+q8dusig
         mtAw==
X-Gm-Message-State: AOJu0YwedCd4SJYjpgd24qGBUKlQff4X0I2NHWMZ70uYMFIZzSKtSbgi
        R6o/BpXcUsG7pyK8N3xmgXAx3a6XhLXMFWipmdY=
X-Google-Smtp-Source: AGHT+IH50+JuT0hNWVHhO8l5lBOC4otqoUC+uD8KQFJh7d5H2c8inCy3MrjHonCe1JbAgZ2NZbenow==
X-Received: by 2002:a05:600c:c5:b0:3fe:2f31:8bf7 with SMTP id u5-20020a05600c00c500b003fe2f318bf7mr6796220wmm.26.1695369145016;
        Fri, 22 Sep 2023 00:52:25 -0700 (PDT)
Received: from myrica ([2a02:c7c:7290:b00:fd32:2b31:6755:400c])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d4642000000b00317e77106dbsm3731065wrs.48.2023.09.22.00.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 00:52:24 -0700 (PDT)
Date:   Fri, 22 Sep 2023 08:52:30 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230922075230.GA1361815@myrica>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
 <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
 <20230919081519.GA3860249@myrica>
 <1d513178-bab9-0522-87f5-1a058bb8121d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d513178-bab9-0522-87f5-1a058bb8121d@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 09:28:08AM +0100, Robin Murphy wrote:
> On 2023-09-19 09:15, Jean-Philippe Brucker wrote:
> > On Mon, Sep 18, 2023 at 05:37:47PM +0100, Robin Murphy wrote:
> > > > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > > > index 17dcd826f5c2..3649586f0e5c 100644
> > > > --- a/drivers/iommu/virtio-iommu.c
> > > > +++ b/drivers/iommu/virtio-iommu.c
> > > > @@ -189,6 +189,12 @@ static int viommu_sync_req(struct viommu_dev *viommu)
> > > >    	int ret;
> > > >    	unsigned long flags;
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
> > 
> > They're not strictly equivalent: this check works around a temporary issue
> > with the IOMMU core, which calls map/unmap before the domain is finalized.
> > Once we merge domain_alloc() and finalize(), then this check disappears,
> > but we still need to test nr_endpoints in map/unmap to handle detached
> > domains (and we still need to fix the synchronization of nr_endpoints
> > against attach/detach). That's why I preferred doing this on viommu and
> > keeping it in one place.
> 
> Fair enough - it just seems to me that in both cases it's a detached domain,
> so its previous history of whether it's ever been otherwise or not shouldn't
> matter. Even once viommu is initialised, does it really make sense to send
> sync commands for a mapping on a detached domain where we haven't actually
> sent any map/unmap commands?

If no requests were added by map/unmap, then viommu_sync_req() is
essentially a nop because virtio doesn't use sync commands (and
virtqueue_kick() only kicks the host when the queue's not empty, if I
remember correctly). It still does a bit of work so is less efficient than
a preliminary check on nr_endpoints, but it feels nicer to streamline the
case where the domain is attached, since map/unmap on detached domains
happens rarely, if ever.

Either is fine by me. An extra test won't make much difference performance
wise, and I guess will look less confusing. Niklas, do you mind resending
the version with nr_endpoints check (and updated commit messages)?

Thanks,
Jean

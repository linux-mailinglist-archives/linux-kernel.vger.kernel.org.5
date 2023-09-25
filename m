Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3537AD82F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjIYMlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIYMlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:41:01 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565EAC0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:40:54 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-59be6bcf408so74176257b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695645653; x=1696250453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E4kzsEhG+gR50UuYrr0hWNyVHM1Qwmcb10rU8QBkH+4=;
        b=Jvp4XWB+p4cfkDFhOjPcUQzDWG2LHHAH9g1icWKnBov/hpfLvCVz5BEYOj4AsOyjIV
         86XMalJSdMRDUfkd1ZeEcncCkmgeWWtRsVJ4c2hkTtinY12iHmwkXZVJQ5OBrCaSTuxB
         bqQpdl5y9s/v84iX+Y3zcbZR1s9XkwIU0QBz8GGFEue41FQWh14YanMX/+v47G348/qM
         wieBhH+hvHmTKGYOAyZyjErO/XxNt/6nKbKT0E6FNntavyCpbX+VpaislHoVqdkSAoLB
         1Og2W0cG6idLFpDuzmaftDERAI4XWi1CU1HG8Rgru/Qq1ogHRNZp42+4sZq+ZXaC91sP
         vsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695645653; x=1696250453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4kzsEhG+gR50UuYrr0hWNyVHM1Qwmcb10rU8QBkH+4=;
        b=DeHs++LodHU634TwuUgMRdNqpXjj+eMp8a8lJus8d18bgoYKc0vIKAIiLo3/DpKjUZ
         4g1yoFpLGw1u4RuuRj3HgYPburwLj/7HYAdN4E3FIjMNl92AnOt7aRHpyAK4mSNCRxvH
         CaSl/pYM7zyCrMhfQiwJ6ofQroYF2OgP5JUi4HdZG0jkaiCg2fztzJ6vuRvntDxwcWEI
         SwhQcdPHaxF71yaEkbPFxZJ1o8rpsgvJY2BDIs6VgxNTW4SjlMA6Pnl4B9xRWznm6NaS
         pB40xvtmK/hXj2BxuKwr9TJJMYLkwsJgRlRaDugx2qK3eUwXQoGhFuLL5+3IYqLfHGsc
         U4og==
X-Gm-Message-State: AOJu0Yz3dzTt2gXAVenZmz5fcEvdHqxPhLHM305+YCq+FFB2JDE7hEag
        1xJx1WsQeeketT5+mSH8n41k6g==
X-Google-Smtp-Source: AGHT+IH3Y+9j9raszOHHXw26GDW4jOHx9++pXJi8a0moyryr53oJi6UZzICnhW5K7XiQ5mDWOsyiGA==
X-Received: by 2002:a25:496:0:b0:d80:9ed:5038 with SMTP id 144-20020a250496000000b00d8009ed5038mr5820473ybe.21.1695645653492;
        Mon, 25 Sep 2023 05:40:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id m8-20020a0cf188000000b0065898a8977dsm1891356qvl.71.2023.09.25.05.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 05:40:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qkktQ-000qtP-5V;
        Mon, 25 Sep 2023 09:40:52 -0300
Date:   Mon, 25 Sep 2023 09:40:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230925124052.GJ13795@ziepe.ca>
References: <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
 <20230919081519.GA3860249@myrica>
 <20230919144649.GT13795@ziepe.ca>
 <20230922075719.GB1361815@myrica>
 <20230922124130.GD13795@ziepe.ca>
 <900b644e-6e21-1038-2252-3dc86cbf0a32@arm.com>
 <20230922162714.GH13795@ziepe.ca>
 <123c53c3-d259-9c20-9aa6-0c216d7eb3c0@arm.com>
 <20230922233309.GI13795@ziepe.ca>
 <42860c87-cf4d-0413-c3ae-b74ee9e7e5e6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42860c87-cf4d-0413-c3ae-b74ee9e7e5e6@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 10:48:21AM +0800, Baolu Lu wrote:
> On 9/23/23 7:33 AM, Jason Gunthorpe wrote:
> > On Fri, Sep 22, 2023 at 07:07:40PM +0100, Robin Murphy wrote:
> > 
> > > virtio isn't setting ops->pgsize_bitmap for the sake of direct mappings
> > > either; it sets it once it's discovered any instance, since apparently it's
> > > assuming that all instances must support identical page sizes, and thus once
> > > it's seen one it can work "normally" per the core code's assumptions. It's
> > > also I think the only driver which has a "finalise" bodge but*can*  still
> > > properly support map-before-attach, by virtue of having to replay mappings
> > > to every new endpoint anyway.
> > Well it can't quite do that since it doesn't know the geometry - it
> > all is sort of guessing and hoping it doesn't explode on replay. If it
> > knows the geometry it wouldn't need finalize...
> 
> The ultimate solution to this problem seems to be to add device pointer
> to the parameter of ops->domain_alloc. So once the domain is allocated,
> it is fully initialized. Attaching this domain to a device that is not
> compatible will return -EINVAL, then the caller has to allocate a new
> domain for this device.

Sure, it looks like this, and it works already for default domain
setup.

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 8599394c9157d7..1697f5a2370785 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -637,15 +637,10 @@ static void viommu_event_handler(struct virtqueue *vq)
 
 /* IOMMU API */
 
-static struct iommu_domain *viommu_domain_alloc(unsigned type)
+static struct viommu_domain *__viommu_domain_alloc(void)
 {
 	struct viommu_domain *vdomain;
 
-	if (type != IOMMU_DOMAIN_UNMANAGED &&
-	    type != IOMMU_DOMAIN_DMA &&
-	    type != IOMMU_DOMAIN_IDENTITY)
-		return NULL;
-
 	vdomain = kzalloc(sizeof(*vdomain), GFP_KERNEL);
 	if (!vdomain)
 		return NULL;
@@ -654,16 +649,32 @@ static struct iommu_domain *viommu_domain_alloc(unsigned type)
 	spin_lock_init(&vdomain->mappings_lock);
 	vdomain->mappings = RB_ROOT_CACHED;
 
+	return vdomain;
+}
+
+static struct iommu_domain *viommu_domain_alloc(unsigned type)
+{
+	struct viommu_domain *vdomain;
+
+	/*
+	 * viommu sometimes creates an identity domain out of a
+	 * paging domain, that can't use the global static.
+	 * During attach it will fill in an identity page table.
+	 */
+	if (type != IOMMU_DOMAIN_IDENTITY)
+		return NULL;
+	vdomain = __viommu_domain_alloc();
+	if (!vdomain)
+		return NULL;
 	return &vdomain->domain;
 }
 
 static int viommu_domain_finalise(struct viommu_endpoint *vdev,
-				  struct iommu_domain *domain)
+				  struct viommu_domain *vdomain)
 {
 	int ret;
 	unsigned long viommu_page_size;
 	struct viommu_dev *viommu = vdev->viommu;
-	struct viommu_domain *vdomain = to_viommu_domain(domain);
 
 	viommu_page_size = 1UL << __ffs(viommu->pgsize_bitmap);
 	if (viommu_page_size > PAGE_SIZE) {
@@ -680,13 +691,13 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
 
 	vdomain->id		= (unsigned int)ret;
 
-	domain->pgsize_bitmap	= viommu->pgsize_bitmap;
-	domain->geometry	= viommu->geometry;
+	vdomain->domain.pgsize_bitmap = viommu->pgsize_bitmap;
+	vdomain->domain.geometry = viommu->geometry;
 
 	vdomain->map_flags	= viommu->map_flags;
 	vdomain->viommu		= viommu;
 
-	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
+	if (vdomain->domain.type == IOMMU_DOMAIN_IDENTITY) {
 		if (virtio_has_feature(viommu->vdev,
 				       VIRTIO_IOMMU_F_BYPASS_CONFIG)) {
 			vdomain->bypass = true;
@@ -717,6 +728,24 @@ static void viommu_domain_free(struct iommu_domain *domain)
 	kfree(vdomain);
 }
 
+static struct iommu_domain *viommu_domain_alloc_paging(struct device *dev)
+{
+	struct viommu_domain *vdomain;
+	vdomain = __viommu_domain_alloc();
+	if (!vdomain)
+		return NULL;
+
+	if (dev) {
+		struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
+
+		if (viommu_domain_finalise(vdev, vdomain)) {
+			viommu_domain_free(&vdomain->domain);
+			return NULL;
+		}
+	}
+	return &vdomain->domain;
+}
+
 static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int i;
@@ -732,7 +761,7 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		 * Properly initialize the domain now that we know which viommu
 		 * owns it.
 		 */
-		ret = viommu_domain_finalise(vdev, domain);
+		ret = viommu_domain_finalise(vdev, vdomain);
 	} else if (vdomain->viommu != vdev->viommu) {
 		ret = -EINVAL;
 	}
@@ -1045,6 +1074,7 @@ static bool viommu_capable(struct device *dev, enum iommu_cap cap)
 static struct iommu_ops viommu_ops = {
 	.capable		= viommu_capable,
 	.domain_alloc		= viommu_domain_alloc,
+	.domain_alloc_paging	= viommu_domain_alloc_paging,
 	.probe_device		= viommu_probe_device,
 	.probe_finalize		= viommu_probe_finalize,
 	.release_device		= viommu_release_device,

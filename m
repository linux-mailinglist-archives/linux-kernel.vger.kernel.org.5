Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240907FC179
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344331AbjK1Qdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjK1Qdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:33:38 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C45BAB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:33:44 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1fa619735c1so1129183fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701189224; x=1701794024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HN35qZ+uGTBAFYCaQRWTgLrt9+VoejNBpfU4/ki1w6g=;
        b=fXpPCgSSVXWkXBa/5/iQ1mlMAp/yPiPDgnKIGsX373O3zrFFOx3AATG2oTavjcA5wZ
         N/8GuB5hQdXtoqcHtK2jWl5kVpyghuD4FoK+z8X6o6glSkgqpWf31hxbc8TLxfLzt9Lg
         CExsjpnldbntu+Q9hSh2bqv4wITgRc5BX5F8+yGsU55Bji36esuOllw6KLdPOTYrj63H
         FDYBN4o616+H6pr/so0HaDoqg5eWMuWkxTSchnaQ3+TMLZuixiDay40aIeTOkacglr6h
         h0teNjgFjvGsbejEmR/ztCm2Z/pPmBLaGbFYM7q9AZNDF1Kq/23hJl6KWtk+fZmziBNY
         OJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701189224; x=1701794024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HN35qZ+uGTBAFYCaQRWTgLrt9+VoejNBpfU4/ki1w6g=;
        b=gnCzqvZloIF7wBZLBb3lXZmSMwkgFiVQ9i1GHdHvPANvl4RibjM2zH7oOZ/2UF4lVU
         WXK8hQNa83ywEHakwbTka/xj9wNt8yz5EaVs/KTAia2XtthXUi2EZemV/7A8pDe8o3Wr
         dRJdXlzT6BBuCsOOEGxyN7IU5jtrM9HysphXlDarFXIqVSUi/+/kJwPFpbisRNBbPq10
         JGP1zlF8w10pVBbIGpp0J/xqIgufEDmTRSPMKeRTohobR/SvDVAuOqOavwAE1G1XOkZW
         N5mf8L/oIJUQvtZjYSp4OZfYHXgAb40y4FF7DLqFcxeXtmmyfXqid7pCLkUS3hgIAjBW
         zCKQ==
X-Gm-Message-State: AOJu0YxzUbIrvRWnq+BgnRRhotkBdXepYCKBXMxlXT2DGHD+oAIz2JQX
        3Bvd7hYXioFXfiGCPfzSVsmn/A==
X-Google-Smtp-Source: AGHT+IFTCfs4volRi4dOFIcsdSDNqlvXP8PkQi+sW0alsSi8XNp6WNUtD/IJadmfz7As4aT8DcCV/w==
X-Received: by 2002:a05:6871:328b:b0:1eb:e8b:7206 with SMTP id mp11-20020a056871328b00b001eb0e8b7206mr24273641oac.14.1701189223401;
        Tue, 28 Nov 2023 08:33:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id ml13-20020a056871724d00b001fa4f5ffd90sm1123887oac.26.2023.11.28.08.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 08:33:42 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r811q-005VHk-1K;
        Tue, 28 Nov 2023 12:33:42 -0400
Date:   Tue, 28 Nov 2023 12:33:42 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, kevin.tian@intel.com, will@kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommufd/selftest: Use a fwnode to distinguish devices
Message-ID: <20231128163342.GI432016@ziepe.ca>
References: <cover.1701165201.git.robin.murphy@arm.com>
 <e365c08b21a8d0b60e6f5d1411be6701c1a06a53.1701165201.git.robin.murphy@arm.com>
 <20231128144331.GA1191405@ziepe.ca>
 <69db9205-cb9a-425a-a48e-6d68d1f900f1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69db9205-cb9a-425a-a48e-6d68d1f900f1@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 04:02:42PM +0000, Robin Murphy wrote:
> On 28/11/2023 2:43 pm, Jason Gunthorpe wrote:
> > On Tue, Nov 28, 2023 at 10:42:11AM +0000, Robin Murphy wrote:
> > > With bus ops gone, the trick of registering against a specific bus no
> > > longer really works, and we start getting given devices from other buses
> > > to probe,
> > 
> > Make sense
> > 
> > > which leads to spurious groups for devices with no IOMMU on
> > > arm64,
> > 
> > I'm not sure I'm fully understanding what this means?
> 
> It means on my arm64 ACPI system, random platform devices which are created
> after iommufd_test_init() has run get successfully probed by the mock
> driver, unexpectedly:

Okay that is what I guessed

> > I guess that the mock driver is matching random things once it starts
> > being called all the time because this is missing:
> > 
> >   static struct iommu_device *mock_probe_device(struct device *dev)
> >   {
> > +       if (dev->bus != &iommufd_mock_bus_type)
> > +               return -ENODEV;
> >          return &mock_iommu_device;
> >   }
> > 
> > Is that sufficient to solve the problem?
> 
> Unfortunately not...

I see, so we create the other problem that without bus ops we don't
get to have two 'global' drivers and with the above mock won't probe
on x86.

> I did intend coexistence to work on x86 too, where the "other" driver would
> be virtio-iommu using fwnodes, so aligning the mock driver that way seemed
> far neater than any more special-case hacks in core code.

Lets just do the above and what I suggested earlier. This is from a
WIP tree I have, it shows the idea but needs other stuff to work. If
you agree I'll pull its parts out and post a clean version of them.

commit 51c9a54cc111b4b31af6a0527015db82e782e1d3
Author: Jason Gunthorpe <jgg@ziepe.ca>
Date:   Tue Nov 28 11:54:47 2023 -0400

    iommu: Call all drivers if there is no fwspec
    
    Real systems only have one ops, so this effectively invokes the single op
    in the system to probe each device. If there are multiple ops we invoke
    each one once, and drivers that don't understand the struct device should
    return -ENODEV.
    
    Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7468a64778931b..54e3f14429b3b4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -241,6 +241,26 @@ static int remove_iommu_group(struct device *dev, void *data)
 	return 0;
 }
 
+static void iommu_device_add(struct iommu_device *iommu)
+{
+	struct iommu_device *cur;
+
+	/*
+	 * Keep the iommu_device_list grouped by ops so that
+	 * iommu_find_init_device() works efficiently.
+	 */
+	mutex_lock(&iommu_probe_device_lock);
+	list_for_each_entry(cur, &iommu_device_list, list) {
+		if (cur->ops == iommu->ops) {
+			list_add(&iommu->list, &cur->list);
+			goto out;
+		}
+	}
+	list_add(&iommu->list, &iommu_device_list);
+out:
+	mutex_unlock(&iommu_probe_device_lock);
+}
+
 /**
  * iommu_device_register() - Register an IOMMU hardware instance
  * @iommu: IOMMU handle for the instance
@@ -262,9 +282,7 @@ int iommu_device_register(struct iommu_device *iommu,
 	if (hwdev)
 		iommu->fwnode = dev_fwnode(hwdev);
 
-	mutex_lock(&iommu_probe_device_lock);
-	list_add_tail(&iommu->list, &iommu_device_list);
-	mutex_unlock(&iommu_probe_device_lock);
+	iommu_device_add(iommu);
 
 	for (int i = 0; i < ARRAY_SIZE(iommu_buses) && !err; i++)
 		err = bus_iommu_probe(iommu_buses[i]);
@@ -502,6 +520,29 @@ static void iommu_deinit_device(struct device *dev)
 
 DEFINE_MUTEX(iommu_probe_device_lock);
 
+static int iommu_find_init_device(struct iommu_probe_info *pinf)
+{
+	const struct iommu_ops *ops = NULL;
+	struct iommu_device *iommu;
+	int ret;
+
+	lockdep_assert_held(&iommu_probe_device_lock);
+
+	/*
+	 * Each unique ops gets a chance to claim the device, -ENODEV means the
+	 * driver does not support the device.
+	 */
+	list_for_each_entry(iommu, &iommu_device_list, list) {
+		if (iommu->ops != ops) {
+			ops = iommu->ops;
+			ret = iommu_init_device(pinf, iommu->ops);
+			if (ret != -ENODEV)
+				return ret;
+		}
+	}
+	return -ENODEV;
+}
+
 static int __iommu_probe_device(struct iommu_probe_info *pinf)
 {
 	struct device *dev = pinf->dev;
@@ -524,13 +565,6 @@ static int __iommu_probe_device(struct iommu_probe_info *pinf)
 		ops = fwspec->ops;
 		if (!ops)
 			return -ENODEV;
-	} else {
-		struct iommu_device *iommu;
-
-		iommu = iommu_device_from_fwnode(NULL);
-		if (!iommu)
-			return -ENODEV;
-		ops = iommu->ops;
 	}
 
 	/*
@@ -546,7 +580,10 @@ static int __iommu_probe_device(struct iommu_probe_info *pinf)
 	if (dev->iommu_group)
 		return 0;
 
-	ret = iommu_init_device(pinf, ops);
+	if (ops)
+		ret = iommu_init_device(pinf, ops);
+	else
+		ret = iommu_find_init_device(pinf);
 	if (ret)
 		return ret;
 

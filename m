Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CCD7527C9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbjGMPzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjGMPzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:55:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C402686
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689263710; x=1720799710;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HzDe1rmkDf9NDLJwnlBTzYnFxwjCcY33RbbgJLyqs1c=;
  b=ZT5Rcx9bzgM2HbpvI4s3iTZAbMj55EedINvDaWCVqslHMGcNut+WxFwn
   Cd/vAUDwcS1B872DAI5OJMXw2RpH89PdS7OGPOge+u4ajNYU1hbKir6Yk
   RyIMn0LXrnBnm/jij6Yrsnjxvahe2ANErTkoHflHnSxH3KMbjLF8C/Bj0
   rhgrjuq/qzYJ4wyJI3xZYrSCDyZynDVY38xwdVBaHOj604EIuBWMuUR0W
   rXgGgDj7xdFwkyL7BZnWZ9s441lSyyUjssQqikiGTfiRxY22qd/+Z+2yd
   AEiHYvR64N1BrCNGOiXg+AAmAimaI6z8uOuHL1JGNV0jLhJWH2mEhzpCA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="428995541"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="428995541"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 08:55:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="672311580"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="672311580"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 08:55:09 -0700
Date:   Thu, 13 Jul 2023 09:00:07 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Will Deacon <will@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v10 2/7] iommu: Move global PASID allocation from SVA to
 core
Message-ID: <20230713090007.40ef2ac3@jacob-builder>
In-Reply-To: <BN9PR11MB527619C7106BE91167B9EC118C37A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230712163355.3177511-1-jacob.jun.pan@linux.intel.com>
        <20230712163355.3177511-3-jacob.jun.pan@linux.intel.com>
        <BN9PR11MB527619C7106BE91167B9EC118C37A@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Thu, 13 Jul 2023 07:42:01 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Thursday, July 13, 2023 12:34 AM
> > 
> >  }
> > +
> > +ioasid_t iommu_alloc_global_pasid_dev(struct device *dev)
> > +{
> > +	int ret;
> > +
> > +	/* max_pasids == 0 means that the device does not support
> > PASID */
> > +	if (!dev->iommu->max_pasids)
> > +		return IOMMU_PASID_INVALID;
> > +
> > +	/*
> > +	 * max_pasids is set up by vendor driver based on number of
> > PASID bits
> > +	 * supported but the IDA allocation is inclusive.
> > +	 */
> > +	ret = ida_alloc_range(&iommu_global_pasid_ida,
> > IOMMU_FIRST_GLOBAL_PASID,
> > +			      dev->iommu->max_pasids - 1, GFP_KERNEL);
> > +	return ret < 0 ? IOMMU_PASID_INVALID : ret;
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_alloc_global_pasid_dev);  
> 
> nit. Just call it iommu_alloc_global_pasid.

will do. it will be symmetric.

Thanks,

Jacob

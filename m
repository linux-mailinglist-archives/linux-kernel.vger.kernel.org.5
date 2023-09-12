Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF5279D6B6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbjILQtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236062AbjILQtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:49:12 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848C6110;
        Tue, 12 Sep 2023 09:49:08 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RlV034NmJz67g1D;
        Wed, 13 Sep 2023 00:48:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 12 Sep
 2023 17:49:05 +0100
Date:   Tue, 12 Sep 2023 17:49:04 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 14/18] dax/region: Support DAX device creation on
 dynamic DAX regions
Message-ID: <20230912174904.00005fed@Huawei.com>
In-Reply-To: <64f80177c2c21_1e8e7829487@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
        <20230604-dcd-type2-upstream-v2-14-f740c47e7916@intel.com>
        <20230830125025.00000fea@Huawei.com>
        <64f80177c2c21_1e8e7829487@iweiny-mobl.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Sep 2023 21:35:03 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Mon, 28 Aug 2023 22:21:05 -0700
> > Ira Weiny <ira.weiny@intel.com> wrote:
> >   
> > > Dynamic Capacity (DC) DAX regions have a list of extents which define
> > > the memory of the region which is available.
> > > 
> > > Now that DAX region extents are fully realized support DAX device
> > > creation on dynamic regions by adjusting the allocation algorithms
> > > to account for the extents.  Remember also references must be held on
> > > the extents until the DAX devices are done with the memory.
> > > 
> > > Redefine the region available size to include only extent space.  Reuse
> > > the size allocation algorithm by defining sub-resources for each extent
> > > and limiting range allocation to those extents which have space.  Do not
> > > support direct mapping of DAX devices on dynamic devices.
> > > 
> > > Enhance DAX device range objects to hold references on the extents until
> > > the DAX device is destroyed.
> > > 
> > > NOTE: At this time all extents within a region are created equally.
> > > However, labels are associated with extents which can be used with
> > > future DAX device labels to group which extents are used.  
> > 
> > This sound like a bad place to start to me as we are enabling something
> > that is probably 'wrong' in the long term as opposed to just not enabling it
> > until we have appropriate support.  
> 
> I disagree.  I don't think the kernel should be trying to process tags at
> the lower level.
> 
> > I'd argue better to just reject any extents with different labels for now.  
> 
> Again I disagree.  This is less restrictive.  The idea is that labels can
> be changed such that user space can ultimately decided which extents
> should be used for which devices.  I have some work on that already.
> (Basically it becomes quite easy to assign a label to a dax device and
> have the extent search use only dax extents which match that label.)

That sounds good - but if someone expects that and uses it with an old
kernel I'm not sure if it is better to say 'we don't support it yet' or
do something different from a newer kernel.


> > > @@ -1400,8 +1507,10 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
> > >  	device_initialize(dev);
> > >  	dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
> > >  
> > > +	dev_WARN_ONCE(parent, is_dynamic(dax_region) && data->size,
> > > +		      "Dynamic DAX devices are created initially with 0 size");  
> > 
> > dev_info() maybe more appropriate?  
> 
> Unless I'm mistaken this can happen from userspace but only if something
> in the code changes later.  Because the dax layer is trying to support
> non-dynamic regions (which dynamic may be a bad name), I was worried that
> the creation with a size might slip through...

Fair enough - if strong chance userspace will control it at somepoitn then
ONCE seems fine.

> 
> > Is this common enough that we need the
> > _ONCE?  
> 
> once is because it could end up spamming a log later if something got
> coded up wrong.

I'm not sure I care about bugs spamming the log.   Only things that
are userspace controlled or likely hardware failures etc.




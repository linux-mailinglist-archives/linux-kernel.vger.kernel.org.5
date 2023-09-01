Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CA678FA77
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348714AbjIAJI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbjIAJI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:08:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791CC91;
        Fri,  1 Sep 2023 02:08:24 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RcXGn3LsSz6HJpQ;
        Fri,  1 Sep 2023 17:07:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 1 Sep
 2023 10:08:21 +0100
Date:   Fri, 1 Sep 2023 10:08:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Robert Richter <rrichter@amd.com>
CC:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v9 02/15] cxl/regs: Prepare for multiple users of
 register mappings
Message-ID: <20230901100820.000027fb@Huawei.com>
In-Reply-To: <ZPCLCSngB95EGBMk@rric.localdomain>
References: <20230825233211.3029825-1-terry.bowman@amd.com>
        <20230825233211.3029825-3-terry.bowman@amd.com>
        <20230829145254.00003259@Huawei.com>
        <ZPCLCSngB95EGBMk@rric.localdomain>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 14:43:53 +0200
Robert Richter <rrichter@amd.com> wrote:

> On 29.08.23 14:52:54, Jonathan Cameron wrote:
> > On Fri, 25 Aug 2023 18:31:58 -0500
> > Terry Bowman <terry.bowman@amd.com> wrote:
> >   
> > > From: Robert Richter <rrichter@amd.com>
> > > 
> > > The function devm_cxl_iomap_block() is used to map register mappings
> > > of CXL component or device registers. A @dev is used to unmap the IO
> > > regions during device removal.
> > > 
> > > Now, there are multiple devices using the register mappings. E.g. the
> > > RAS cap of the Component Registers is used by cxl_pci, the HDM cap
> > > used in cxl_mem. This could cause IO blocks not being freed and a
> > > subsequent reinitialization to fail if the same device is used for
> > > both.
> > > 
> > > To prevent that, expand cxl_map_component_regs() to pass a @dev to be
> > > used with devm to IO unmap. This allows to pass the device that
> > > actually is creating and using the IO region.
> > > 
> > > For symmetry also change the function i/f of cxl_map_device_regs().
> > > 
> > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > Signed-off-by: Terry Bowman <terry.bowman@amd.com>  
> > 
> > I'm not sure we should leave map->dev around after this change
> > as it's not obvious where it is valid to use and where it isn't.
> > 
> > Perhaps we just need to pass the device into the few calls
> > that use it other than the ones you have here.  
> 
> I have checked that and it turned out we would need to pass @dev
> through multiple functions (see cxl_setup_regs()). So I left it in as
> devm is a special case (mis)using it.
> 
> > 
> > This patch itself looks fine to me.  
> 
> I will take it as a Reviewed-by:?
> 
No.  I'm not convinced on the map->dev question even though I appreciate
that passing it around is a mess. To me it's really non obvious that
in some cases map->dev is appropriate and in others a different dev
is needed.  Maybe some naming change would make it clear what each one is for?

Jonathan

> Thanks,
> 
> -Robert
> 
> > 
> > Jonathan
> >   
> > > ---
> > >  drivers/cxl/core/hdm.c  | 3 ++-
> > >  drivers/cxl/core/regs.c | 4 ++--
> > >  drivers/cxl/cxl.h       | 2 ++
> > >  drivers/cxl/pci.c       | 4 ++--
> > >  4 files changed, 8 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > > index 4449b34a80cc..17c8ba8c75e0 100644
> > > --- a/drivers/cxl/core/hdm.c
> > > +++ b/drivers/cxl/core/hdm.c
> > > @@ -98,7 +98,8 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
> > >  		return -ENODEV;
> > >  	}
> > >  
> > > -	return cxl_map_component_regs(&map, regs, BIT(CXL_CM_CAP_CAP_ID_HDM));
> > > +	return cxl_map_component_regs(&map, &port->dev, regs,
> > > +				      BIT(CXL_CM_CAP_CAP_ID_HDM));
> > >  }
> > >  
> > >  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> > > diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> > > index 6281127b3e9d..dfc3e272e7d8 100644
> > > --- a/drivers/cxl/core/regs.c
> > > +++ b/drivers/cxl/core/regs.c
> > > @@ -201,10 +201,10 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
> > >  }
> > >  
> > >  int cxl_map_component_regs(const struct cxl_register_map *map,
> > > +			   struct device *dev,
> > >  			   struct cxl_component_regs *regs,
> > >  			   unsigned long map_mask)
> > >  {
> > > -	struct device *dev = map->dev;
> > >  	struct mapinfo {
> > >  		const struct cxl_reg_map *rmap;
> > >  		void __iomem **addr;
> > > @@ -235,9 +235,9 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
> > >  EXPORT_SYMBOL_NS_GPL(cxl_map_component_regs, CXL);
> > >  
> > >  int cxl_map_device_regs(const struct cxl_register_map *map,
> > > +			struct device *dev,
> > >  			struct cxl_device_regs *regs)
> > >  {
> > > -	struct device *dev = map->dev;
> > >  	resource_size_t phys_addr = map->resource;
> > >  	struct mapinfo {
> > >  		const struct cxl_reg_map *rmap;
> > > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > > index 76d92561af29..ec8ba9ebcf64 100644
> > > --- a/drivers/cxl/cxl.h
> > > +++ b/drivers/cxl/cxl.h
> > > @@ -274,9 +274,11 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
> > >  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
> > >  			   struct cxl_device_reg_map *map);
> > >  int cxl_map_component_regs(const struct cxl_register_map *map,
> > > +			   struct device *dev,
> > >  			   struct cxl_component_regs *regs,
> > >  			   unsigned long map_mask);
> > >  int cxl_map_device_regs(const struct cxl_register_map *map,
> > > +			struct device *dev,
> > >  			struct cxl_device_regs *regs);
> > >  int cxl_map_pmu_regs(struct pci_dev *pdev, struct cxl_pmu_regs *regs,
> > >  		     struct cxl_register_map *map);
> > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > index 48f88d96029d..88ddcff8a0b2 100644
> > > --- a/drivers/cxl/pci.c
> > > +++ b/drivers/cxl/pci.c
> > > @@ -827,7 +827,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  	if (rc)
> > >  		return rc;
> > >  
> > > -	rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
> > > +	rc = cxl_map_device_regs(&map, cxlds->dev, &cxlds->regs.device_regs);
> > >  	if (rc)
> > >  		return rc;
> > >  
> > > @@ -844,7 +844,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  
> > >  	cxlds->component_reg_phys = map.resource;
> > >  
> > > -	rc = cxl_map_component_regs(&map, &cxlds->regs.component,
> > > +	rc = cxl_map_component_regs(&map, cxlds->dev, &cxlds->regs.component,
> > >  				    BIT(CXL_CM_CAP_CAP_ID_RAS));
> > >  	if (rc)
> > >  		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");  
> >   


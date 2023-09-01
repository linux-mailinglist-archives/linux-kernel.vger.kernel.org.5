Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF70F78FA76
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348713AbjIAJH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238270AbjIAJHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:07:24 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC3B10D2;
        Fri,  1 Sep 2023 02:07:17 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RcXF70gkKz6HJgB;
        Fri,  1 Sep 2023 17:05:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 1 Sep
 2023 10:06:54 +0100
Date:   Fri, 1 Sep 2023 10:06:54 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Robert Richter <rrichter@amd.com>
CC:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v9 01/15] cxl/port: Pre-initialize component register
 mappings
Message-ID: <20230901100654.00006799@Huawei.com>
In-Reply-To: <ZPCGCwakf3BeV7gp@rric.localdomain>
References: <20230825233211.3029825-1-terry.bowman@amd.com>
        <20230825233211.3029825-2-terry.bowman@amd.com>
        <20230829143851.00006467@Huawei.com>
        <ZPCGCwakf3BeV7gp@rric.localdomain>
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

On Thu, 31 Aug 2023 14:22:35 +0200
Robert Richter <rrichter@amd.com> wrote:

> On 29.08.23 14:38:51, Jonathan Cameron wrote:
> > On Fri, 25 Aug 2023 18:31:57 -0500
> > Terry Bowman <terry.bowman@amd.com> wrote:
> >   
> > > From: Robert Richter <rrichter@amd.com>  
> > 
> > Hi Robert, Terry,
> >   
> > > 
> > > The component registers of a component may not exist or are not
> > > needed.  
> > 
> > How do we now it's not needed in this function?
> > Perhaps "may not exist." is the bit that matters in this sentence.
> >   
> > > The setup may fail for that reason. In some cases the
> > > initialization should continue anyway. Thus, always initialize struct
> > > cxl_register_map with valid values. In case of errors, zero it, set a
> > > value for @dev and make @resource a the valid value using  
> > 
> > make @resource CXL_RESOURCE_NONE.
> > 
> > (not "a the")
> >   
> > > CXL_RESOURCE_NONE.  
> > 
> > It might be worth making it clear that this will (I think) only matter
> > for future usecases and isn't a fix for how this function is used today.  
> 
> I reworded the whole text:
> 
> """
> The component registers of a component may not exist and
> cxl_setup_comp_regs() will fail for that reason. In another case,
> Software may not use and set those registers up. cxl_setup_comp_regs()
> is then called with a base address of CXL_RESOURCE_NONE. Both are
> valid cases, but the function returns without initializing the
> register map.
> 
> Now, a missing component register block is not necessarily a reason to
> fail (feature is optional or its existence checked later). Change
> cxl_setup_comp_regs() to also use components with the component
> register block missing. Thus, always initialize struct
> cxl_register_map with valid values, set @dev and make @resource
> CXL_RESOURCE_NONE.
> 
> The change is in preparation of follow-on patches.
> """

Looks good to me.

J
> 
> I hope that is better now.
> 
> >   
> > > 
> > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > Signed-off-by: Terry Bowman <terry.bowman@amd.com>  
> > Otherwise seems sensible to me with one comment below.
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >   
> > > ---
> > >  drivers/cxl/core/port.c | 11 ++++++-----
> > >  1 file changed, 6 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > > index 724be8448eb4..2d22e7a5629b 100644
> > > --- a/drivers/cxl/core/port.c
> > > +++ b/drivers/cxl/core/port.c
> > > @@ -693,16 +693,17 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
> > >  static int cxl_setup_comp_regs(struct device *dev, struct cxl_register_map *map,
> > >  			       resource_size_t component_reg_phys)
> > >  {
> > > -	if (component_reg_phys == CXL_RESOURCE_NONE)
> > > -		return 0;
> > > -
> > >  	*map = (struct cxl_register_map) {
> > >  		.dev = dev,
> > > -		.reg_type = CXL_REGLOC_RBI_COMPONENT,  
> > 
> > Could set this explicitly to CXL_REGLOC_RBI_EMPTY
> > which is what happens anyway, but it isn't obvious that
> > 0 maps to something that indicates this doesn't exist.  
> 
> Will change that.
> 
> Thanks,
> 
> -Robert
> 
> 
> >   
> > >  		.resource = component_reg_phys,
> > > -		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
> > >  	};
> > >  
> > > +	if (component_reg_phys == CXL_RESOURCE_NONE)
> > > +		return 0;
> > > +
> > > +	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
> > > +	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
> > > +
> > >  	return cxl_setup_regs(map);
> > >  }
> > >    
> >   


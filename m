Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864377CAAF5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjJPOIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjJPOIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:08:10 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3470483;
        Mon, 16 Oct 2023 07:08:08 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8JmX2b8Pz6K6SG;
        Mon, 16 Oct 2023 22:05:48 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 16 Oct
 2023 15:08:05 +0100
Date:   Mon, 16 Oct 2023 15:08:04 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Terry Bowman <Terry.Bowman@amd.com>
CC:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v11 10/20] cxl/pci: Introduce config option PCIEAER_CXL
Message-ID: <20231016150804.000054aa@Huawei.com>
In-Reply-To: <da5bc564-76c4-4078-97ab-1d543933071e@amd.com>
References: <20230927154339.1600738-1-rrichter@amd.com>
        <20230927154339.1600738-11-rrichter@amd.com>
        <20231002154628.00004f9b@Huawei.com>
        <21fa3d41-3585-40b4-b919-d3b66557e9d8@amd.com>
        <da5bc564-76c4-4078-97ab-1d543933071e@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> >>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> >>> index 04107058739b..61ca21c020fa 100644
> >>> --- a/drivers/cxl/mem.c
> >>> +++ b/drivers/cxl/mem.c
> >>> @@ -157,6 +157,8 @@ static int cxl_mem_probe(struct device *dev)
> >>>  	else
> >>>  		endpoint_parent = &parent_port->dev;
> >>>  
> >>> +	devm_cxl_setup_parent_dport(dev, dport);  
> >>
> >> devm calls can always fail (because if nothing else you have to register
> >> some cleanup and that involves an allocation.  If you want to ignore
> >> that I'd expect a comment here.
> >>  
> > 
> > We will add error handling here.
> > 
> > Regards,
> > Terry
> >  
> 
> Found devm_cxl_setup_parent_dport() is a NULL function without return value.
Hmm. Then it's not a devm function. 

I went looking and can't find it registering any cleanup so
just rename it to cxl_setup_parent_dport()

>  
> Regards,
> Terry


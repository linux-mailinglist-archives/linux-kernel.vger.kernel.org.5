Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469B07B5513
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237620AbjJBOOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237479AbjJBOOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:14:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AE5AD;
        Mon,  2 Oct 2023 07:14:46 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RzjbW6tMyz67ZgC;
        Mon,  2 Oct 2023 22:13:11 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 2 Oct
 2023 15:14:44 +0100
Date:   Mon, 2 Oct 2023 15:14:43 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Robert Richter <rrichter@amd.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v11 01/20] cxl/port: Fix release of RCD endpoints
Message-ID: <20231002151443.000017d5@Huawei.com>
In-Reply-To: <20230927154339.1600738-2-rrichter@amd.com>
References: <20230927154339.1600738-1-rrichter@amd.com>
        <20230927154339.1600738-2-rrichter@amd.com>
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

On Wed, 27 Sep 2023 17:43:20 +0200
Robert Richter <rrichter@amd.com> wrote:

> Binding and unbindind RCD endpoints (e.g. mem0 device) caused the
> corresponding endpoint not being released. Reason for that is the
> wrong port discovered for RCD endpoints. See cxl_mem_probe() for
> proper endpoint parent detection. Fix delete_endpoint() respectively.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I wondered briefly if an access function of some type could be
used to hide this detail away. However it's messy enough that
that is a little tricky so I think we should just keep it
explicit in each location.  So as you have it here.

> ---
>  drivers/cxl/core/port.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 7ca01a834e18..d4572a02989a 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1222,12 +1222,17 @@ static void delete_endpoint(void *data)
>  	struct cxl_memdev *cxlmd = data;
>  	struct cxl_port *endpoint = cxlmd->endpoint;
>  	struct cxl_port *parent_port;
> +	struct cxl_dport *dport;
>  	struct device *parent;
>  
> -	parent_port = cxl_mem_find_port(cxlmd, NULL);
> +	parent_port = cxl_mem_find_port(cxlmd, &dport);
>  	if (!parent_port)
>  		goto out;
> -	parent = &parent_port->dev;
> +
> +	if (dport->rch)
> +		parent = parent_port->uport_dev;
> +	else
> +		parent = &parent_port->dev;
>  
>  	device_lock(parent);
>  	if (parent->driver && !endpoint->dead) {


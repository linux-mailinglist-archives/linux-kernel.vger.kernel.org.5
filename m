Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D6D7B55E4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237720AbjJBOem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237538AbjJBOek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:34:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAE5B4;
        Mon,  2 Oct 2023 07:34:37 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rzk436LWDz67fjR;
        Mon,  2 Oct 2023 22:34:27 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 2 Oct
 2023 15:34:34 +0100
Date:   Mon, 2 Oct 2023 15:34:34 +0100
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
Subject: Re: [PATCH v11 04/20] cxl/port: Rename @comp_map to @reg_map in
 struct cxl_register_map
Message-ID: <20231002153434.000073b9@Huawei.com>
In-Reply-To: <20230927154339.1600738-5-rrichter@amd.com>
References: <20230927154339.1600738-1-rrichter@amd.com>
        <20230927154339.1600738-5-rrichter@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

On Wed, 27 Sep 2023 17:43:23 +0200
Robert Richter <rrichter@amd.com> wrote:

> Name the field @reg_map, because @reg_map->host will be used for
> mapping operations beyond component registers (i.e. AER registers).
> This is valid for all occurrences of @comp_map. Change them all.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
Makes sense.  Can we pull the one I moaned about in the previous
patch into this one?

That way the renames are all together.

If not, I'm fine with just moaning :)  Whichever patch split
you go with across this and previous...

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.co>
> ---
>  drivers/cxl/core/port.c | 2 +-
>  drivers/cxl/cxl.h       | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 99df86d72dbc..b993dea61436 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -712,7 +712,7 @@ static int cxl_port_setup_regs(struct cxl_port *port,
>  {
>  	if (dev_is_platform(port->uport_dev))
>  		return 0;
> -	return cxl_setup_comp_regs(&port->dev, &port->comp_map,
> +	return cxl_setup_comp_regs(&port->dev, &port->reg_map,
>  				   component_reg_phys);
>  }
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 68abf9944383..3a51b58a66d0 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -572,7 +572,7 @@ struct cxl_dax_region {
>   * @regions: cxl_region_ref instances, regions mapped by this port
>   * @parent_dport: dport that points to this port in the parent
>   * @decoder_ida: allocator for decoder ids
> - * @comp_map: component register capability mappings
> + * @reg_map: component and ras register mapping parameters
>   * @nr_dports: number of entries in @dports
>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>   * @commit_end: cursor to track highest committed decoder for commit ordering
> @@ -592,7 +592,7 @@ struct cxl_port {
>  	struct xarray regions;
>  	struct cxl_dport *parent_dport;
>  	struct ida decoder_ida;
> -	struct cxl_register_map comp_map;
> +	struct cxl_register_map reg_map;
>  	int nr_dports;
>  	int hdm_end;
>  	int commit_end;


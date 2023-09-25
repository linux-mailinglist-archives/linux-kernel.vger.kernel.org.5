Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8377AD558
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjIYKIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjIYKHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:07:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86931FC;
        Mon, 25 Sep 2023 03:07:48 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvJSD1NTPz6K7TJ;
        Mon, 25 Sep 2023 18:06:36 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 25 Sep
 2023 11:07:45 +0100
Date:   Mon, 25 Sep 2023 11:07:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jeongtae Park <jtp.park@samsung.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        "Wonjae Lee" <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        "Jeongtae Park" <jeongtae.park@gmail.com>
Subject: Re: [PATCH v2 2/7] cxl/region: Fix a checkpatch warning
Message-ID: <20230925110745.00001127@Huawei.com>
In-Reply-To: <20230922113520.3298976-1-jtp.park@samsung.com>
References: <CGME20230922113233epcas2p2cd57df10dde36b0da3b2fc5a916132e8@epcas2p2.samsung.com>
        <20230922113520.3298976-1-jtp.park@samsung.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023 20:35:20 +0900
Jeongtae Park <jtp.park@samsung.com> wrote:

> WARNING: else is not generally useful after a break or return
> 
> Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

This one is a little ugly. I'd prefer to see the error
condition remain out of line (vs the warning one)

		if (!IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
			dev_err(&cxlr->dev,
				"Failed ...");
			return -ENOXIO
		}

		dev_warn_once(...

		return 0;

Or keep the else.

Not that important though as code is small enough that less
than ideal in / out of line doesn't matter that much to readability.

Jonathan


> ---
>  drivers/cxl/core/region.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e115ba382e04..1fc9d01c1ac0 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -133,11 +133,10 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
>  				&cxlr->dev,
>  				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
>  			return 0;
> -		} else {
> -			dev_err(&cxlr->dev,
> -				"Failed to synchronize CPU cache state\n");
> -			return -ENXIO;
>  		}
> +
> +		dev_err(&cxlr->dev, "Failed to synchronize CPU cache state\n");
> +		return -ENXIO;
>  	}
>  
>  	cpu_cache_invalidate_memregion(IORES_DESC_CXL);


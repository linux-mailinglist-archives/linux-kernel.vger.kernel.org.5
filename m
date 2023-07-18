Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BB8757805
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjGRJ3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjGRJ3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:29:41 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B5FE0;
        Tue, 18 Jul 2023 02:29:40 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4tqf0h84z6D9CT;
        Tue, 18 Jul 2023 17:26:22 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 18 Jul
 2023 10:29:38 +0100
Date:   Tue, 18 Jul 2023 10:29:37 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     Breno Leitao <leitao@debian.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, <leit@meta.com>,
        kernel test robot <lkp@intel.com>,
        "open list:COMPUTE EXPRESS LINK (CXL)" <linux-cxl@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: Use printk specifier for resource
Message-ID: <20230718102937.00001af0@Huawei.com>
In-Reply-To: <a607c370-030a-2b96-9aca-886a23248e83@intel.com>
References: <20230717102625.4083462-1-leitao@debian.org>
        <a607c370-030a-2b96-9aca-886a23248e83@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 09:28:47 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 7/17/23 03:26, Breno Leitao wrote:
> > Commit 3840e10e8dca ("cxl/acpi: Fix a use-after-free in cxl_parse_cfmws()")
> > is using %llx to print resources pointers, but it is incorrect on 32-bits
> > system, causing the following compilation warning on i386:
> > 
> > 	 drivers/cxl/acpi.c:300:4: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]
> > 
> > Instead of using pointers to the resource, uses the proper printk
> > specifier that knows how to handle the struct "resources".
> > 
> > This is the new format, being printed now:
> > 
> > 	Failed to add decode range: [mem 0x4080000000-0x2baffffffff flags 0x200]
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202307151059.2vvBt55H-lkp@intel.com/
> > Fixes: 3840e10e8dca ("cxl/acpi: Fix a use-after-free in cxl_parse_cfmws()")
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Breno Leitao <leitao@debian.org>  
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

FWIW
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> > ---
> >   drivers/cxl/acpi.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 815b43859c16..d1c559879dcc 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -296,8 +296,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> >   	else
> >   		rc = cxl_decoder_autoremove(dev, cxld);
> >   	if (rc) {
> > -		dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
> > -			res->start, res->end);
> > +		dev_err(dev, "Failed to add decode range: %pr", res);
> >   		return rc;
> >   	}
> >   	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",  
> 


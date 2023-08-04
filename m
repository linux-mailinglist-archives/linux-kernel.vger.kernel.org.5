Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FCB770009
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjHDMQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjHDMQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:16:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A49146A8;
        Fri,  4 Aug 2023 05:16:15 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RHPjX0pwkz6J7d7;
        Fri,  4 Aug 2023 20:12:32 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 13:16:13 +0100
Date:   Fri, 4 Aug 2023 13:16:12 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] cxl/mbox: Use correct handle in events debug
 message
Message-ID: <20230804131612.0000770d@Huawei.com>
In-Reply-To: <20230731-cxl-fix-clear-event-debug-print-v2-1-9bdd08d386e9@intel.com>
References: <20230731-cxl-fix-clear-event-debug-print-v2-0-9bdd08d386e9@intel.com>
        <20230731-cxl-fix-clear-event-debug-print-v2-1-9bdd08d386e9@intel.com>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Aug 2023 13:13:28 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> The handle value used to report an event being cleared by dev_dbg() is
> incorrect due to a post increment of the payload handle index.
> 
> Delay the increment of the index until after the print.
> 
> Fixes: 6ebe28f9ec72 ("cxl/mem: Read, trace, and clear events on driver load")
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 

FWIW given how well this has already been reviewed.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> Changes for v2
> [Dan] Go ahead and mark this for backporting
> [Dan] Remove 'To/Cc' cruft from individual patches
> [Dan/Alison] Split out the additional debugging
> [Alison] New oneliner
> ---
>  drivers/cxl/core/mbox.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index d6d067fbee97..a1c490f66bbf 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -882,9 +882,10 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  	 */
>  	i = 0;
>  	for (cnt = 0; cnt < total; cnt++) {
> -		payload->handles[i++] = get_pl->records[cnt].hdr.handle;
> +		payload->handles[i] = get_pl->records[cnt].hdr.handle;
>  		dev_dbg(mds->cxlds.dev, "Event log '%d': Clearing %u\n", log,
>  			le16_to_cpu(payload->handles[i]));
> +		i++;
>  
>  		if (i == max_handles) {
>  			payload->nr_recs = i;
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0225277000F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjHDMRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHDMRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:17:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716A146A8;
        Fri,  4 Aug 2023 05:17:49 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RHPlL0FTvz6J7mS;
        Fri,  4 Aug 2023 20:14:06 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 13:17:47 +0100
Date:   Fri, 4 Aug 2023 13:17:46 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alison Schofield <alison.schofield@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] cxl/mbox: Add handle to event processing debug
Message-ID: <20230804131746.00003d65@Huawei.com>
In-Reply-To: <ZMvjKIEEeUwqANrz@aschofie-mobl2>
References: <20230731-cxl-fix-clear-event-debug-print-v2-0-9bdd08d386e9@intel.com>
        <20230731-cxl-fix-clear-event-debug-print-v2-2-9bdd08d386e9@intel.com>
        <ZMqEY2qj8s8uKZlN@aschofie-mobl2>
        <64cb35b4ef5cc_9473e29411@iweiny-mobl.notmuch>
        <ZMvjKIEEeUwqANrz@aschofie-mobl2>
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

On Thu, 3 Aug 2023 10:26:00 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> On Wed, Aug 02, 2023 at 10:05:56PM -0700, Ira Weiny wrote:
> > Alison Schofield wrote:  
> > > On Tue, Aug 01, 2023 at 01:13:29PM -0700, Ira Weiny wrote:  
> > > > Knowing which handle is being processed helped in debugging new event
> > > > code.  Add a dev_dbg() message with this information.
> > > > 
> > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > > ---
> > > >  drivers/cxl/core/mbox.c | 6 +++++-
> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > > > index a1c490f66bbf..f052d5f174ee 100644
> > > > --- a/drivers/cxl/core/mbox.c
> > > > +++ b/drivers/cxl/core/mbox.c
> > > > @@ -947,9 +947,13 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> > > >  		if (!nr_rec)
> > > >  			break;
> > > >  
> > > > -		for (i = 0; i < nr_rec; i++)
> > > > +		for (i = 0; i < nr_rec; i++) {
> > > > +			dev_dbg(dev, "Event log %d: processing handle %u\n",
> > > > +				type,
> > > > +				le16_to_cpu(payload->records[i].hdr.handle));
> > > >  			cxl_event_trace_record(cxlmd, type,
> > > >  					       &payload->records[i]);
> > > > +		}  
> > > 
> > > Is dev_dbg() overkill when the info is in the trace event?  
> > 
> > The trace event will not happen if tracing is not turned on.
> > 
> > This was all part of my testing the DCD events which don't have to, and
> > likely will not, have tracing on.  So this helped to track which handles
> > were being processed from the cxl-test and qemu layers.
> > 
> > Ira  
> 
> Thanks for explaining!

Good to have that detail in the commit message as it's good justification
for the change. Otherwise LGTM.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> >   
> > >   
> > > >  
> > > >  		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
> > > >  			trace_cxl_overflow(cxlmd, type, payload);
> > > > 
> > > > -- 
> > > > 2.41.0
> > > >   
> > 
> >   


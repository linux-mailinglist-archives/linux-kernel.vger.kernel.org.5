Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EBA76F090
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbjHCR0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjHCR0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:26:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C4C3581;
        Thu,  3 Aug 2023 10:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691083563; x=1722619563;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LQ8Ts4+kVMy9ToL7lr6JqL5MmpyhtXlvku8kyBpCoE8=;
  b=mgjGA1Nga4YsDDHYTuwJKMeRtaGxnx+tguFER9FdSfsKIOhz1ZZ6ZuK2
   jCYFTfxJ/oRU+/JxIL2jh7hGPGGYkZ+cIBvXmaseO1jDzq2zi9Nr9AdaX
   eYT8yOyJbZQ2eXj5fft++laNuyVSs32CkLHQUiwObr1gsnfOaA9+4lJqB
   jsgWtXWH3wVqaCnd3I9TkMGUlPTncMHkXqBtzjpJc+Zb9hOq61lT3D5v7
   q4AA63wQ9iAB4VYq2PnpGGs0+wTErbEyJqB49uqRWQms2tjKsDG0l3GCR
   RDsLgPD7GUlvM+H9s1T6xdn/6cZuukO3sNdP1H5g5vdGSvOaoce9aziU0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="373588414"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="373588414"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 10:26:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="706648971"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="706648971"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.86.212])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 10:26:02 -0700
Date:   Thu, 3 Aug 2023 10:26:00 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cxl/mbox: Add handle to event processing debug
Message-ID: <ZMvjKIEEeUwqANrz@aschofie-mobl2>
References: <20230731-cxl-fix-clear-event-debug-print-v2-0-9bdd08d386e9@intel.com>
 <20230731-cxl-fix-clear-event-debug-print-v2-2-9bdd08d386e9@intel.com>
 <ZMqEY2qj8s8uKZlN@aschofie-mobl2>
 <64cb35b4ef5cc_9473e29411@iweiny-mobl.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64cb35b4ef5cc_9473e29411@iweiny-mobl.notmuch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 10:05:56PM -0700, Ira Weiny wrote:
> Alison Schofield wrote:
> > On Tue, Aug 01, 2023 at 01:13:29PM -0700, Ira Weiny wrote:
> > > Knowing which handle is being processed helped in debugging new event
> > > code.  Add a dev_dbg() message with this information.
> > > 
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > ---
> > >  drivers/cxl/core/mbox.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > > index a1c490f66bbf..f052d5f174ee 100644
> > > --- a/drivers/cxl/core/mbox.c
> > > +++ b/drivers/cxl/core/mbox.c
> > > @@ -947,9 +947,13 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> > >  		if (!nr_rec)
> > >  			break;
> > >  
> > > -		for (i = 0; i < nr_rec; i++)
> > > +		for (i = 0; i < nr_rec; i++) {
> > > +			dev_dbg(dev, "Event log %d: processing handle %u\n",
> > > +				type,
> > > +				le16_to_cpu(payload->records[i].hdr.handle));
> > >  			cxl_event_trace_record(cxlmd, type,
> > >  					       &payload->records[i]);
> > > +		}
> > 
> > Is dev_dbg() overkill when the info is in the trace event?
> 
> The trace event will not happen if tracing is not turned on.
> 
> This was all part of my testing the DCD events which don't have to, and
> likely will not, have tracing on.  So this helped to track which handles
> were being processed from the cxl-test and qemu layers.
> 
> Ira

Thanks for explaining!

> 
> > 
> > >  
> > >  		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
> > >  			trace_cxl_overflow(cxlmd, type, payload);
> > > 
> > > -- 
> > > 2.41.0
> > > 
> 
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCE0778A36
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjHKJjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjHKJje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:39:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3C73A92;
        Fri, 11 Aug 2023 02:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691746759; x=1723282759;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZZFkeQRqIq/ziJ7Ov21Tp4dugsMz1eK8BIZ6YuLMnrY=;
  b=lzwT1RsaQL8g6YiQOb+RijXfK2bJTdr+w5gf6baBuezwuxYdXN0s/pjy
   BKrY9Fx2nARbRWBMMWfUiLo93iShfEQs82E2bDu4/L8iq6njH3gyUMQuh
   91GYJezKHWzNCl/ztdibULYuSOIa9yOkFVZ5HEnPJ9L///AIrfqq50fqb
   najqnODDk0rokq6MQ7OlMN0Jdc/HTVDUFeSlgn+lXSg+uMyCYeXEWGGfo
   vUCBFrMVaKxF03z/trDGy4gsre8+ffUeGR0JY92nWHdPUlBnyH5rwcqOs
   L+qcwJIzP6mDDgSx0KLnzjahhLm72ZvXr4lQJWDplwgOOzMn7Nr+O1Sq/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="437977820"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="437977820"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 02:38:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="682482303"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="682482303"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 11 Aug 2023 02:38:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qUOb7-008tD5-1i;
        Fri, 11 Aug 2023 12:38:21 +0300
Date:   Fri, 11 Aug 2023 12:38:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] serial: core: Fix serial core port id, including
 multiport devices
Message-ID: <ZNYBjafHuutSrN4B@smile.fi.intel.com>
References: <20230810065737.47294-1-tony@atomide.com>
 <ZNUBHaDTsAXVNNLZ@smile.fi.intel.com>
 <ZNUBvZQcbBbCziXU@smile.fi.intel.com>
 <20230811051121.GL11676@atomide.com>
 <ZNYAxb3eSJ63w7U9@smile.fi.intel.com>
 <ZNYA/JDs4cqC9CJn@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNYA/JDs4cqC9CJn@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:35:56PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 11, 2023 at 12:35:01PM +0300, Andy Shevchenko wrote:
> > On Fri, Aug 11, 2023 at 08:11:21AM +0300, Tony Lindgren wrote:
> > > * Andy Shevchenko <andriy.shevchenko@intel.com> [230810 15:26]:
> > > > On Thu, Aug 10, 2023 at 06:24:13PM +0300, Andy Shevchenko wrote:
> > > > > On Thu, Aug 10, 2023 at 09:57:34AM +0300, Tony Lindgren wrote:

...

> > > > > > +	unsigned int min = 0, max = ~0U;
> > > > > 
> > > > > Shouldn't this be int? The max IIRC will be INT_MAX with this anyway.
> > > > 
> > > > Ah, and then you can supply is as 0 (IIRC).
> > > 
> > > The returned id will be INT_MAX, but idr.h uses unsigned int:
> > > 
> > > int ida_alloc_range(struct ida *, unsigned int min, unsigned int max, gfp_t);
> > > 
> > > If there's some reason to limit max id we can do it, otherwise it's just
> > > a don't care flag.
> > > 
> > > Please clarify if I'm not following what you are suggesting :)
> > 
> > 	... max = 0;
> > 
> > Will have the same effect with more explicit intention "use whatever maximum is
> > default". With ~0U I would expect to see something bigger than INT_MAX, but it
> > won't ever appear.
> 
> You can put a comment on top
> 
> 	/* Use 0 for max to apply IDA defaults */

Hmm... Looking into the implementation code it seems better to have

	/* Use -1 for max to apply IDA defaults */
	int min = 0, max = -1;

And supply like that.

-- 
With Best Regards,
Andy Shevchenko



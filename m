Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20CA75D0AB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjGUR17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjGUR14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:27:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFBE2691;
        Fri, 21 Jul 2023 10:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689960474; x=1721496474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pj63wD4/DYQgakoYsXMEa/0XH9I2qq7zxenF6w6n6eY=;
  b=niR0SG/HMtSCG855A5TjhShBe6XgOaLf6ySSmK6sQ9qBxOwrwhVVe1Qg
   UOIYpUKSjGhQJJezMDxPgNRa4D5T/j8vT7xLTzgV1sNeUXp7RvP47dw+U
   tloEk/Mn4RIsva0Ypht+OT66nTxfqxSwLY/gRmylRZHn/g5c1XY5Xd7iH
   4/rKJcejr5yOlkpLX6xUqELR7CAHh+gPcAzu1d/vJi7NFomdkqg7XIcYv
   OABkyncrcI9A1zy97tQmfX/RLPPXvJsm/z6AvLxHv5+x+d4LCtteHQ9bc
   960LkFEmZ18HmaKrX8mMh+qRuTZL0m4VftC52YTceXSjuKD9S4JyMfguF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="453453164"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="453453164"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 10:27:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="815036936"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="815036936"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jul 2023 10:27:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qMtuw-00EWnk-13;
        Fri, 21 Jul 2023 20:27:50 +0300
Date:   Fri, 21 Jul 2023 20:27:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v2 1/8] iio: core: Add opaque_struct_size() helper and
 use it
Message-ID: <ZLrAFmyWz7/gtOgF@smile.fi.intel.com>
References: <20230721170022.3461-1-andriy.shevchenko@linux.intel.com>
 <20230721170022.3461-2-andriy.shevchenko@linux.intel.com>
 <ZLq+2+9q6To3uAkf@smile.fi.intel.com>
 <ZLq/eDDSblr2vlSA@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLq/eDDSblr2vlSA@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 08:25:12PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 21, 2023 at 08:22:35PM +0300, Andy Shevchenko wrote:
> > On Fri, Jul 21, 2023 at 08:00:15PM +0300, Andy Shevchenko wrote:
> > > Introduce opaque_struct_size() helper, which may be moved
> > > to overflow.h in the future, and use it in the IIO core.

...

> > > +#define opaque_struct_size(p, a, s)	({		\
> > > +	size_t _psize = sizeof(*(p));			\
> > > +	size_t _asize = ALIGN(_psize, (a));		\
> > > +	size_t _ssize = s;				\
> > > +	_ssize ? size_add(_asize, _ssize) : _psize;	\
> > > +})
> > > +
> > > +#define opaque_struct_data(p, a)			\
> > > +	((void *)(p) + ALIGN(sizeof(*(p)), (a)))
> > 
> > Hmm... This can potentially evaluate p twice.
> > 
> > Perhaps this variant is better:
> > 
> > #define opaque_struct_data(p, a)	ALIGN((p) + 1, (a)))
> > 
> > Besides, I don't think we should worry about @s evaluation in the main macro
> > which may be simplified to
> > 
> > #define opaque_struct_size(p, a, s)					\
> > 	((s) ? size_add(ALIGN(sizeof(*(p)), (a)), (s)) : sizeof(*(p)))
> > 
> > Thoughts?
> 
> Also we may leave the struct always be aligned which makes the above even
> simpler (but might waste bytes if @s = 0).
> 
> #define opaque_struct_size(p, a, s)	size_add(ALIGN(sizeof(*(p)), (a)), (s))
> 
> (with the respective documentation update).

Jonathan, this patch can be skipped and if you are okay with the rest, the rest
may be (clearly, I have just checked) applied without as there is no dependency.

-- 
With Best Regards,
Andy Shevchenko



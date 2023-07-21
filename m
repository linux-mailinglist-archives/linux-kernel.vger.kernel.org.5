Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DB175D0A1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjGUR0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjGURZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:25:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3714D4201;
        Fri, 21 Jul 2023 10:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689960321; x=1721496321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uIkKjPDawoiFfENQmTtdTBfG12v/OWQvuxstItlhHZQ=;
  b=CaouzBx2yMOQFqU0TJ217seSK0E3LycMZGVcoe0Xr1FrH8V8k++tgY6l
   7BegXuUcwE9WoW7bbX+yFsDrJwngGkOzZpsUJ0UAoMSsKMnE29YxfiaLY
   G0APKZLkTlCIj5JKtu77ZKtZHXqEYe7uEcqYMXClBkrUvGP3v/4uuWjS3
   Gmwyrb/+ekXHiLhq+Y2V1EISsVi99w/HKGOOwXfRn+VqcwKOufhH4tc0y
   4XqepSs5Vgt+v8MA3Kq2pwVTY453pCPGSJYCBnlIYVFL2lBQvichaGWBV
   LZLSpLxmRDEg97dsWZX4tgK16MkRonA7Pb9ZKAfqkRj4Sm6A7RfKYbG9g
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="351959630"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="351959630"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 10:25:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="795031707"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="795031707"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jul 2023 10:25:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qMtsO-00ER2L-2D;
        Fri, 21 Jul 2023 20:25:12 +0300
Date:   Fri, 21 Jul 2023 20:25:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v2 1/8] iio: core: Add opaque_struct_size() helper and
 use it
Message-ID: <ZLq/eDDSblr2vlSA@smile.fi.intel.com>
References: <20230721170022.3461-1-andriy.shevchenko@linux.intel.com>
 <20230721170022.3461-2-andriy.shevchenko@linux.intel.com>
 <ZLq+2+9q6To3uAkf@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLq+2+9q6To3uAkf@smile.fi.intel.com>
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

On Fri, Jul 21, 2023 at 08:22:35PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 21, 2023 at 08:00:15PM +0300, Andy Shevchenko wrote:
> > Introduce opaque_struct_size() helper, which may be moved
> > to overflow.h in the future, and use it in the IIO core.

...

> > +#define opaque_struct_size(p, a, s)	({		\
> > +	size_t _psize = sizeof(*(p));			\
> > +	size_t _asize = ALIGN(_psize, (a));		\
> > +	size_t _ssize = s;				\
> > +	_ssize ? size_add(_asize, _ssize) : _psize;	\
> > +})
> > +
> > +#define opaque_struct_data(p, a)			\
> > +	((void *)(p) + ALIGN(sizeof(*(p)), (a)))
> 
> Hmm... This can potentially evaluate p twice.
> 
> Perhaps this variant is better:
> 
> #define opaque_struct_data(p, a)	ALIGN((p) + 1, (a)))
> 
> Besides, I don't think we should worry about @s evaluation in the main macro
> which may be simplified to
> 
> #define opaque_struct_size(p, a, s)					\
> 	((s) ? size_add(ALIGN(sizeof(*(p)), (a)), (s)) : sizeof(*(p)))
> 
> Thoughts?

Also we may leave the struct always be aligned which makes the above even
simpler (but might waste bytes if @s = 0).

#define opaque_struct_size(p, a, s)	size_add(ALIGN(sizeof(*(p)), (a)), (s))

(with the respective documentation update).

-- 
With Best Regards,
Andy Shevchenko



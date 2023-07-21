Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B2375C5E6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjGULba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjGULb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:31:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E1CE0;
        Fri, 21 Jul 2023 04:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689939087; x=1721475087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9/ut5UjQKUswKVul7iirnPDvZhjc6d3idO3CXe5FhlI=;
  b=Jaz3kR8KLez68W2bwvTWaixZQyviLl/N747RJfXh1N/iYK3mKJgnnvJm
   m3HMTanwlxE6MtsPiC8DYTqrVEm+oyKYllFVrXbMrWt+7nOa0E57hfFZp
   Zdi85doAtzTSD7x5KNHp/ideh9J/CuHx6o0V4DURo+nShYqkxJmpjDgGR
   nBj2wPo+gplpPgGCP3Fsbheud78QWE6fzn2cLAOj6Cp19d5bKcBEYwwUq
   /mH9+f9n4rUiCwVQ6l1pkw1jVaPXersUCKlJI35V4u5sdbQqD4DzCsk1n
   GMTwNseIsD3ayh69Pba8ynaPjku+Z0evHvenOhbgQedRQ4eDfxAmTTqAZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="433230705"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="433230705"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 04:31:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="838521376"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="838521376"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jul 2023 04:31:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qMoM0-002DKi-02;
        Fri, 21 Jul 2023 14:31:24 +0300
Date:   Fri, 21 Jul 2023 14:31:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 3/8] iio: core: Switch to krealloc_array()
Message-ID: <ZLpsi8tiq4J/CUxx@smile.fi.intel.com>
References: <20230720205324.58702-1-andriy.shevchenko@linux.intel.com>
 <20230720205324.58702-4-andriy.shevchenko@linux.intel.com>
 <65dbc603062018e1cd968caf983512c2cb2039e5.camel@gmail.com>
 <ZLpaeHlJujd8l0DS@smile.fi.intel.com>
 <f565b705ba6656ae1c8b34740aa176ccfe260f60.camel@gmail.com>
 <ZLpr5KmYNlXkgBFb@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZLpr5KmYNlXkgBFb@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 02:28:36PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 21, 2023 at 12:53:53PM +0200, Nuno Sá wrote:
> > On Fri, 2023-07-21 at 13:14 +0300, Andy Shevchenko wrote:
> > > On Fri, Jul 21, 2023 at 09:59:37AM +0200, Nuno Sá wrote:
> > > > On Thu, 2023-07-20 at 23:53 +0300, Andy Shevchenko wrote:

...

> > > > > +       struct attribute **attrs, **attr, *clk = NULL;
> > > > >         struct iio_dev_attr *p;
> > > > > -       struct attribute **attr, *clk = NULL;
> > > > >  
> > > > >         /* First count elements in any existing group */
> > > > > -       if (indio_dev->info->attrs) {
> > > > > -               attr = indio_dev->info->attrs->attrs;
> > > > > -               while (*attr++ != NULL)
> > > > > +       attrs = indio_dev->info->attrs ? indio_dev->info->attrs->attrs :
> > > > > NULL;
> > > > > +       if (attrs) {
> > > > > +               for (attr = attrs; *attr; attr++)
> > > > >                         attrcount_orig++;
> > > 
> > > > not really related with the change... maybe just mention it in the commit?
> > > 
> > > Hmm... It's related to make krealloc_array() to work as expected.
> > > 
> > 
> > Hmm, I think it's arguable :). while() -> for() it's not really needed unless
> > I'm missing something. You could even initialize 'attrs' to NULL at declaration
> > and keep the above diff minimum.
> 
> I'm not a fan of the assignments in the declarations when it potentially can be
> disrupted by a chunk of code and reading the code itself may be harder due to
> an interruption for checking the initial value. Hence, having
> 
> +	attr = attrs;
>  	while (... != NULL)
> 
> seems enough to be replaced with one liner for-loop.

Note that attrs is reused later, so the above assignment makes it cleaner that
some value is assigned to it. With the original code it's not so obvious.

> > That said, I actually prefer this style (even though some people don't like much
> > the ternary operator).
> 
> Thanks!
> 
> > > > >         }

-- 
With Best Regards,
Andy Shevchenko



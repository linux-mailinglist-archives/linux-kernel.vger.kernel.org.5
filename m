Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E32A75C5DA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjGUL2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjGUL2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:28:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDE22D75;
        Fri, 21 Jul 2023 04:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689938921; x=1721474921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+gslPWbygwqn5Kvc0dRzmp02x3RLtVTyyTHjhx1fRZU=;
  b=MGutghEWydl8fJU3BUwh6waFerdT/6c1nf45d7FHkT+kl3oQqanG1BKz
   uZnXA43yy0WvDHwV47T8mncoZdLmiXE0U57F1l3rbQmsP5u47e9eq7M5+
   E+lzG9wKKGvLowmBpeprYEXvFNWk1mJcFIfeC33qWbnlfSpaUtGd6J+/M
   kW+OsNZBz3MfxMktYxVghjFs7+DrgZW3IKt8YfHJxA0/xcqTbA6RXODO9
   eONmUpHCXk+D1DpA08qtl4YT2BIJ9P9KtD87B78kVgUPBsIhAQKrhOl55
   ksGt1eHR7HOjfZlP9Rp7j3NltyS4bftdxoTCdz22i/AUUMeDNseqrFZeS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="433230167"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="433230167"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 04:28:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="971412983"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="971412983"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 21 Jul 2023 04:28:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qMoJI-0027aV-1m;
        Fri, 21 Jul 2023 14:28:36 +0300
Date:   Fri, 21 Jul 2023 14:28:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 3/8] iio: core: Switch to krealloc_array()
Message-ID: <ZLpr5KmYNlXkgBFb@smile.fi.intel.com>
References: <20230720205324.58702-1-andriy.shevchenko@linux.intel.com>
 <20230720205324.58702-4-andriy.shevchenko@linux.intel.com>
 <65dbc603062018e1cd968caf983512c2cb2039e5.camel@gmail.com>
 <ZLpaeHlJujd8l0DS@smile.fi.intel.com>
 <f565b705ba6656ae1c8b34740aa176ccfe260f60.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f565b705ba6656ae1c8b34740aa176ccfe260f60.camel@gmail.com>
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

On Fri, Jul 21, 2023 at 12:53:53PM +0200, Nuno Sá wrote:
> On Fri, 2023-07-21 at 13:14 +0300, Andy Shevchenko wrote:
> > On Fri, Jul 21, 2023 at 09:59:37AM +0200, Nuno Sá wrote:
> > > On Thu, 2023-07-20 at 23:53 +0300, Andy Shevchenko wrote:

...

> > > > +       struct attribute **attrs, **attr, *clk = NULL;
> > > >         struct iio_dev_attr *p;
> > > > -       struct attribute **attr, *clk = NULL;
> > > >  
> > > >         /* First count elements in any existing group */
> > > > -       if (indio_dev->info->attrs) {
> > > > -               attr = indio_dev->info->attrs->attrs;
> > > > -               while (*attr++ != NULL)
> > > > +       attrs = indio_dev->info->attrs ? indio_dev->info->attrs->attrs :
> > > > NULL;
> > > > +       if (attrs) {
> > > > +               for (attr = attrs; *attr; attr++)
> > > >                         attrcount_orig++;
> > 
> > > not really related with the change... maybe just mention it in the commit?
> > 
> > Hmm... It's related to make krealloc_array() to work as expected.
> > 
> 
> Hmm, I think it's arguable :). while() -> for() it's not really needed unless
> I'm missing something. You could even initialize 'attrs' to NULL at declaration
> and keep the above diff minimum.

I'm not a fan of the assignments in the declarations when it potentially can be
disrupted by a chunk of code and reading the code itself may be harder due to
an interruption for checking the initial value. Hence, having

+	attr = attrs;
 	while (... != NULL)

seems enough to be replaced with one liner for-loop.

> That said, I actually prefer this style (even though some people don't like much
> the ternary operator).

Thanks!

> > > >         }

-- 
With Best Regards,
Andy Shevchenko



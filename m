Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C000F75C444
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjGUKO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjGUKOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:14:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855AB2D51;
        Fri, 21 Jul 2023 03:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689934460; x=1721470460;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bWTmW8Z1SY90z599UVo5aQdGHN8twxKFeXBEUIYTGM8=;
  b=WskYfaGXHvty2kGoysqPbODaChPnhXNnWgxOm9QCw5FEErUSg0HVqRmb
   PDutP+IKvjqb33SDVP7uSnoj3Osj5XfO0XwZgPN+00CAG1JP4GG1ehvGd
   yOtILCWqMte9c3FcksrMZRf5MfebCYtBCIilPjXm3Z2vXTK+meIpqBa2R
   FiADN5OdhjyPjKEkRSgo+ob/+Jd5UE/cCfTLQtWx/OUBiBEy8+b2/xyEf
   Q23VbzFimNF8aB/aLJJHSwWSgAHKcMyL3SLwpzS7208kFowufRvIisos6
   plRJEwU+xJeSgWv61vtL6eqy22l/LvNA8YfPOW3YOqvbBjppnEUgc/jc7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="356973658"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="356973658"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:14:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="1055512678"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="1055512678"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jul 2023 03:14:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qMn9M-00H8nR-2Z;
        Fri, 21 Jul 2023 13:14:16 +0300
Date:   Fri, 21 Jul 2023 13:14:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 3/8] iio: core: Switch to krealloc_array()
Message-ID: <ZLpaeHlJujd8l0DS@smile.fi.intel.com>
References: <20230720205324.58702-1-andriy.shevchenko@linux.intel.com>
 <20230720205324.58702-4-andriy.shevchenko@linux.intel.com>
 <65dbc603062018e1cd968caf983512c2cb2039e5.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65dbc603062018e1cd968caf983512c2cb2039e5.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 09:59:37AM +0200, Nuno Sá wrote:
> On Thu, 2023-07-20 at 23:53 +0300, Andy Shevchenko wrote:

...

> > +       struct attribute **attrs, **attr, *clk = NULL;
> >         struct iio_dev_attr *p;
> > -       struct attribute **attr, *clk = NULL;
> >  
> >         /* First count elements in any existing group */
> > -       if (indio_dev->info->attrs) {
> > -               attr = indio_dev->info->attrs->attrs;
> > -               while (*attr++ != NULL)
> > +       attrs = indio_dev->info->attrs ? indio_dev->info->attrs->attrs : NULL;
> > +       if (attrs) {
> > +               for (attr = attrs; *attr; attr++)
> >                         attrcount_orig++;

> not really related with the change... maybe just mention it in the commit?

Hmm... It's related to make krealloc_array() to work as expected.

> >         }

...

> >         iio_dev_opaque->chan_attr_group.attrs =
> > -               kcalloc(attrcount + 1,
> > -                       sizeof(iio_dev_opaque->chan_attr_group.attrs[0]),
> > -                       GFP_KERNEL);
> > +               krealloc_array(attrs, attrcount + 1, sizeof(*attrs),
> > GFP_KERNEL);
> >         if (iio_dev_opaque->chan_attr_group.attrs == NULL) {
> 
> since you're here and you also already did some style cleanups above, maybe
> change it to 'if (!iio_dev_opaque->chan_attr_group.attrs)'?

I don't think it's related (but you can tell that this check related to
the allocator, and since we touch it, we may touch this), if Jonathan
wants this, I definitely do.

...

Thank you for the review!

-- 
With Best Regards,
Andy Shevchenko



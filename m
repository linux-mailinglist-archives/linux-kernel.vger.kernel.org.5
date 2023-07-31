Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1D776A1A7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjGaUBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjGaUB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:01:28 -0400
Received: from mgamail.intel.com (unknown [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796908F;
        Mon, 31 Jul 2023 13:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690833687; x=1722369687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5oGbXYGj4vcg8CCQuePDiYFktmYReAlAj/YZnxzjeD0=;
  b=VkSFNtZBA5HOuUJzC3R1icmDvQPvaAovL+TfbO/EOpgzDgV/6PRUzgr9
   u+7wxsxHJYvHKyFr/VuFl4kD8aBzaq4rSJvuvcruOkq/tViFjvAsv6hs9
   /yDs0vdFZL/bhDKTbkrgygq/7K6gNXNI2ZqDFEqO8Barq/w8ZsSRLrZaX
   i1Jn2qKPMl3qnCrMnpVsIMab34i/ojQDL1pxPwC+OSnFS7k4CBQ1nEbJ7
   8VO/9v+SWnsMIMzNQ+PKSYDyaCdKDoRxiNw71khvFggIM3nLoZ09dDvCK
   ywU6CBpj2eV/Cqn5J+P8V8DlPmLVP30DH4052Hc9+yNS+hgtY71//AQ4v
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="435428394"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="435428394"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 13:01:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="1059115379"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="1059115379"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 31 Jul 2023 13:01:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qQZ4t-003ufD-1R;
        Mon, 31 Jul 2023 23:01:15 +0300
Date:   Mon, 31 Jul 2023 23:01:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Kees Cook <keescook@chromium.org>, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v3 2/4] iio: core: Add opaque_struct_size() helper and
 use it
Message-ID: <ZMgTCzslTd2REumj@smile.fi.intel.com>
References: <20230724110204.46285-1-andriy.shevchenko@linux.intel.com>
 <20230724110204.46285-3-andriy.shevchenko@linux.intel.com>
 <20230729124618.67e89fff@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729124618.67e89fff@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 12:46:18PM +0100, Jonathan Cameron wrote:
> On Mon, 24 Jul 2023 14:02:02 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> > + * Note, when @s is 0, the alignment @a is added to the sizeof(*(@p))
> > + * and the result, depending on the @a, may be way off the initial size.
> 
> How often is this true?  A quick and dirty grep suggests at least 2 so perhaps
> worth retaining the old behaviour.

You mean that the sizeof(_some_grepped_struct_) is much less than an alignment
in those uses?

> Can we take that into account?  Maybe something like
> 
> #define opaque_struct_size(p, a, s) ((s) ? size_add(ALIGN(sizeof(*(p)), (a)), (s)): sizeof(*p)) 

(s) will be evaluated twice, not good. So, not in this form.

> Or do it at the call site below.

Looks much better to me.

...

> 	if (sizeof_priv)
> 		alloc_size = opaque_struct_size(iio_dev_opaque, IIO_DMA_MINALIGN, sizeof_priv);
> 	else
> 		alloc_size = sizeof(struct iio_dev_opaque);

Right.

...

> > -	indio_dev->priv = (char *)iio_dev_opaque +
> > -		ALIGN(sizeof(struct iio_dev_opaque), IIO_DMA_MINALIGN);
> > +	indio_dev->priv = opaque_struct_data(iio_dev_opaque, IIO_DMA_MINALIGN);
> 
> Would have been safer if original code set this to NULL if
> sizeof_priv == 0

Yeah, original code and proposed change has no difference in this sense.

> A driver doing that should never have used iio_priv() but nicer if it was
> NULL rather than off the end of the allocation.

Agree.
But looking at the above, I would rather see that in a form of

	if (...)
		priv = opaque_struct_data(...);
	else
		priv = NULL;

-- 
With Best Regards,
Andy Shevchenko



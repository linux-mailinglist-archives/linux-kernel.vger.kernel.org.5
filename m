Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE48975F387
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjGXKi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjGXKiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:38:55 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B60E64;
        Mon, 24 Jul 2023 03:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690195105; x=1721731105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tW+M2N9Q+IxZ0D9H/5OTffwd2d4CE68kUFZWbzqXWTU=;
  b=S/VhcWPuMCNMc4zdsHM8FQv+vfeWvS0wnSScCbUHaMLZJdEjR1F3Yt9J
   KKr9tZUkfUW3PQhXXIlv9neuJR65oXPK6/OqfuDXEsaGLMdIVZoBGrnkt
   dLaklklgLeGY7htJPtA37pjN7uxioSQlpPjzCZQQQNF57hCA2tg2+tJ7V
   vdUWyZwRS3whf1Qdd9Gj+9jNkI3kg1Ur+nIkCWvwWkyi7i6zi2jPqgwe9
   iRRUTLHrTRKtsiXT6m9Yw1Szu6rHPPiblKjzg0or/JfBL3+d20flkjwuf
   f/6kwJpdGJtp7K/9aRw/KYLYsBQNc/PyU+ykF6t9cNqUFx0XLsh5maBXF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="398308492"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="398308492"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 03:37:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="675784266"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="675784266"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 24 Jul 2023 03:37:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qNswk-008vQd-2A;
        Mon, 24 Jul 2023 13:37:46 +0300
Date:   Mon, 24 Jul 2023 13:37:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v2 3/8] iio: core: Switch to krealloc_array()
Message-ID: <ZL5UeqLJirqkezyx@smile.fi.intel.com>
References: <20230721170022.3461-1-andriy.shevchenko@linux.intel.com>
 <20230721170022.3461-4-andriy.shevchenko@linux.intel.com>
 <20230722182820.28fb3115@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230722182820.28fb3115@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 06:28:20PM +0100, Jonathan Cameron wrote:
> On Fri, 21 Jul 2023 20:00:17 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> > +		krealloc_array(attrs, attrcount + 1, sizeof(*attrs), GFP_KERNEL);
> 
> 
> I'm a little lost, but isn't this realloc()ing attrs, which should be provided
> by drivers as constant if it is set to indio_dev->info->attrs->attrs? 
> 
> That seems unlikely to work correctly, but I may well have lost track of the
> flow and attrs points somewhere else at this point.  I guess it might work
> as the realloc code will detect it can't resize that array.

Argh!

The attrs are defined without const. So, basically to prevent code like this
we have to make sure our local variables are defined as const.

I will drop this hunk from the next version, need to think if it makes sense
to refactor and if so, in which way.

-- 
With Best Regards,
Andy Shevchenko



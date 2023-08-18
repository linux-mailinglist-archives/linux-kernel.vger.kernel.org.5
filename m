Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BFD780FAF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378370AbjHRP5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349349AbjHRP5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:57:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934352722;
        Fri, 18 Aug 2023 08:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692374241; x=1723910241;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9YjmrG0M3FuEJFsUpIklKPspYGwMDw6HDn/wrRhzTLo=;
  b=l0/sogmJsUnK2/uKG6W8Di+Dhu4bizmU+DcZEVoS6buBPNbTE+ixnSRX
   SvS5vM3D5Zn5j6ULtWhEeln6dk3bVvBtf6CgHahHxlYqLtRrKN7swGCjL
   zsIKz+XQ2PB3Hrro6IgG8EHQ7pp4ca2uJARXneIIBLGJSq2Nx56RCgNMH
   XTY068fymoEgHqv7L5IZw2kOyYbCz7iLqMDLvrufWV046q4M5MyDNdzJN
   VmRMTjI8ht78rEAcLBhSMplTNIFru1UGOCgcM88IvMFi3UKuRUY/JLEBg
   G7lBwAE8XWz+MbPdU8hp/V1hQ8itaqw+qlXTDJ/FZfIV5vbexwfYLUgdv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="439512031"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="439512031"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 08:57:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="735144842"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="735144842"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 18 Aug 2023 08:57:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qX1qf-00EqNx-2Z;
        Fri, 18 Aug 2023 18:57:17 +0300
Date:   Fri, 18 Aug 2023 18:57:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] iio: pressure: bmp280: Allow multiple chips id per
 family of devices
Message-ID: <ZN+U3Rqef7bvhpZ7@smile.fi.intel.com>
References: <cover.1692305434.git.ang.iglesiasg@gmail.com>
 <8856287079b5dc1099f5b98a0168f008fbb8debd.1692305434.git.ang.iglesiasg@gmail.com>
 <ZN9TyGjr/pqLQUpT@smile.fi.intel.com>
 <b209214a80c98f92db57be30883ec78dfc116ab0.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b209214a80c98f92db57be30883ec78dfc116ab0.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 05:52:07PM +0200, Angel Iglesias wrote:
> On Fri, 2023-08-18 at 14:19 +0300, Andy Shevchenko wrote:
> > On Thu, Aug 17, 2023 at 11:05:21PM +0200, Angel Iglesias wrote:

...

> > > -       const unsigned int chip_id;
> > 
> > Yeah, this const makes a little sense...
> > 
> > > +       const unsigned int *chip_id;
> > 
> > ...but not this :-)
> 
> Isn't the same case as "const struct iio_chan_spec *channels" or "const int
> *oversampling_temp_avail". I thoght that this meant a pointer to a constant
> integer. On bmp280-core I declare the arrays with the modifiers static const.

Yes, and that is my point:
- old code makes a little sense
- new code makes a lot of sense

> > What I'm wondering is why it's int and not u8 / u16
> > (as it seems only a byte value there).
> 
> Yeah, can be u8, as the reg width is 1 byte and this IDs are stored on one reg.
> I just carried over the int type from previous versions, but it's just wasting
> space :/

-- 
With Best Regards,
Andy Shevchenko



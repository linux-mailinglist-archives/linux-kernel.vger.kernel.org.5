Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805E277F743
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351156AbjHQNCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351426AbjHQNCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:02:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD0C4202;
        Thu, 17 Aug 2023 06:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692277268; x=1723813268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FlmVFVLaQiYINCu3XvqupYomUiJl8X6gme0z7avFboA=;
  b=NLymVT2mGi702JzCkPxmm1NERoYLey8qbgzeFO+1bWsMR3xciD2qyJ5l
   tt67bjUiR4BPKnQzptd16JIry2PV3cfXB1JElZsthaAiyJRDUJGHOshvH
   zSI5sKoTNqc4+7ynqiZ0dVMWiwjc7TauOXFRY91oCPIVwvsg0dUSlI+WV
   BTxnNloj2pDCeDGmdRsLNo/F2u928rceSuU4x9/Ea5X8MBT7vFS6VqQHY
   PDaUM/jU+ppXa0Ju9YbypMMxiJqsZUIvqN9jrFuBe5jal8bEIfs1nU/+u
   k6e4lnsl1kXbM2s9wMxST1dWsaVRtTJPdivBGBelrQUZzxj0gG80mXzet
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="370270128"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="370270128"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 06:00:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="804626902"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="804626902"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2023 06:00:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWccQ-00CT5c-11;
        Thu, 17 Aug 2023 16:00:54 +0300
Date:   Thu, 17 Aug 2023 16:00:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v5] gpio: consumer: new virtual driver
Message-ID: <ZN4aBXX69m/YxWhZ@smile.fi.intel.com>
References: <20230815185650.152968-1-brgl@bgdev.pl>
 <ZN3wauUBENDd7aRU@smile.fi.intel.com>
 <CAMRc=MdUWXZVnjkPqH2BZvDY0v-OOysQ=NMjwQEi1rt+16NEQQ@mail.gmail.com>
 <ZN4U2u9h0vVNmf9d@smile.fi.intel.com>
 <CAMRc=Mds_PC8xO25HfjGbAP1LTqop4vkuz0OPHbcx9UO7QFF5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mds_PC8xO25HfjGbAP1LTqop4vkuz0OPHbcx9UO7QFF5A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 02:53:04PM +0200, Bartosz Golaszewski wrote:
> On Thu, Aug 17, 2023 at 2:38 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Aug 17, 2023 at 02:14:04PM +0200, Bartosz Golaszewski wrote:
> > > On Thu, Aug 17, 2023 at 12:03 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Tue, Aug 15, 2023 at 08:56:50PM +0200, Bartosz Golaszewski wrote:

...

> > > > > +     struct gpio_consumer_device *dev = lookup->parent;
> > > > > +
> > > > > +     guard(mutex)(&dev->lock);
> > > > > +
> > > > > +     return sprintf(page, "%s\n", lookup->key);
> >
> > (1)

...

> > So the 1) has to be amended then.
> 
> No! lookup->key is a string stored in the lookup struct BUT protected
> by the consumer device's lock (it must be or else the lookup could get
> removed while it's being modified). Unless you want to duplicate the
> string in order to release the mutex earlier, it has to be locked
> until sprintf() returns.

Ah, good point, otherwise we would need a copy...

-- 
With Best Regards,
Andy Shevchenko



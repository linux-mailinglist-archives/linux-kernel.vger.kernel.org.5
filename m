Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE9F79BC6B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359199AbjIKWPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236227AbjIKKAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:00:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901C5E67;
        Mon, 11 Sep 2023 03:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694426437; x=1725962437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/H0b/R+uNUqfiQLQRnj4GrCx/gkBli1h0d0agleOMDc=;
  b=hIq1yAl6qvUQftrgIG0snElvkRvj5xggYmL60LNUm8NeVMTiD6eZ8bMZ
   jR0jh/zo31bfwzg1ZKwfkm4s1OZcRiHajgB1j8t37o5ZkOfkuPVhGAvn8
   xZtgMcM4l3obP6VN28GotsAh0RdqTgcIuRPOeZJhn9lN+jZnDy4XtyEp/
   2jBLRNYP/zlAYDMC2W/wdgI3qv+lQsssFGnzG61YOEnbLrc0xJeBGsjak
   /5nh9pdbW4HF872z0HdOZ9oL651nc36cizXdZTTBZzcuNeXqsF/UsnOT2
   8/BL7WrLKEqDZZklbERAmgKJEYBe7cHqjwUvnx+5gUcPd7KuQlsU5x7Ux
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="380741891"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="380741891"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 03:00:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="990043201"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="990043201"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 03:00:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qfdiZ-008Hjf-0p;
        Mon, 11 Sep 2023 13:00:31 +0300
Date:   Mon, 11 Sep 2023 13:00:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4] gpio: sim: don't fiddle with GPIOLIB private members
Message-ID: <ZP7lPn5BfAJj+soP@smile.fi.intel.com>
References: <20230907082751.22996-1-brgl@bgdev.pl>
 <ZPnaoOUiYDR3yqGu@smile.fi.intel.com>
 <CAMRc=MfDOaRbgCH4OH8roLorRNYEscg1WhNFN_nDGyz9xRVWiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfDOaRbgCH4OH8roLorRNYEscg1WhNFN_nDGyz9xRVWiQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 02:39:28PM +0200, Bartosz Golaszewski wrote:
> On Thu, Sep 7, 2023 at 4:13 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Sep 07, 2023 at 10:27:51AM +0200, Bartosz Golaszewski wrote:

...

> > >  #include <linux/completion.h>
> > >  #include <linux/configfs.h>
> > >  #include <linux/device.h>
> >
> > > +#include <linux/device/bus.h>
> >
> > No need, the device.h guarantees that.
> 
> Wait, wasn't you the one who always suggests including headers
> directly if we're using any symbols defined in them? Like when I said
> that we don't need to include linux/notifier.h because it's already
> included in gpiolib.h and you argued the opposite? :)
> 
> device_match_fwnode() is defined in linux/device/bus.h so I thought
> it's in order to include it.

Yes, but I am not radical with it, I am for a compromise when some headers
guarantee to include some others. That is the case I believe, I don't think
device.h ever will be broken to the parts that are not include each other
(too many things to change right now, if it happens, not in the feasible
 future).

...

> > > +static int gpio_sim_dev_match_fwnode(struct device *dev, void *data)
> > > +{
> > > +     /*
> > > +      * We can't pass this directly to device_find_child() due to pointer
> > > +      * type mismatch.
> > > +      */
> >
> > Not sure if this comment adds any value.
> 
> I disagree - I would have used device_match_fwnode() as argument
> passed directly to device_find_child() but I cannot due to pointer
> type mismatch error so we need this wrapper and it's useful to say
> why.

Yes, and we have dozen(s ?) of the similar wrappers without a comment.
So, I'm still for removing it.

> > > +     return device_match_fwnode(dev, data);
> > > +}

-- 
With Best Regards,
Andy Shevchenko



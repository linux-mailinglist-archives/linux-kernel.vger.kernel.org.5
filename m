Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF58791438
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 11:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346667AbjIDI7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 04:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236003AbjIDI7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:59:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157D518C;
        Mon,  4 Sep 2023 01:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693817939; x=1725353939;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=W7fo/oErm2qTTpiwFnbFqLwIaJ6SfixvCi/d8bot2KQ=;
  b=XDLgGvSKKjNIurgWbOILdcDGKzWRemOp83ASvunv5S2qnpBgWm7th1im
   8z0AW8gQlusLWmr/BfDlkFQRP/WP7b69GOhip1XKVAaVM+AHQ8rB/f6La
   RkNNrnCNsxKFOXc2teGzVudoYSFBMPLqlwjTy735FU0T3Tm8L9NSKWBOo
   g1RU8AP1QdVDyEu/y08jAgcRmeawGoNMYj/Z8NWMZ+waxIXNIfxZbKQQm
   i+q9SPemd3Y8HQR+vRi9mSupgmxZrgcFbMGwlOF1h9JaurrMQX/bamzjn
   RDUW3YAqYKRvE7MgtXsTya/8QnjtSamMDmHcrtZov1rkf+y/uQSnb58Ja
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="379269245"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="379269245"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 01:58:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="740679273"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="740679273"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 01:58:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd5Q4-006NZP-2P;
        Mon, 04 Sep 2023 11:58:52 +0300
Date:   Mon, 4 Sep 2023 11:58:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpio: sim: don't fiddle with GPIOLIB private members
Message-ID: <ZPWcTMPiu4MSq+F7@smile.fi.intel.com>
References: <20230901183240.102701-1-brgl@bgdev.pl>
 <ZPJTT/l9fX1lhu6O@smile.fi.intel.com>
 <CAMRc=Mekf9Rek3_G2ttQY+yBvWM3+P4RAWVOQH99eajn38F+og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mekf9Rek3_G2ttQY+yBvWM3+P4RAWVOQH99eajn38F+og@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 02, 2023 at 04:40:05PM +0200, Bartosz Golaszewski wrote:
> On Fri, Sep 1, 2023 at 11:10 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Sep 01, 2023 at 08:32:40PM +0200, Bartosz Golaszewski wrote:

...

> > > -static void gpio_sim_free(struct gpio_chip *gc, unsigned int offset)
> >
> > Why is this?
> 
> Dunno, some git shenanigans?

Time to use --patience then?

...

> > > -     /* Used by sysfs and configfs callbacks. */
> > > -     dev_set_drvdata(&gc->gpiodev->dev, chip);
> > > +     /* Used by sysfs callbacks. */
> > > +     dev_set_drvdata(swnode->dev, chip);
> >
> > dev pointer of firmware node is solely for dev links. Is it the case here?
> > Seems to me you luckily abuse it.
> 
> I don't think so. If anything we have a helper in the form of
> get_dev_from_fwnode() but it takes reference to the device while we
> don't need it - we know it'll be there because we created it.
> 
> This information (struct device of the GPIO device) can also be
> retrieved by iterating over the device children of the top platform
> device and comparing their fwnodes against the one we got passed down
> from probe() but it's just so many extra steps.
> 
> Or we can have a getter in gpio/driver.h for that but I don't want to
> expose another interface is we can simply use the fwnode.

dev pointer in the fwnode strictly speaking is optional. No-one, except
its solely user, should rely on it (its presence and lifetime).

-- 
With Best Regards,
Andy Shevchenko



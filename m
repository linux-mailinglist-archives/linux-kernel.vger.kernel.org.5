Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3797914EB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 11:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239668AbjIDJki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 05:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjIDJkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 05:40:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546CEC6;
        Mon,  4 Sep 2023 02:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693820434; x=1725356434;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=WgwczCOjnM4FXQaxnMi4Y+wxLxnnv0gHRCBxrNvBIRE=;
  b=lSJA/zuJw6Wt+y52tR/i9NF7UMs7h0+M7Pyt8ucxrU6ya3r48kCw3L+N
   4HT+7bgxZClYQZFx6Rv6swUhYK9+azaIMxYjDdVBojRV++K+NuraHQuYT
   zju3vh6mUv5ldIbjjGSRB4lVNwM5MxVBE+Fg7EbH6bH8fe5H3v7TrUX3S
   lRRXmv0q8YmxknJ96ITIxlw6UF0ogP2zaX5G0OE1gO8dDJWjTM6JSOebd
   iFPzpyiXZ2zBy4DpmSDP6/nexFmBw8R7qCzg1My47gC64SS+lUASuzOwe
   ptmYlaXKj5Fpu7A8t2Dp3PbZG95lfC4FeHH0phxnf6VRuTqZxJeLJeF9D
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="375452558"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="375452558"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:40:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="855551387"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="855551387"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:40:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd64K-006O8v-2z;
        Mon, 04 Sep 2023 12:40:28 +0300
Date:   Mon, 4 Sep 2023 12:40:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Saravana Kannan <saravanak@google.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpio: sim: don't fiddle with GPIOLIB private members
Message-ID: <ZPWmDL6QJJMNi2qa@smile.fi.intel.com>
References: <20230901183240.102701-1-brgl@bgdev.pl>
 <ZPJTT/l9fX1lhu6O@smile.fi.intel.com>
 <CAMRc=Mekf9Rek3_G2ttQY+yBvWM3+P4RAWVOQH99eajn38F+og@mail.gmail.com>
 <ZPWcTMPiu4MSq+F7@smile.fi.intel.com>
 <CAMRc=MfZv70FXHyNw4yK90NL5-jjAJa6qbKc6SV2ZwbaJkKQqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfZv70FXHyNw4yK90NL5-jjAJa6qbKc6SV2ZwbaJkKQqg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 11:22:32AM +0200, Bartosz Golaszewski wrote:
> On Mon, Sep 4, 2023 at 10:59 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Sat, Sep 02, 2023 at 04:40:05PM +0200, Bartosz Golaszewski wrote:
> > > On Fri, Sep 1, 2023 at 11:10 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Fri, Sep 01, 2023 at 08:32:40PM +0200, Bartosz Golaszewski wrote:

...

> > > > > -     /* Used by sysfs and configfs callbacks. */
> > > > > -     dev_set_drvdata(&gc->gpiodev->dev, chip);
> > > > > +     /* Used by sysfs callbacks. */
> > > > > +     dev_set_drvdata(swnode->dev, chip);
> > > >
> > > > dev pointer of firmware node is solely for dev links. Is it the case here?
> > > > Seems to me you luckily abuse it.
> > >
> > > I don't think so. If anything we have a helper in the form of
> > > get_dev_from_fwnode() but it takes reference to the device while we
> > > don't need it - we know it'll be there because we created it.
> > >
> > > This information (struct device of the GPIO device) can also be
> > > retrieved by iterating over the device children of the top platform
> > > device and comparing their fwnodes against the one we got passed down
> > > from probe() but it's just so many extra steps.
> > >
> > > Or we can have a getter in gpio/driver.h for that but I don't want to
> > > expose another interface is we can simply use the fwnode.
> >
> > dev pointer in the fwnode strictly speaking is optional. No-one, except
> > its solely user, should rely on it (its presence and lifetime).
> 
> Where is this documented? Because just by a quick glance into
> drivers/base/core.c I can tell that if a device has an fwnode then
> fwnode->dev gets assigned when the device is created and cleared when
> it's removed (note: note even attached to driver, just
> created/removed). Seems like pretty reliable behavior to me.

Yes, and even that member in fwnode is a hack in my opinion. We should not mix
layers and the idea in the future to get rid of the fwnode_handle to be
_embedded_ into struct device. It should be separate entity, and device
instance may use it as a linked list. Currently we have a few problems because
of the this design mistake.

The get_dev_from_fwnode() is used only in devlink and I want to keep it that way.
Nobody else should use it, really.

We can discuss with Saravana, but I don't believe he can convince me otherwise.

-- 
With Best Regards,
Andy Shevchenko



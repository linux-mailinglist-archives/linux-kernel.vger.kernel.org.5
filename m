Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C05378FA4D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348577AbjIAI4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjIAIz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:55:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72AF10DE;
        Fri,  1 Sep 2023 01:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693558555; x=1725094555;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=piDcFnofZ/dBRLLeg12gMD809GNKD90RTH/xZXY/YsQ=;
  b=QqBhCuy1fE5z3APx1gAgr3JvSVotzt0+0QqhV9CkoxPebainMYSrVDAi
   R06bzkow+rQkVQ38h2IEUQxFfS70i1JyQYVfk/Y4O/GGQwrpNsyvOoypM
   Vko8IsRMpSwTP6Q65HuQkUyZoxRKAIiaQN00GCBs/oSO6Mv+EEQ/w6sZJ
   MznYNsyYNXYn0yeU8x2/hKB5x+flden7i3x1SZQq4qZr6J1bG23eS6qQm
   hnTsjsnRoKjBu5GmJ0QPN0wJW3MGpEtXKXL4nxaal4bRfJwhwqpW5gEK3
   IotXT1T97TbyifeZb5XxpELS99b9DTmfRllSQ7ewSYOXLZx5HIWWlQXRc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="440151594"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="440151594"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 01:55:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="1070669637"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="1070669637"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 01:55:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qbzwS-005cse-36;
        Fri, 01 Sep 2023 11:55:48 +0300
Date:   Fri, 1 Sep 2023 11:55:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFT PATCH] spi: bcm2835: reduce the abuse of the GPIO API
Message-ID: <ZPGnFHgtK1wE6Ppf@smile.fi.intel.com>
References: <20230831194934.19628-1-brgl@bgdev.pl>
 <ZPEhS0uBWABpaE+/@smile.fi.intel.com>
 <CAMRc=Md-6i+nqDtYiUUtZExA32c0nJxhevYsiZqmd1PP8aaMng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Md-6i+nqDtYiUUtZExA32c0nJxhevYsiZqmd1PP8aaMng@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 09:40:11AM +0200, Bartosz Golaszewski wrote:
> On Fri, Sep 1, 2023 at 1:25 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Thu, Aug 31, 2023 at 09:49:34PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Currently the bcm2835 SPI driver uses functions meant for GPIO providers
> > > exclusively to locate the GPIO chip it gets its CS pins from and request
> > > the relevant pin. I don't know the background and what bug forced this.

...

> > >       /*
> > > +      * TODO: The code below is a slightly better alternative to the utter
> > > +      * abuse of the GPIO API that I found here before. It creates a
> > > +      * temporary lookup table, assigns it to the SPI device, gets the GPIO
> > > +      * descriptor and then releases the lookup table.
> > >        *
> > > +      * Still the real problem is unsolved. Looks like the cs_gpiods table
> > > +      * is not assigned correctly from DT?
> > >        */
> >
> > I'm not sure why this quirk is here. AFAIR the SPI CS quirks are located in
> > gpiolib-of.c.
> >
> 
> I'm not sure this is a good candidate for the GPIOLIB quirks. This is
> the SPI setup callback (which makes me think - I should have used
> gpiod_get(), not devm_gpiod_get() and then put the descriptor in
> .cleanup()) and not probe. It would be great to get some background on
> why this is even needed in the first place. The only reason I see is
> booting the driver with an invalid device-tree that doesn't assign the
> GPIO to the SPI controller.

Maybe Lukas knows more?

-- 
With Best Regards,
Andy Shevchenko



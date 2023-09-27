Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0417B05B9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 15:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjI0Nq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 09:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjI0Nqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:46:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A52121;
        Wed, 27 Sep 2023 06:46:53 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="412740175"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="412740175"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 06:46:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="752601458"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="752601458"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 06:46:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andy@kernel.org>)
        id 1qlUsH-00000000ttl-0fli;
        Wed, 27 Sep 2023 16:46:45 +0300
Date:   Wed, 27 Sep 2023 16:46:44 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH RFC v2 3/6] ARM: pxa: Convert Spitz CF power control to
 GPIO descriptors
Message-ID: <ZRQyREMrfCaDMnI0@smile.fi.intel.com>
References: <20230926-pxa-gpio-v2-0-984464d165dd@skole.hr>
 <20230926-pxa-gpio-v2-3-984464d165dd@skole.hr>
 <ZRMDqVCtrUyhcqaw@smile.fi.intel.com>
 <5984688.lOV4Wx5bFT@radijator>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5984688.lOV4Wx5bFT@radijator>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 02:56:07PM +0200, Duje Mihanović wrote:
> On Tuesday, September 26, 2023 6:15:37 PM CEST Andy Shevchenko wrote:
> > On Tue, Sep 26, 2023 at 05:46:24PM +0200, Duje Mihanović wrote:

...

> > > +	cf_power = gpiod_get(&pxa_device_mci.dev, "cf_power", GPIOD_ASIS);
> > > +	if (IS_ERR(cf_power)) {
> > > +		dev_err(&pxa_device_mci.dev,
> > > +				"failed to get power control GPIO with 
> %ld\n",
> > > +				PTR_ERR(cf_power));
> > > +		return;
> > > +	}
> > > 
> > > +	gpiod_put(cf_power);
> > 
> > Don't you want to use guarded gpiod_get()?
> > Okay, it seems not yet in the pending list, but we can survive without that.
> 
> Can you please elaborate? If I understand correctly, the if statement right 
> after gpiod_get is a guard.

It's about RAII version of the gpiod_get(). It's quite a new thing
in the Linux kernel.

-- 
With Best Regards,
Andy Shevchenko



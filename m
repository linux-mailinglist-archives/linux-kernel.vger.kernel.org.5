Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C33A79140F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 10:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240971AbjIDIzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 04:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjIDIzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:55:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E85131;
        Mon,  4 Sep 2023 01:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693817748; x=1725353748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Bjr8VKvgs/rVspRwakQ9zo2f6fkmmFaw7ymumH5rC6w=;
  b=JF7szY1Gx76t3KxnnSO3qTWH4kSiLltz21zN8HiLWfWLqTkrdbA3zONb
   +0NBc4cge3G3V5lv/VSKx7P8WKhvy3yhUpyDc6toQBC9Ni9B0dC14d6rF
   SexkVsrUze4wepshyz0yICkweVWu2dOaGzytdhgvbhuB0twF5gKE1fCsx
   O8OTdMBvNQ+X5Xw1PLynWjBVNUO7a63E7nNVXRAJGdpIDnJRwATkSPHd7
   TQJUkabzt5E6WezHiPP7f5Op2LrCAZYzWM658I3MK1cbn6dcdNSLGbf+9
   orlezqKTRIUbTl15f1gtvNt7co8hHvuLxrWs+VY7/0tB6FfNPuUuwupox
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="462920560"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="462920560"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 01:55:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="769913289"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="769913289"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 01:55:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd5My-006NXI-0v;
        Mon, 04 Sep 2023 11:55:40 +0300
Date:   Mon, 4 Sep 2023 11:55:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [RFT PATCH v2] spi: bcm2835: reduce the abuse of the GPIO API
Message-ID: <ZPWbi3caxQWbn2Wr@smile.fi.intel.com>
References: <20230901111548.12733-1-brgl@bgdev.pl>
 <CACRpkdYLcOZQ9r46aBwesh-H392C_0AWC8n2ikuwUknfEhoNNA@mail.gmail.com>
 <ba9803e9-3aff-42b9-87ad-4e6d75d36d87@sirena.org.uk>
 <CACRpkdaDG30k_OM_xTCM6yOTB3rjzxrsbbrLZpvYCh7e66Zt7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdaDG30k_OM_xTCM6yOTB3rjzxrsbbrLZpvYCh7e66Zt7g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 02, 2023 at 06:56:51PM +0200, Linus Walleij wrote:
> On Fri, Sep 1, 2023 at 2:31 PM Mark Brown <broonie@kernel.org> wrote:
> 
> > > > +       struct gpiod_lookup_table *lookup __free(kfree) = NULL;
> >
> > > Whoa!
> > > This is really neat.
> > > As noted, it will confuse static checkers at no end, but they just have
> > > to adopt. (CC to Dan C if he now runs into this.)
> >
> > It also doesn't look amazing for humans, it's very not C like...
> 
> <linux/cleanup.h> and the __free() macro was introduced by Peter
> Z who also very famously suggested (OTOMH!) that instead of
> adopting Rust to the kernel it would be possible to bring the
> desired Rust features into C.

Competition is always good :-)

> Which is what he does, well the feature has been there for a while
> but he identified it and made it easily accessible.
> 
> Now if this path is desirable ... yeah. Maybe a matter of taste.

-- 
With Best Regards,
Andy Shevchenko



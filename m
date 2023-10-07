Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640277BC5A5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343693AbjJGHj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343611AbjJGHj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:39:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B36DBD;
        Sat,  7 Oct 2023 00:39:55 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="448101647"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="448101647"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 00:39:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="729118298"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="729118298"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 00:39:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andy@kernel.org>)
        id 1qp1ug-00000003Xq6-18l2;
        Sat, 07 Oct 2023 10:39:50 +0300
Date:   Sat, 7 Oct 2023 10:39:50 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dipen Patel <dipenp@nvidia.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFC/RFT PATCH] gpiolib: reverse-assign the fwnode to struct
 gpio_chip
Message-ID: <ZSELRvVk3G1y258L@smile.fi.intel.com>
References: <20231006115147.18559-1-brgl@bgdev.pl>
 <ZSAKdOXpo+xOI3sJ@smile.fi.intel.com>
 <CAMRc=MeYiiWaaqRtSjRBfaWGFtZCPWCjYk+ZrX5TwicNq9MQeA@mail.gmail.com>
 <CACRpkdaqPm9471q7Sg-cxcLTTE63=NuKuSUFiFtPsaUoRiB3jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdaqPm9471q7Sg-cxcLTTE63=NuKuSUFiFtPsaUoRiB3jA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 12:22:01AM +0200, Linus Walleij wrote:
> On Fri, Oct 6, 2023 at 9:08 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > I don't see any good reason for it not having the fwnode assigned.

> > User calling gpio_device_find() will have to jump through hoops in
> > order to match the device by fwnode
> 
> Yeah I would add
> 
> struct fwnode_handle *gpiochip_get_fwnode(struct gpio_chip *gc)
> {
>    return dev_fwnode(&gc->gpiodev->dev);
> }
> 
> so it's easy for external users to get the fwnode if they really need it.
> This and a few more changes and we can drop gc->fwnode altogether
> can't we?

This would work, but the problem here is to understand which fwnode
(semantically) the caller wants to use.

One is the GPIO device's, and the other is what provider explicitly assigned.
Currently the latter case is transparent in a sense that GPIO device will get
the same fwnode as GPIO chip submitted by the provider.

Internally GPIOLIB must use GPIO device fwnode and rely only on it.
Externally it depends. Basically it's provider's business to know if it
is safe to use gc->fwnode or not and when.

-- 
With Best Regards,
Andy Shevchenko



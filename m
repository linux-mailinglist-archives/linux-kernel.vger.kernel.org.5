Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557F8777BF9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbjHJPTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjHJPTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:19:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF2226B5;
        Thu, 10 Aug 2023 08:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691680762; x=1723216762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x6k1erl4t9tWXDGkDpu6EtDpKNzUku2CvqW/FmS6BLI=;
  b=eG74oiJLBWk9HFhPxFIiptg5V4C90mKwAs/+4jG9P35rWEw46Il4JlJ4
   6YhNw5xLmNxLMW9HgWQC3K/o/ooFGgZaU8263VjlQZWocnehp8GvvXY6G
   rr1p7GVvdLJg4ef50zSNV8tSleYUza90b6pnaUjtP0WoeDBio9+KODfBE
   uoit6wTBELaaO91OcKuRdlXivQ/RMELwZFXYgYNMSwJ0+3cC4mv+tobC2
   7jk/0jytpLM4HM+VS6LlsmtLeg7STdyHflgD15/1k6GOqND0bYl78Ff5R
   QV2fJ0oA7A+Wj6SCdHUgyQzoJg9w9LXW+tevErXlGRmsiu8F5q7nPB3HC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="437775476"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="437775476"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 08:19:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="906102440"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="906102440"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 10 Aug 2023 08:19:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qU7RV-006Ysq-2m;
        Thu, 10 Aug 2023 18:19:17 +0300
Date:   Thu, 10 Aug 2023 18:19:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpiolib: fix reference leaks when removing GPIO chips
 still in use
Message-ID: <ZNT/9WqW4c0FwVlw@smile.fi.intel.com>
References: <20230810100335.9330-1-brgl@bgdev.pl>
 <ZNT/hvkZswZsZUFU@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNT/hvkZswZsZUFU@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 06:17:26PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 10, 2023 at 12:03:34PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

...

> >  void gpiod_free(struct gpio_desc *desc)
> >  {
> > -	if (desc && desc->gdev && gpiod_free_commit(desc)) {
> > -		module_put(desc->gdev->owner);
> > -		gpio_device_put(desc->gdev);
> > -	} else {
> > +	if (!desc)
> > +		return;

> 	VALIDATE_DESC_VOID() ?

If it is not possible to use, the comment should be added, like we have in
gpiod_to_irq().

> > +	if (!gpiod_free_commit(desc))
> >  		WARN_ON(extra_checks);
> > -	}
> > +
> > +	gpio_device_put(desc->gdev);
> > +	module_put(desc->gdev->owner);
> >  }

-- 
With Best Regards,
Andy Shevchenko



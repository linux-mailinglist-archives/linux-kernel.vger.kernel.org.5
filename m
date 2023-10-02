Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049E97B4EA8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbjJBJFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbjJBJFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:05:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C5C91;
        Mon,  2 Oct 2023 02:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696237519; x=1727773519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kfqKs+0cNmvI19UU8b/Nv0Di7NOKQZPlZ3XU9/IVcM4=;
  b=XZUVAB5QEREZh8zhcUF6aAhlg0eA0fIy4VDXR3ALwBmCGuNiLvABswDS
   pngHX6mQZgTibNLveAIvvAYKI0l/w4FLO+re487AD8koNM3XhuD6uf12D
   VAvT5UN+uyhovkh43jj+7+ExvNl8USruHwQ6jw4qdiBxuxxM7/F9DcP05
   RY+KWswMxkJBtnX2FN1Q99+bNcaABrJTUDq0gMpvoUPHmmAXU32dZECEH
   t4g/EWY2s9DuqS9RaJu3wc06Xs20I+txmxoQgtD2ZXnZ1zIIhSvwU7afE
   eUVEZRZAH/zcoAcGJO1g6r80otf8in4pnKsTgJT6ZueGa+UsLyfy8rm0E
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="386478982"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; 
   d="scan'208";a="386478982"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:05:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="700282974"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; 
   d="scan'208";a="700282974"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:05:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qnErX-0000000279P-3dcG;
        Mon, 02 Oct 2023 12:05:11 +0300
Date:   Mon, 2 Oct 2023 12:05:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Yury Norov <yury.norov@gmail.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH v1 5/5] gpiolib: cdev: Utilize more bitmap APIs
Message-ID: <ZRqHx+Ihcxor2Jz4@smile.fi.intel.com>
References: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
 <20230926052007.3917389-6-andriy.shevchenko@linux.intel.com>
 <ZROGG44v5kfktdVs@sol>
 <ZRQdQnL5VbX659cl@smile.fi.intel.com>
 <ZRQy795YoPOKsOcz@sol>
 <ZRQ1RpHEapodQ0xU@smile.fi.intel.com>
 <ZRQ60KBtY09uPxp6@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRQ60KBtY09uPxp6@sol>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 10:23:12PM +0800, Kent Gibson wrote:
> On Wed, Sep 27, 2023 at 04:59:34PM +0300, Andy Shevchenko wrote:
> > On Wed, Sep 27, 2023 at 09:49:35PM +0800, Kent Gibson wrote:
> > > On Wed, Sep 27, 2023 at 03:17:06PM +0300, Andy Shevchenko wrote:
> > > > On Wed, Sep 27, 2023 at 09:32:11AM +0800, Kent Gibson wrote:

...

> > > > Yet, it opens a way to scale this in case we might have v3 ABI that let's say
> > > > allows to work with 512 GPIOs at a time. With your code it will be much harder
> > > > to achieve and see what you wrote about maintenance (in that case).
> > > 
> > > v3 ABI?? libgpiod v2 is barely out the door!
> > > Do you have any cases where 64 lines per request is limiting?
> > 
> > IIRC it was SO question where the OP asks exactly about breaking the 64 lines
> > limitation in the current ABI.
> > 
> > > If that sort of speculation isn't premature optimisation then I don't know
> > > what is.
> > 
> > No, based on the real question / discussion, just have no link at hand.
> > But it's quite a niche, I can agree.
> 
> Let me know if you find a ref to that discussion - I'm curious.

Here it is (read comments as well):
https://stackoverflow.com/questions/76307370/control-gpio-from-linux-userspace-with-linux-gpio-h

-- 
With Best Regards,
Andy Shevchenko



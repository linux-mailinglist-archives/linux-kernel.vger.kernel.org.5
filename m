Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA715780C89
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377141AbjHRNaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377173AbjHRN3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:29:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7256FE74;
        Fri, 18 Aug 2023 06:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692365391; x=1723901391;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LwcdNDrZAXt7Dh6y7ICk95eGvcN8eDNINGcjD84ZHxs=;
  b=QG3gy5/QPkcYw4GxnvbaF/zH7Uq8/x3fZCuk4nDvyDRtHvRC0HuC5rTV
   pRcjU/2XL5pDWqJz25Y3m7Xn9P6noiwawIXy0YNGkqJvNyfVacbi6vnD2
   VYfCfLIULggjFD9aJX+o2sqPtZMqncqp2hFJymOW1cE38/ch80YphvZiR
   /StQ+DdW8/139Fybzq7loMI20if43b/zUmGvlZXFVPZw7fFjM7Xf3Wp3t
   lvIoE2e5+gbE9dlqA+TvSItdq8KaoKLpfiiQCzf/HTysDmD5n5flhHHhW
   /taEYf0WTl17jjlvTl/z8z8uIa7DdIQZXokEm8g2vGqVlfklEiz/BROhh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="375880679"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="375880679"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 06:29:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="981657929"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="981657929"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 18 Aug 2023 06:29:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWzXv-009qyX-0r;
        Fri, 18 Aug 2023 16:29:47 +0300
Date:   Fri, 18 Aug 2023 16:29:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 0/6] gpio: cdev: bail out of poll() if the device goes
 down
Message-ID: <ZN9ySmxxdoLODcc9@smile.fi.intel.com>
References: <20230817184958.25349-1-brgl@bgdev.pl>
 <ZN9JID53QpSz4epI@smile.fi.intel.com>
 <CAMRc=MfZ=GgcqKkDXkUgWC-bdCJECs0HfjRe9Ffy-Metwz6fFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfZ=GgcqKkDXkUgWC-bdCJECs0HfjRe9Ffy-Metwz6fFQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 02:06:21PM +0200, Bartosz Golaszewski wrote:
> On Fri, Aug 18, 2023 at 12:34 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Thu, Aug 17, 2023 at 08:49:52PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Wake up all three wake queues (the one associated with the character
> > > device file, the one for V1 line events and the V2 line request one)
> > > when the underlying GPIO device is unregistered. This way we won't get
> > > stuck in poll() after the chip is gone as user-space will be forced to
> > > go back into a new system call and will see that gdev->chip is NULL.
> >
> > Why can't you use the global device unbind notifications and filter out
> > what you are interested in?
> 
> There's no truly global device unbind notification - only per-bus.
> GPIO devices can reside on any bus, there are no limitations and so
> we'd have to subscribe to all of them.

We have, but it requires a bit of code patching.
Look at device_platform_notify()/device_platform_notify_remove().

I noticed, btw, that platform_notify() and Co is a dead code :-)
Maybe it can be converted to a list and a manager of that list,
so specific cases can utilize it.

-- 
With Best Regards,
Andy Shevchenko



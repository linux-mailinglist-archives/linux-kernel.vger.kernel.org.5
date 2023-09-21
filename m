Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D5A7AA0D3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjIUUsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjIUUs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:48:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73E790F13;
        Thu, 21 Sep 2023 10:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318443; x=1726854443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/bI3SZUJj1sK0d5AIlLR9Jsr77qgx3aGIqY4S44vdwo=;
  b=h8Bbgud3rW/qm7NMi6jEenNM+SfAs/0mP51HHTd9w9dWZdz/iC9Nhtdw
   Nv/OjvRoh44ez1znxThFfde5bs0yQJdH6bjOE5h+qhNTw8rDtCxqU/J5L
   2DybNjQWlcxx3aKswvWIWGuGWfZFMfNqXOOFiwuBYqGciHs8Meuhxhn8G
   DoVb+Nl7gLBqoDUMTOOwgnZNwLu0NA+ZIIMrSVpot8NU6ncis2tqwwqdE
   GVh6LE63qKxJO8GETQnewy9PZF+Z57CwooptgfluvfEZoiPKOcbuns9ic
   Y6b3fnxXl1eO1+Cw/uEUdR7+esdtlSrlk64I9lOBmx9WwqHfcZFABh0NE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="377764188"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="377764188"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 02:45:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="994014933"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="994014933"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 02:45:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qjGF2-0000000GqzG-1y2X;
        Thu, 21 Sep 2023 12:45:00 +0300
Date:   Thu, 21 Sep 2023 12:45:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v5] gpio: sim: fix an invalid __free() usage
Message-ID: <ZQwQnA/W1TZDJivM@smile.fi.intel.com>
References: <20230920073253.51742-1-brgl@bgdev.pl>
 <ZQr3E/7crMrVxMp9@smile.fi.intel.com>
 <CAMRc=MfvOL-ovQ89i7FASg=RoWHQPARGsc5Pxu9kC+roGqaE4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MfvOL-ovQ89i7FASg=RoWHQPARGsc5Pxu9kC+roGqaE4g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 01:12:16AM -0700, Bartosz Golaszewski wrote:
> On Wed, 20 Sep 2023 15:43:47 +0200, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> said:
> > On Wed, Sep 20, 2023 at 09:32:53AM +0200, Bartosz Golaszewski wrote:

...

> > As for the material to be backported it's fine, but I'm wondering if we
> > actually can add the entries in a sorted manner, so we would need the exact
> > what I mentioned in previous review round, just search backwards to the first
> > satisfying entry. I don't believe the adding an entry to the list is a
> > hot-path, so would be fine to call list_sort().
> 
> Given the need for the callback function, this would result in bigger code.

Is it a problem?

On the below I kinda agree.

> Also calling:
> 
>     list_add_tail();
>     list_sort();
> 
> is not very elegant. I would possibly go for adding list_add_sorted() but
> that's a separate change for the future.

Note, we do this for the GPIO bases already.

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E25784638
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237373AbjHVPuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237356AbjHVPuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:50:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B1EE42;
        Tue, 22 Aug 2023 08:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692719402; x=1724255402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FJkJ4AcD733wKA/TC0jO2qVk5wEySRr7m0nT1f3mBfA=;
  b=POv1vMDI6Dm/70OZus0+Nj5qPYvXB4OoDX22Fkcqc2Nl+okNKzn7UpyD
   PUOP4FTzAg8y7HobbfwpS6F4/DzWyrTUbMjJIPUnaqwM999l5wjx6Kgdz
   HknofpTvXa2oXGqx/8VRfskR5r/EQsXG1M9ngcTxvgXVjt4fJsizOu/8Q
   X8K0gq4w3IziA30kQXkzWuE8QigljfTh74f6toUbzeGEmQQZ2s5iboIHV
   Zbrp+x6qrzPoQpyNmTmlmY8+BHTpZl90dUcRlLC00e/8j4V+VYR4UIEod
   4os7ORrjmwBmgt2G8ZyCooJlW/zS5ocDq8YY9+S/MWm4l7vkFwhYlpuVQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="376658426"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="376658426"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 08:49:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="771393764"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="771393764"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 22 Aug 2023 08:49:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qYTdf-00H1kv-0A;
        Tue, 22 Aug 2023 18:49:51 +0300
Date:   Tue, 22 Aug 2023 18:49:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] HID: cp2112: make the irqchip immutable
Message-ID: <ZOTZHn1BzO6oZYOH@smile.fi.intel.com>
References: <20230822152244.214394-1-brgl@bgdev.pl>
 <ZOTUHzKKBNcjQLRi@smile.fi.intel.com>
 <CAMRc=MdWbQPuNh=ziyqD_xVaXDD3nE5yNeq1+d4F_P4_3H=xxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdWbQPuNh=ziyqD_xVaXDD3nE5yNeq1+d4F_P4_3H=xxQ@mail.gmail.com>
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

On Tue, Aug 22, 2023 at 05:38:45PM +0200, Bartosz Golaszewski wrote:
> On Tue, Aug 22, 2023 at 5:28 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Aug 22, 2023 at 05:22:44PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > This make the GPIO irqchip exposed by the CP2112 driver use an immutable
> > > irq_chip struct thus addressing the following warning on probe:
> > >
> > >   (cp2112_gpio): not an immutable chip, please consider fixing it!
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?h=for-next&id=3e2977c425ad2789ca18084fff913cceacae75a2
> >
> > Can you test HID for-next for this hardware?
> 
> Ah you beat me to it. I didn't see this one.

Now looking at it, I don't understand why I added a call to IRQ shutdown
callback... (Looks like it slipped from experimental patch.) If you can
test this, would be nice.

-- 
With Best Regards,
Andy Shevchenko



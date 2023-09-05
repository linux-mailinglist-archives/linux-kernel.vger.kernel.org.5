Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FD27925EA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239318AbjIEQHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354509AbjIEMJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:09:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8E71AD;
        Tue,  5 Sep 2023 05:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693915741; x=1725451741;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fAfBubslgSKdBchRfYMZIybytubhIFTDeB4uboA6cZ8=;
  b=iAEMDCGcT1UTrxAYeygbrXwyj9bob7OTF5N4oFzHRdt1Qp8SJnhn1ziY
   bSW2IAg74lwnFK8tOrSLxqbVh8vOL4oUt+YdU9yWiXOq40lMDwZeUzjoq
   jkT6GT6hjgaulUbKm051FbnA42IMb9PG8wjrvsA05ZjXRA9YdhJ+yhw+H
   2hR3gcXPsrjaBnD+njDk1cmNWBaHpR3JKOXl8hwICzQYl4hmCv1zia1f4
   ZRTz2NAIpKJ8netRYVbp77ZLXOE0fquZMuXBYKoTzR+NeH1WwHZhq2Z7q
   HVAmptAIyBhnFEEHZ4z2grNyN6UBPxANM7zZjdAtKzKEv6zzkQ9WBcvU6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="376701442"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="376701442"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 05:09:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="690911411"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="690911411"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 05:08:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qdUrW-006g85-2w;
        Tue, 05 Sep 2023 15:08:54 +0300
Date:   Tue, 5 Sep 2023 15:08:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3] gpio: sim: don't fiddle with GPIOLIB private members
Message-ID: <ZPcaVjOudGeLd5EP@smile.fi.intel.com>
References: <20230905082413.21954-1-brgl@bgdev.pl>
 <ZPcZfd5UtzMmIUvm@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPcZfd5UtzMmIUvm@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 03:05:17PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 05, 2023 at 10:24:13AM +0200, Bartosz Golaszewski wrote:

...

> > +	chip->swnode = swnode;
> > +	ret = device_for_each_child(dev, chip, gpio_sim_chip_set_device);
> > +	if (!ret)
> > +		return -ENODEV;
> 
> Can bus_find_device_by_fwnode() be used here?

Answering to myself: you already mentioned that this should cover any bus,
so the answer is "no".

But also we have device_find_child() if I understood the purpose of the above
it should suit better, no?

-- 
With Best Regards,
Andy Shevchenko



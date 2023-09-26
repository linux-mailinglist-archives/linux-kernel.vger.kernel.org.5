Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B4F7AF039
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbjIZQGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjIZQGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:06:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADDFFB;
        Tue, 26 Sep 2023 09:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695744363; x=1727280363;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1d47nvRusVKBELm9EbFnAsqAr8P3Sbsc2oZYIgRvtgk=;
  b=Dk/QzbfUTV1+9t+sR6W7F+IkDajqZ9htHStn2+4ZgTk+JQATwFMiqyul
   9lBqP7o/yg03klJA+F9dhv7+nWq61Ux/BqUeRpySTaOhFHX88Z6IA6J9/
   N1YhbvFLj82Q27bEcxQKrTz34mBUsU42MKeuuA5Ruuiqq5kOGgPUDbv2E
   AK8x9jZ87YTxtDesE0PukSkZBJLT8FnaVmENxrk4Z/HxCKekjfVer+iA/
   yRiZDlatQzqFcMyx6aYdCZbFB1sebbqpxr5uPtHOLq8gaa9sqDqcdGkdb
   QGek6JjBjCUdfbBDAB2+n5iIo+XZoTYzZ/FJlQ6DFV2Z6XNgCNTHiyhcA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="378880240"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="378880240"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:05:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="1079753902"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="1079753902"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:05:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qlAZ0-00000000eps-1VMc;
        Tue, 26 Sep 2023 19:05:30 +0300
Date:   Tue, 26 Sep 2023 19:05:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Raag Jadav <raag.jadav@intel.com>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Simplify code with cleanup helpers
Message-ID: <ZRMBSgQSotMgQ8hd@smile.fi.intel.com>
References: <20230926132336.416612-1-andriy.shevchenko@linux.intel.com>
 <20230926153729.GW3208943@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926153729.GW3208943@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 06:37:29PM +0300, Mika Westerberg wrote:
> On Tue, Sep 26, 2023 at 04:23:35PM +0300, Andy Shevchenko wrote:
> > Use macros defined in linux/cleanup.h to automate resource lifetime
> > control in the driver.
> > 
> > While at it, unify the variables and approach in intel_gpio_irq_*().
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



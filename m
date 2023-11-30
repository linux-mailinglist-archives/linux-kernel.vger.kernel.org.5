Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A400A7FF056
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345613AbjK3NjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345563AbjK3NjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:39:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D871C4;
        Thu, 30 Nov 2023 05:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701351549; x=1732887549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+riVxxL383e97L0xvu8Uk6PzvwJHF7/f5CdAalVYZZw=;
  b=EEFvppcZCRcfqfaHG8xFqIHxxPIpRhuNkPfr8tteSuX5iUAWb5yVcZPW
   eWZU1+IE0AOWAXeU7F9DNmfIb/+YpPeG7UEM5mvQ5MOFVOvaSRAxl15gg
   mO/Llq9+DdUamGE6+VDslyU5OgqlDXF3xz8hFbDfFKzgFi40UlqKjBcjs
   kE6OnY2MsjpavMc4VCOaKA1sFdbgz4563S3NCNNQ0PKQ5L3fr4pZ9ctKw
   5PzrsajqLiOiQjv2keYTLhEHZ0JFieGS8HLbMRmvt5/H56Xv4W8RuRSzi
   SstOHTzTwC/z0yVT/ptLTmsJXAgZNf0x701kIocuABeIHS0xi2Z27tLjz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="372703553"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="372703553"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 05:39:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="942719145"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="942719145"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 05:39:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r8hFw-00000000i1T-1BrU;
        Thu, 30 Nov 2023 15:39:04 +0200
Date:   Thu, 30 Nov 2023 15:39:04 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpio: sim: implement the dbg_show() callback
Message-ID: <ZWiQeKZ8jMgl4W5q@smile.fi.intel.com>
References: <20231130104023.11885-1-brgl@bgdev.pl>
 <ZWiQLEz6P3vbZgx0@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWiQLEz6P3vbZgx0@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 03:37:48PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 30, 2023 at 11:40:23AM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

...

> > +#else
> > +#define gpio_sim_dbg_show NULL
> > +#endif /* CONFIG_DEBUG_FS */
> 
> I;m wondering if you can use PTR_IF() instead of this ugly ifdeffery.

If brave enough, you can even propose a new macro like

#define debugfs_ptr(ptr) ...

(see pm_sleep_ptr() / pm_ptr() as examples).

-- 
With Best Regards,
Andy Shevchenko



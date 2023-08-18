Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0600780A0B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359486AbjHRK31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359520AbjHRK3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:29:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87C012C;
        Fri, 18 Aug 2023 03:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692354544; x=1723890544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rlQaQCIqu5oJXVa89w+WCcXX20kESMPRP8hHfsmDbI4=;
  b=dbHS7XT6PlO/MBS0WB/P2b8BWrOuqG87YKBuCEr8YpSOxRdYaZxs6K7B
   6jceuP3LlFx5LMuf9Tgwo6A9BzU2tjSsHOOZG1JdLsGpC/YgC01gragO6
   tWGeqb0enOrbeChI1d6z8jR4LlfcHj5TNPFSir+WBiDxUSrtToILp37aP
   fUyNtCgwln9qTNjo9xnYieck2Efw2FnsPBGqFVTnF0Jwk5awCAZLPyyHW
   EwczcNQRUGahkikhUOda7r7MdaaTeXLgOkHNHFFKi3u343hRZF3/z/K9q
   izVd14z3EpsMC61qc5ve6i5ojq9oD8n+8qcMIpNuZCo/PNQ0crbDuox+A
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="370529073"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="370529073"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 03:29:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="735049926"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="735049926"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 18 Aug 2023 03:28:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWwis-003hzY-36;
        Fri, 18 Aug 2023 13:28:54 +0300
Date:   Fri, 18 Aug 2023 13:28:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 2/6] gpio: cdev: open-code to_gpio_chardev_data()
Message-ID: <ZN9H5jVjMSDfhCXz@smile.fi.intel.com>
References: <20230817184958.25349-1-brgl@bgdev.pl>
 <20230817184958.25349-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817184958.25349-3-brgl@bgdev.pl>
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

On Thu, Aug 17, 2023 at 08:49:54PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> This function is a wrapper around container_of(). It's used only once and
> we will have a second notifier soon, so instead of having two flavors of
> this helper, let's just open-code where needed.

...

> +	struct gpio_chardev_data *cdev = container_of(nb,
> +						      struct gpio_chardev_data,
> +						      lineinfo_changed_nb);

This way it's slightly better.

	struct gpio_chardev_data *cdev =
		container_of(nb, struct gpio_chardev_data, lineinfo_changed_nb);

-- 
With Best Regards,
Andy Shevchenko



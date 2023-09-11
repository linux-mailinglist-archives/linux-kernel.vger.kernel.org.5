Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA50279B124
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359798AbjIKWSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237495AbjIKMyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:54:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590ECCEB;
        Mon, 11 Sep 2023 05:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694436838; x=1725972838;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6qH+94mdCDHsO5dlQVDj6sE7FIc2PGyqepOUsYk3jaI=;
  b=cDMIJrjiS/3ntGlgPbOZeTvsCgrSc3hGw1O61wGWphXdOL3M2QO6IZuf
   nj0bK+c3WIrhnID4+mK97qipg/Q/z7RJVKrJmdQvdKk2lyx4aLkcWRK1+
   UqmEKddsXSiyQBVM6u7/pIAU4Jk23nogRXqAyP4mfeHJnrYeEksCAmDsF
   zuJgaaGd1emxnYKEvWGG+0fGDqF0MtaXpIbQF9MAHyde4FtkqGwbzJDQR
   RGWi7r+uim41BNzlmuz5J2+AXKjjwBz7j/SuEJ0qU9ZDPE1OM7cdjkM4m
   +kF/ZVdgco36H3a/0445aA97tOQGJ2betiojmgPZ/kE0bQhXonlBghctG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="444490143"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="444490143"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:53:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="743336362"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="743336362"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:53:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qfgQL-008KU3-05;
        Mon, 11 Sep 2023 15:53:53 +0300
Date:   Mon, 11 Sep 2023 15:53:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v5] gpio: sim: don't fiddle with GPIOLIB private members
Message-ID: <ZP8N4M6cqyP9rS3W@smile.fi.intel.com>
References: <20230911110740.16284-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911110740.16284-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 01:07:40PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We access internals of struct gpio_device and struct gpio_desc because
> it's easier but it can actually be avoided and we're working towards a
> better encapsulation of GPIO data structures across the kernel so let's
> start at home.
> 
> Instead of checking gpio_desc flags, let's just track the requests of
> GPIOs in the driver. We also already store the information about
> direction of simulated lines.
> 
> For kobjects needed by sysfs callbacks: we can iterate over the children
> devices of the top-level platform device and compare their fwnodes
> against the one passed to the init function from probe.
> 
> While at it: fix one line break and remove the untrue part about
> configfs callbacks using dev_get_drvdata() from a comment.

(Just wondering if you used --patience)

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



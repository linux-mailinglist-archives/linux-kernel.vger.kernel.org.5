Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA7477898A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbjHKJO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjHKJO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:14:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AF5211C;
        Fri, 11 Aug 2023 02:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691745297; x=1723281297;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B0PTp68QBaHEMGjETTEG/Ui5ge9x1geBW0y6XBpBgCs=;
  b=ff0+U0yPxq/q8XIjLzZFPzNxL5Z36Xc7D8CoISkoCecf4JDj6kfvD+x/
   D1fN6AmvJ47YyqnoLS7wtfEbXALn0J+wmuxA3dJa+x0fsJFpFEGF5sQ6r
   rZyUOHC+oolbDNooIDqDTm0wQMN3Y01byu7+xXdbR5wfqMP4Rf+VTnYXm
   Lo9l1gvny4TWYTt0A19nLXahX1pMRnmGA6Q1smrKgNxa0k2J48inezf8c
   AdtoiHQS/3l5uzNK+kFCgcaLcJ8mA8VhXk2NdUA9p3Lq/GCAUXtQfl6a4
   j1C24e6yT2i98j7UYAcQTgmI8i3eKQd3majOJoNU+H5HkRLsY8d+bM1HR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="369106397"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="369106397"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 02:14:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="802601945"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="802601945"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2023 02:14:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qUOEO-00852W-25;
        Fri, 11 Aug 2023 12:14:52 +0300
Date:   Fri, 11 Aug 2023 12:14:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     oe-kbuild@lists.linux.dev, Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/2] gpio: sim: simplify code with cleanup helpers
Message-ID: <ZNX8DDKYMOyxdTnB@smile.fi.intel.com>
References: <20230809131442.25524-2-brgl@bgdev.pl>
 <2444c3ff-eaf3-4cb9-851b-8e92156128b0@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2444c3ff-eaf3-4cb9-851b-8e92156128b0@kadam.mountain>
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

On Fri, Aug 11, 2023 at 08:20:11AM +0300, Dan Carpenter wrote:

> smatch warnings:
> drivers/gpio/gpio-sim.c:1472 gpio_sim_config_make_device_group() warn: possible memory leak of 'dev'

Isn't smatch a bit dumb about cleanup.h?

-- 
With Best Regards,
Andy Shevchenko



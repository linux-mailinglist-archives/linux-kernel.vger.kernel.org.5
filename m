Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3DC780A46
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358417AbjHRKff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376545AbjHRKej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:34:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFD12D58;
        Fri, 18 Aug 2023 03:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692354852; x=1723890852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y9fRMegnJMWJ+p+ZMRt191P/MQhxDL+ApZBYzyhbABc=;
  b=c0EPAh2pkmhtT/4VCQH0Wr3tDowpO/7OPWTA/NqAlIfIOx7fLgKPlIRA
   HT1owZUscKEG5czHbUNurtXjT8WZAPrNcooBvfHkXq1vijQU/m+7mPbmh
   7SmMdUIXgmFiJ5TWdQAFcKnRtA7aeRvCgX3stVg5zqOnjjvCP+RjEUBAJ
   DKPTuB1htg29yHy+Nvaafmigc3W3Mr6bbFpBIlG9sXqGXROFNcUngI2vV
   vSdRt5eo8w4ykkaPnk5fdLex3tNVsQI2LNmm7NDiw6rXKM/D1i8vDSSRi
   pHSZPjIMLLEIyVdRjGF/6uIK2KVv/dH/IHANIpONXLNi6J7+dNoeYN95L
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="439450172"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="439450172"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 03:34:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="711953384"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="711953384"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 18 Aug 2023 03:34:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWwnx-003stx-0R;
        Fri, 18 Aug 2023 13:34:09 +0300
Date:   Fri, 18 Aug 2023 13:34:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 0/6] gpio: cdev: bail out of poll() if the device goes
 down
Message-ID: <ZN9JID53QpSz4epI@smile.fi.intel.com>
References: <20230817184958.25349-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817184958.25349-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 08:49:52PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Wake up all three wake queues (the one associated with the character
> device file, the one for V1 line events and the V2 line request one)
> when the underlying GPIO device is unregistered. This way we won't get
> stuck in poll() after the chip is gone as user-space will be forced to
> go back into a new system call and will see that gdev->chip is NULL.

Why can't you use the global device unbind notifications and filter out
what you are interested in?

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05207A41B8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239124AbjIRHG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240095AbjIRHGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:06:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660F3C4;
        Mon, 18 Sep 2023 00:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695020767; x=1726556767;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QY+lvSdFQLNT+afXhjinqJPraKwe9skyDfZMOTPf6yU=;
  b=fiuvYotjEzxJ/90LQcpcTq7bVEFXGEAu0+r8M3PSJ8qhyKOLG3+jPcNV
   lkHAIG+XQ0+1VWvRSz/MNx1TxtyVqsu7SJgPR4u2AkRJYkxYdgOkdn/GZ
   Mb91XXKhpl6z1fXivM4SynyCm6naB5dgfdr+lk1dzjrwbGxsb1Mke02AH
   s/Zs8/8b4H9sJjzKJwuLvsT+gUPtPLLH0XszVh9mvRcPCTjoWjuHceYA2
   KDR1nURyTLaUE7MaRtTuohtFwqpzUTMYlMS6zNQxl4DIRRMIEV6j810mL
   4ws8gSjAFOMxPPzlcYJtX/zOHHfbAXGbPLawiH1dpVkCrxvM9/CB5j2t6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="358998651"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="358998651"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 00:06:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="860936808"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="860936808"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 00:06:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qi8KW-0000000DqwI-3B2L;
        Mon, 18 Sep 2023 10:06:00 +0300
Date:   Mon, 18 Sep 2023 10:06:00 +0300
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
Subject: Re: [PATCH v3 2/2] gpio: sim: initialize a managed pointer when
 declaring it
Message-ID: <ZQf22FxCiPe2GUcd@smile.fi.intel.com>
References: <20230917091225.6350-1-brgl@bgdev.pl>
 <20230917091225.6350-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917091225.6350-3-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2023 at 11:12:25AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Variables managed with __free() should typically be initialized where
> they are declared so that the __free() callback is paired with its
> counterpart resource allocator. Fix the second instance of using
> __free() in gpio-sim to follow this pattern.

...

>  {
> -	struct gpio_sim_device *dev __free(kfree) = NULL;
>  	int id;
>  
> -	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +	struct gpio_sim_device *dev __free(kfree) = kzalloc(sizeof(*dev),
> +							    GFP_KERNEL);
>  	if (!dev)
>  		return ERR_PTR(-ENOMEM);

Aside: Oh, this might be a downside of the __free() sugar, as we can
theoretically end up with a code in the future like

	struct bar *foo;
	...
	struct baz *foo __free() = ...
	...

and I am not sure how it goes to work. Or relaxed variant with

	struct bar *foo;
	...
	{
		struct baz *foo __free() = ...
		...
	}

where we would have two variables with the same name, but different scope
(this, perhaps, would work, but I assume compiler should warn about shadowed
 name for the variable).

(Also what if in both cases bar == baz, i.e. same type?)

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D6F77CB2C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbjHOKeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 06:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjHOKeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 06:34:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530E110E;
        Tue, 15 Aug 2023 03:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692095656; x=1723631656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=joiMz1E6+IG9ShcCCtZi72zB/Khq47MJfO1OCuXeLZ8=;
  b=H4HRZI2c5p8Lv7hUu3XA5c2VQC9eJg1bI2D2QlOhz4ZfTp35i9MbI3wz
   ysUB7lU7XiJI/WSCzWBIRvDA9nn0umt2bF0u5/u3XXAbc3bHjM43SePOJ
   ejXy8PGwe7rPmnnOof2lWs4PmBKtPK3SWK/w6zTUBOkov4h0YditA88hF
   p45Q8YyeEtfkwW+TaYgiQTmXRIDDWU9z7/7Q+WJW7VDdbHANOQ0s22XJn
   iIRmuNu97ww9OwsrhgVwu7H7WyToUWz2xoTwWDObQL8ThwzGEWeyE6iGc
   XneoA7xwok5pvqGNHu9GXKUFz5ecnCChimBUntvbK2Slv6z+YlwwU0C9c
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="438590349"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="438590349"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 03:34:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="857407325"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="857407325"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 15 Aug 2023 03:34:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVrNM-00ElR8-1N;
        Tue, 15 Aug 2023 13:34:12 +0300
Date:   Tue, 15 Aug 2023 13:34:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpio: sim: replace memmove() + strstrip() with
 skip_spaces() + strim()
Message-ID: <ZNtUpMe41HEztHLw@smile.fi.intel.com>
References: <20230812185748.5799-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812185748.5799-1-brgl@bgdev.pl>
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

On Sat, Aug 12, 2023 at 08:57:48PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Turns out we can avoid the memmove() by using skip_spaces() and strim().
> We did that in gpio-consumer, let's do it in gpio-sim.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> +	strim(trimmed);
>  
> -	return dup;
> +	return trimmed;

Can be also

	return strim(trimmed);

If it's only about \n replacement, then

	return strreplace(trimmed, '\n', '\0');

would work and in the next release be changed to kstrdup_and_replace().

>  }

-- 
With Best Regards,
Andy Shevchenko



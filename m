Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF838133A5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573572AbjLNOxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573563AbjLNOxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:53:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F38121;
        Thu, 14 Dec 2023 06:53:39 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2288515"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="2288515"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 06:53:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="897768617"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="897768617"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 06:53:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andy@kernel.org>)
        id 1rDn5i-00000005s64-2QaF;
        Thu, 14 Dec 2023 16:53:34 +0200
Date:   Thu, 14 Dec 2023 16:53:34 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Kent Gibson <warthog618@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org
Subject: Re: [PATCH v2 1/5] gpiolib: cdev: adopt scoped_guard()
Message-ID: <ZXsW7hsetst56K-b@smile.fi.intel.com>
References: <20231214095814.132400-1-warthog618@gmail.com>
 <20231214095814.132400-2-warthog618@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214095814.132400-2-warthog618@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 05:58:10PM +0800, Kent Gibson wrote:
> Use scoped_guard for critical sections rather than distinct

scoped_guard()

> lock/unlock pairs.

...

> -	mutex_lock(&lr->config_mutex);
> -
> -	ret = linereq_set_values_unlocked(lr, &lv);
> -
> -	mutex_unlock(&lr->config_mutex);
> +	scoped_guard(mutex, &lr->config_mutex)
> +		ret = linereq_set_values_unlocked(lr, &lv);
>  
>  	return ret;

In this case it can be guard()

	guard(...)(...);

	return linereq_...

...

> -	mutex_lock(&lr->config_mutex);
> -
> -	ret = linereq_set_config_unlocked(lr, &lc);
> -
> -	mutex_unlock(&lr->config_mutex);
> +	scoped_guard(mutex, &lr->config_mutex)
> +		ret = linereq_set_config_unlocked(lr, &lc);
>  
>  	return ret;

Ditto.

-- 
With Best Regards,
Andy Shevchenko



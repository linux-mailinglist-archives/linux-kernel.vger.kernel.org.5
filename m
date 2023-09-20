Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1410F7A83AE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbjITNoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbjITNn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:43:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F146A1;
        Wed, 20 Sep 2023 06:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695217434; x=1726753434;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tl3QfxxJwdhEtlgypBEs0r5r9sQ+h9OIC9TIa+8Uh8g=;
  b=bSXLI7G+rVmqrNm4bHi0U0r/DzYtbirtd4fhQEmZtgrofAHcDS8WcdrO
   jIiuUiMq9ACSrdE/X4hCtL7A/X36mLZlHsRD1zJIxiR7qQUAM0tZ02K8k
   Qgghf2jNhP4WUuxhnTU6xazH8ZYV9j9Jdy/D2U5Nla6sbZGPlhHrajVsk
   FHtvcd93gGgt91Y+nwfHybKem6rs1F3y4C+zWa5klD5wTQwJWJPkwTdg4
   fHvCGtWLlBKxI6Fi0HkndbibuiDTdQ2jCLuBI9Ui85MlDTftjiXAJl1eZ
   9iF39xZLqqc5oujNgDqlvXV2qyuaaHXbP/rQaiw+motXEY6bavxORAGRy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="360482085"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="360482085"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 06:43:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="816902760"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="816902760"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 06:43:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qixUZ-0000000DyYe-3ujG;
        Wed, 20 Sep 2023 16:43:47 +0300
Date:   Wed, 20 Sep 2023 16:43:47 +0300
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
Subject: Re: [PATCH v5] gpio: sim: fix an invalid __free() usage
Message-ID: <ZQr3E/7crMrVxMp9@smile.fi.intel.com>
References: <20230920073253.51742-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920073253.51742-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 09:32:53AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> gpio_sim_make_line_names() returns NULL or ERR_PTR() so we must not use
> __free(kfree) on the returned address. Split this function into two, one
> that determines the size of the "gpio-line-names" array to allocate and
> one that actually sets the names at correct offsets. The allocation and
> assignment of the managed pointer happens in between.

...

>  	list_for_each_entry(line, &bank->line_list, siblings) {
> -		if (line->offset >= bank->num_lines)
> +		if (!line->name || (line->offset >= bank->num_lines))
>  			continue;
>  
> -		if (line->name) {
> -			if (line->offset > max_offset)
> -				max_offset = line->offset;
> -
> -			/*
> -			 * max_offset can stay at 0 so it's not an indicator
> -			 * of whether line names were configured at all.
> -			 */
> -			has_line_names = true;
> -		}
> +		size = max(size, line->offset + 1);
>  	}

As for the material to be backported it's fine, but I'm wondering if we
actually can add the entries in a sorted manner, so we would need the exact
what I mentioned in previous review round, just search backwards to the first
satisfying entry. I don't believe the adding an entry to the list is a
hot-path, so would be fine to call list_sort().

-- 
With Best Regards,
Andy Shevchenko



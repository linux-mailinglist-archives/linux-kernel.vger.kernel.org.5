Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39639778982
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbjHKJMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbjHKJMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:12:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11FD2D5B;
        Fri, 11 Aug 2023 02:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691745150; x=1723281150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ex4QtUXpfocvEJRdcIdHuspw5Gn/nTjI+tF9OQh7QV8=;
  b=JA+6wIeDGRgq0mgf/KC/BBBde2qA+OhakTZvPZByj3GabRqYbQZwA6NZ
   7iEq4zBxVNzdSA0SULAJwSnBgMJ7E3g0CrANTDgmR4qY7PoRxbn/px9Zl
   e666vFZYgDZlMC2jaFnwPA/eNtmJYo6as6yFz7Lup3OZ9vK6wk0kM3D/b
   uMXDwCE2NQYi/+sN0j12EF36BrVrVqvekS/W+AfhHQp6dQJwVc0jqC0ec
   4floQ0ptL8Z4CpZr9wzW69Ll/tmeZUIdpu7W9WHGDzI5RvfFMLlF8F8+A
   C81M7Tr7fhcBgAGZF/i93YA2N0iQ5FAbRcU3VHx34p5bsFcJq68o7Xuth
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="369106085"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="369106085"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 02:12:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="802601740"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="802601740"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2023 02:12:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qUOC2-007zmN-2p;
        Fri, 11 Aug 2023 12:12:26 +0300
Date:   Fri, 11 Aug 2023 12:12:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2] gpiolib: fix reference leaks when removing GPIO chips
 still in use
Message-ID: <ZNX7etYJrCuERn8/@smile.fi.intel.com>
References: <20230810184846.22144-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810184846.22144-1-brgl@bgdev.pl>
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

On Thu, Aug 10, 2023 at 08:48:46PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> After we remove a GPIO chip that still has some requested descriptors,
> gpiod_free_commit() will fail and we will never put the references to the
> GPIO device and the owning module in gpiod_free().
> 
> Rework this function to:
> - not warn on desc == NULL as this is a use-case on which most free
>   functions silently return
> - put the references to desc->gdev and desc->gdev->owner unconditionally
>   so that the release callback actually gets called when the remaining
>   references are dropped by external GPIO users

...

> +	/*
> +	 * We must not use VALIDATE_DESC_VOID() as the underlying gdev->chip
> +	 * may already be NULL but we still want to put the references.
> +	 */

Clear now!

...

> +	if (!gpiod_free_commit(desc))
>  		WARN_ON(extra_checks);

	/* Always call gpiod_free_commit() */
	WARN_ON(!gpiod_free_commit(desc) && extra_checks);

?

-- 
With Best Regards,
Andy Shevchenko



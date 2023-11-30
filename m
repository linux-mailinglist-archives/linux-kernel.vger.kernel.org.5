Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549A67FF546
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjK3Q1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjK3Q1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:27:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED75B10D0;
        Thu, 30 Nov 2023 08:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701361640; x=1732897640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P2Ck2twzncEFsxmEXKJU4pWeYjkFdrx3ftGdMJ1FzfU=;
  b=cTt6FFNB9AVaSFtODJCcY661pPv9Q7XgtueE+7Guu66Fa7h83Y4ZJRBJ
   yq5KpfCQDgI+FmRuxR4rvnxO7wX/xsRb/3JmZkGoaETj6nCbYYTRNg53X
   4hODtt/QiQzTE3fWuK3XBn8466X0HQXEwHxnUcthjFr9+5auIJtV0h1D2
   5CwAXbVv1eN5dL1gTm371/Kq1DbOuTGZoAmolReTrClVYELKt2yf/4o7P
   Ob8aG1TnTA08ZvLw3MeMuoK2BqcaCFG3GOXP01+yj+XPc2fpHvp1qJ2o7
   CgXxtPzzURUbbkWII9foT7uU/p2YA4lRy+sLxxbDgjUvI2+7+ZV+J36Rp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="479553787"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="479553787"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 08:27:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="942763033"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="942763033"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 08:27:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r8jsg-00000000kH2-3K0W;
        Thu, 30 Nov 2023 18:27:14 +0200
Date:   Thu, 30 Nov 2023 18:27:14 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 01/10] gpiolib: provide gpiochip_dup_line_label()
Message-ID: <ZWi34tkzNsvkCQqi@smile.fi.intel.com>
References: <20231130134630.18198-1-brgl@bgdev.pl>
 <20231130134630.18198-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130134630.18198-2-brgl@bgdev.pl>
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

On Thu, Nov 30, 2023 at 02:46:21PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> gpiochip_is_requested() not only has a misleading name but it returns
> a pointer to a string that is freed when the descriptor is released.
> 
> Provide a new helper meant to replace it, which returns a copy of the
> label string instead.

...

> + * Must not be called from atomic context.

Put the respective lockdep annotation.

...

> +	char *cpy;

So, why not naming it fully, i.e. "copy"?

-- 
With Best Regards,
Andy Shevchenko



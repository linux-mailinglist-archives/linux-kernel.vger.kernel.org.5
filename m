Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B08A8034BD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344353AbjLDN0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344721AbjLDNZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:25:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F2710C2;
        Mon,  4 Dec 2023 05:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701696279; x=1733232279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VXxTq0Pwhb4MhOFBAy4e98giPRfKzaM6kTgk9BDeYq0=;
  b=eCPAlddx68oTNLHJNpU3BL6DWy6VRetVXethiHKu9gC+EFKkNN5stQ/H
   U2hDHssmcEFkrpgOCP21kRgBnbbyklifnT2UbXzO0DncoaDjPvElJrPST
   YxXIJgtVDbKM8aLqh4jkgMKmoBYuePemlHx5RuzqaoLyWcgKOo/zwGg/Z
   0m2S1tPhVp/s13UevhoHtivkjR6HGVV1pNzr/OcQCnDvutB1XYSD1RX+4
   UfmbyqvCTK0EInjih45zjiJ6NOp9BGhif7Rd4kBKN3/HGjS4rz+WowRdH
   KMxup1uL8S2gxQ0/pbB+DoQuLd1Mq8BsgMWfdUugIxAeJ9YrihCPj4wVp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="378764990"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="378764990"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 05:24:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="888524755"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="888524755"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 05:24:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1rA8w5-00000001l5x-3Jn8;
        Mon, 04 Dec 2023 15:24:33 +0200
Date:   Mon, 4 Dec 2023 15:24:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 09/10] gpiolib: use gpiochip_dup_line_label() in
 for_each helpers
Message-ID: <ZW3TEQok8Ri-epw8@smile.fi.intel.com>
References: <20231204093509.19225-1-brgl@bgdev.pl>
 <20231204093509.19225-10-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204093509.19225-10-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 10:35:08AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Rework for_each_requested_gpio_in_range() to use the new helper to
> retrieve a dynamically allocated copy of the descriptor label and free
> it at the end of each iteration. We need to leverage the CLASS()'
> destructor to make sure that the label is freed even when breaking out
> of the loop.

...

> -		if ((label = gpiochip_is_requested(chip, base + i)) == NULL) {} else

I see, but...

> +		if ((*_data.label =							\
> +			gpiochip_dup_line_label(_chip, _base + *_data.i)) == NULL) {}	\

...can we drop this NULL check by using !(...) notation?


-- 
With Best Regards,
Andy Shevchenko



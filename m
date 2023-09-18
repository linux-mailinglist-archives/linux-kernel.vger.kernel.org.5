Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2227A422D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240142AbjIRHUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240164AbjIRHUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:20:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAD2EA;
        Mon, 18 Sep 2023 00:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695021592; x=1726557592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=epXgnaEJlqPGoGszAk+/kopiRPBo1kbQ8ZMDoljbdmk=;
  b=FvdQBKMsHXGXtdnfEo63jtzz6OSmWCwqiNdsAKCBa+u1+jXKL81FgKHf
   orHpecWyBnZApeZNiH7juHEwchFQbtsMBuf1WTTJxoG4ktKC16NfeP1bf
   tGidzuGouV3xNxSIctGuGfOZyLAEks8tMA8OtdD+cgG7nJsCDxiqtzHaj
   p5McwkDA3swDN/s8wy2TGbh7o0i5+LjSuHVk03okDALfn6yN0fTfg4Yg8
   97+tW7NolWhK6eKztmQdjRKZFtqRoulLIUAe7P18u6/UgYI4Vt9kAwI81
   TVRCEDLmbRR6LhZVg+rlXX1WZZJ/icyvebgpoQkS9DEgUo6+bhAbQGBIe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="410540999"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="410540999"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 00:19:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="722369077"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="722369077"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 00:19:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qi8Xr-0000000EIhy-1H4f;
        Mon, 18 Sep 2023 10:19:47 +0300
Date:   Mon, 18 Sep 2023 10:19:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 04/11] gpiolib: provide gpio_device_find_by_label()
Message-ID: <ZQf6E+itll3dmCnU@smile.fi.intel.com>
References: <20230915150327.81918-1-brgl@bgdev.pl>
 <20230915150327.81918-5-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915150327.81918-5-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 05:03:19PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> By far the most common way of looking up GPIO devices is using their
> label. Provide a helpers for that to avoid every user implementing their
> own matching function.

...

> +static int gpio_chip_match_by_label(struct gpio_chip *gc, void *label)
> +{
> +	return gc->label && !strcmp(gc->label, label);
> +}

I am still wondering if we can oblige providers to have label to be non-empty.

-- 
With Best Regards,
Andy Shevchenko



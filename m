Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD937A4239
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240160AbjIRHXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240213AbjIRHXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:23:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77B4AA;
        Mon, 18 Sep 2023 00:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695021779; x=1726557779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RIR2pEcEVhctX36Lz+WjGjwpXZAaBUs9ecXfeIMfP58=;
  b=RHU5MeT1X1nHRmQRkdXgo1RL/aztVIteiVyfqMOMj+hUlqlaRB/kdkcG
   /wYqCa5NMFBZASCfanGsL6nFY3IETr/G3LVfcjXUVxs8plEwCvEQFziRa
   0t+ZEQG5KTaTzmplHSCh4YfIRYfK5ukE4ej4k2M+3LK0ahu/3PMbMWcLv
   +GaMg/GvvN/HucmMEu8pISvhQHVs2oqrRYt5QLbCUUV/0/Tj9Vfz1Stn+
   lnkz3m8cmdM9m/8RUjul7KexbNjr5oFnM2qah5s3eayxY3Qf07aiTHJ4a
   +x8Tz+5wJ0w1nmup6hhzw7ewA4UhdL3ZStl3zyGCgkn1Jhj2ooMppj8p8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="382329771"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="382329771"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 00:22:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="888927412"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="888927412"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 00:22:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qi8ar-0000000EP4Y-2tCW;
        Mon, 18 Sep 2023 10:22:53 +0300
Date:   Mon, 18 Sep 2023 10:22:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 07/11] gpiolib: replace find_chip_by_name() with
 gpio_device_find_by_label()
Message-ID: <ZQf6zTsoZDFaIgHO@smile.fi.intel.com>
References: <20230915150327.81918-1-brgl@bgdev.pl>
 <20230915150327.81918-8-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915150327.81918-8-brgl@bgdev.pl>
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

On Fri, Sep 15, 2023 at 05:03:22PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Remove all remaining uses of find_chip_by_name() (and subsequently:
> gpiochip_find()) from gpiolib.c and use the new
> gpio_device_find_by_label() instead.

...

> -static int gpiochip_match_name(struct gpio_chip *gc, void *data)
> -{
> -	const char *name = data;
> -
> -	return !strcmp(gc->label, name);

And this we had no check for the label being NULL...

...

>  	for (p = &table->table[0]; p->key; p++) {
> +		struct gpio_device *gdev __free(gpio_device_put) = NULL;

> +		gdev = gpio_device_find_by_label(p->key);
> +		if (!gdev) {

I haven't got the fix for gpio-sim, shouldn't we have the same here, i.e.
definition being done together with the assignment when __free() is in use?

>  		}

-- 
With Best Regards,
Andy Shevchenko



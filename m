Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A147A424B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240209AbjIRH0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240203AbjIRH0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:26:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F2B12C;
        Mon, 18 Sep 2023 00:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695021961; x=1726557961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kFJCHQ4Odn3541lWdgt/yJMzNIv3Rnoj9Tzzh8CYgOY=;
  b=d9Z+A5m4AA5cJdha++DurDYnHPzf9IGfg9Sd37Ii1AV+F49rqWc7GChZ
   bVmIC4XtmQHkvDKCgmrkDOOFwj1kBVZa+AiAMuvhXb/J1e2ixX0xoLSUW
   vK3iAlV32CBXLYVe2y1CwyGCuV5tZ0+w+YMC/CtVizaqbuCZjoYeVZ31N
   QDrTZkxkB3sHYQ9oGnI9Ej6XuFaqhgPnoCZZEoEITogQKX7D05iDo16rP
   TTS4Kage/5GfxJyUD6o8fXzY+Z9Ql1CpftqAaylZhWginSJGs/O2RFYON
   1Z+1t1lZHtHGvJu04donT/MN3ZgJuO1lYnh97AgtrD7dbM45+mlwVxVJi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="410541866"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="410541866"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 00:26:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="1076484354"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="1076484354"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 00:25:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qi8dn-0000000EUuI-3aQJ;
        Mon, 18 Sep 2023 10:25:55 +0300
Date:   Mon, 18 Sep 2023 10:25:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 10/11] gpio: swnode: replace gpiochip_find() with
 gpio_device_find_by_label()
Message-ID: <ZQf7g92JgULqNaHz@smile.fi.intel.com>
References: <20230915150327.81918-1-brgl@bgdev.pl>
 <20230915150327.81918-11-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915150327.81918-11-brgl@bgdev.pl>
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

On Fri, Sep 15, 2023 at 05:03:25PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We're porting all users of gpiochip_find() to using gpio_device_find().
> Update the swnode GPIO code.

...

> +	gdev = gpio_device_find_by_label((void *)gdev_node->name);

Why do you need casting here?

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022107AEFAC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbjIZP2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbjIZP2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:28:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669AC10E;
        Tue, 26 Sep 2023 08:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695742081; x=1727278081;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gmy3AqMcLkURDUPVRN0R9ITETg1R0Zr8P8UlSqqQHlU=;
  b=bSVdwde1wj/F2t/EUlYPYiO+myEkrkYqWg/WOFfcxuIy4B3JrjQ5zPWb
   4qlFce6WwJy9xZeoapBWXAI9C32G2MZvNg2RQWW8M8biguuQMXlP2F2OD
   RiPy0+PQ1qr3bVHG+7JiDgO1lbDjMlY4DekDziKt5UAcUUEholZ6raY+h
   9hPD4PIXKEkMwpVwvZppwsn/dItk1h0FxToFBnHPLd2SxUv8Rc3K5N+yr
   gO9C+ScDt8zw2deHSgXn+m5fIY4ZESjwY6RZPgVM7zPY6gmoSGcdxmvh+
   DsnV2xqok4rSH6tyVFTHHkS2/gLYgHfuewcLKsr60gHxN1msKI28wLG8w
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="361843461"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="361843461"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 08:28:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="819062447"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="819062447"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 08:27:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ql9yd-00000000eLp-0nKD;
        Tue, 26 Sep 2023 18:27:55 +0300
Date:   Tue, 26 Sep 2023 18:27:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Scally <djrscally@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFT PATCH 4/4] gpio: acpi: remove acpi_get_and_request_gpiod()
Message-ID: <ZRL4epTUrDmHCk8K@smile.fi.intel.com>
References: <20230926145943.42814-1-brgl@bgdev.pl>
 <20230926145943.42814-5-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926145943.42814-5-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 04:59:43PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> With no more users, we can remove acpi_get_and_request_gpiod().

The best patch in the series!
Reviewed-by: From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F95E7A83E0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbjITNun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236413AbjITNuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:50:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B96DC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695217831; x=1726753831;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LsSKH/WVCDp1Q9EMjMqxZ0ku+LUjn/WMtIe8Aqn7jOM=;
  b=U6YlKLFPvgkFEn3kLpQnISaPSdaozsa7wWTzZcStBXevdH+6LQRKkAuY
   xRHF/JcUUxoxNF0MkSu1XcPnN5I8mnJvlpi1ddgaNa4nvitFPcn6vLSXj
   q0vjhv5j+O9q+7YlYUVdogWVnF6KmXKilqY4dzJsDvcQU4hEb3t5ue9zl
   C7kn7PFJ93IBaxjDFWAhWci3v9SA1PGf2pqkR/R28xWq1qrDfnSLfA0Bu
   Ykm11zr/BmeUIp+2JAmpE2IV2DIde8JBr7BMQCtK8IROD619b2Ul3A2IG
   poePpEIjfpQYYNTKrvN7afh6OkytjgyhXDxMv5rJCaf9Mgge6sGOZk9BI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="446694675"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="446694675"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 06:50:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="1077433773"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="1077433773"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 06:50:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qixay-0000000EC1B-1Vtm;
        Wed, 20 Sep 2023 16:50:24 +0300
Date:   Wed, 20 Sep 2023 16:50:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 1/4] bitmap: define a cleanup function for bitmaps
Message-ID: <ZQr4oMx0+A3qHPVC@smile.fi.intel.com>
References: <20230920075500.96260-1-brgl@bgdev.pl>
 <20230920075500.96260-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920075500.96260-2-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 09:54:57AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add support for autopointers for bitmaps allocated with bitmap_alloc()
> et al.

Haven't I given a tag? (Probably this is significant change...) Whatever,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



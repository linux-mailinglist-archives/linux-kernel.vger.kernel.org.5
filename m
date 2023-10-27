Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82D87D96B3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjJ0LdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjJ0LdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:33:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FAD1B3;
        Fri, 27 Oct 2023 04:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698406379; x=1729942379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OApmSqXXZbIaoiJzOhkxdZnJfAMT4marLH+AGdbwU0U=;
  b=hrGvThSgf5j0kiHxvHzeJLH2MLAX+tT4BhPJsDaDIOQPVbIa/yvc6x49
   2ri7Jl2XyePxQVXKzjKTFSFN41D2WmZo4NBn1dsX7ZDozDm/80aacqytU
   LWvfi+XLvYI+2XiedIQm6s9OcRe1CQQa6O28nvQJw+6O22skolcPNc6fj
   DqA/7mRX6ORkdx+xBPD383mABo5C6ZxnCKRNtOC2PB282dJSBLiKgMXJe
   wjz1TndIgZK4/WeVQW7fAytnnmfRj5I+Z+yASljb6kt50J5aIz5tPDRG2
   vRi21ZWX+CVpyR3jtSWgBnRXujIoJ1sb0vKeFjrL1mgRPO3yBG0bLLfI+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="451997562"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="451997562"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 04:32:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="883160448"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="883160448"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 04:32:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qwL5B-000000098Aj-35H6;
        Fri, 27 Oct 2023 14:32:53 +0300
Date:   Fri, 27 Oct 2023 14:32:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linhua Xu <Linhua.xu@unisoc.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        lh xu <xulh0829@gmail.com>,
        Zhirong Qiu <zhirong.qiu@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: Re: [PATCH V3 2/6] pinctrl: sprd: Fix the incorrect mask and shift
 definition
Message-ID: <ZTuf5fk8PV/LqHwr@smile.fi.intel.com>
References: <20231027071426.17724-1-Linhua.xu@unisoc.com>
 <20231027071426.17724-3-Linhua.xu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027071426.17724-3-Linhua.xu@unisoc.com>
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

On Fri, Oct 27, 2023 at 03:14:22PM +0800, Linhua Xu wrote:
> From: Linhua Xu <Linhua.Xu@unisoc.com>
> 
> Pull-up and pull-down are mutually exclusive. When setting one of them,
> the bit of the other needs to be clear. Now, there are cases where pull-up
> and pull-down are set at the same time in the code, thus fix them.

...

> Fixes:<1fb4b907e808> ("pinctrl: sprd: Add Spreadtrum pin control driver")
> 
> Signed-off-by: Linhua Xu <Linhua.Xu@unisoc.com>

Same comment  about the Fixes: tag.

...

> -#define SLEEP_PULL_DOWN_MASK		0x1
> +#define SLEEP_PULL_DOWN_MASK		GENMASK(1, 0)
>  #define SLEEP_PULL_DOWN_SHIFT		2

No, this is an incorrect (prone to errors and confusion) change.
You need to introduce new mask for both of them and use in the code.

#define SLEEP_PULL_UP_DOWN_MASK		GENMASK(1, 0)
#define SLEEP_PULL_UP_DOWN_SHIFT	2

...

> -#define PULL_DOWN_MASK			0x1
> +#define PULL_DOWN_MASK			(GENMASK(1, 0) | BIT(6))
>  #define PULL_DOWN_SHIFT			6

Ditto.

#define PULL_UP_DOWN_MASK		(GENMASK(1, 0) | BIT(6))
#define PULL_UP_DOWN_SHIFT		6

-- 
With Best Regards,
Andy Shevchenko



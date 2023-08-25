Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FEA788479
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243935AbjHYKNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243833AbjHYKNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:13:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196562109;
        Fri, 25 Aug 2023 03:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692958410; x=1724494410;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+goDWYvyCDiTU+FZzVIlTsgA1LEnbG9/nfPMkUmECvI=;
  b=BD+7Q7DZkk/THwUZOCgasPFaCJJhvzPbqnrrxK3njbtVhzlkPWDNx0u0
   Z4dtXW7DJThWO+rPjwQpjev1N0hrkz0lqrXx55dmIJqTAtVS3hUVTSWUn
   kDOt7Rngej73Fxkxb4Rr1VuAwIC/6NTdVMav1KYJ2YTwZRSEdXU8O+Li6
   gjoeutGvZCXct+Xx6gEzBdUHMwaN4PZnojdjLfvFM33EKnSDWlKQWgsJO
   4b14bG8IGCg/q3yHRPqhPkajzVmPD2IxlN+71dDtPyr7lVHA6IdmdbqE1
   yoee3tsd1uv4qjf/YnRlqmrqJZVgL7X8MxEUjEA2M6lXQ38iLlazbPcM3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="372080042"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="372080042"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 03:13:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="687256172"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="687256172"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 25 Aug 2023 03:13:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qZToj-00CVoq-18;
        Fri, 25 Aug 2023 13:13:25 +0300
Date:   Fri, 25 Aug 2023 13:13:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linhua Xu <Linhua.xu@unisoc.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        lh xu <xulh0829@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: Re: [PATCH 3/6] pinctrl: sprd: Modify pull-up parameters
Message-ID: <ZOh+xZqr0RiCLPC3@smile.fi.intel.com>
References: <20230825031826.31599-1-Linhua.xu@unisoc.com>
 <20230825031826.31599-4-Linhua.xu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825031826.31599-4-Linhua.xu@unisoc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 11:18:23AM +0800, Linhua Xu wrote:
> From: Linhua Xu <Linhua.Xu@unisoc.com>
> 
> For UNISOC pin controller, there are three different configurations of
> pull-up drive current: 1 for pull-up resistor is 20K, 2 for pull-up
> resistor is 4.7K and 3 for pull-up resistor is 1.8K. Thus modify them.

...

> -					if (arg == 20000)
> -					else if (arg == 4700)

> +					if (arg == 3)
> +					else if (arg == 2)
> +					else if (arg == 1)

This will break existing users. What's wrong with leaving this as is
and adding 1.8kOhm?

-- 
With Best Regards,
Andy Shevchenko



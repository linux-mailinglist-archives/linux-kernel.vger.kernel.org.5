Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184DE79ADBE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345650AbjIKVVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236166AbjIKJwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:52:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6143FE4E;
        Mon, 11 Sep 2023 02:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694425919; x=1725961919;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6VFTFuruN2uSMZ2HAV5yoTE1QyK+PLotHbOXUJ4WTbA=;
  b=YcXbmYM1Dk5P5E/UUv+pm1Yv4923qV3/5gI/le4znCn51oY+AZrqo0J9
   Dfllj0TjUb4d4fflgE67aV9Y40vIwfTm3FPhKB2uhydD5vyNvBy63wKNa
   8AmtIc86k1PNSYMhVjKsXPss+BkzwNBNWiCB48cZnl4qHSAWbT7fdKIQW
   BA3UXivNGIBFCZ9sKUZszKK7DhqhQbtzwqelsYSIHZHUN2xRf8s7tgKO3
   peUsreRywuEK/sQh+41lVpxuuoo+6xHBAFfczY+jEa9wz3i6qma6URmbu
   x9cm6VcV3752sdypvrXyBqsjSDetegWKSdwuNaWRfvWpyPurcYsBZFtnY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="444457583"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="444457583"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 02:51:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="833443698"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="833443698"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 02:51:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qfdaD-008Hbv-0b;
        Mon, 11 Sep 2023 12:51:53 +0300
Date:   Mon, 11 Sep 2023 12:51:52 +0300
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
Subject: Re: [PATCH V2 3/6] pinctrl: sprd: Modify pull-up parameters
Message-ID: <ZP7jOJ2sPJIU3ka6@smile.fi.intel.com>
References: <20230908055146.18347-1-Linhua.xu@unisoc.com>
 <20230908055146.18347-4-Linhua.xu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908055146.18347-4-Linhua.xu@unisoc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 01:51:43PM +0800, Linhua Xu wrote:
> From: Linhua Xu <Linhua.Xu@unisoc.com>
> 
> For UNISOC pin controller, there are three different configurations of
> pull-up drive current. Modify the 20K pull-up resistor configuration and
> add the 1.8K pull-up resistor configuration.

...

> -#define PULL_UP_4_7K			(BIT(12) | BIT(7))
> +#define PULL_UP_1_8K			(BIT(12) | BIT(7))
> +#define PULL_UP_4_7K			BIT(12)

This looks like a real fix, please add Fixes tag and move the patch to be the
first in the series.

-- 
With Best Regards,
Andy Shevchenko



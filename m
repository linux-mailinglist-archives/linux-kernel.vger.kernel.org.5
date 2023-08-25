Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BC5788451
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243041AbjHYKLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240867AbjHYKLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:11:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D006210C;
        Fri, 25 Aug 2023 03:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692958261; x=1724494261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xBJUoCg4kWQasJ3T8GzssUZ5Wq5zRXQnCvEZ2kv0Tfc=;
  b=mlxIHBXuDbPuqeQdAQ9QDfukjZ85GO5/N/09FjDwVRe1VJWn+gv7ZS78
   YJy01f5n/TXosC2kQM75UW7JOtsLVUCRNqqEbs+bOrFoFx1HMQjws/6WX
   BTQJ2BPoOzt65Y6p9ZW4Aw8QWNN3Kldq9JzHR6NezPPDM/oLiHtVDW1T3
   m+kiBKA2RJdc4zNoFH7h5Vrl2FB51Qd3jdWG2fU6EPtx+OISmYZkW6Eum
   9yqTYrSJ3qE3KogzdQLdP8qOftTcPUwOWNNHh5Jrtt22JSWpgBCblrA1o
   8L1WMF2AmLRjeNn+dSSdcLLmDyO4FRVRIoGuXyj+jAUmIc4hoOJ5wx3lV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="377420796"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="377420796"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 03:11:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="731009596"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="731009596"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 25 Aug 2023 03:10:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qZTmK-00CQSo-0v;
        Fri, 25 Aug 2023 13:10:56 +0300
Date:   Fri, 25 Aug 2023 13:10:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linhua Xu <Linhua.xu@unisoc.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        lh xu <xulh0829@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: Re: [PATCH 2/6] pinctrl: sprd: Fix the incorrect mask and shift
 definition
Message-ID: <ZOh+MBq/GQQUCumT@smile.fi.intel.com>
References: <20230825031826.31599-1-Linhua.xu@unisoc.com>
 <20230825031826.31599-3-Linhua.xu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825031826.31599-3-Linhua.xu@unisoc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 11:18:22AM +0800, Linhua Xu wrote:
> From: Linhua Xu <Linhua.Xu@unisoc.com>
> 
> Pull-up and pull-down are mutually exclusive. When setting one of them,
> the bit of the other needs to be clear. Now, there are cases where pull-up
> and pull-down are set at the same time in the code, thus fix them.

...

> -#define SLEEP_PULL_DOWN_MASK		0x1
> +#define SLEEP_PULL_DOWN_MASK		0x3

GENMASK()

...

> -#define PULL_DOWN_MASK			0x1
> +#define PULL_DOWN_MASK			0x3

GENMASK()

...

> -#define SLEEP_PULL_UP_MASK		0x1
> +#define SLEEP_PULL_UP_MASK		0x3

GENMASK()

...

> -#define PULL_UP_MASK			0x21
> +#define PULL_UP_MASK			0x43

GENMASK() + BIT()?

-- 
With Best Regards,
Andy Shevchenko



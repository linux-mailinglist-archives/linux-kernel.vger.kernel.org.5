Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F26079C07E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358751AbjIKWNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbjIKJu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:50:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB710ED;
        Mon, 11 Sep 2023 02:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694425851; x=1725961851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iCAgKyq7VgwAnxmQkRS3Ccgm7XbsQwNb7q495NUM0tI=;
  b=iMD5Xaup317khdy3ciyod3WW8ZQjJo0fk6q7fRF6A1HEfdOsE1koHiHi
   bdSKboZDqPCwVWW1Pg/oFeiIKRtkkg18+DH/XlwzoNWCbQL95WA34JrzA
   98+uawDb3BE1skHV1Y8GMfMrwVeLckfCzWrXkLJ8jKj2ABXeQ5/T/T4Bi
   uoJy7d0jQHK5wxl9UNVwoIrGJaUCd+KEdmOFK6gXSDpBPRJJcVKqPsxmG
   RMukfqLLtowagvLkvNIDKxMd5M+0FZuI9ftk95oOp4H/u4aVp9flydoSb
   xZKiq9A+rNdcRxBtiJQHB/nFwSC159JeEHXOldMMx78wzs9ZxP9taqmvk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="377957116"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="377957116"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 02:50:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="693032158"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="693032158"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 02:50:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qfdZ0-008Hb0-2A;
        Mon, 11 Sep 2023 12:50:38 +0300
Date:   Mon, 11 Sep 2023 12:50:38 +0300
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
Subject: Re: [PATCH V2 2/6] pinctrl: sprd: Fix the incorrect mask and shift
 definition
Message-ID: <ZP7i7oSthp9YHeXh@smile.fi.intel.com>
References: <20230908055146.18347-1-Linhua.xu@unisoc.com>
 <20230908055146.18347-3-Linhua.xu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908055146.18347-3-Linhua.xu@unisoc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 01:51:42PM +0800, Linhua Xu wrote:
> From: Linhua Xu <Linhua.Xu@unisoc.com>
> 
> Pull-up and pull-down are mutually exclusive. When setting one of them,
> the bit of the other needs to be clear. Now, there are cases where pull-up
> and pull-down are set at the same time in the code, thus fix them.

...

>  #define SLEEP_PULL_DOWN			BIT(2)
> -#define SLEEP_PULL_DOWN_MASK		0x1
> +#define SLEEP_PULL_DOWN_MASK		GENMASK(1, 0)
>  #define SLEEP_PULL_DOWN_SHIFT		2
>  
>  #define PULL_DOWN			BIT(6)
> -#define PULL_DOWN_MASK			0x1
> +#define PULL_DOWN_MASK			(GENMASK(1, 0) | BIT(6))
>  #define PULL_DOWN_SHIFT			6
>  
>  #define SLEEP_PULL_UP			BIT(3)
> -#define SLEEP_PULL_UP_MASK		0x1
> -#define SLEEP_PULL_UP_SHIFT		3
> +#define SLEEP_PULL_UP_MASK		GENMASK(1, 0)
> +#define SLEEP_PULL_UP_SHIFT		2
>  
>  #define PULL_UP_4_7K			(BIT(12) | BIT(7))
>  #define PULL_UP_20K			BIT(7)
> -#define PULL_UP_MASK			0x21
> -#define PULL_UP_SHIFT			7
> +#define PULL_UP_MASK			(GENMASK(1, 0) | BIT(6))
> +#define PULL_UP_SHIFT			6

These look strange now.

So, SLEEP MASK doesn't cover bits 2 and 3.
I believe you should have

#define SLEEP_PULL_UP_DOWN_MASK		GENMASK(3, 2)

The other even weirder with this BIT(6) there.

In the similar way:

#define PULL_UP_DOWN_MASK		GENMASK(7, 6)


-- 
With Best Regards,
Andy Shevchenko



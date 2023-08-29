Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BB878C53A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbjH2NZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbjH2NZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:25:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBB4198;
        Tue, 29 Aug 2023 06:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693315522; x=1724851522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Su8TWlvT1KlZHo58Z3GoON6BauY+84W3pS8MMxeoPRI=;
  b=b7BuU+ZadwAZvqRCpdNfjPUPxKsbOuWPJeWVarcZ71vrAiOxR+vHnU9k
   qRhp0rgEy3GW0TUYmSiE3e5+ToG938h+jgDXdpQFB9TjcI6USEKCbts3C
   9nkBpJgVcskIHtvmZ/ei7+a0niiUM9ntDudDUxy+bPsC8amvA5ejAWkFD
   k572Zf/welBBP1lRvHeAbLD0se2UOTrYuaEA+80FHB4tS9RVYMzQJ1Qj4
   zc69RIQfhMXHIC5zXW+wV0r9xna0Q2i/APgFyd4DuXt7iTB5BMLyu/MBq
   fkGlRIiUsevu4VgAh+f2vjnlmK7YcMjTX8VUT5SO64+dqgQTBNDPZXaky
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="372778421"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="372778421"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 06:24:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="853285626"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="853285626"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2023 06:24:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qayhx-004tAX-05;
        Tue, 29 Aug 2023 16:24:37 +0300
Date:   Tue, 29 Aug 2023 16:24:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        haozhe chang <haozhe.chang@mediatek.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] wwan: core: Use the bitmap API to
 allocate bitmaps
Message-ID: <ZO3xlJ/7WDCDuz2T@smile.fi.intel.com>
References: <20230828131953.3721392-1-andriy.shevchenko@linux.intel.com>
 <689ae7b5-0b73-3cb3-5d9c-5ae23e36ee85@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <689ae7b5-0b73-3cb3-5d9c-5ae23e36ee85@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 09:06:09PM +0300, Sergey Ryazanov wrote:
> On 28.08.2023 16:19, Andy Shevchenko wrote:
> > Use bitmap_zalloc() and bitmap_free() instead of hand-writing them.
> > It is less verbose and it improves the type checking and semantic.
> > 
> > While at it, add missing header inclusion (should be bitops.h,
> > but with the above change it becomes bitmap.h).
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Make sense. Thank you.
> 
> BTW, any plans to update __dev_alloc_name(), which was used as reference, in
> the same way?

Ah, will look at it, thanks for the pointer.

> Reviewed-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

And thank you for the review!

-- 
With Best Regards,
Andy Shevchenko



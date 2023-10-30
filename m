Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07ED27DC0D6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjJ3T4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJ3T4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:56:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9A2EE;
        Mon, 30 Oct 2023 12:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698695780; x=1730231780;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RfFmeUpBcZaSntkwX6+z9kb48K08ozZBr+jkwdc7DzY=;
  b=OBgb7qB8J/QfjNaTrX8JiAn2ZSM3zX6rW1zO4+GcHWi3c2TF6FJ55er8
   QtPDmOddSn3qJ7TSObBBVgeNhyrwYPnQ6KJCHw2Vx8v54UcukAgX3skwj
   KAe2ynEySGiPO3V15X6u3TRM7uRLlEgDp+CHGihzmSsLGDxWoSvQphdN8
   gp1d0sjGm1RWnIfi9ZTAprQlVWnoCTc+tDWvuGxdpiTdAf21Y9waAiJ46
   shcMCYye3HtzcUhHhpx+/fxwlwwUWMPTZPcUix59ruR5CSsy9oa2dT7oT
   UQn7mLiTtFvTtyCVP6rH8EQSSqKrWNHdD9qvRt6OEeqtkxnrNuYEvRO3v
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="419260314"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="419260314"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 12:56:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="753898339"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="753898339"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 12:56:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qxYMw-00000009yDG-3nYB;
        Mon, 30 Oct 2023 21:56:14 +0200
Date:   Mon, 30 Oct 2023 21:56:14 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 01/17] pinctrl: intel: Provide Intel pin control wide
 PM ops structure
Message-ID: <ZUAKXulF43OtSAWN@smile.fi.intel.com>
References: <20231030120734.2831419-1-andriy.shevchenko@linux.intel.com>
 <20231030120734.2831419-2-andriy.shevchenko@linux.intel.com>
 <20231030194112.00001917@Huawei.com>
 <20231030194350.0000581f@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030194350.0000581f@Huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 07:43:50PM +0000, Jonathan Cameron wrote:
> On Mon, 30 Oct 2023 19:41:12 +0000
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

...

> Actually looking at usecase, why isn't the absence of an EXPORT in
> the !CONFIG_PM_SLEEP path not a problem for bisection of this series given
> you haven't yet protected the users?

I'm not sure I got the issue you are trying to point out.
Between first and last patches the main driver exports two things: the PM ops
functions, which are _always_ been exported and PM ops structure, which is
exported only when CONFIG_PM_SLEEP=y. Every converted user has pm_sleep_ptr()
guard added so it shouldn't be a problem. What exactly did I miss?

-- 
With Best Regards,
Andy Shevchenko



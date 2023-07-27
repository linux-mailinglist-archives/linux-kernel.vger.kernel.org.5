Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EAB765906
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjG0Qnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjG0Qna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:43:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6BF1BF2;
        Thu, 27 Jul 2023 09:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690476210; x=1722012210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1CLEKciZ7vMQwlx5CCt/8Pv6yTX7KNyg6xp32XDo6iM=;
  b=ATUGjFxcMen1KlNtdZ3vBxwV8Rwud7+eGTEjOI314zXwFDY9FG1PAetu
   n117ehh+cy3lubkW4DYiouRDz7J2PQwpRntUKoyBv9y1nyQbNcUAdVGPk
   LAYpnGrBSQ11bI93ygKJY1xq0at1IGX2HJSCml0Om3X9CL4o4eHB52Ulr
   gAdT8/NQaedeX6zMcCJZK6+xSs0kwkXVRkYWerRlCzLfQt0nMS64xiJjz
   md2LdDECJvp1hDiGO0h41Ng+uJJhzObF1AWAd125s+gIsLKz50OdSfqOg
   xRg4/qkqi1Qnt+CgGKoq17MrhKxjbMs7NWc7LmB9/8fcAfpsxdoS7x5ZK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="367244204"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="367244204"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 09:42:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="704252007"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="704252007"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 27 Jul 2023 09:42:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qP44T-00CV3h-1v;
        Thu, 27 Jul 2023 19:42:37 +0300
Date:   Thu, 27 Jul 2023 19:42:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.com
Subject: Re: [PATCH v2 3/9] clk: mmp: Switch to use struct u32_fract instead
 of custom one
Message-ID: <ZMKefY+LMqahz/bO@smile.fi.intel.com>
References: <20230727162909.6031-1-duje.mihanovic@skole.hr>
 <20230727162909.6031-4-duje.mihanovic@skole.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230727162909.6031-4-duje.mihanovic@skole.hr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 06:29:01PM +0200, Duje Mihanović wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> The struct mmp_clk_factor_tbl repeats the generic struct u32_fract.
> Kill the custom one and use the generic one instead.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I believe you missed your own Tested-by here.

> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>

-- 
With Best Regards,
Andy Shevchenko



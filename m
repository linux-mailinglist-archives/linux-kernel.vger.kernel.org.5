Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50737F73DD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 13:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjKXMcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 07:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXMcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 07:32:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1A7B6;
        Fri, 24 Nov 2023 04:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700829179; x=1732365179;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ua9WzBIueklW0+q3gIH97GV61BDNLh+kPw+aWwuovUk=;
  b=IUxRDH8eW1DtuOP8ZBMeRPovkV7fjYpJk0CL3+g1BlZVJtbhfRWD3aiS
   qkJlLyZYb2qXzAStaDZAbOlY8u+hNYOTaFAZOJXJJdcO7ppF83esjEbev
   N3iQb25/vBqaOPoNGbWsT5BiVmjUUeqw79qpN2XCMLnk0/mkb2FBv/vk8
   rI7DE3RmjVr55ytQ5iUnZsswFnG9Y3jAbHO5XMckrOU/eb3BMMqXVpt3o
   7sppvncGiOSUYqdvgVC5dwGCSB20guVYErXw47K1hXKWLSMe0weHcunbU
   DqMBzMD3Fyu8nvBrvNm7ZEKZqfmKrAuemziExatH9f6JxqBwiTpRH+kYy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="391291470"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="391291470"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 04:32:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="1014895116"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="1014895116"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 04:32:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r6VMd-0000000Giba-2QBm;
        Fri, 24 Nov 2023 14:32:55 +0200
Date:   Fri, 24 Nov 2023 14:32:55 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pinctrl: tangier: simplify locking using cleanup
 helpers
Message-ID: <ZWCX9_rv4Tn5L_RF@smile.fi.intel.com>
References: <20231123140212.12135-1-raag.jadav@intel.com>
 <20231123142816.GE1074920@black.fi.intel.com>
 <ZWCEXZrgafGqwBKT@smile.fi.intel.com>
 <ZWCSJQoJ1m9PtF_e@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWCSJQoJ1m9PtF_e@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 02:08:05PM +0200, Raag Jadav wrote:
> On Fri, Nov 24, 2023 at 01:09:17PM +0200, Andy Shevchenko wrote:
> > On Thu, Nov 23, 2023 at 04:28:16PM +0200, Mika Westerberg wrote:
> > > On Thu, Nov 23, 2023 at 07:32:12PM +0530, Raag Jadav wrote:
> > > > Use lock guards from cleanup.h to simplify locking.
> > > > 
> > > > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > > 
> > > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > 
> > Pushed to my review and testing queue, thanks!
> 
> Awesome, I noticed a few commits having duplicate Acks in Intel tree.

You are right, I have mistakenly run a msg-filter before applying my byt
series. Thanks for spotting this, now should be fixed!

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97756770367
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjHDOqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjHDOqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:46:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D258B49C3;
        Fri,  4 Aug 2023 07:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691160394; x=1722696394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5MPFyRSfG0xkTnPukKOMqtAE4tC8J3r3tMjEcen5nx8=;
  b=au7H20ExS+ZIMSDzwIS1hALGsRcxZE3G4BUM5To8VGPre3KLzNUt+XZ3
   Mohd+pwEULY6zL8PlI50GAdmZyOH3J6SbuecSfwkI6ojPXh7rsRMcsGuG
   wS0SrNZ9VJ/1PaBN9nUoA2dZHKD+8tUZ0wlEielXLzI3kSJ37I2GI3WTF
   FLUVM5V6a1+ub3iXYdB3EyANHseZ1pcBTxqGxdzHtNIzdAOWaKRUh5K5Y
   RSpZ3X+8aC4M/nSzbfzbfakoeix1W//cvEGPyNNmtQdbqWDj0J9Za84l4
   12sdUR2N8csLd4s7BkCcftvZ2KLsXfpOZQUYUv4FxklaJN+isWF4pL8R/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="434017742"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="434017742"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 07:46:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="707047754"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="707047754"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 04 Aug 2023 07:46:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRw4E-00CpIK-0B;
        Fri, 04 Aug 2023 17:46:14 +0300
Date:   Fri, 4 Aug 2023 17:46:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH v1 2/4] driver core: Replace kstrdup() + strreplace()
 with kstrdup_and_replace()
Message-ID: <ZM0PNW6Emks7+Edk@smile.fi.intel.com>
References: <20230628153211.52988-1-andriy.shevchenko@linux.intel.com>
 <20230628153211.52988-3-andriy.shevchenko@linux.intel.com>
 <2023080456-ride-unrobed-b738@gregkh>
 <CAHp75Vcb-uTh0r4YKACAcBwePHjs8Rn0R44NN+oyz11tbCG0Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vcb-uTh0r4YKACAcBwePHjs8Rn0R44NN+oyz11tbCG0Sw@mail.gmail.com>
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

On Fri, Aug 04, 2023 at 05:30:49PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 4, 2023 at 5:10 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Wed, Jun 28, 2023 at 06:32:09PM +0300, Andy Shevchenko wrote:

...

> Stephen, can you take the series now (okay, I think I need to send a
> new version with all tags and typos fixed)?

v2 has been sent: 20230804143910.15504-1-andriy.shevchenko@linux.intel.com

-- 
With Best Regards,
Andy Shevchenko



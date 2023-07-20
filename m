Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AA275AA44
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjGTI7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjGTIdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:33:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AFD1A8;
        Thu, 20 Jul 2023 01:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689841981; x=1721377981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=seQV9zQsch8WX/hqCsOYHbU0ptwGcziO6Y53iuJxVRI=;
  b=RhaxEsIfhIs7fC2Mqz+amT/qqTsqQOmEQAI4qb2fLJTXjmW45fNDueTT
   fzL9SJkCif/IlKgjZOfMewL9EJyGGyaBdhm7HfsZv0gRRNC1N5S9bBNd2
   Ndk7AVHo/JduZti/Knrlfkz/IN5JIAoUiX0608s7E0kYS78uKsq+z4BwT
   zOt62uaXi+vnMfc5j1btPKHXckQpBrjq7v6Cna9woLgjyaIfzYRj9k/5k
   GfuBPQX3Df9pGygmCb8gbS0c1gnw9F6SUcE1tbWLSpnaHa+mgZ8VHo2hh
   rWr1S7ua9I2Vv5kR/viN0hyl6zglDOYDf8q9a/5iuJygmGZGTrT6T4I7g
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="432869424"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="432869424"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 01:33:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="898211096"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="898211096"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 20 Jul 2023 01:32:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qMP5i-00Ga0R-1b;
        Thu, 20 Jul 2023 11:32:54 +0300
Date:   Thu, 20 Jul 2023 11:32:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        Tony Lindgren <tony@atomide.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH v1 0/4] clk: Add kstrdup_and_replace() helper and use it
Message-ID: <ZLjxNgQEqTJfkL8F@smile.fi.intel.com>
References: <20230628153211.52988-1-andriy.shevchenko@linux.intel.com>
 <ad13bab23313ca4bdfd405528a76ac37.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad13bab23313ca4bdfd405528a76ac37.sboyd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 04:47:58PM -0700, Stephen Boyd wrote:
> Quoting Andy Shevchenko (2023-06-28 08:32:07)
> > There are a few existing users and more might come which would like
> > to have the kstrdup_and_replace() functionality.
> > 
> > Provide this new API and reuse it in a few users.
> > 
> > Since most of that is under CCF, perhaps it makes sense to route it
> > via that tree.
> 
> I'm happy to pick it up if you can get an ack from GregKH on the driver
> core bits.

It's also an option to skip that patch.
Greg, can you Ack the patch 2 in this series?


-- 
With Best Regards,
Andy Shevchenko



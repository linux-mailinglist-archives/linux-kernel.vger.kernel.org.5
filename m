Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B777377293A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjHGPaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjHGPaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:30:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007B39D;
        Mon,  7 Aug 2023 08:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691422215; x=1722958215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0E4xvUMuTWbD5ytfDVjva9pYAK9Qn/aofaNA/SwkX6s=;
  b=krLjp1KkBG1thENzZYVnMm+w+WoUeEawRIn9xuCHES1Ktmyhvkleqs97
   NMeVWQXtjbaA76bWtYs1XT7ETvPZOAPFENgcEhNu8OIsWsVK595o3A2D5
   TjQJVN0N0Q5rvTBOZO7UByPpzPFGoIDsUcN50EjqPBV80uGwjct/YXhJm
   JxKx9oy3QMmgbm7PRQV81IKe2zusDEyJrx/GHQvmtliQIKNP+x73kv+/I
   SjWe8DFasGUKnaJeVI0Js+8LfpW4Cn7Nja2RrfB3zHr6DwnYUYrNQHcg2
   tp9Zp9WJltsYdnaKebu+2b4wdjBp/28sV989wEAPSs0NheuMYpfdTsJSa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="374251325"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="374251325"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 08:30:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="904811303"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="904811303"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 07 Aug 2023 08:30:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qT2BN-00HRW3-14;
        Mon, 07 Aug 2023 18:30:09 +0300
Date:   Mon, 7 Aug 2023 18:30:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] of: dynamic: Refactor action prints to not use
 "%pOF" inside devtree_lock
Message-ID: <ZNEOAd0A/3b1fLCQ@smile.fi.intel.com>
References: <20230801-dt-changeset-fixes-v2-0-c2b701579dee@kernel.org>
 <20230801-dt-changeset-fixes-v2-2-c2b701579dee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801-dt-changeset-fixes-v2-2-c2b701579dee@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 04:41:52PM -0600, Rob Herring wrote:

...

> v5 (v2 in this series):
> v4:
> v3:
> v1 and v2 from Geert simply moved the devtree_lock into each case
> statement:
> https://lore.kernel.org/all/c593d8389352c574b5be69d4ca4810da13326a50.1690533838.git.geert+renesas@glider.be/

Side note: More natural to use main versioning as of this series and put
the other to the parentheses.

-- 
With Best Regards,
Andy Shevchenko



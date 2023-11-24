Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC127F7280
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 12:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345777AbjKXLNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 06:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345771AbjKXLNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 06:13:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7B6D7E;
        Fri, 24 Nov 2023 03:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700824397; x=1732360397;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bno8cSNOfIDyBjHnkBz4p3/WS1Ms0Q6QCyL3sjMUeQw=;
  b=LlLi0peUURQjrn9+UYwd/hnx1r/grlvGvX1RP6CkIiG3BnVUjQffJGTV
   7+TpK2LhEBZwT8tEzV/6cGiSTHU2YdL48ynGVDRRoC1g0OaL6uO7xqBiM
   d8ZWyXhbGQOgP6ZIfELi85MdCOYEZ94RI10lU3sSSnhqZJNWeOx+D93I2
   grohAmbhOBMQPxIWaDc5Gnf8H1F4Ow1Z4N2RjVr+vT0Tgbw1gY2WKhDyn
   AD0kzWmmycCKP7kHAY+Cc8+yIqQ+C4TyIBamgh9K9e0Fdc36tz3uHDDp1
   A7ANkMF48T31jMrva0B7962XwxF1/VmvaEws0uvtcsoO6HtHaSvLYZoKp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="13963210"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="13963210"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 03:13:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="760933195"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="760933195"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 03:13:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r6U7U-0000000GhEu-1RIk;
        Fri, 24 Nov 2023 13:13:12 +0200
Date:   Fri, 24 Nov 2023 13:13:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/4] pinctrl: baytrail: Fix types of config value in
 byt_pin_config_set()
Message-ID: <ZWCFSGLB6LEzH979@smile.fi.intel.com>
References: <20231122175039.2289945-1-andriy.shevchenko@linux.intel.com>
 <20231124053339.GG1074920@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124053339.GG1074920@black.fi.intel.com>
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

On Fri, Nov 24, 2023 at 07:33:39AM +0200, Mika Westerberg wrote:
> On Wed, Nov 22, 2023 at 07:50:36PM +0200, Andy Shevchenko wrote:
> > When unpacked, the config value is split to two of different types.
> > Fix the types accordingly.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> There was one typo which I commented (please fix when applying).
> Otherwise the series looks good to me,
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Fixed locally.

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



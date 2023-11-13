Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22B27E9B3C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjKMLfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjKMLfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:35:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19482D69;
        Mon, 13 Nov 2023 03:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699875335; x=1731411335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RD/WCvfoV+16HLNd+5scZiuZFdL49rMcOLxi/EFXgWc=;
  b=fKeP69VQJItiQxGhFH8h/A6AfOCUbNkIeV4wPOT6qiENhlYscUW6qqBP
   Zqi8c8LBKWN/1msphO3qWHyj2Jim/MuhDzEb8F6zMFRdzfaUm3UElxBA3
   gYqdIFcytKmkrAXefWyeDc8vPr5Dz4A/gXlJ4yiCuWMQ5llWaEEQX9WJw
   2TvWKnGMzikrBMOiYFmwhr+0BUC04s5Chn5lLXYmu+i0QkpO2yPxt9xsw
   c1VQ9+kJWt242YJTRYZMLKNuGFGoa0IrpRqqXY7kAbOT0kDd18oSc69pz
   SXjtoAGhNbTIaawpOhvs4fOqSqGDsn7q7We3aJ/spRyxBpYtkbV2C1VUL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="393283370"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="393283370"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 03:35:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="1011515730"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="1011515730"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 03:35:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r2VE1-0000000DXp0-1KRo;
        Mon, 13 Nov 2023 13:35:29 +0200
Date:   Mon, 13 Nov 2023 13:35:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 00/17] pinctrl: intel: Use NOIRQ PM helper
Message-ID: <ZVIKAB1cjEeyFf_E@smile.fi.intel.com>
References: <20231030120734.2831419-1-andriy.shevchenko@linux.intel.com>
 <20231110061422.GI17433@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110061422.GI17433@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 08:14:22AM +0200, Mika Westerberg wrote:
> On Mon, Oct 30, 2023 at 02:07:17PM +0200, Andy Shevchenko wrote:
> > Intel pin control drivers use NOIRQ variant of the PM callbacks.
> > To make them smaller and less error prone against different
> > kernel configurations (with possible defined but not used variables)
> > switch to use NOIRQ PM helper.

...

> Nice! For the series,
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



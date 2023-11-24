Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FE87F7270
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 12:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345740AbjKXLJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 06:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345362AbjKXLJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 06:09:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C02D64;
        Fri, 24 Nov 2023 03:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700824180; x=1732360180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3b0450yeKOhsXHRbmaL0w0QDUDUm2b2Mw4scsYFWfU0=;
  b=h8vDMejDiRfiMosg4KR+zieClq1aAKQDQuks2pV4iopZ0EOJXZVdOEO7
   FW5LR8tA81HnKoTUPmkfIMWn+Wt6gypjxjqTBy2HN7MoyzESVHVVrLMz+
   vP+DOsY65OoW9OVIhudJQiirAOZJEXQJMnZ28gYAm1ZWD7tORFLi1eshm
   PNAQRYjA45R58JMLnJXkAqDj7JY2RT0vf3Cn9tW3l4CO2JZ3DUUNu+siJ
   hnmf4fOQy5D+WJ/mq3J75Dl6ePx99wqyZbWOvDAEALHmpLkg0yLWSQKFp
   2uf/N6vF/zIPqowrOmKU80D+G3Iu6wBgrd+6+gD2mfEsCIiuKED10wHcC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="396313079"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="396313079"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 03:09:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="940899614"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="940899614"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 03:09:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r6U40-0000000GhBd-08JK;
        Fri, 24 Nov 2023 13:09:36 +0200
Date:   Fri, 24 Nov 2023 13:09:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: lynxpoint: Simplify code with cleanup
 helpers
Message-ID: <ZWCEbyCsLbCinq1V@smile.fi.intel.com>
References: <20231122175444.2316719-1-andriy.shevchenko@linux.intel.com>
 <20231124053429.GH1074920@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124053429.GH1074920@black.fi.intel.com>
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

On Fri, Nov 24, 2023 at 07:34:29AM +0200, Mika Westerberg wrote:
> On Wed, Nov 22, 2023 at 07:54:44PM +0200, Andy Shevchenko wrote:
> > Use macros defined in linux/cleanup.h to automate resource lifetime
> > control in the driver.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9251A7D8269
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344880AbjJZMSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjJZMSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:18:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8671B9;
        Thu, 26 Oct 2023 05:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698322689; x=1729858689;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4SIqzd7VmLdAqXDMR8AQjWqSByhKET1nuFOLf9Fl56Q=;
  b=L9OXc8Nm9Vf2G86eCJd/Cd7XI40cK+SkjrmRG9MeQ5gch2sfKSOc1gHd
   OxY9T+Ib02Kw63h1tfSz3oxLM8yBfvuxaT4t6h2UbaPnEtuW4Zo1MWtFo
   Jgq8abwPvSzEcFqantPwaAyYc+96b86Ep0Ih+pIFu1dArGoXl9Wlc/nw3
   qiuDYwBpzLqUZXxWb4yVwDFDc4j0CAkupWw2w/qYRIKS7vat2kZpcZs8G
   ztis3aGwEHUJxD+LvHZ/ORVEMFTbJeiAjwV3lzURh07y6oWK6+KVJ6TY4
   v97X8c/5X8zJmNm/X6vBvKTD24GszGyNTKdYrQzKzaJBaXwaCGSUoe3wv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="391395962"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="391395962"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 05:18:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="759165642"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="759165642"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 05:18:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qvzJL-00000008qmN-1Cq5;
        Thu, 26 Oct 2023 15:18:03 +0300
Date:   Thu, 26 Oct 2023 15:18:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     kristo@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        tony@atomide.com, claudiu.beznea@microchip.com, robh@kernel.org,
        dario.binacchi@amarulasolutions.com, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ti: fix possible memory leak in _ti_omap4_clkctrl_setup
Message-ID: <ZTpY+0PAApDo/2Om@smile.fi.intel.com>
References: <20231025090741.32997-1-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025090741.32997-1-hbh25y@gmail.com>
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

On Wed, Oct 25, 2023 at 05:07:41PM +0800, Hangyu Hua wrote:
> kstrndup and kstrdup_and_replace in clkctrl_get_name can perform

kstrndup()
kstrdup_and_replace()
clkctrl_get_name()

> dynamic memory allocation. So clkctrl_name needs to be freed when
> provider->clkdm_name is NULL.

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF077DCB0A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbjJaKmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjJaKmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:42:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4636783;
        Tue, 31 Oct 2023 03:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698748933; x=1730284933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9uZ64730+nuirrjXNVNzsndGS/0DAlcsQpQ+mk4LQFU=;
  b=HYnBXvPke/ccpEkT2ybMlW/FT4l5tnPAaysf7anctaQ4GNDRcXwflgPN
   ed2jqxzmUDCsf4HeoKXmU0fJd8O3+RV0tapd5wSrELQ/Ni5vrMLts56LA
   YyDMK6CPEf+aQltgUFt/xH0f0UcpQiSZyJljWQ4HxCXRom/9w7y0WkG1n
   wjUZ8oo29yu1wvsX5uhGykFlDSndGI4Cy/1Fgmw/ZRy2DhDbFEVpMQFL2
   4WwergOel5mJjDAj+2fjx0uB0m+IgDagjAi/XinnHnSctu4kK76IEAqaB
   9k8nrxmmmpxZ8Us1yutZG5IUQ/hPnoWxRb0nv8gwZlcgqca4sKyY8voI2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="1108639"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="1108639"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 03:42:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="795536405"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="795536405"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 03:42:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qxmCE-0000000A7Eh-1tq2;
        Tue, 31 Oct 2023 12:42:06 +0200
Date:   Tue, 31 Oct 2023 12:42:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     kristo@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        tony@atomide.com, claudiu.beznea@microchip.com, robh@kernel.org,
        dario.binacchi@amarulasolutions.com, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ti: fix possible memory leak in
 _ti_omap4_clkctrl_setup()
Message-ID: <ZUDZ_tDvM7oUBfkq@smile.fi.intel.com>
References: <20231031103010.23792-1-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031103010.23792-1-hbh25y@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 06:30:10PM +0800, Hangyu Hua wrote:
> kstrndup() and kstrdup_and_replace() in clkctrl_get_name() can perform
> dynamic memory allocation. So clkctrl_name needs to be freed when
> provider->clkdm_name is NULL.

> Fixes: bd46cd0b802d ("clk: ti: clkctrl: check return value of kasprintf()")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
> 
> 	 v2 and v3: fix commit info.

I believe I gave you my Rb tag. It's your responsibility to care it on if you
send a new version. Otherwise, please tell what makes you think that tag should
not be here?

-- 
With Best Regards,
Andy Shevchenko



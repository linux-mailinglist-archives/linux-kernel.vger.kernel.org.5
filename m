Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608B4780772
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358745AbjHRIrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358814AbjHRIrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:47:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6B93AA1;
        Fri, 18 Aug 2023 01:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692348419; x=1723884419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KktEApQVMKss72JNTNsuvANlVsqDOTFxayB0RNLemnA=;
  b=kddoKnrT/Snx+BgbGzdemqYtTWudqaWMKnlIfkZKyyCicgNBkHg8RCWO
   V+aWv+583yqQIWHtL8ZR9dIp7HmMCP+h8CBRTF7QzR7kBZfswu9QoxOt6
   awPAJLZn2NVsMohPp71Pvj3PHhoyGASc2T5oupD7dUD93eQRhebO8Titd
   175ATEoiSJcUHUFVQ8xWI8wWz5FzBRjlPCjIiC9rFK1cBz6pcgjmCacZG
   msLyeCLl9FyXVBGqfMl6t7KfzFolDDCe/vBtKFjcchYseHiMzAfFImgMF
   jhXHQwuVOh0I2dIakmjN9NPjvH7khwrLHcKuY7tVBw+40J5lBgZaZ6jpg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="436962793"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="436962793"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 01:46:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="1065661523"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="1065661523"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 18 Aug 2023 01:46:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qWv8B-000E2U-2t;
        Fri, 18 Aug 2023 11:46:55 +0300
Date:   Fri, 18 Aug 2023 11:46:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        qat-linux@intel.com, alx.manpages@gmail.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: Re: [PATCH 4/4] crypto: qat - add pm_status debugfs file
Message-ID: <ZN8v/2McQboR3dIu@smile.fi.intel.com>
References: <20230817143352.132583-1-lucas.segarra.fernandez@intel.com>
 <20230817143352.132583-5-lucas.segarra.fernandez@intel.com>
 <ZN8BipaGe6DOwiVS@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN8BipaGe6DOwiVS@gondor.apana.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 01:28:42PM +0800, Herbert Xu wrote:
> On Thu, Aug 17, 2023 at 04:33:17PM +0200, Lucas Segarra Fernandez wrote:
> >
> > +static struct pm_status_row pm_event_rows[] = {
> > +	PM_INFO_REGSET_ENTRY32(event_log[0], EVENT0),
> > +	PM_INFO_REGSET_ENTRY32(event_log[1], EVENT1),
> > +	PM_INFO_REGSET_ENTRY32(event_log[2], EVENT2),
> > +	PM_INFO_REGSET_ENTRY32(event_log[3], EVENT3),
> > +	PM_INFO_REGSET_ENTRY32(event_log[4], EVENT4),
> > +	PM_INFO_REGSET_ENTRY32(event_log[5], EVENT5),
> > +	PM_INFO_REGSET_ENTRY32(event_log[6], EVENT6),
> > +	PM_INFO_REGSET_ENTRY32(event_log[7], EVENT7),
> > +};
> > +
> > +static_assert(ARRAY_SIZE_OF_FIELD(struct icp_qat_fw_init_admin_pm_info, event_log) ==
> > +	      ARRAY_SIZE(pm_event_rows));
> 
> Was all of that churn just for this one line?
> 
> How about simply declaring a macro
> 
> 	#define QAT_NUMBER_OF_PM_EVENTS 8
> 
> and then use it for the two arrays:
> 
> 	static struct pm_status_row pm_event_rows[QAT_NUMBER_OF_PM_EVENTS] = {
> 
> 	__u32 event_log[QAT_NUMBER_OF_PM_EVENTS];
> 
> What am I missing?

Splitting ARRAY_SIZE() is very beneficial on its own.
The static assert is slightly more robust for the big code then defining
something that at some point can be missed or miscalculated. Yet we can
survive with a macro if you thinks it's better.

-- 
With Best Regards,
Andy Shevchenko



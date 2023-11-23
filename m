Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CF37F6121
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345717AbjKWOLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345696AbjKWOLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:11:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20BED48;
        Thu, 23 Nov 2023 06:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700748667; x=1732284667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bW0unczmLC8Z6r9eteprn03yFMbnTDGSjK+E3ygFzGI=;
  b=IkFfJ2unTcDpiczOCT2mYMkV6hdA58H6MWxphmFY/1OMFwqHlbt7G40s
   EieTa66QdrsCJRzX5fgwKMmKju4LFhtohODNt0yZmIlTH7ZfsP6JHQE/w
   bgr0TWNskDx5Nr2ZjwrHz/Myc44UDTHD1BiAkXNaG+0yCYR/SJMAlZ6os
   ovGLNSCzQHZga1qeYPUQr1M5ftZyQGTMP8BcBtD4D7Ng0cRtn/nvoDnSO
   ujhbxsUqeIgSP7pf1s3neCLPf8Qt//B3woojBa8uJKQq01YO34S8K09Iz
   FGvZKP+tr7CfLxLR1qcxycxKusKhlztbgOMh6w1/ivAF9Sk4vEo8U73iV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="478472474"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="478472474"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 06:11:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="911178084"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="911178084"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 06:11:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r6AQ3-0000000GO4A-2Uxq;
        Thu, 23 Nov 2023 16:11:03 +0200
Date:   Thu, 23 Nov 2023 16:11:03 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v1 2/4] leds: trigger: gpio: Convert to use kstrtox()
Message-ID: <ZV9dd6khfmWmj6D_@smile.fi.intel.com>
References: <20231103195310.948327-1-andriy.shevchenko@linux.intel.com>
 <20231103195310.948327-2-andriy.shevchenko@linux.intel.com>
 <20231123110538.GA1243364@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123110538.GA1243364@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 11:05:38AM +0000, Lee Jones wrote:
> On Fri, 03 Nov 2023, Andy Shevchenko wrote:

...

> > -	ret = sscanf(buf, "%u", &desired_brightness);

"%u" (see man sscanf() for the details)

...

> > +	ret = kstrtou8(buf, 10, &desired_brightness);
> 
> Where does 10 come from?

See above.

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA09375C40E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjGUKKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjGUKKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:10:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBBE2733;
        Fri, 21 Jul 2023 03:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689934204; x=1721470204;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t1QQKVzhlJ1Xn/AfZeblXQvq1hOA27QUiTChIE7xeCo=;
  b=TooINJqD6Bkp2PwWoxtikKPQsF/rbivq44e+dSzys90eqThu8Daj/Qva
   WY45/ni9n6r/XQXPMvxL1dcC2b9bSlmE/Xmtkxtiw9IMzuctvGay6qGtd
   lP67ZqvbV0UJzcHuE9oje2gkJ4sNgK6nvQtzTwEG/k5tRSMHp4O/A82pi
   HbSedwYOg3TnTLMu+ib+XcERtB53xwQXTOVjypIPaZoejEMAHub8eDX08
   IySCXuyeCFXsf4cl8JTyn89LVdP135OBpollcrwlOmib2uEIPO677Sq5P
   fiXrY0Qla9z8uD2q+WwmNo0a8rM0+lfXKIXC3r8YhV4wj8o9SJZXynRwO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="369661785"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="369661785"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:09:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="814889517"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="814889517"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jul 2023 03:09:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qMn4z-00Gyya-0x;
        Fri, 21 Jul 2023 13:09:45 +0300
Date:   Fri, 21 Jul 2023 13:09:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] serial: core: Controller id cannot be negative
Message-ID: <ZLpZabV4FRgtXGL8@smile.fi.intel.com>
References: <20230720051021.14961-1-tony@atomide.com>
 <20230720051021.14961-2-tony@atomide.com>
 <2023072022-country-replace-68ca@gregkh>
 <20230721054326.GO5194@atomide.com>
 <2023072144-splurge-debate-e681@gregkh>
 <20230721061523.GP5194@atomide.com>
 <20230721065701.GQ5194@atomide.com>
 <2023072109-fidelity-modular-4074@gregkh>
 <20230721071753.GR5194@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721071753.GR5194@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 10:17:53AM +0300, Tony Lindgren wrote:
> * Greg Kroah-Hartman <gregkh@linuxfoundation.org> [230721 07:07]:

...

> Also I noticed that using git send-email --cc-cover does
> not work for the cover letter.. It tries to use the first patch that
> is the cover letter or something like that. I'm going back to my custom
> email scripts for now rather than try to have git handle things
> automagically.

I have my script [1] that shows good enough results to send patches.
I suggest give it a try :-)

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

-- 
With Best Regards,
Andy Shevchenko



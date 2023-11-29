Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051277FD8F7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbjK2OJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjK2OJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:09:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E844AF;
        Wed, 29 Nov 2023 06:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701266948; x=1732802948;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+fOWzb6OXn2tsYSYA4iym/lgxytyGV3SehVFw4FWBT4=;
  b=nV1VAOSjGtLFBtCDf1/uECk48bBqSyNHf9fH4z7sdytjXDZrJLfd7ydC
   1FS41I6kw1RZA9A4eEmTcKsYetF4buvBlpoUkp3BMdQVO1LIApfQDrtMh
   KHULyOD4ygW1kOL/6KYBypb6WEXmiU7LKWmL7wusCT+2t5AmlqpZ6gSfU
   lgvgVj5j7y4svss7UTFN1qGaD8HM1Dh+AhzIs/ZrzOSmC7fUDXCYzEVMa
   hL7ZAwppkWDq0++x6IqR6WSidpUBgwSvY9BOVyzapole/mGwhRnVcMFp7
   u9tOaG3FGMRsZcWBNwAm8qQ2ap8fQ5moSZet4gOEXzo1y4Nz7vhO/HQAl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="152877"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="152877"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 06:09:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="912865925"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="912865925"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 06:09:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r8LFO-00000000SOq-0Aua;
        Wed, 29 Nov 2023 16:09:02 +0200
Date:   Wed, 29 Nov 2023 16:09:01 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v1 3/4] ACPI: OSL: Allow Notify () handlers to run on all
 CPUs
Message-ID: <ZWdF_XdUD6gxtYIW@smile.fi.intel.com>
References: <3281896.aeNJFYEL58@kreacher>
 <7617703.EvYhyI6sBW@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7617703.EvYhyI6sBW@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 02:50:54PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notify () handlers, like GPE handlers, are only allowed to run on CPU0
> now out of the concern that they might trigger an SMM trap and that (in
> some cases) the SMM code running as a result of that might corrupt
> memory if not run on CPU0.

Pardon my French, but I'm a bit lost in the semantics of all those "that".
Maybe the above can be simplified?

> However, Notify () handlers are registered by kernel code and they
> are not likely to evaluate AML that would trigger an SMM trap.  In
> fact, many of them don't even evaluate any AML at all and even if
> they do, that AML may as well be evaluated in other code paths.  In
> other words, they are not special from the AML evaluation perspective,
> so there is no real reason to treat them in any special way.
> 
> Accordingly, allow Notify () handlers, unlike GPE handlers, to be
> executed by all CPUs in the system.
> 
> Also adjust the allocation of the "notify" workqueue to allow multiple
> handlers to be executed at the same time, because they need not be
> serialized.

Code wise LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



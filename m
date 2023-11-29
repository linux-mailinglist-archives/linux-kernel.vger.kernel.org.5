Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB9D7FDA63
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbjK2OwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbjK2OwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:52:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D74BD6E;
        Wed, 29 Nov 2023 06:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701269529; x=1732805529;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iBvOUeV8GInwE1URST0+LDM0euJ0nkLB2pW7xGvI54M=;
  b=DllLsTbCDGzsiRjyGLwYTZ/fsdnOC6DIkSEgvSDLNDjvDoyi2JmkZMir
   vJd/ltvdRjonJ07scRO1YChX/VdC8jHpT/sUzHJ/JeMazw1J0+U7eG3c3
   VQB6y58UXlTIDjmh8YYHF0/mMdcqOehgIihDIYkQZp7GigZabjI2kawHW
   5rfVXI2N2Sk2fGLTVvz94HZ9a1rNJBENX+9OjUm5Wzof1Fae4uD8ETuy9
   VS2jHlT6eoOSi7pNhMeMQLpNABI1jmh02R7ysrxujhztUiCxOKz2xKeg4
   Dszk9f8HjHfUp1Fdd3JtQ+T0MKhQikf1Tj/gPnCm1sg9ShYZ1ivcv2imJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="6386724"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="6386724"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 06:52:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="942347393"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="942347393"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 06:48:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r8Lrx-00000000Svm-1uUE;
        Wed, 29 Nov 2023 16:48:53 +0200
Date:   Wed, 29 Nov 2023 16:48:53 +0200
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
Subject: Re: [PATCH v1 2/4] ACPI: OSL: Rearrange workqueue selection in
 acpi_os_execute()
Message-ID: <ZWdPVSf4DTzliQ_L@smile.fi.intel.com>
References: <3281896.aeNJFYEL58@kreacher>
 <2267180.iZASKD2KPV@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2267180.iZASKD2KPV@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 02:48:22PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace the 3-branch if () statement used for selecting the target
> workqueue in acpi_os_execute() with a switch () one that is more
> suitable for this purpose and carry out the work item initialization
> before it to avoid code duplication.
> 
> No intentional functional impact.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



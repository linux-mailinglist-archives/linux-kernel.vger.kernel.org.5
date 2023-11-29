Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC487FD90C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbjK2OKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjK2OKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:10:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A20FAF;
        Wed, 29 Nov 2023 06:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701267045; x=1732803045;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eQal9aMivxpFDhH6E/QqJF0j6TwRxcsMoHWT7iUi6lE=;
  b=JmPAib3IS4BO+8P9Q2Uy2ddreTeBR3rGJp+DAJzIvB2ufw1e0NDxhErv
   clN0f3gwMglpkCeBgz8+NdSU1xeCKCdvM+mSiBCZmQLHj0rUYk8WrV/fl
   wxnbLDwV7d+ue0DUIbRL9c2owG8gZL61X86M+jZ2OJ9B14Sm6gXFRGWR3
   JX4YOReJrkqNWX38O+5+6fDBCiAzWXL8X1OEXIOUfb+L1ccWBVdgNZRSe
   /IQ3r2st6Lmxaaw7XcLkMLk1OVeCNTvobZN7XXSoEVs7jakdHviQTbhE3
   bQ8zyq9M81hugbcIQ4T2nXLMS2/Eg9MZg2N6EV8Tzj5fYW/bjML8UPsQP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="479368531"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="479368531"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 06:10:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="762327083"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="762327083"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 06:10:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r8LGu-00000000SPr-3ztj;
        Wed, 29 Nov 2023 16:10:36 +0200
Date:   Wed, 29 Nov 2023 16:10:36 +0200
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
Subject: Re: [PATCH v1 1/4] ACPI: OSL: Rework error handling in
 acpi_os_execute()
Message-ID: <ZWdGXAFdLhZVKPmW@smile.fi.intel.com>
References: <3281896.aeNJFYEL58@kreacher>
 <8321623.T7Z3S40VBb@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8321623.T7Z3S40VBb@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 02:46:51PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Reduce the number of checks and goto labels related to error handling
> in acpi_os_execute() and drop the status local variable, which turns
> out to be redundant, from it.
> 
> No intentional functional impact.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



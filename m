Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975547FD8FC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbjK2OKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbjK2OKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:10:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1FA1AD;
        Wed, 29 Nov 2023 06:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701267013; x=1732803013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MN4A6IGsZ2ef5MgVmL424WRLbkGtvA0G27iaAixyti4=;
  b=KLAGKr+UhptKv2t0VwImV2pDTGcQrkS2ROZuz3BPWUc4g8IH+P0vdzMd
   MhcnFwz/wEuMVMjEIKT3+5TfqFonHoEb5aKAssTvk+uYYTDtB3exdz0dZ
   eMT4SctT/deZ8sfMuPI4nTSQ4/fF253HyvERRjgRw7CFzjV1xP8QxKkxJ
   EC85QOpKbKMZDp3K7QQdkMOiCN2rgI/snQ3pVgadOaePGS9GKno0EUR2m
   f0m2Z6pCk8lOt/uctwodI9NwIIw4nvsIgLVxTVEHWlTLVgsZ18NEmnEzJ
   1RcjqYSEWn1+wbdjuyjjVydgEn8hjdmKwQGwtGpGs8CP/m/vuIr0KsZaQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="373351613"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="373351613"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 06:10:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="772692335"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="772692335"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 06:10:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r8LGR-00000000SPV-3Lb3;
        Wed, 29 Nov 2023 16:10:07 +0200
Date:   Wed, 29 Nov 2023 16:10:07 +0200
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
Subject: Re: [PATCH v1 4/4] ACPI: OSL: Use GFP_KERNEL for work item
 allocations
Message-ID: <ZWdGP3wH1uvESpfe@smile.fi.intel.com>
References: <3281896.aeNJFYEL58@kreacher>
 <3552364.iIbC2pHGDl@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3552364.iIbC2pHGDl@kreacher>
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

On Wed, Nov 29, 2023 at 02:52:22PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After the recent modification changing the ACPI SCI interrupt handler
> into a threaded one, the SCI interrupt handler code does not run in
> interrupt context any more and acpi_os_execute(), that may be invoked
> by it, need not use GFP_ATOMIC for allocating work items.
> 
> Make it use GFP_KERNEL instead.

True, threader IRQ handler can sleep.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



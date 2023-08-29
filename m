Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C1B78C6C6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbjH2ODg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236866AbjH2ODd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:03:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1132CF4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693317789; x=1724853789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2x8gNsfNw+4RciIxgwJfn82TXN7RXZlGlS1eqek6Ss0=;
  b=QQHMI/uH8IiMI033EBrY2DlB0q0EKFG6quGhzuo+3EtyQTPVmpe+KKBZ
   oHGm2mI0SVCjF+SLvVYZy9RHjte+qnGCcbOoytoIdNh5kTE4OTAbsUjgH
   NGHUEr6oshhYJKXPm7gULXTJQD8x/Q0j1vfitQc5iDf7+9EseR0F8waRe
   79MdP/DKnG4RXiHD/vM9zhnWxRauBNsQxGu+z5Go6hxfHbAfxF7O1SiRI
   bZc6AKXZYq6sGcp5syY/zume0Ma+dFiktasR3gmIOuKo9oA6K3oVod9f9
   NGx4HOWWOzWHtFHff3vUt/Jq48AxLsKScUj+YsvdGgSOm5xLtSitHERGE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="354887888"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="354887888"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 07:02:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="688519546"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="688519546"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 29 Aug 2023 07:02:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qazIp-004tfH-2p;
        Tue, 29 Aug 2023 17:02:43 +0300
Date:   Tue, 29 Aug 2023 17:02:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        artem.bityutskiy@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, lenb@kernel.org,
        jgross@suse.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] ACPI: processor: Move MWAIT quirk out of acpi_processor.c
Message-ID: <ZO36g3IOX7UU0X5l@smile.fi.intel.com>
References: <c7a05a44-c0be-46c2-a21d-b242524d482b@roeck-us.net>
 <CAJZ5v0jASjc_RYp-SN5KMGJXDv8xbMOqJscLF3wG8rdE2_KJGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jASjc_RYp-SN5KMGJXDv8xbMOqJscLF3wG8rdE2_KJGw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 03:54:18PM +0200, Rafael J. Wysocki wrote:
> On Tue, Aug 29, 2023 at 3:44 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > On Mon, Jul 10, 2023 at 05:03:29PM +0300, Michal Wilczynski wrote:
> > > Commit 2a2a64714d9c ("ACPI: Disable MWAIT via DMI on broken Compal board")
> > > introduced a workaround for MWAIT for a specific x86 system.
> > >
> > > Move the code outside of acpi_processor.c to acpi/x86/ directory for
> > > consistency and rename the functions associated with it, so their names
> > > start with "acpi_proc_quirk_" to make the goal obvious.
> > >
> > > No intentional functional impact.
> >
> > Except for:
> >
> > ia64-linux-ld: drivers/acpi/acpi_processor.o: in function `acpi_early_processor_control_setup':
> > acpi_processor.c:(.init.text+0x712): undefined reference to `acpi_proc_quirk_mwait_check'
> > ia64-linux-ld: drivers/acpi/processor_pdc.o: in function `acpi_early_processor_set_pdc':
> > processor_pdc.c:(.init.text+0x72): undefined reference to `acpi_proc_quirk_mwait_check'
> >
> > which breaks all ia64 builds.
> >
> > Time to retire that architecture yet ? No one but me seems to even
> > build test it.
> 
> Including 0-day it seems.  This had been in linux-next for several weeks.

IIRC someone explicitly asked to shut down 0-day on ia64. Maybe I'm mistaken?
I would suggest to ask internally Dave Hansen et al for this.

-- 
With Best Regards,
Andy Shevchenko



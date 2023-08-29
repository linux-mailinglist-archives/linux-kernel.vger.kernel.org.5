Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A753678C849
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbjH2PG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237070AbjH2PGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:06:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501A31B4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693321555; x=1724857555;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D6VKkkNMPEOdxq9OE83EoftbQvBINjMSIrgIqmUSrJg=;
  b=eehBfsg1LCrsg6Du6c+YBa37Y7CrAxHEqO5IpS/ohcw1EM7QYS0j62nI
   gtRMFP6FR2cV7xnj/2oP6bItH/TfBdPWfWsj30KvNPsMgK7ClER2O00+D
   aa87ni7fNcvwjLKyrlJkVqIE1vDbGCN+4Umd3oPUlB7sV+2AGSna52hgd
   JBT0mCGGL5ybua5qwQfY+JjyQ+SPZkiTAYP3vJbLbgUADzEXQVpGlSXkD
   /1zDKKVzR8TclV/z4oLVkt8r9mAG0c6HkZgOmWY4mvYcbYWCckLr1oOqM
   dAfmo7KlkGsR1CXUsUkwrkNcC7DWnUisNxOCCGoecqh9dFVEUmXqbCVWe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="439345797"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="439345797"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 08:05:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="882363169"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 29 Aug 2023 08:05:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qb0Hs-004uUa-1o;
        Tue, 29 Aug 2023 18:05:48 +0300
Date:   Tue, 29 Aug 2023 18:05:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Wilczynski, Michal" <michal.wilczynski@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        artem.bityutskiy@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, lenb@kernel.org,
        jgross@suse.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] ACPI: processor: Move MWAIT quirk out of acpi_processor.c
Message-ID: <ZO4JTIiygSQf+eKC@smile.fi.intel.com>
References: <c7a05a44-c0be-46c2-a21d-b242524d482b@roeck-us.net>
 <CAJZ5v0jASjc_RYp-SN5KMGJXDv8xbMOqJscLF3wG8rdE2_KJGw@mail.gmail.com>
 <3fd2e62d-0aa9-1098-3eb3-ed45460a3580@intel.com>
 <CAJZ5v0hnNK4O_HyinvTp01YxXR7V4vzpMhf85yW9M2=52-O2Fg@mail.gmail.com>
 <60bea4fb-9044-76f1-fe2b-ddc35c526d5c@intel.com>
 <CAJZ5v0hkNFof_Wy0FmPAizuOT9WPEEPW+R27UCgERhS1ZKjOBw@mail.gmail.com>
 <6a50e2c7-a73b-ff02-3e36-e7477ea7dc4d@intel.com>
 <24860c20-0e08-46d6-8016-5cbbb97b4550@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24860c20-0e08-46d6-8016-5cbbb97b4550@roeck-us.net>
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

On Tue, Aug 29, 2023 at 07:53:21AM -0700, Guenter Roeck wrote:
> On Tue, Aug 29, 2023 at 04:38:33PM +0200, Wilczynski, Michal wrote:

[ ... ]

> Or just drop it. From Ard Biesheuvel's e-mail sent to 0-day:
> 
>     > Hello all,
>     >
>     > The Linux community is currently in the process of deprecating the
>     > Itanium IA-64 architecture, which no longer has a maintainer or any
>     > actual users.
>     >
>     > We aim to remove it entirely from the Linux tree before the end of the
>     > year, but one of the first steps is to stop build testing it - there
>     > is really no point any longer in spending any cycles on this, and it
>     > is definitely undesirable to inform developers by email if their
>     > changes result in any build issues on IA-64.
>     >
>     > So please remove IA64 from the set of architectures that are build
>     > tested by LKP.
> 
> This is from the 0-day commit log disabling ia64 build tests. I have now
> disabled ia64 in my build tests as well.

Oh, nice! Thank you for digging this up!

-- 
With Best Regards,
Andy Shevchenko



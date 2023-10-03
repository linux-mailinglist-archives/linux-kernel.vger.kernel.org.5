Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FCF7B64A9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239347AbjJCIsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjJCIst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:48:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B44CA9;
        Tue,  3 Oct 2023 01:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696322926; x=1727858926;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x8PAGnQYc2NcxY6KGr2gS4Kpd9E+7T9nG0n2qjbE0G4=;
  b=E9Nk42yQdXYVPv9CemGIYi4TtUEjDTDueZJnm4x31IBnn7+Au0xUuaLI
   ZI0QTQc2AW30Sfe7B5J1GZoB4MEMZJRiRqtTuEjqwcWCLysuWUZn+4Xie
   JcQzJl3V/Qk293lvykAMSOO2Ye7MLdcShGh04nyy9w5SVore2/ZSnOLSa
   RVMcZ0E48rYqJssYGxZKuczM3o/RShFy9AkQIy2rHVJipNmk83V+vJVFH
   DjudnMJWJCDWsKaUie2irRZ/WZHpA3kgkLGEZrb8XMs0Lnji7DKUeC0ze
   p5rFivJeJAu3MxMNVLK+Ser5fXMdArpOwRYEu2GfnfurKzU0SS62JKaWT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="380101442"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="380101442"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 01:48:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="727546647"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="727546647"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 01:48:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qnb55-00000002R9j-2xen;
        Tue, 03 Oct 2023 11:48:39 +0300
Date:   Tue, 3 Oct 2023 11:48:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>
Cc:     nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/1] ACPI: NFIT: Switch to use
 acpi_evaluate_dsm_typed()
Message-ID: <ZRvVZylnYeIBDEH/@smile.fi.intel.com>
References: <20231002135458.2603293-1-andriy.shevchenko@linux.intel.com>
 <ec5029b0-553c-4a6c-b2a9-ef9943e553dc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec5029b0-553c-4a6c-b2a9-ef9943e553dc@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 10:27:02PM +0200, Wilczynski, Michal wrote:
> On 10/2/2023 3:54 PM, Andy Shevchenko wrote:

...

> > +	out_obj = acpi_evaluate_dsm_typed(handle, guid, revid, func, &in_obj, ACPI_TYPE_BUFFER);
> 
> This line is 90 characters long, wouldn't it be better to split it ?

I dunno it's a problem, but if people insist, I can redo that.

...

> > +	if (!out_obj || out_obj->buffer.length < sizeof(smart)) {
> >  		dev_dbg(dev->parent, "%s: failed to retrieve initial health\n",
> >  				dev_name(dev));
> 
> While at it maybe fix alignment ? :-)

I don't think it's in scope of this change.

> >  		ACPI_FREE(out_obj);
> 
> Just nitpicks, functionally code seems correct to me.
> Reviewed-by: Michal Wilczynski <michal.wilczynski@intel.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



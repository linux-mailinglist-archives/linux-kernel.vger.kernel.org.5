Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353E47B4F20
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbjJBJh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjJBJhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:37:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8991F83;
        Mon,  2 Oct 2023 02:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696239442; x=1727775442;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uRt1ae+PaFLvuL/WtDM9bT7telz1ws3WCIW7qDvGk1I=;
  b=OpqjdQ+RfN2HHXUytaVXv+98kieVoqp66+s0a1hUD1s4lmWNUzzbLgZo
   U+ajP9d2+Cw8demaNymvpvl8erEDdeuKQhB4PV9gcqx7QqnZdh6cxiWfg
   7PX3285lyv9PIjWThNgYmeKtf5xOabs9y7YYPMH8JPM0Jnrg68GUKflkF
   syVqlZmADsHe5uYtXV23WC8E/vgfnFfFnS7k4PSaQMSNALPLsRJJggCZv
   jgn9juTo09AcD5k+v4ie5b13q8C7iMuuj6ltn0uY+GyyisJD4AcXMp5LF
   dawsqdGxC71LCL2D1wrP++KDnaJJ2WmqTNzbtVEkImY1m2S6V216irOVG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="361987748"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="361987748"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:37:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="997573837"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="997573837"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:37:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qnFMO-000000027Z7-0xKM;
        Mon, 02 Oct 2023 12:37:04 +0300
Date:   Mon, 2 Oct 2023 12:37:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev, rafael.j.wysocki@intel.com,
        lenb@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com
Subject: Re: [PATCH v1 1/2] ACPI: NFIT: Fix memory leak, and local use of
 devm_*()
Message-ID: <ZRqPP9xT9fqrZLQS@smile.fi.intel.com>
References: <20230926184520.2239723-1-michal.wilczynski@intel.com>
 <20230926184520.2239723-2-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926184520.2239723-2-michal.wilczynski@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 09:45:19PM +0300, Michal Wilczynski wrote:
> devm_*() family of functions purpose is managing memory attached to a
> device. So in general it should only be used for allocations that should
> last for the whole lifecycle of the device. This is not the case for
> acpi_nfit_init_interleave_set(). There are two allocations that are only
> used locally in this function. What's more - if the function exits on
> error path memory is never freed. It's still attached to dev and would
> be freed on device detach, so this leak could be called a 'local leak'.
> 
> Fix this by switching from devm_kcalloc() to kcalloc(), and adding
> proper rollback.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7FA77FCD3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352978AbjHQRQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353881AbjHQRQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:16:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3E5BF;
        Thu, 17 Aug 2023 10:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692292579; x=1723828579;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o6y1BWMjXV74XcSSqEAshBC+8ARHfDknIFta4VOIKeI=;
  b=BMlf1mxqOuBaqf9AjT5fQ/ZbjjIwZSwWNkIny0Xcrp1Hso6P54u32261
   HIUenyzN0dQ4p4TWFDPgV0RRbcRlEFm3BNpMrOsox1LgxdpWPSoLeLjsC
   jvJ+2MJQaKurl/WL68I7EFzHHREfiJ1imvDi7gycKeTyFmkbp9MTpeee1
   XybcTvP/BVylGIpWY56FvdtqKfNW5QoEWKkZPEwJstmOTbh9UAj0efkQa
   bocUEIZq0I00PqtvIFnpQ3VNzfI6s3HY/rjpjY0ljZL6LMh+lQOO3ZiaS
   J6wqopLeDbChLdgh4Db/bv7Ln90DFdVlqUa7/33mXF+CvYiXzTq9K2oHg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="372866611"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="372866611"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 10:15:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="804770162"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="804770162"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2023 10:15:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWgbB-003a75-3B;
        Thu, 17 Aug 2023 20:15:53 +0300
Date:   Thu, 17 Aug 2023 20:15:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] of: dynamic: Move dead property list check into
 property add/update functions
Message-ID: <ZN5Vyd22nwx0l5mM@smile.fi.intel.com>
References: <20230801-dt-changeset-fixes-v2-0-c2b701579dee@kernel.org>
 <20230801-dt-changeset-fixes-v2-5-c2b701579dee@kernel.org>
 <ZNEPqwQ0H9srkxxq@smile.fi.intel.com>
 <20230817170934.GA1495946-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817170934.GA1495946-robh@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 12:09:34PM -0500, Rob Herring wrote:
> On Mon, Aug 07, 2023 at 06:37:15PM +0300, Andy Shevchenko wrote:
> > On Fri, Aug 04, 2023 at 04:41:55PM -0600, Rob Herring wrote:

...

> > Suggested-by: ? :-)
> 
> Humm, by me? The change in behavior and point of this patch comes from 
> me. You've provided review comments which will get covered by a
> Reviewed-by I presume.

OK!

-- 
With Best Regards,
Andy Shevchenko



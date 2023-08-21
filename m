Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0E878276A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjHUKwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 06:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjHUKwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:52:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72F0D9;
        Mon, 21 Aug 2023 03:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692615160; x=1724151160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nO9ZFLRZ+pQwUcXusWHoQJ4JMlocAKBzzP9xBktA8wg=;
  b=FdXYBqgWFLqccE11cweqZPcihSeVtlP34RP0KSPQXnbeJNneSSoB2vC+
   CMwJfnXCzL1aRABs0zJCP84YaJTV++xMTHtGe0SUzEJeCoKEJe+aCaGgZ
   n51b4xUVxtAl6vp1Mt+bvtYaJhkFWdyDG4CEfO3JrNZ/Y3yw9q1gibgje
   qMm2CpsxM0nL6Qmq6m3N2tH1MkMDdUOC/D0FAkpFVf9E2P3w5q8LKGCJ6
   JRR2oYeJQJYcNiYomdEOS4cjZLrsO6EFAR2Y/0/njjZRmc7JbcdytwkK8
   i5eq3jFqZ7IYEvThowfgWxgi4IBO4KO12vljuq38ukAxC3H5ss+1xH7Ek
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="404560336"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="404560336"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 03:52:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="1066562679"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="1066562679"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 21 Aug 2023 03:52:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qY2WR-00AYQo-1d;
        Mon, 21 Aug 2023 13:52:35 +0300
Date:   Mon, 21 Aug 2023 13:52:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] of: dynamic: Move dead property list check into
 property add/update functions
Message-ID: <ZONB85sZreII1Z9q@smile.fi.intel.com>
References: <20230801-dt-changeset-fixes-v3-0-5f0410e007dd@kernel.org>
 <20230801-dt-changeset-fixes-v3-5-5f0410e007dd@kernel.org>
 <ZONBMMVrzuu53hwC@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZONBMMVrzuu53hwC@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 01:49:20PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 18, 2023 at 03:41:00PM -0500, Rob Herring wrote:

...

> > v3:
> >  - Keep existing style in deadprops loop
> 
> Not sure where exactly in the code that one, but...

> ...if it's this one, I don't see how it's better than

Also check the comment for the next patch.

-- 
With Best Regards,
Andy Shevchenko



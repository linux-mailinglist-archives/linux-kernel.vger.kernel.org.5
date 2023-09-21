Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC147A9DDB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjIUTuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjIUTtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:49:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C987D7D735
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318645; x=1726854645;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dk15iRd1aecBASo2ilC0TfiCW6JmsYJjN8LYbsqz3K0=;
  b=DJh7vO8oKsUIn9HtwgaMgUJ8BKZ3sZsOdETah2XbI/HzInkT4tRLErEF
   OUqaWcaN8HvDMQQLqlmXdqriaW5Jps/B2jnHVJxvBm1M6lFvoj1MCTsdQ
   1MzwdIgWyJbiTpjEKmKoTPHT8ABOZK9HekETCeMjuiaHk9iB7e1eUuGev
   s5gOP8Kb/AkCuvEI8wel4oMda0SAQa+flvq6aGAT7jG1VJ21zl7kRflY1
   SZml21kVt8PBeeGcSyfvcXjG7Ubq9N0xygJXxfZS0iFPHxjVRBcOiGO9Y
   T8ElZ9bSwr+2R7wZ+HfMEy2JzGkxxdbXhICdvKStctStJ2vgGKtfoBI/m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="384313889"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="384313889"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 02:36:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="812571405"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="812571405"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 02:36:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qjG73-0000000Gqt1-1S5R;
        Thu, 21 Sep 2023 12:36:45 +0300
Date:   Thu, 21 Sep 2023 12:36:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/6] params: Use sysfs_emit() to instead of scnprintf()
Message-ID: <ZQwOrCtkhVSikWhE@smile.fi.intel.com>
References: <20230912150551.401537-1-andriy.shevchenko@linux.intel.com>
 <ZQiBhRCGG13CNWqt@smile.fi.intel.com>
 <ZQuPNzgJfPILOTHq@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQuPNzgJfPILOTHq@bombadil.infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 05:32:55PM -0700, Luis Chamberlain wrote:
> On Mon, Sep 18, 2023 at 07:57:41PM +0300, Andy Shevchenko wrote:
> > On Tue, Sep 12, 2023 at 06:05:46PM +0300, Andy Shevchenko wrote:
> > > Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> > > should only use sysfs_emit() or sysfs_emit_at() when formatting the
> > > value to be returned to user space.
> > 
> > Any comments?
> 
> What tree were you taretting, looks sane to me.

I see that you was a person with last SoB in late patches in that area.
Whatever it went through in your case.

P.S. TBH I thought you have your own tree for things like this...

-- 
With Best Regards,
Andy Shevchenko



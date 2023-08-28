Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33DE78B0C9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 14:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjH1Mmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 08:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjH1Mmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:42:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E27107
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 05:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693226553; x=1724762553;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tvNba5dsGVy14uXWrWuJ3hHVDQ7/CZCqBs6ssRH5Yfg=;
  b=kQB9l/5hPwqsfeaJXw9SVX+Z2iDHt5a9NDR814Dm0KGJxj/DS10c4sPV
   2eD+WwtU7YWCiHjUpPkcjh1vRkBcguoFTyAaA9j/nZLf6wSn17El8kRLs
   KbAiDfZBytEEfjDDJNdRdt80XicdiEyqjGxh4Otew/amS597ooJbtcXBf
   4MTXOr95+RdfDc4Hwylgp/BzszW9MYpFiALk9ltqD0W3HmYpHxsTuKm/m
   7aOYIVIyCINaCu9paou6I1tRujpCIOFbmcD9aaeDAlMp+Mxp53R5yNAf1
   0UN/Dc1qgLmAVjG2lUs4T1gk/JUdTWfhOg2UVzi+unt1R13mJheqvaXfP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="439037120"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="439037120"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 05:42:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="912040532"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="912040532"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 28 Aug 2023 05:42:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qabZc-000yVi-1S;
        Mon, 28 Aug 2023 15:42:28 +0300
Date:   Mon, 28 Aug 2023 15:42:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     syzbot <syzbot+bdfb03b1ec8b342c12cb@syzkaller.appspotmail.com>,
        hdanton@sina.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] general protection fault in
 nfc_register_device
Message-ID: <ZOyWNNNjnClWlUQg@smile.fi.intel.com>
References: <0000000000001b6a0c0603f8ab85@google.com>
 <ZOyGeUk89gwLAKPJ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOyGeUk89gwLAKPJ@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 02:35:22PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 28, 2023 at 02:53:37AM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> 
> Thanks! Will work on it ASAP.

So, can somebody from syzbot explain me what this is?

My readings as follows:
1) syzbot inserts fault injection into

        dev_set_name(&dev->dev, "nfc%d", dev->idx);

2) that becomes a NULL in the corresponding kobj->name, correct?
3) which leads to the device_add() to exercise the paths that check for name
   being NULL, i.e.

     if (dev->init_name) {
        error = dev_set_name(dev, "%s", dev->init_name);
        dev->init_name = NULL;
     }

     if (dev_name(dev))
         error = 0;
     /* subsystems can specify simple device enumeration */
     else if (dev->bus && dev->bus->dev_name)
         error = dev_set_name(dev, "%s%u", dev->bus->dev_name, dev->id);
     if (error)
         goto name_error;

   so, either we have init_name or bus->name defined, but this seems not
   the case; anyway in both cases the dev_set_name() may fail in strchr()
   if and only if the fmt is NULL, which is not, as above calls have it
   hard coded literals.

What's going on here?

(The error check for dev_set_name() in nfc_allocate_device() probably fixes
 this, but it must not affect the code execution, right?)

P.S.
Of course the test patch from hdanton@ doesn't fix it, the error is checked in
the code later on.

-- 
With Best Regards,
Andy Shevchenko



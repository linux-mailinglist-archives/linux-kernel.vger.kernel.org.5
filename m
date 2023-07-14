Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D577534B1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbjGNIJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbjGNIIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:08:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4864D46B6;
        Fri, 14 Jul 2023 01:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689321990; x=1720857990;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fkEz5ngu5Jx0yxp4LTMvoYpwTKcv6182sEOb+9SRMDc=;
  b=oJ5rrXQeMX7aUpi15rx0ixnvmLEjJoIk6kCwYR60N7KRnPFZkCYM6Ja8
   RvH/9N5yRb55b3IqJ1bGCBuOvS8ohxqlrpvVelzd/U6Nk+KLbR10ThMWj
   ETvRpCz6093gquQI0cBhlm1jUvXkzsCaughntPJuKvD3bc0upqEf7szSM
   If1MuViNl9wmv6UjEW4h1T/NeD6kmAnfPCiTMbzAon5PsfypWtdbHgTLw
   rEZG/c3+dHa9x3zzYXt8iTe0Ddo24pUs+nH+YWYrMdBPtfCFMfkZHQSa2
   8ZHeQHWV4G9pcWwzZF9DDrvl/F39f6zm8J7XknHIlTJS1Wkr4z7Bs7jQh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="345014317"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="345014317"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 01:06:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="812338488"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="812338488"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jul 2023 01:05:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qKDoL-002bC8-1D;
        Fri, 14 Jul 2023 11:05:57 +0300
Date:   Fri, 14 Jul 2023 11:05:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     luoruihong <colorsu1922@gmail.com>
Cc:     ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, luoruihong@xiaomi.com,
        weipengliang@xiaomi.com, wengjinfei@xiaomi.com
Subject: Re:
Message-ID: <ZLEB5fxhJ/GDVX4W@smile.fi.intel.com>
References: <64b09dbb.630a0220.e80b9.e2ed@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64b09dbb.630a0220.e80b9.e2ed@mx.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 08:58:29AM +0800, luoruihong wrote:
> On Thu, Jul 13, 2023 at 07:51:14PM +0300, Andy Shevchenko wrote:
> > On Thu, Jul 13, 2023 at 08:42:36AM +0800, Ruihong Luo wrote:
> > > Preserve the original value of the Divisor Latch Fraction (DLF) register.
> > > When the DLF register is modified without preservation, it can disrupt
> > > the baudrate settings established by firmware or bootloader, leading to
> > > data corruption and the generation of unreadable or distorted characters.
> >
> > You forgot to add my tag. Why? Do you think the name of variable warrants this?
> > Whatever,
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Next time if you don't pick up somebody's tag, care to explain in the changelog
> > why.
> >
> > > Fixes: 701c5e73b296 ("serial: 8250_dw: add fractional divisor support")
> > > Signed-off-by: Ruihong Luo <colorsu1922@gmail.com>
> 
> I'm sorry, I didn't know about this rule. Thank you for helping me add
> the missing tags back and for all your previous kind assistance.

For now no need to do anything, just wait for Ilpo's and/or Greg's answer(s),

-- 
With Best Regards,
Andy Shevchenko



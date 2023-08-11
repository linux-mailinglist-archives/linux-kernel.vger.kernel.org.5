Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CE1778984
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbjHKJOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjHKJOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:14:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564E11BD;
        Fri, 11 Aug 2023 02:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691745247; x=1723281247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lGakJNNFUtfZiqP/sKV4opLGlYZoNKOYhGGsZPRr5UI=;
  b=SSUPpS9gYFpdPPXQpVlb5LSQgkuDDe9y+vDyx/3XVHSODf39Kakgzk7U
   w7sQ0c5vmkVi9v7fmwHD9tPjk/h+fEQ7Q9lqoaYyWWUX/Mk7JsH3/Xg/1
   pKc/Lhdxv6mHIcRPC76cakYSyAVzHdDIS07eanJzm97ZOUqO9FSX1DBov
   BEWQe1QxBXSPr6W1MA3R3slm1bO7k92cVwJWdkNebPg6BguQRF817ijLZ
   CRrDDu3FIpXLywIgrvYXBn7Vlg74ygMI/wqYB4lJ/BZh3Xe/vgTvzfcgf
   /QYenM5GtVcIdEbNgGRFgii/ZR8G4cCGeUybynDh1pOR0f8OyLE3DabWj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="356598668"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="356598668"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 02:14:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="856241139"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="856241139"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 11 Aug 2023 02:14:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qUODa-0083EI-1I;
        Fri, 11 Aug 2023 12:14:02 +0300
Date:   Fri, 11 Aug 2023 12:14:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/2] gpio: sim: simplify code with cleanup helpers
Message-ID: <ZNX72qCPBK0mzEVq@smile.fi.intel.com>
References: <20230809131442.25524-1-brgl@bgdev.pl>
 <20230809131442.25524-2-brgl@bgdev.pl>
 <ZNT2pNW3aPu82vs1@smile.fi.intel.com>
 <CAMRc=Me43ZqeDf0e3pA=UJ-x_051HxUbzESmTfSSTbG3cV8-hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Me43ZqeDf0e3pA=UJ-x_051HxUbzESmTfSSTbG3cV8-hw@mail.gmail.com>
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

On Thu, Aug 10, 2023 at 09:04:12PM +0200, Bartosz Golaszewski wrote:
> On Thu, Aug 10, 2023 at 4:42 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Aug 09, 2023 at 03:14:42PM +0200, Bartosz Golaszewski wrote:

...

> > > +     scoped_guard(mutex, &chip->lock)
> > > +             bitmap_replace(chip->value_map, chip->value_map, bits, mask,
> > > +                            gc->ngpio);
> >
> > Perhaps with {} ?
> 
> This scoped_guard() thing is in essence a for loop, so I believe
> kernel coding style applies and a single statement doesn't require a
> {}.

You have two lines (or single wrapped line). I found to read it better with {}.

-- 
With Best Regards,
Andy Shevchenko



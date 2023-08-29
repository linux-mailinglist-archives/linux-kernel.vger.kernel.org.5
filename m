Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2C578C74E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbjH2OUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236937AbjH2OUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:20:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57FC198
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693318837; x=1724854837;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5fE5tAjAqKWPXrD1injHuzkNkqZ2cGTf1jxfBM2m15s=;
  b=FklUJTY+AO8XUbc2iTYAo5HlP0qQmyRQNYkGa6OeF/BmRZRAQOLqU+2l
   uOimmgQCM0E+lLPwZI7wCQTBdFx0azMrrPxMCcBwWR89ZiTU0lftg/vxT
   I51nVhn/K33iEiUqSY3ruWYUAyLniO07RvTyXIikrVFWvhVeAKqlw/MhY
   yliGtBFXXGnheZgMODggq1OgIOJGcecIm91Y0iQCHeU2xX29Q22IREHS5
   x2DqGJz2jKGQ2ZgWBfIvOSVkI2D9/PqRWpHFhziGC/AJADmug4fNjhlbB
   Zpy1YCTuGYazPDJQhehrNa0+r7Cie9NOXHWGXkNkENDWwUrTqBIXlNcNg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="378097310"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="378097310"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 07:20:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="732228250"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="732228250"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 29 Aug 2023 07:20:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qaza5-004tth-3C;
        Tue, 29 Aug 2023 17:20:33 +0300
Date:   Tue, 29 Aug 2023 17:20:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/1] ALSA: control: Use list_for_each_entry_safe()
Message-ID: <ZO3+sVKQrQT+Sefj@smile.fi.intel.com>
References: <20230829135252.3915124-1-andriy.shevchenko@linux.intel.com>
 <9b71579b-3c2c-aafc-64d0-ae16603de82b@perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b71579b-3c2c-aafc-64d0-ae16603de82b@perex.cz>
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

On Tue, Aug 29, 2023 at 04:10:24PM +0200, Jaroslav Kysela wrote:
> On 29. 08. 23 15:52, Andy Shevchenko wrote:

...

> > Takashi, if you have anybody or want yourself to spend some time,
> > I believe you can simplify a lot the parser in this file with
> > the help of lib/cmdline.c APIs.
> 
> You probably mean next_arg() function. Unfortunately, it does not handle all
> cases we need to parse. The control IDs are a bit different than standard
> arguments.

Not only that, but also get_option() / get_options().
It might still make sense to look into and expand next_arg() to do
what you want (like I have done to get_option() which later allows
to have parse_int_array_user() be implemented).

It also have test cases, which can be expanded / amended as well.

...

> > -	list_for_each_entry(lctl, &led->controls, list)
> > +	list_for_each_entry(lctl, _lctl, &led->controls, list)
> 
> The list_for_each_entry_safe() should be used here, too.

Oh, good catch!

> With the fix:
> 
> Reviewed-by: Jaroslav Kysela <perex@perex.cz>

Thank you, I'll send a v2 soon.

-- 
With Best Regards,
Andy Shevchenko



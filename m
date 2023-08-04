Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAF977095A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjHDUFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjHDUF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:05:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C98E6F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691179525; x=1722715525;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=61/5zzRVpmjuaeQ+th73cerqMU4YQpzyb5WsNL6XhHg=;
  b=NCMI/c8f3W12Gcon3bKKOkmt6xpWU6Vclf+PFfku5CN+xrEpjbjVWOXV
   28sJvYQtAnb4fmhRIXlOhmrbV2agbB1xSCzXWeWW+MPbWX81zNaUj1RVc
   oeu6f/Nv0i9pXu248nPHLl7/Jtvje2VYGYtV6y2KZQ/1loLw9Y3X3fZOE
   BBhJ3o/TQbThZwuxy4IjnBXOPfojChCZrG/UXih2GQBpb4p1XDkldmUQ6
   2dF9qgXBOwYrzk/au4Xf3zV+ckkHRzLMlDV+zmzWMQhcYngHjNQXfB3Ef
   KQ3mzIBVKO/RZEmmGolVeS9RrUmQ3ZmWvuV8d25mQyr+/Cam/K/mCvsUv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="370225972"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="370225972"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 13:05:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="873510290"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 04 Aug 2023 13:05:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qS131-0061z2-3D;
        Fri, 04 Aug 2023 23:05:19 +0300
Date:   Fri, 4 Aug 2023 23:05:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Potapenko <glider@google.com>, catalin.marinas@arm.com,
        will@kernel.org, pcc@google.com, andreyknvl@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 1/5] lib/bitmap: add bitmap_{set,get}_value()
Message-ID: <ZM1Z/6l6yCaOEjjF@smile.fi.intel.com>
References: <20230720173956.3674987-1-glider@google.com>
 <20230720173956.3674987-2-glider@google.com>
 <ZLyI+0EL1VztnHLe@yury-ThinkPad>
 <CAG_fn=V4wyHjXT41byPbAkrZzisZRfKszwM4EUFV-FNWuXXfbw@mail.gmail.com>
 <ZMG29WmwQFVgTSCv@yury-ThinkPad>
 <CAG_fn=VrPJj6YowHNki5RGAAs8qvwZpUVN4K9qw=cf4aW7Qw9A@mail.gmail.com>
 <ZM1XlUbAJ7Qpd6OO@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZM1XlUbAJ7Qpd6OO@yury-ThinkPad>
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

On Fri, Aug 04, 2023 at 12:55:01PM -0700, Yury Norov wrote:
> On Fri, Aug 04, 2023 at 06:07:00PM +0200, Alexander Potapenko wrote:

> > > > ~BITMAP_FIRST_WORD_MASK(start));
> > >
> > > As I said, ~BITMAP_FIRST_WORD_MASK() is the same as BITMAP_LAST_WORD_MASK()
> > > and vise-versa.
> > 
> > Surprisingly, ~BITMAP_FIRST_WORD_MASK() generates better code than
> > BITMAP_LAST_WORD_MASK().
>  
> Wow... If that's consistent across different compilers/arches, we'd
> just drop the latter. Thanks for pointing that. I'll check.

It might be...

...

> >         map[index] &= (fit ? (~(GENMASK(nbits - 1, 0) << offset)) :
> > ~BITMAP_FIRST_WORD_MASK(start));

...that both parts of ternary are using negation. So compiler may use negation
only once. (Haven't looked at the assembly.)

-- 
With Best Regards,
Andy Shevchenko



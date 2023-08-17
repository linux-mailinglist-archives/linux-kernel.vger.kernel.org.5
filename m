Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA36177F330
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349528AbjHQJZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349601AbjHQJZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:25:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0DD2724;
        Thu, 17 Aug 2023 02:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692264320; x=1723800320;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=diQgJhtqaTL9bBmQnRVPSp1k6/0glCwWzddX5p4Tyrc=;
  b=XS2yupF/FjeoKJeotZ4CjJfIfgvQ2ptWNEnXoVtu/F7aeGQCMpN4r1zS
   Fe1+Ezt9GzSR5eL8+rOanGu2VkI3DdZvhpEvPpckAxYpyJFIEIYKtIyrO
   W33HpsmNDPoK9N67XOR0gA6BZjnUPG9YUp9TjCboU6IVkRnzhUyoPXaFT
   7KD5BZiOU6gKBajXGVemtUJc9JIANFdujoeIpDeLDZb5YcDHs7NGSq79T
   FjskvGjAc/ryJ03HcYINE2kj6JZBBAy1SVxerniaDsCEir5yywlXEU295
   IDaKBc1TrQ7Kf/Hu5PcCePomOHdPlKU0DKmbUTVP8Zx/dAnJ/eCrfhlcU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="376496506"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="376496506"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 02:25:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="878152230"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 17 Aug 2023 02:25:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWZFZ-0054T5-2B;
        Thu, 17 Aug 2023 12:25:05 +0300
Date:   Thu, 17 Aug 2023 12:25:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3] gpio: sim: simplify code with cleanup helpers
Message-ID: <ZN3ncVjDn9ZXHOS5@smile.fi.intel.com>
References: <20230812183635.5478-1-brgl@bgdev.pl>
 <ZNtT37d3eR6FcQyR@smile.fi.intel.com>
 <CAMRc=McqdnBBSe1QhyNEFCs3E+Qb_K-z1dT+B8+n2KvWajj5hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McqdnBBSe1QhyNEFCs3E+Qb_K-z1dT+B8+n2KvWajj5hA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 09:09:55PM +0200, Bartosz Golaszewski wrote:
> On Tue, Aug 15, 2023 at 12:31 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Sat, Aug 12, 2023 at 08:36:35PM +0200, Bartosz Golaszewski wrote:

...

> > > -     mutex_lock(&chip->lock);
> > > -     __assign_bit(offset, chip->value_map, value);
> > > -     mutex_unlock(&chip->lock);
> > > +     scoped_guard(mutex, &chip->lock)
> > > +             __assign_bit(offset, chip->value_map, value);
> >
> > But this can also be guarded.
> >
> >         guard(mutex)(&chip->lock);
> >
> >         __assign_bit(offset, chip->value_map, value);
> 
> Come on, this is total bikeshedding! I could produce ten arguments in
> favor of the scoped variant.
> 
> Linus acked even the previous version and Peter says it looks right. I
> will queue it unless some *real* issues come up.

I still think this will be, besides being shorter and nicer to read,
more consistent with other simple use of "guard(); return ..." cases.

-- 
With Best Regards,
Andy Shevchenko



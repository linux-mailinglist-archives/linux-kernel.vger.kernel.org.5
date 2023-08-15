Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C2477CE5E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237764AbjHOOpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237743AbjHOOpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:45:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21C710F0;
        Tue, 15 Aug 2023 07:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692110720; x=1723646720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Q1salXJI+zzxg06IZ3d1FiWspFLqiYYwuqZGiPPvT+k=;
  b=fYeloy3/MC4FR7pKKB5WUb5hZ/79WY1+W8t0Igr8XxiRscYU5iZ2e21z
   8v+6us2+THd1qrVtmDGR6uc75yMiNbsQhaSaxgQbLa09NVF+UE0pwng/m
   vvxDu88zh2nWaLH22wK4j9bLen4e0x+abwC77h5MRghtevDYxiTt419ax
   JOTeWnK+q7wBOUcgFXJgmaeipw/xQdcTxlfKXh4sBq8JEZkQTP7UOJMu6
   Xxg8NeXK3S4ux76lVxF8CBZ4VyqMmL72KOsSz8Ol0lXnKZRgtSrb53Lqs
   pdfAF0Ful/zHGTF5CW2+ZyUI40IOLPM3QiFTeDAVtQhX/lCAoLHQHCc+q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403273146"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="403273146"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 07:45:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="710731386"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="710731386"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 15 Aug 2023 07:45:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVvIB-005n4m-0z;
        Tue, 15 Aug 2023 17:45:07 +0300
Date:   Tue, 15 Aug 2023 17:45:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3] gpiolib: fix reference leaks when removing GPIO chips
 still in use
Message-ID: <ZNuPcwnUOdAeGPW/@smile.fi.intel.com>
References: <20230811193034.59124-1-brgl@bgdev.pl>
 <ZNtKQlnQxFediB0J@smile.fi.intel.com>
 <CACRpkdZ32gW3YgQKPbWTnoRwxjXkViendGMhrAxfyp+W4NbqkA@mail.gmail.com>
 <ZNt2KQMtpMdK9TyY@smile.fi.intel.com>
 <CACRpkdbij=8NMVodezEXG-rtiBzp1q_fecizYtda4HbDXheu8Q@mail.gmail.com>
 <ZNuPKf8NqcgcuGSd@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZNuPKf8NqcgcuGSd@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 05:43:53PM +0300, Andy Shevchenko wrote:
> On Tue, Aug 15, 2023 at 03:07:50PM +0200, Linus Walleij wrote:
> > On Tue, Aug 15, 2023 at 2:57 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, Aug 15, 2023 at 01:40:22PM +0200, Linus Walleij wrote:
> > > > On Tue, Aug 15, 2023 at 11:50 AM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Fri, Aug 11, 2023 at 09:30:34PM +0200, Bartosz Golaszewski wrote:

...

> > > > > > +     module_put(desc->gdev->owner);
> > > > > > +     gpio_device_put(desc->gdev);
> > > > >
> > > > > So, if gdev can be NULL, you will get an Oops with new code.
> > > >
> > > > I read it such that gdev->chip can be NULL, but not gdev,
> > > > and desc->gdev->owner is fine to reference?
> > >
> > > Basically the Q is
> > > "if desc is non-NULL, does it guarantee that gdev is non-NULL either?"
> > 
> > gdev->desc is assigned in one single spot, which is in
> > gpiochip_add_data_with_key():
> > 
> >        for (i = 0; i < gc->ngpio; i++)
> >                 gdev->descs[i].gdev = gdev;
> > 
> > It is never assigned anywhere else, so I guess yes.
> > 
> > We may also ask if it is ever invalid (i.e. if desc->gdev can point to
> > junk).
> > 
> > A gdev turns to junk when its reference count goes down to zero
> > and gpiodev_release() is called effectively calling kfree() on the
> > struct gpio_device *.
> > 
> > But that can only happen as a result of module_put() getting
> > called, pulling the references down to zero. Which is what we
> > are discussing. The line after module_put(), desc->gdev
> > *could* be NULL.
> 
> Yes.
> 
> > But then we just call gpio_device_put(desc->gdev) which is
> > just a call to device_put(), which is NULL-tolerant.
> 
> But gpio_device_put() does not NULL tolerant.
> So, oops in this line then.

That said, this gpiod_free() function needs a lot of additional comments to
explain all this.

-- 
With Best Regards,
Andy Shevchenko



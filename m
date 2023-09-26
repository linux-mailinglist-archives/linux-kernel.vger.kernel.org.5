Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D3B7AEB33
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjIZLQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIZLQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:16:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C11DE5;
        Tue, 26 Sep 2023 04:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695726975; x=1727262975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bgJ6JLn5dG4WpQOqgkcDkaqD70XkjWn2MU0AKV6t6rA=;
  b=iV7KQLCZXYZWsvJmcclwUj/ErDbwKj7Cl5uj8Aifc1CV9HXyQ2Awj2Bf
   C+j5TnBwQAJVcBdVR1ZO5cYvDsfcS8fh/YqrM1k6BOdIwpMRCq6AaHAS4
   UUTmAlL0h9prTNgCjP7xPHkd8DFkREJMYiV6yUXqCL2IOfprnYp3nrnWM
   ogwKSTMEOMhXv2fjdgX2Gz6TIjdeLALq48MOjHwBiiRMPlNSu8aLP1ltF
   pWIAkh+A5i3g9qtOPE8n67JY8C1TTEKNa3PdB8hNG3TTugH1WmiPz/YUM
   Xec44SS8S1glAs45zgnauNZWDx8/sMxuzcgr6BOgYMRBStp/iwGxhuko4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360922973"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="360922973"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 04:16:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="1079666794"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="1079666794"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 04:16:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ql62y-00000000aPT-3VEr;
        Tue, 26 Sep 2023 14:16:08 +0300
Date:   Tue, 26 Sep 2023 14:16:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Yury Norov <yury.norov@gmail.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH v1 0/5] bitmap: get rid of bitmap_remap() and
 bitmap_biremap() uses
Message-ID: <ZRK9eCTy2rreZB5W@smile.fi.intel.com>
References: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdYCY+P5+6nk28TQ9stoyYO83q1X1YG7mbrBJnG65uTwwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYCY+P5+6nk28TQ9stoyYO83q1X1YG7mbrBJnG65uTwwA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 10:52:05AM +0200, Linus Walleij wrote:
> On Tue, Sep 26, 2023 at 7:20 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > As Rasmus suggested [1], the bit remapping APIs should be local to NUMA.
> > However, they are being in use outside of that for a while. To make
> > above happen, introduces simplified APIs that can be used otherwise.
> >
> > It seems we might have yet another user of the above mentioned APIs.
> >
> > The last patch has not been tested anyhow (except compilation, so
> > all testing and comments are welcome).
> >
> > The idea is to get an immutable tag (via my tree) that can be pulled
> > by bitmap and GPIO trees on the need (while usually I send PR to
> > the GPIO subsystem).
> >
> > Link: https://lore.kernel.org/all/20230815235934.47782-1-yury.norov@gmail.com/ [1]
> 
> I don't understand the bitmap changes very well,

Me neither... Oops (it was a joke :-)

> but the resulting
> changes to cdev look very nice clearly making that code more readable
> and maintainable,

While the above is a joke it took quite a time to get into the logic.
Hence this patch. TBH I'm in doubt, that's why asking for careful testing
and reviews.

> so FWIW:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



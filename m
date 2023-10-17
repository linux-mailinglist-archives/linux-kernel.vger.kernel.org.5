Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860A17CCAE3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 20:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343849AbjJQSjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 14:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJQSjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 14:39:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6270494;
        Tue, 17 Oct 2023 11:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697567951; x=1729103951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7XIg506zwTp8Enjt+cILlp/9UqrW9bg740iuuvBkva0=;
  b=jzKYCeiFY5eEd5s9REm7IkHeePdl3hdxcLOoY4cKNTGYkFQlNxBh71/6
   uK/0KjMvNsR5WzgzDvaN1abXzWDAqa6m2IpW5l2Y7af7tFznq7psNGR+y
   87h5NhPpcalgor9TYDBQ6vfsl2l8se++Lirq7XRWsCtUQ/dO/9i+NyrCg
   j6ob0VqgccAjy/FyP2yckeRjRk7DKw5Oj2q2lHvg6876BLUabd4//dqxs
   3wi971f5Oq187szP1oIEPPu0W5n6ksE2yt7hpi3IRAhqtSrGVSjKa16Xb
   RevYmpgV8ceD1WPJ+gSG8v/i8+TCjE4xU31xaD5BCaM6anxYeKC4xixd5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="388720258"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="388720258"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 11:39:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="785583919"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="785583919"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 11:39:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qsoyA-00000006Od3-2se3;
        Tue, 17 Oct 2023 21:39:06 +0300
Date:   Tue, 17 Oct 2023 21:39:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: Re: [PATCH v1 1/1] Revert "pinctrl: avoid unsafe code pattern in
 find_pinctrl()"
Message-ID: <ZS7UyhumiUoAunEi@smile.fi.intel.com>
References: <20231017141806.535191-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdbHJHsgJ=3pYveP-x-Vuwwf3ib6TnFOt3UpCrKevf=d1w@mail.gmail.com>
 <ZS7TuodhwNxU9Ez6@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZS7TuodhwNxU9Ez6@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 09:34:34PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 17, 2023 at 08:18:23PM +0200, Linus Walleij wrote:
> > On Tue, Oct 17, 2023 at 4:18 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > > The commit breaks MMC enumeration on the Intel Merrifield
> > > plaform.
> > 
> > The enumeration works, just that the probe order is different, right?
> > 
> > > Before:
> > > [   36.439057] mmc0: SDHCI controller on PCI [0000:00:01.0] using ADMA
> > > [   36.450924] mmc2: SDHCI controller on PCI [0000:00:01.3] using ADMA
> > > [   36.459355] mmc1: SDHCI controller on PCI [0000:00:01.2] using ADMA
> > > [   36.706399] mmc0: new DDR MMC card at address 0001
> > > [   37.058972] mmc2: new ultra high speed DDR50 SDIO card at address 0001
> > > [   37.278977] mmcblk0: mmc0:0001 H4G1d 3.64 GiB
> > > [   37.297300]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10
> > >
> > > After:
> > > [   36.436704] mmc2: SDHCI controller on PCI [0000:00:01.3] using ADMA
> > > [   36.436720] mmc1: SDHCI controller on PCI [0000:00:01.0] using ADMA
> > > [   36.463685] mmc0: SDHCI controller on PCI [0000:00:01.2] using ADMA
> > > [   36.720627] mmc1: new DDR MMC card at address 0001
> > > [   37.068181] mmc2: new ultra high speed DDR50 SDIO card at address 0001
> > > [   37.279998] mmcblk1: mmc1:0001 H4G1d 3.64 GiB
> > > [   37.302670]  mmcblk1: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10
> > >
> > > This reverts commit c153a4edff6ab01370fcac8e46f9c89cca1060c2.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Relying on this probe order or whatever it is causing one or the other
> > to be enumerated first seems very fragile, I think this condition can be
> > caused by other much more random things in the probe path as well,
> > so it would be great if we could just hammer this down for good, as
> > it is apparently ABI.

And as I mentioned in the reply to the patch, I have 100% reproducibility
of the issue, I never have "random" or arbitrary numbers. While it might
be fragile, it very well works reliably for _years_.

> > In the past some file system developers have told us (Ulf will know)
> > that we can't rely on the block device enumeration to identify
> > devices, and requires that we use things such as sysfs or the
> > UUID volume label in ext4 to identify storage.
> 
> While I technically might agree with you, this was working for everybody
> since day 1 of support of Intel Merrifield added (circa v4.8), now _user
> space_ is broken.
> 
> Note, I'm having _simple_ setup, no fancy UDEV or DBUS there, and I want
> my scripts simply continue working. As I mentioned, this is Buildroot
> + Busybox which I haven't touched in the area of how they treat MMC
> devices in _user space_.
> 
> Since we are at rc6 I prefer to get this reverted first and next cycle we can
> discuss better solutions. I'm all for testing any.
> 
> > That said, device trees are full of stuff like this:
> > 
> >         aliases {
> >                 serial0 = &uart_AO;
> >                 mmc0 = &sd_card_slot;
> >                 mmc1 = &sdhc;
> >         };
> 
> And Rob, AFAIU, is against aliases.
> 
> > Notice how this enumeration gets defined by the aliases.
> > 
> > Can you do the same with device properties? (If anyone can
> > answer that question it's Dmitry!)
> 
> No, and why should we?

-- 
With Best Regards,
Andy Shevchenko



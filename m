Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651227CC5FA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343866AbjJQOfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343637AbjJQOfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:35:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D569E92;
        Tue, 17 Oct 2023 07:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697553329; x=1729089329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YM6r2dALC2AyB2TLnYzxDUrSh1HLtPBxCZadb1oxHlY=;
  b=gi9GcxfH8H4I571zPjfMTKSvEDf3NaKBoOh1RJUr/WvHbAachewtgo9S
   Qr//k8PicFV9nsQmBDAc8aPTJzy+lfILfOOv2Yk523NorZ8pjFJ0o4bm6
   V8G+FgzLIWoxda9sZGjRt7qlttkdwhPfmkChDySgNx0Miu6Qb4HI8bPJE
   uWygtDorYHz+3pV+S9VduVA/un6XcicxUca4Dt0HNCs3Y6frDT9ORx+Mo
   WCoDRROp4wE8ljZ8WkcyGu9OehdQ1AeUrRZNfZfMG7e876n0YoIP6S5r1
   4laEt3RMqa19zUaCcZMYmXacr7eedsl/Di20VmBpX0t1E6ZN+8QIPPIiX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="388656153"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="388656153"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 07:35:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="822003066"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="822003066"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 07:34:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qskqC-00000006JM8-1kWq;
        Tue, 17 Oct 2023 17:14:36 +0300
Date:   Tue, 17 Oct 2023 17:14:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Ferry Toth <ftoth@exalondelft.nl>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: avoid unsafe code pattern in find_pinctrl()
Message-ID: <ZS6WzGauyQmdANec@smile.fi.intel.com>
References: <ZQs1RgTKg6VJqmPs@google.com>
 <CACRpkdbuOn4gKBE-tB4MHQ3mx_ujQZLdPp1hp75ANFgsGb1jQQ@mail.gmail.com>
 <ZS6VReT2Md9UNjFu@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZS6VReT2Md9UNjFu@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 05:08:05PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 25, 2023 at 03:30:53PM +0200, Linus Walleij wrote:
> > On Wed, Sep 20, 2023 at 8:09 PM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > 
> > > The code in find_pinctrl() takes a mutex and traverses a list of pinctrl
> > > structures. Later the caller bumps up reference count on the found
> > > structure. Such pattern is not safe as pinctrl that was found may get
> > > deleted before the caller gets around to increasing the reference count.
> > >
> > > Fix this by taking the reference count in find_pinctrl(), while it still
> > > holds the mutex.
> > >
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > After some thinking, applied for fixes and tagged for stable as
> > it is a very real problem that can cause random crashes under
> > the right circumstances.
> 
> Follow the strange and weird bisection [1] this one at least confirmed to be
> the culprit by reverting the only one from the v6.6-rc6 based branch.
> 
> Long story short, after this commit my user space setup (minimal Buildroot + Busybox)
> has become broken in a sense of MMC enumeration. My all scripts were pointed to
> mmcblk0 which becomes out of a sudden mmcblk1!

`dmesg` after revert:

[   36.439057] mmc0: SDHCI controller on PCI [0000:00:01.0] using ADMA
[   36.450924] mmc2: SDHCI controller on PCI [0000:00:01.3] using ADMA
[   36.459355] mmc1: SDHCI controller on PCI [0000:00:01.2] using ADMA
[   36.706399] mmc0: new DDR MMC card at address 0001
[   37.058972] mmc2: new ultra high speed DDR50 SDIO card at address 0001
[   37.278977] mmcblk0: mmc0:0001 H4G1d 3.64 GiB
[   37.297300]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10

and before:

[   36.436704] mmc2: SDHCI controller on PCI [0000:00:01.3] using ADMA
[   36.436720] mmc1: SDHCI controller on PCI [0000:00:01.0] using ADMA
[   36.463685] mmc0: SDHCI controller on PCI [0000:00:01.2] using ADMA
[   36.720627] mmc1: new DDR MMC card at address 0001
[   37.068181] mmc2: new ultra high speed DDR50 SDIO card at address 0001
[   37.279998] mmcblk1: mmc1:0001 H4G1d 3.64 GiB
[   37.302670]  mmcblk1: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10

Reproducibility 100%.

> git bisect start
> # status: waiting for both good and bad commits
> # bad: [58720809f52779dc0f08e53e54b014209d13eebb] Linux 6.6-rc6
> git bisect bad 58720809f52779dc0f08e53e54b014209d13eebb
> # status: waiting for good commit(s), bad commit known
> # good: [2dde18cd1d8fac735875f2e4987f11817cc0bc2c] Linux 6.5
> git bisect good 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> # good: [47ca50600efcf994adb62a9a4e75c77d91bd0781] Merge tag 'soc-defconfig-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> git bisect good 47ca50600efcf994adb62a9a4e75c77d91bd0781
> # good: [b89b029377c8c441649c7a6be908386e74ea9420] Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> git bisect good b89b029377c8c441649c7a6be908386e74ea9420
> # good: [2a5a4326e58339a26cd1510259e7310b8c0980ff] Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> git bisect good 2a5a4326e58339a26cd1510259e7310b8c0980ff
> # good: [85eba5f1759f9eb89273225027254ced57bd18a2] Merge tag 'mm-hotfixes-stable-2023-09-23-10-31' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> git bisect good 85eba5f1759f9eb89273225027254ced57bd18a2
> # good: [b78b18fb8ee19f7a05f20c3abc865b3bfe182884] Merge tag 'erofs-for-6.6-rc5-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs
> git bisect good b78b18fb8ee19f7a05f20c3abc865b3bfe182884
> # bad: [9a5a14948574ee09f339990cab69b4ab997d2f7d] Merge tag 'soc-fixes-6.6-2' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> git bisect bad 9a5a14948574ee09f339990cab69b4ab997d2f7d
> # good: [b9ddbb0cde2adcedda26045cc58f31316a492215] Merge tag 'parisc-for-6.6-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
> git bisect good b9ddbb0cde2adcedda26045cc58f31316a492215
> # good: [b711538a40b794ccc83838fb66990a091c56c101] Merge tag 'hyperv-fixes-signed-20231009' of git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux
> git bisect good b711538a40b794ccc83838fb66990a091c56c101
> # good: [bab19d1b21547046b0a38dde948086f6cbcaefaa] Merge tag 'for-linus-2023101101' of git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid
> git bisect good bab19d1b21547046b0a38dde948086f6cbcaefaa
> # bad: [82a040a8fa9b4f3845eff73a69a9931a59335902] Merge tag 'pinctrl-v6.6-2' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
> git bisect bad 82a040a8fa9b4f3845eff73a69a9931a59335902
> # good: [759d1b653f3c7c2249b7fe5f6b218f87a5842822] Merge tag 'for-6.6-rc5-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
> git bisect good 759d1b653f3c7c2249b7fe5f6b218f87a5842822
> # bad: [c153a4edff6ab01370fcac8e46f9c89cca1060c2] pinctrl: avoid unsafe code pattern in find_pinctrl()
> git bisect bad c153a4edff6ab01370fcac8e46f9c89cca1060c2
> # good: [87d315a34133edcb29c4cadbf196ec6c30dfd47b] pinctrl: nuvoton: wpcm450: fix out of bounds write
> git bisect good 87d315a34133edcb29c4cadbf196ec6c30dfd47b
> # good: [64061b67335e958e6328bcb5bb2b5490d57f3f59] pinctrl: starfive: jh7110: Add system pm ops to save and restore context
> git bisect good 64061b67335e958e6328bcb5bb2b5490d57f3f59
> # first bad commit: [c153a4edff6ab01370fcac8e46f9c89cca1060c2] pinctrl: avoid unsafe code pattern in find_pinctrl()
> 
> [1]: https://lore.kernel.org/r/20230830102434.xnlh66omhs6ninet@quack3

-- 
With Best Regards,
Andy Shevchenko



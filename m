Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662477C4FA5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbjJKKIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbjJKKHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:07:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AE0DC;
        Wed, 11 Oct 2023 03:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697018808; x=1728554808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=F8DEoimETRvu/FJ7It/A46cbcbQMcDIctzYXV2885B4=;
  b=WESyMG1Z93+IFmHtJ3nb3IyYcdK618bej8ysn1zFM0s41BbJvQhgCEb3
   yiMDMGKFyDjhSUq91IjASYtb6XR0A7N84ePpP31YYsS39oW0/IxOPsux8
   mYHE/CPtHNihne59SJochiBt8c7Y0lg4pmhrSiQW6Z4xjWDtIGRIU9wYF
   N3XEvjuEcrGv4n5TIbGoqP8TIc9MTslvxkI03TJQNSxSMRLmdvMfsMemO
   m4Et42CKv1pyDC/cNpQehWbMDT1+wXk7fGXmZiQpOfBGD5mb8xq5CbrSN
   ew+f09Ek7He9zn9CIWBGbAN+C+zwCwgo+vk9473kfdcWg5Vsb4YzVnUZD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="364910012"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="364910012"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:06:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="844500470"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="844500470"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:06:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qqW6z-00000004aTj-2qgE;
        Wed, 11 Oct 2023 13:06:41 +0300
Date:   Wed, 11 Oct 2023 13:06:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v1 0/4] hte: Improve GPIO handling and other cleanups
Message-ID: <ZSZzsfaunP5yRvZ4@smile.fi.intel.com>
References: <20231010151709.4104747-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=Mdiuth0=XPBsoStXN81ydfpUfqm1BMc2TZOT4Kmx6jNkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mdiuth0=XPBsoStXN81ydfpUfqm1BMc2TZOT4Kmx6jNkA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 11:33:51AM +0200, Bartosz Golaszewski wrote:
> On Tue, Oct 10, 2023 at 5:18 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > This is a series provides a new API to GPIO library (so far only
> > available in the GPIO tree), and respective update to the Tegra
> > HTE driver. On top a couple of other cleaups (patches 3 & 4, they
> > can be applied separately).
> >
> > Patch 2 inherited tags from its respective discussion thread [1],
> > but I believe the Tested-by needs to be confirmed again.
> >
> > Due to dependencies this either should be applied to the GPIO tree,
> > or to the HTE when GPIO updates land the upstream (optionally with
> > the first patch be applied even now to the GPIO tree independently).
> >
> > Another option is to have an immutable branch or tag, but I assume
> > that was discussed and rejected (?) in [1].
> 
> The series looks good to me. I'd like to take patches 1 and 2 through
> the GPIO tree once v2 is out. This way we could potentially remove
> gpiochip_find() for v6.7 already.

It would be nice to see it being removed sooner than later!
I'm waiting for the test results by Dipen, I'll send the v2
ASAP if tests pass.

-- 
With Best Regards,
Andy Shevchenko



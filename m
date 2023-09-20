Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8557A77A4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbjITJet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbjITJeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:34:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BEB93;
        Wed, 20 Sep 2023 02:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695202480; x=1726738480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=daA+8WUnrisnNAHI3xd2zdlB9Zrw2I7xkKHBIHY3+hM=;
  b=Lb8uPbzuQG3/c57LZOie3Yjt5Y8x9aOcHtY6fYcKClvIAVCcLCQJ8+ax
   a6UcyUtwRNwOpacniO+VIICwmwAWAT/hj9+jI3J1jHDfG064jwcS4BtUw
   lWbCoedu5qZHvAz/KxuHRGwDYAKL+a9FhAN6cEfb+asbHh2Pm+Fryu6uu
   dEt3l4TWK9aEy+Ko/5jKnsmfOo+APUPC0MPq66Z7r06jmjLWdk4zdWAF6
   FS5DFzqoQKShotGMI39GqzTYhJzMVBuFiIV642a4n4ki/pcnDq+o9MrLv
   qe0XXWLDcIvwhZ7G6YhhITY8Ufm8tOxiZKyn8xGKWIdxcI3pYrBktUiek
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="360431944"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="360431944"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 02:33:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="740126368"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="740126368"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 02:33:14 -0700
Date:   Wed, 20 Sep 2023 12:33:11 +0300
From:   Raag Jadav <raag.jadav@intel.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        Jonathan.Cameron@huawei.com, andriy.shevchenko@linux.intel.com,
        rf@opensource.cirrus.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v3] PM: Fix symbol export for _SIMPLE_ variants of
 _PM_OPS()
Message-ID: <ZQq8V5D06CaMxWqQ@black.fi.intel.com>
References: <20230920084121.14131-1-raag.jadav@intel.com>
 <790fac97ce79534733fe0bbd93cc0c9eaa835bf2.camel@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <790fac97ce79534733fe0bbd93cc0c9eaa835bf2.camel@crapouillou.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 10:53:23AM +0200, Paul Cercueil wrote:
> Le mercredi 20 septembre 2023 à 14:11 +0530, Raag Jadav a écrit :
> > Currently EXPORT_*_SIMPLE_DEV_PM_OPS() use EXPORT_*_DEV_PM_OPS() set
> > of macros to export dev_pm_ops symbol, which export the symbol in
> > case
> > CONFIG_PM=y but don't take CONFIG_PM_SLEEP into consideration.
> > 
> > Since _SIMPLE_ variants of _PM_OPS() do not include runtime PM
> > handles
> > and are only used in case CONFIG_PM_SLEEP=y, we should not be
> > exporting
> > their dev_pm_ops symbol in case CONFIG_PM_SLEEP=n.
> > 
> > This can be fixed by having two distinct set of export macros for
> > both
> > _RUNTIME_ and _SIMPLE_ variants of _PM_OPS(), such that the export of
> > dev_pm_ops symbol used in each variant depends on CONFIG_PM and
> > CONFIG_PM_SLEEP respectively.
> > 
> > Introduce _DEV_SLEEP_PM_OPS() set of export macros for _SIMPLE_
> > variants
> > of _PM_OPS(), which export dev_pm_ops symbol only in case
> > CONFIG_PM_SLEEP=y
> > and discard it otherwise.
> > 
> > Fixes: 34e1ed189fab ("PM: Improve EXPORT_*_DEV_PM_OPS macros")
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > ---
> > PS: This is a standalone fix and works without updating any drivers.
> 
> I had to double-check that, to make sure that none of the drivers using
> these macros also use pm_ptr() instead of pm_sleep_ptr() to access the
> exported dev_pm_ops.
> 
> I did not check extensively but everything seems to use pm_sleep_ptr(),
> so it looks safe enough.

I have tested it against -rc2 without any problems.

> > Changes since v2:
> > - Drop redundant patches
> > 
> > Changes since v1:
> > - Update drivers to new set of macros
> > 
> >  include/linux/pm.h | 43 +++++++++++++++++++++++++++++--------------
> >  1 file changed, 29 insertions(+), 14 deletions(-)
> > 
> > diff --git a/include/linux/pm.h b/include/linux/pm.h
> > index 1400c37b29c7..99a8146fa479 100644
> > --- a/include/linux/pm.h
> > +++ b/include/linux/pm.h
> > @@ -374,24 +374,39 @@ const struct dev_pm_ops name = { \
> >         RUNTIME_PM_OPS(runtime_suspend_fn, runtime_resume_fn,
> > idle_fn) \
> >  }
> >  
> > -#ifdef CONFIG_PM
> > -#define _EXPORT_DEV_PM_OPS(name, license,
> > ns)                          \
> > +#define _EXPORT_PM_OPS(name, license,
> > ns)                              \
> >         const struct dev_pm_ops
> > name;                                   \
> >         __EXPORT_SYMBOL(name, license,
> > ns);                             \
> >         const struct dev_pm_ops name
> > -#define EXPORT_PM_FN_GPL(name)         EXPORT_SYMBOL_GPL(name)
> > -#define EXPORT_PM_FN_NS_GPL(name, ns)  EXPORT_SYMBOL_NS_GPL(name,
> > ns)
> > -#else
> > -#define _EXPORT_DEV_PM_OPS(name, license,
> > ns)                          \
> > +
> > +#define _PM_OPS(name, license,
> 
> This macro creates a dev_pm_ops that's meant to be garbage-collected by
> the compiler; so maybe name it _USELESS_PM_OPS() or something like
> that.

_USELESS_PM_OPS() sounds a bit heavy handed ;)
Gives the impression that the macro itelf is not used anywhere in code.

Something like _DISCARD_PM_OPS() makes more sense.

Raag

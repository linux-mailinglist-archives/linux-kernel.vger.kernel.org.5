Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BBB78EF35
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344983AbjHaOFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344764AbjHaOFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:05:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47051F4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 07:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693490701; x=1725026701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2jUcdYXZ5BuGaoIZv4/2jO2chufivloxZgc2KVoSycY=;
  b=WZECcIlMNZNzUyRlDRjgTxOFRU92ATYoRkFMvL36ilB2H0Zrtj5E8s+N
   qSpPloKEli1jPKNKyGiB8T6NJFYBYfoqJJy3oeHy7+mEJ3oOEudDPHgmm
   eHoWg4hgNeersiYe/nFhkX0+Owzu19j/Na9PYyWhb2jViVNQhKh1hP3Ht
   BeJKumV/EEnNhklfhG61JPDtJHv5+KxweqIx9lifPH/OvKbN8fo3DCZq0
   X1YhqMUxeguLe0wV7rB4FkTJyVsys5Dz2YlS8f+wRSvs5qTl8/PfIYC6y
   5mKWGRCoZ0Pamj3C1zPR7xOHFvVhpteVrV3BsUmVf4sslMDoieJfyXfRI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="442332115"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="442332115"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 06:37:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="913256033"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="913256033"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 06:37:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qbhrA-005OmL-2Y;
        Thu, 31 Aug 2023 16:37:08 +0300
Date:   Thu, 31 Aug 2023 16:37:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ASoC: ak4642: Simplify probe()
Message-ID: <ZPCXhDHMVAYHqhFC@smile.fi.intel.com>
References: <20230828180003.127896-1-biju.das.jz@bp.renesas.com>
 <ZO4NrT36gbwc27+0@smile.fi.intel.com>
 <OS0PR01MB5922A08379222B0DF6D0323286E7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922A08379222B0DF6D0323286E7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 06:02:51PM +0000, Biju Das wrote:
> > On Mon, Aug 28, 2023 at 07:00:03PM +0100, Biju Das wrote:

...

> > > -	if (np) {
> > > -		const struct of_device_id *of_id;
> > > -
> > 
> > > +	if (dev_fwnode(dev)) {
> > 
> > Why do we need this at all?
> It is replacement for np.

I am questioning it's necessity to begin with (even before your patch).

> > >  		mcko = ak4642_of_parse_mcko(dev);
> > >  		if (IS_ERR(mcko))
> > >  			mcko = NULL;
> > 
> > This can suffice on its own, right?
> > 
> > Can be done in a separate change as a precursor to this one.
> 
> Agreed.

-- 
With Best Regards,
Andy Shevchenko



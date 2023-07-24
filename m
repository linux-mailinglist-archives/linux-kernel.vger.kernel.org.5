Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A0475F4C1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjGXLRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjGXLR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:17:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE4810EC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 04:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690197425; x=1721733425;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qrAfN4pFwmKEkCyDG2aU1NgUas7wKrBSvcRpy76R1jI=;
  b=ZzHiABt9YWTtMif2RtNG00UVLGNbRTmBbelQS6MubjOwBAH+70339eGd
   0bfLEX7MgmyCq+B/OyDmfAIcmdaf0oMjc2EwtMJFIajz4yWHytAd1njaa
   DoH+uP/xfjfu1d0utQLb5EkFjo4txZ5aC/4tsUP2VGWzEKBh0LBAFIOl/
   UQKEB0+ucGahUhtnbQzjO+CWb1UgMV9TeJMmRuhVMXxyyiXUBUKrH+H4l
   wALCQtLwnBBZNqt/Xg0AlP1cB1joRd7e1ZzfSVw5eMR239tHT1A43qbC/
   vPfyCuJTgBbKq+lFehDEhCNl3xGHgZZfv7zPLoMOmSc3SUJeIHClznaPS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="371012552"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="371012552"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:16:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="728873056"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="728873056"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 24 Jul 2023 04:16:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qNtY7-00AGs2-0G;
        Mon, 24 Jul 2023 14:16:23 +0300
Date:   Mon, 24 Jul 2023 14:16:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Lu, Brent" <brent.lu@intel.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        "Bhat, Uday M" <uday.m.bhat@intel.com>,
        Terry Cheong <htcheong@chromium.org>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        "R, Dharageswari" <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 1/2] ASoC: Intel: maxim-common: get codec number from ACPI
Message-ID: <ZL5dhosg28uIpcFd@smile.fi.intel.com>
References: <20230720092628.758834-1-brent.lu@intel.com>
 <20230720092628.758834-2-brent.lu@intel.com>
 <dc6de509-6984-1434-b53f-9600e8bc7c49@linux.intel.com>
 <ZL5Jzod5NBETv9Dp@smile.fi.intel.com>
 <CY5PR11MB62579D3B679BB437017529D79702A@CY5PR11MB6257.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR11MB62579D3B679BB437017529D79702A@CY5PR11MB6257.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 11:06:02AM +0000, Lu, Brent wrote:
> > > > +/* helper function to get the number of specific codec */
> > 
> > ...and leak a lot of reference counts...
> > 
> > > > +static int get_num_codecs(const char *hid) {
> > > > +	struct acpi_device *adev = NULL;
> > > > +	int dev_num = 0;
> > > > +
> > > > +	do {
> > > > +		adev = acpi_dev_get_next_match_dev(adev, hid, NULL, -1);
> > >
> > > Humm, I am a bit worried about reference counts.
> > >
> > > See
> > > https://elixir.bootlin.com/linux/latest/source/drivers/acpi/utils.c#L9
> > > 16, it's not clear to me where the get() is done.
> > >
> > > Adding Andy to make sure this is done right.
> > 
> > Thank you for Cc'ing.
> > 
> > Yes, the above code is problematic. One has to use the respective for_each macro
> > (defined nearby the used API).
> > 
> > > > +		if (adev)
> > > > +			dev_num++;
> > > > +	} while (adev != NULL);
> > > > +
> > > > +	return dev_num;
> > > > +}

> Each invocation of acpi_dev_get_next_match_dev() calls acpi_dev_put() to release the
> adev from previous call. And the last call returns NULL. It seems to me the reference count
> should be fine. Is my understanding correct?

Ah, right. sorry for the confusion. That's why we have a macro
to not think about these details :-)

> I saw the macro for_each_acpi_dev_match and re-write the function as follow. Thanks for
> suggesting using the macro.
> 
> /* helper function to get the number of specific codec */
> static int get_num_codecs(const char *hid) {
> 	struct acpi_device *adev;

> 	int dev_num = 0;

size_t here or at least unsigned int is more correct.

> 	for_each_acpi_dev_match(adev, hid, NULL, -1)
> 		dev_num++;
> 
> 	return dev_num;
> }

Otherwise, yes, that's what I have in mind.

> Will test it in next few days.

-- 
With Best Regards,
Andy Shevchenko



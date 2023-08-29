Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B15978C875
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbjH2PTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237203AbjH2PTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:19:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC75A1B3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693322379; x=1724858379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l7lBilpGq2tKtr5VFFRR9ZyJDMuDoY2t4wphNMtdaLY=;
  b=BS5mYio54Vf24JC3IiljQfyYXacp+JtMLjNvPVzfwQE+VeKp/b0l5wrF
   TKkQF4uzjL7pOvAEpvW1vinH/Mw0u9oc47BhkFn6EZiDXHNcOEN9FiFv7
   S31XqZp5mE5ebfzn9LFX/5ox6yENWVoCQSSjQ4i0BObTrNiGt5bG4ER5n
   R1889hQv7K9dgyz2Zf56cEr8uDtOTkVDa1szCfUVLv6vepM001cdHb3Wj
   DsKXHPoQE7vbyTBESA7Uv8+Z/eELV0EokTfOdd5iDpsKWgKHsqrfRI7f3
   C7ODmRf8NtCd3sDBF/zSKnjpNgXe2cQrjMvXNI6hgzJZddZij3mLeNMjC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="439350225"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="439350225"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 08:19:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="804158067"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="804158067"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 29 Aug 2023 08:19:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qb0VB-004ug7-1s;
        Tue, 29 Aug 2023 18:19:33 +0300
Date:   Tue, 29 Aug 2023 18:19:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2] ASoC: cs42xx8-i2c: Simplify probe()
Message-ID: <ZO4MhWUmamTqJvXd@smile.fi.intel.com>
References: <20230828174856.122559-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828174856.122559-1-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 06:48:56PM +0100, Biju Das wrote:
> Simplify probe() by replacing of_match_device->i2c_get_match_data() and
> extend matching support for ID table. Also replace
> dev_err()->dev_err_probe() to simplify the code.

...

Can also be

	struct device *dev = &i2c->dev;

>  	int ret;
>  	struct cs42xx8_driver_data *drvdata;
> -	const struct of_device_id *of_id;
> -
> -	of_id = of_match_device(cs42xx8_of_match, &i2c->dev);
> -	if (!of_id) {
> -		dev_err(&i2c->dev, "failed to find driver data\n");
> -		return -EINVAL;
> -	}
>  
> -	drvdata = (struct cs42xx8_driver_data *)of_id->data;
> +	drvdata = (struct cs42xx8_driver_data *)i2c_get_match_data(i2c);
> +	if (!drvdata)

> +		return dev_err_probe(&i2c->dev, -EINVAL,
> +				     "failed to find driver data\n");

		return dev_err_probe(dev, -EINVAL, "failed to find driver data\n");

-- 
With Best Regards,
Andy Shevchenko



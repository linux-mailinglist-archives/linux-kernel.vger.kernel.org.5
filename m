Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9AC7E1DDF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjKFKHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjKFKHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:07:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031E81BF;
        Mon,  6 Nov 2023 02:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699265255; x=1730801255;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XJEcXmB6TalkxyxKKmu2KMtpz3YCZ01vFQnK5Fy50Hk=;
  b=XQB9+tCYgDUP8mAlBcBOKu4kaUVutdSzWW7QfWmIOhFxRQvefaR3bVEu
   b28GOCmggXDlQIzo9lLYyW3o+tNyICpweNjt2H/XhywNHdg6wn108saR4
   Q6LKnSMm1JthYdOm0lMpEVfvPWN2NU+nZnSfrStw8kLNzJ3bwsC3egQgW
   zMqCAyzhUy7VsR7KO7msvB0oXuhAGmsu7PkgTBcUKRfro7gEg05/RQ0eC
   VjWYV7awDh3MhFzGxNhXqabEMTcVDWj5mbjcNus0CG1iNgkMzVHqwRNBc
   RB6o7WEaU1wP4kkeQX8j0EDKWFk/hb02dM3mTOlVq38nnKrsk3Jv4kWL6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="392113610"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="392113610"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 02:07:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="832680493"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="832680493"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 02:07:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qzwVy-0000000Bku0-1d3n;
        Mon, 06 Nov 2023 12:07:26 +0200
Date:   Mon, 6 Nov 2023 12:07:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Paul Gazzillo <paul@pgazz.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, Matt Ranostay <matt@ranostay.sg>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: light: Add support for APDS9306 Light Sensor
Message-ID: <ZUi63hP2ifKTBHL8@smile.fi.intel.com>
References: <20231027074545.6055-3-subhajit.ghosh@tweaklogic.com>
 <202311052102.1GrBH0gk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202311052102.1GrBH0gk-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2023 at 10:22:07PM +0800, kernel test robot wrote:

> >> drivers/iio/light/apds9306.c:598:10: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
>      598 |                 return ret;
>          |                        ^~~
>    drivers/iio/light/apds9306.c:593:9: note: initialize the variable 'ret' to silence this warning
>      593 |         int ret, intg_old, gain_old, gain_new, gain_new_closest;
>          |                ^
>          |                 = 0
>    1 warning generated.

Bad advice, just use correct error code instead of ret.

>    590	static int apds9306_intg_time_set(struct apds9306_data *data, int val2)
>    591	{
>    592		struct device *dev = data->dev;
>    593		int ret, intg_old, gain_old, gain_new, gain_new_closest;
>    594		bool ok;
>    595	
>    596		if (!iio_gts_valid_time(&data->gts, val2)) {
>    597			dev_err(dev, "Unsupported integration time %u\n", val2);
>  > 598			return ret;
>    599		}
>    600	
>    601		intg_old = iio_gts_find_int_time_by_sel(&data->gts,
>    602							data->intg_time_idx);
>    603		if (ret < 0)
>    604			return ret;
>    605	
>    606		if (intg_old == val2)
>    607			return 0;
>    608	
>    609		gain_old = iio_gts_find_gain_by_sel(&data->gts, data->gain_idx);
>    610		if (gain_old < 0)
>    611			return gain_old;
>    612	
>    613		ret = iio_gts_find_new_gain_by_old_gain_time(&data->gts, gain_old,
>    614							     intg_old, val2, &gain_new);
>    615		if (gain_new < 0) {
>    616			dev_err(dev, "Unsupported gain with time\n");
>    617			return gain_new;
>    618		}
>    619	
>    620		gain_new_closest = iio_find_closest_gain_low(&data->gts, gain_new, &ok);
>    621		if (gain_new_closest < 0) {
>    622			gain_new_closest = iio_gts_get_min_gain(&data->gts);
>    623			if (gain_new_closest < 0)
>    624				return gain_new_closest < 0;
>    625		}
>    626		if (!ok)
>    627			dev_dbg(dev, "Unable to find optimum gain, setting minimum");
>    628	
>    629		ret = iio_gts_find_sel_by_int_time(&data->gts, val2);
>    630		if (ret < 0)
>    631			return ret;
>    632	
>    633		ret = apds9306_intg_time_set_hw(data, ret);
>    634		if (ret)
>    635			return ret;
>    636	
>    637		ret = iio_gts_find_sel_by_gain(&data->gts, gain_new_closest);
>    638		if (ret < 0)
>    639			return ret;
>    640	
>    641		return apds9306_gain_set_hw(data, ret);
>    642	}

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F6276B649
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbjHANxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjHANx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:53:28 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13D1E4;
        Tue,  1 Aug 2023 06:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690898005; x=1722434005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nIYKnL0gLdWiIzoPC3kqGQrPs7uvjKL+Tri0yD1cqF8=;
  b=XU1wwi/1c8SGDwvErMRYqcZmtG7oWGBSwXXzOsRPwl6pwEIkj/0QwXZt
   c1WpYg9bOADyaBDo1evfXyg7dnTcd4yiQxM5CssS0inbVxZXIHuyAK2JE
   IJEyGRQXtwAoVJTWoQEfJuGiQJ6MFwJg1LUY1xytpg26Yz0hq2QZ31Hdz
   l7B8Fy4sju4A/M18obMCumj6ZvUutIq3B5bEiyXozvJfN8QsdAN6TuSJf
   5T4SvSEdWMcoZAvjnHntcQvKHQFyGSI1KwWJOu7XTQgxyExVXZF0rVgkh
   eRiNMI+kUXImtVEU7MvjiU9LXtEDWwpn65cuKPYSk/5od6rGEuiwVjmaW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="366769124"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="366769124"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 06:53:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="705836404"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="705836404"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 01 Aug 2023 06:53:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qQpoO-005Clu-0y;
        Tue, 01 Aug 2023 16:53:20 +0300
Date:   Tue, 1 Aug 2023 16:53:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Satish Nagireddy <satish.nagireddy@getcruise.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/9] media: i2c: ds90ub953: Restructure clkout
 management
Message-ID: <ZMkOTwLHdRQqUtBg@smile.fi.intel.com>
References: <20230731-fpdlink-additions-v3-0-8acfc49c215a@ideasonboard.com>
 <20230731-fpdlink-additions-v3-7-8acfc49c215a@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731-fpdlink-additions-v3-7-8acfc49c215a@ideasonboard.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 04:24:41PM +0300, Tomi Valkeinen wrote:
> Separate clkout calculations and register writes into two functions:
> ub953_calc_clkout_params and ub953_write_clkout_regs, and add a struct
> ub953_clkout_data that is used to store the clkout parameters.
> 
> This simplifies the clkout management.

...

> +#define UB953_DEFAULT_CLKOUT_RATE	25000000UL

HZ_PER_MHZ (from units.h)?

...

> +struct ub953_clkout_data {
> +	u32 hs_div;
> +	u32 m;
> +	u32 n;
> +	unsigned long rate;

You may save 4 bytes on some architectures (which do not allow 4-byte alignment
for 64-bit members) by reshuffling the members.

(besides using u32-fract :-)

> +};

...

> +		dev_dbg(dev, "%s %llu * %u / (8 * %u) = %lu (requested %lu)",
> +			__func__, fc_rate, m, n, clkout_rate, target_rate);

__func__ in dev_dbg() is not needed. It's very rare nowadays to debug a kernel
without Dynamic Debug to be on.

...

> +		dev_dbg(dev, "%s %llu / %u * %u / %u = %lu (requested %lu)",
> +			__func__, fc_rate, hs_div, m, n, clkout_rate,
> +			target_rate);

Ditto.

-- 
With Best Regards,
Andy Shevchenko



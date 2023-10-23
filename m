Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EA67D3299
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbjJWLV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjJWLV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:21:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749D4D6;
        Mon, 23 Oct 2023 04:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698060115; x=1729596115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dTMuOISm9OIG7zQeqd0pR9/QKceuYq5H6DY5SCz3AfI=;
  b=LXCHS0PcGxRRTzeBCBjTfIn5xv89EnxUpRHbFYf788VRsLCKyqDeqjzY
   xpZ3KLrq4jZFk5A1kFSJ7bLPs2/8yZ3RueU/bUiZiiGZIJYN28tSGp7yr
   1p7r/iIdI8h2HA3pZo9RO8MuQyR88QO9ig2fBShpJGNo+NLDwUnXwMLui
   VQoEykY29uKfmcB439W4MN08JKLWhTYveS3khqHzveo+0i3AraSKMUPNP
   sPqjJinWwXJL01TyNtG65l2GlMVObBuW8tIkC2whP8EVUVWfUJJ1/m0Mu
   zjQHzBCP7aZbvmaERqKSTOMrcXwpwlS4o4P8LRjucidTVwr5SuwNQtKqX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="5441793"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="5441793"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 04:21:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="881730411"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="881730411"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 04:21:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qut0H-00000007v6h-0qzY;
        Mon, 23 Oct 2023 14:21:49 +0300
Date:   Mon, 23 Oct 2023 14:21:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Phil Elwell <phil@raspberrypi.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/5] iio: pressure: bmp280: Use i2c_get_match_data()
Message-ID: <ZTZXTLeWbUHKkHIn@smile.fi.intel.com>
References: <cover.1697994521.git.ang.iglesiasg@gmail.com>
 <0554ddae62ba04ccacf58c2de04ec598c876665e.1697994521.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0554ddae62ba04ccacf58c2de04ec598c876665e.1697994521.git.ang.iglesiasg@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2023 at 07:22:17PM +0200, Angel Iglesias wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> Replace device_get_match_data() and id lookup for retrieving match data
> by i2c_get_match_data().
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hmm... What tools have you used to format/send this? It seems differs
to what `git format-patch` does.

-- 
With Best Regards,
Andy Shevchenko



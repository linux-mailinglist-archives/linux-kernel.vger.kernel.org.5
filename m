Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6E77D409C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 22:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjJWUFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 16:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJWUFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 16:05:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264C6F9;
        Mon, 23 Oct 2023 13:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698091531; x=1729627531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vzCYBegKmD99AGE0G2Mekw/HeH8k/864tM2ZX6SzBRc=;
  b=ZFn2sRnMbALWDb2nxWVHpTLoaGdvb87qqsv9Ro80a4lByjN+A76+gS3f
   nU8H2HDcTh4OOJGdToHNXburWv1ln+fBwTXS0AdgwBXWHqogox2WYoRiy
   I3fw3tSAuOC/wKdY6/0/p2cjn7nMBSmBKeJ/HTixAxhAU8D6fJyFqzGyc
   IJOitJhchOeTHqv584JJgDVv0lkT4KgG4ks2mJ2S5MFJTvgOhkaZGHPk0
   DB6hlS5JrsbOooAirn/dBJmuQ6R7r52aACsPIvSVcM4RTXaVml4nuJuVJ
   YZ8iCWQx3cwZ5IJ4k6gboEBJ1gDpI43QJ0iAh+6Yo5yHuvPGOEx825LFB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="385815094"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="385815094"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 13:05:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="761862025"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="761862025"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 13:05:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qv1Ay-000000081ke-3ovp;
        Mon, 23 Oct 2023 23:05:24 +0300
Date:   Mon, 23 Oct 2023 23:05:24 +0300
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
Message-ID: <ZTbSBK+lkPPKA74B@smile.fi.intel.com>
References: <cover.1697994521.git.ang.iglesiasg@gmail.com>
 <0554ddae62ba04ccacf58c2de04ec598c876665e.1697994521.git.ang.iglesiasg@gmail.com>
 <ZTZXTLeWbUHKkHIn@smile.fi.intel.com>
 <b4a76c2f3440da1ab6449b34fb352d21c9347b7b.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4a76c2f3440da1ab6449b34fb352d21c9347b7b.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 04:00:53PM +0200, Angel Iglesias wrote:
> On Mon, 2023-10-23 at 14:21 +0300, Andy Shevchenko wrote:
> > On Sun, Oct 22, 2023 at 07:22:17PM +0200, Angel Iglesias wrote:
> > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > > 
> > > Replace device_get_match_data() and id lookup for retrieving match data
> > > by i2c_get_match_data().
> > > 
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Hmm... What tools have you used to format/send this? It seems differs
> > to what `git format-patch` does.
> 
> I just applied this patch from Biju's series with "git am" and then generated
> this series running the following invocation:
> "git format-patch -v2 -p -n --thread --cover-letter 
> --to=linux-iio@vger.kernel.org --base=iio_upstream/togreg HEAD~5"
> My work repository is publicly available here:
> https://github.com/angiglesias/linux/commits/iio-bmp280-add-bmp390-support

Somehow the diffstat is stripped off...

-- 
With Best Regards,
Andy Shevchenko



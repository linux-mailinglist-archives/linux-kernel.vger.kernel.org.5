Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAFD78C89D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237280AbjH2PaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237281AbjH2P3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:29:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4976199
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693322973; x=1724858973;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lSkUT8x0K7dSdxjSffC8SIGi4cJQxLsyuk82cFlOtTA=;
  b=TIgU2J6dAR+F+Jc1h4ABD4SEaw/wuddoMQVv6mugSNlxbZTkq3cQmuIN
   LPkPVw00NYrhdqcUsOWWkLr7ymzW+iI2uMBsK/U635gw0chDcv5J2YOAi
   JCkUnuETJQRSKEY7khKDJQweUBQxVrYQqjkICQCyC4Rj0XB9KHtCmlgHN
   7EDs1p4fXSwoWkZXsGqhCrNV0T0s02HP5+P3lVY9s+0hKcRiZXN0vztn3
   eFA80+GnWjhgpG2ijjFpFtHxyV5TDn2NLV6oF6eop9mK0q1KS7e6ureZ7
   UctTAvqYuTTeBE8MPycOBaDDPDjF6H3QhRryRDUIFZb2DRuPqdXT24ug2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="461765705"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="461765705"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 08:18:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="862279324"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="862279324"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 29 Aug 2023 08:18:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qb0Tn-004uen-1H;
        Tue, 29 Aug 2023 18:18:07 +0300
Date:   Tue, 29 Aug 2023 18:18:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: wm8580: Simplify probe()
Message-ID: <ZO4ML5Iykmt5xL2e@smile.fi.intel.com>
References: <20230828174019.119250-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828174019.119250-1-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 06:40:19PM +0100, Biju Das wrote:
> Simplify probe() by replacing of_match_device->i2c_get_match_data() and
> extend matching support for ID table.
> 
> While at it, remove comma in the terminator entry and simplify probe()
> by replacing dev_err->dev_err_probe().

dev_err() --> dev_err_probe()

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> -static const struct of_device_id wm8580_of_match[] = {
> -	{ .compatible = "wlf,wm8580", .data = &wm8580_data },
> -	{ .compatible = "wlf,wm8581", .data = &wm8581_data },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(of, wm8580_of_match);

This doesn't change anything functional, please do it in a separate change.

-- 
With Best Regards,
Andy Shevchenko



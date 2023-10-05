Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337BA7BA562
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241474AbjJEQQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240748AbjJEQNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:13:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642FB27553;
        Thu,  5 Oct 2023 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696520242; x=1728056242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IRJ9mtCnYpA5n4HvRCoExQviHP5gvTiNEInaYhfMs24=;
  b=L4lWfqpQAkmKF4OqUq4lmi8B36K7xa2+EjtG9gnD+IBj2SachcFx2V9g
   0bM5EzUBTwv2A6GX6HZHUFxl5/1KqOysske1qkmnZQJFRwnjX2G3ZUmTq
   2m+MZFcm90lOTKIxmUb+BdZL6suFrgT2YC5Iy1Mf8NABATPcKpfgk9d14
   Jf9LvrdSmzPso7J3vu5a8lomXwCGzi2phf4guZYVSHH2PWy8I0br8jByk
   RHZhSKD/yrtKVRWmvw5TcZvPNMfL4qWXO8nHFlPmRt8Ztz8HerL3mGJj2
   oNUYtRh16yAzWe8Mcv9Wcvsy9nVefe6rnzN/jYXaF8yqXKBsm3nItmGT9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="362891114"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="362891114"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 08:37:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="755509753"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="755509753"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 08:37:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qoQPd-0000000344c-04TY;
        Thu, 05 Oct 2023 18:37:17 +0300
Date:   Thu, 5 Oct 2023 18:37:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andi Shyti <andi.shyti@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 1/1] serial: 8250_bcm7271: Use
 devm_clk_get_optional_enabled()
Message-ID: <ZR7YLI3t2YDBbNbK@smile.fi.intel.com>
References: <20231005124550.3607234-1-andriy.shevchenko@linux.intel.com>
 <ZR7UCtRKrycMD5d5@ashyti-mobl2.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR7UCtRKrycMD5d5@ashyti-mobl2.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 05:19:38PM +0200, Andi Shyti wrote:

[...]

> > -	baud_mux_clk = devm_clk_get(dev, "sw_baud");
> > -	if (IS_ERR(baud_mux_clk)) {
> > -		if (PTR_ERR(baud_mux_clk) == -EPROBE_DEFER) {
> > -			ret = -EPROBE_DEFER;
> > -			goto release_dma;
> > -		}
> > -		dev_dbg(dev, "BAUD MUX clock not specified\n");
> > -	} else {
> > +	baud_mux_clk = devm_clk_get_optional_enabled(dev, "sw_baud");
> > +	ret = PTR_ERR_OR_ZERO(baud_mux_clk);
> > +	if (ret)
> > +		goto release_dma;
> > +	if (baud_mux_clk) {
> >  		dev_dbg(dev, "BAUD MUX clock found\n");
> > -		ret = clk_prepare_enable(baud_mux_clk);
> > -		if (ret)
> > -			goto release_dma;
> > +
> >  		priv->baud_mux_clk = baud_mux_clk;
> >  		init_real_clk_rates(dev, priv);
> >  		clk_rate = priv->default_mux_rate;
> > +	} else {
> > +		dev_dbg(dev, "BAUD MUX clock not specified\n");
> 
> little behavioral change here, but I don't think this is a
> problem.

You meant that "if (!x) else" had been changed to "if (x) else" semantics?
Otherwise I don't see any difference.

> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



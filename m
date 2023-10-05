Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC517BA6A5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjJEQjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbjJEQif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:38:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C944C1E;
        Thu,  5 Oct 2023 09:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696522147; x=1728058147;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z6axqSafCG3SFakbUw3zVfXDPE0xVjhwDjcbHzVxyx8=;
  b=P+HxgzV0x1UVgR9PrUmgl9QtC3dTfpj/jokp5KdbGq+EaSm0fNItslrB
   poeBmPnCzCA9ZeDEZn/0r4neRDH4Mrj7gjqF96dUHD8+7rGZ5nIFmPCvg
   BBukPm7KYuBM01cyBOc1+ICxIRfDzOh6ofZx0pZDuyQArYXR7ZpH3XJIw
   jpRJxCnClZXqnVO48VOYbVAHQ5xVrt+PMZ1eAPGqNulAxV9bidkQCJbHT
   XrbymJ5Kw8jN7UPmARcubvwRoXwmpu/aZ4JasE90ZMuQO4cwLDmpQs2wX
   S1Y2Z6g2+Sdi3QS3R5aclo/cP2TJ9FhdrHYpL0OshRw1d6AcL1+2KL0Zf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="383441143"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="383441143"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 09:08:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="787024217"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="787024217"
Received: from yklum-mobl.gar.corp.intel.com (HELO intel.com) ([10.215.244.7])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 09:08:05 -0700
Date:   Thu, 5 Oct 2023 18:07:58 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andi Shyti <andi.shyti@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 1/1] serial: 8250_bcm7271: Use
 devm_clk_get_optional_enabled()
Message-ID: <ZR7fXpps3V2mmiMf@ashyti-mobl2.lan>
References: <20231005124550.3607234-1-andriy.shevchenko@linux.intel.com>
 <ZR7UCtRKrycMD5d5@ashyti-mobl2.lan>
 <ZR7YLI3t2YDBbNbK@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR7YLI3t2YDBbNbK@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Thu, Oct 05, 2023 at 06:37:16PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 05, 2023 at 05:19:38PM +0200, Andi Shyti wrote:
> 
> [...]
> 
> > > -	baud_mux_clk = devm_clk_get(dev, "sw_baud");
> > > -	if (IS_ERR(baud_mux_clk)) {
> > > -		if (PTR_ERR(baud_mux_clk) == -EPROBE_DEFER) {
> > > -			ret = -EPROBE_DEFER;
> > > -			goto release_dma;
> > > -		}
> > > -		dev_dbg(dev, "BAUD MUX clock not specified\n");
> > > -	} else {
> > > +	baud_mux_clk = devm_clk_get_optional_enabled(dev, "sw_baud");
> > > +	ret = PTR_ERR_OR_ZERO(baud_mux_clk);
> > > +	if (ret)
> > > +		goto release_dma;
> > > +	if (baud_mux_clk) {
> > >  		dev_dbg(dev, "BAUD MUX clock found\n");
> > > -		ret = clk_prepare_enable(baud_mux_clk);
> > > -		if (ret)
> > > -			goto release_dma;
> > > +
> > >  		priv->baud_mux_clk = baud_mux_clk;
> > >  		init_real_clk_rates(dev, priv);
> > >  		clk_rate = priv->default_mux_rate;
> > > +	} else {
> > > +		dev_dbg(dev, "BAUD MUX clock not specified\n");
> > 
> > little behavioral change here, but I don't think this is a
> > problem.
> 
> You meant that "if (!x) else" had been changed to "if (x) else" semantics?
> Otherwise I don't see any difference.

If devm_clk_get() fails with anything but -EPROBE_DEFER
originally the code was not returning, while now it returns.

But still... this is perfectly fine.

Andi

> > Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> 
> Thank you!
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 

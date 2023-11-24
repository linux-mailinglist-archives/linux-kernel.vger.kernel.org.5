Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298C17F729B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 12:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344970AbjKXLWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 06:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKXLWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 06:22:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93EB10D7;
        Fri, 24 Nov 2023 03:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700824964; x=1732360964;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NkIA0FKFLlcC69DWDl71RDdxGe5F/FY5m+uFFak1rb4=;
  b=aj7g/DL6CUqXN6hPALkwteejOQ+ZBgoYgb/VPa+wP1pCj1fLLj5jSvvZ
   IEdhSKJLBUGtZU1bVXycUnvlQkDKN+E3L0NWXuafiGz4OhV8Bn0sfpk7S
   yfi5lHy76PfIX0xpuHPJ6E5b+sL1QPhr/SDUzLw1V8MHrSFRV6thZEyL9
   7xDeQ57VPMPNqoPsrNI+VBA0TjcVgzmtU64xylVba9M6ofQcUoIdrntnD
   jRrr59n94NTROFpzOswZtcnnsxh31zgzEABKhZbQVQK6yswvWC9DhFjF3
   2MNW4PKERFY2hGgTayR3Aw5w6U66Um9rAPyOmujfznkb6hNh6627AL+kS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="5628040"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="5628040"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 03:22:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="833670573"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="833670573"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 03:22:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1r6UGa-0000000GhMj-2SIa;
        Fri, 24 Nov 2023 13:22:36 +0200
Date:   Fri, 24 Nov 2023 13:22:36 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        lech.perczak@camlingroup.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: sc16is7xx: improve regmap debugfs by using one
 regmap per port
Message-ID: <ZWCHfGmAmSpGh2e1@smile.fi.intel.com>
References: <20231030211447.974779-1-hugo@hugovil.com>
 <ZV_GHRhqCdeCHV_a@smile.fi.intel.com>
 <20231124000534.aa8f0c866753c3a9e6844354@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124000534.aa8f0c866753c3a9e6844354@hugovil.com>
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

On Fri, Nov 24, 2023 at 12:05:34AM -0500, Hugo Villeneuve wrote:
> On Thu, 23 Nov 2023 23:37:33 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Mon, Oct 30, 2023 at 05:14:47PM -0400, Hugo Villeneuve wrote:

...

> > This change might be problematic, i.e. ...

...

> > >  		regmap_update_bits(
> > >  			s->regmap,
> > > -			SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_SHIFT,
> > > +			SC16IS7XX_IOCONTROL_REG,
> > >  			SC16IS7XX_IOCONTROL_MODEM_A_BIT |
> > >  			SC16IS7XX_IOCONTROL_MODEM_B_BIT, s->mctrl_mask);
> > 
> > ...if this happens inside another regmap operation it might collide with this
> > as there is no more shared locking (and if driver is going to be converted to
> > use an external lock, the one in regmap might be disabled). But I haven't
> > checked anyhow deeply this, so just a heads up for the potential issue.
> 
> Hi Andy,
> are you refering to the above piece of code as the only location where
> this could be problematic?
> 
> If yes, then it is located inside sc16is7xx_setup_mctrl_ports(), which
> is called only during sc16is7xx_probe(), and I assume it should be ok.

With below it becomes two. Maybe you can point out somewhere in the code
(in a form of a comment?) that regmap[0] separate access is allowed only
in probe stage?

Also be aware, that other callbacks shouldn't be called at that time (means
no port should be made visible / registered to the users).

...

> > > -	ret = regmap_read(regmap,
> > > -			  SC16IS7XX_LSR_REG << SC16IS7XX_REG_SHIFT, &val);
> > > +	ret = regmap_read(regmaps[0], SC16IS7XX_LSR_REG, &val);
> > 
> > Here is a probe, most likely no issues.
> 
> Ok.
> 
> > >  	if (ret < 0)
> > >  		return -EPROBE_DEFER;

...

> > > +	snprintf(buf, sizeof(buf), "port%d", port_id);
> > 
> > Should be %u.
> 
> Yes. I just noticed that Greg has applied the patch to its tty-testing
> branch, I assume I should just send a new patch to fix it?

Yes.

-- 
With Best Regards,
Andy Shevchenko


